function __ssh_agent__start_agent
    set -l lifetime
    if set -q __ssh_agent__lifetime
        set lifetime "-t $__ssh_agent__lifetime"
    end
    # Start ssh-agent and setup environment
    echo "Starting ssh-agent..."
    source (/usr/bin/env ssh-agent -s $lifetime | sed 's/\([^=]*\)=\([^;]*\);.*/set -xU \1 \2/' | psub)
end

function __ssh_agent__fix_environment
    if set -qg SSH_AUTH_SOCK
        set -l global_socket (set -xgL | grep SSH_AUTH_SOCK | cut -d' ' -f 2)
        set -l universal_socket (set -xUL | grep SSH_AUTH_SOCK | cut -d' ' -f 2)
        set -eg SSH_AUTH_SOCK
        if test "$global_socket" != "$universal_socket"
            set -xU SSH_AUTH_SOCK $global_socket
        end
    end
end

function __ssh_agent__load_identities
    if not ssh-add -l >/dev/null
        # Only add keys if the agent has no identities
        if set -q __ssh_agent__identities
            set identities $__ssh_agent__identities
        end
        # Load identities
        echo "Loading identities..."
        if not set -q identities
            /usr/bin/ssh-add
        else
            for identity in $identities
                echo "    $identity"
                /usr/bin/ssh-add -AK $HOME/.ssh/$identity
            end
        end
    end
end

if not set -qg SSH_AUTH_SOCK
    if set -qU SSH_AGENT_PID
        if not ps x | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null
            __ssh_agent__start_agent
        end
    end
end
__ssh_agent__fix_environment
__ssh_agent__load_identities
