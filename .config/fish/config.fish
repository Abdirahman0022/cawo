if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x GOPATH $HOME/goprojects
set -x PATH $PATH $GOPATH/bin
