#!/bin/bash
# internsctl v0.1.0 - Custom Linux Command

function show_manual() {
    echo "internsctl(1) - Custom Linux Command"
    echo "NAME"
    echo "    internsctl - Your custom command description here"
    echo ""
    echo "SYNOPSIS"
    echo "    internsctl [OPTIONS] [ARGUMENTS]"
    echo ""
    echo "DESCRIPTION"
    echo "    command's detailed description goes here."
    echo ""
    echo "OPTIONS"
    echo "    -h, --help         Display this help message"
    echo "    --version          Display the command version"
    echo ""
}

# Check if 'man' command is available
if command -v man &> /dev/null; then
    show_manual | man -l -
else
    echo "Error: 'man' command not found. Unable to display manual."
fi

#!/bin/bash
# internsctl v0.1.0 - Custom Linux Command

function show_help() {
    echo "Usage: internsctl [OPTIONS] [ARGUMENTS]"
    echo "Your command's brief description here."
    echo ""
    echo "Options:"
    echo "  -h, --help         Display this help message"
    echo "  --version          Display the command version"
    # Add more help options as needed
    echo ""
}

# Check for --help option
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

#!/bin/bash
# internsctl v0.1.0 - Custom Linux Command

function show_version() {
    echo "internsctl v0.1.0"
}

# Check for --version option
if [[ "$1" == "--version" ]]; then
    show_version
    exit 0
fi

# Your other command functionalities go here
#!/bin/bash
# internsctl v0.1.0 - Custom Linux Command

function get_cpu_info() {
    lscpu
}

function get_memory_info() {
    free
}

# Check the command and execute corresponding function
case "$1" in
    cpu)
        if [ "$2" == "getinfo" ]; then
            get_cpu_info
        else
            echo "Error: Invalid argument for CPU. Usage: internsctl cpu getinfo"
        fi
        ;;
    memory)
        if [ "$2" == "getinfo" ]; then
            get_memory_info
        else
            echo "Error: Invalid argument for Memory. Usage: internsctl memory getinfo"
        fi
        ;;
    *)
        echo "Error: Unknown command. Usage: internsctl [cpu|memory] getinfo"
        ;;
esac

# Part1
#!/bin/bash
# internsctl v0.1.0 - Custom Linux Command

function create_user() {
    if [ -z "$1" ]; then
        echo "Error: Missing username. Usage: internsctl user create <username>"
    else
        sudo useradd -m -s /bin/bash "$1"
        echo "User '$1' created successfully."
    fi
}

function list_users() {
    cut -d: -f1 /etc/passwd
}

function list_sudo_users() {
    getent group sudo | cut -d: -f4 | tr ',' '\n'
}

# Check the command and execute corresponding function
case "$1" in
    user)
        case "$2" in
            create)
                create_user "$3"
                ;;
            list)
                if [ "$3" == "--sudo-only" ]; then
                    list_sudo_users
                else
                    list_users
                fi
                ;;
            *)
                echo "Error: Invalid sub-command for 'user'. Usage: internsctl user [create|list] [--sudo-only]"
                ;;
        esac
        ;;
    *)
        echo "Error: Unknown command. Usage: internsctl [user]"
        ;;
esac


#Part 2
#!/bin/bash
# internsctl v0.1.0 - Custom Linux Command

function get_file_info() {
    local file="$1"
    local size=""
    local permissions=""
    local owner=""
    local last_modified=""

    # Check if the file exists
    if [ -e "$file" ]; then
        size=$(stat --format=%s "$file")
        permissions=$(stat --format=%A "$file")
        owner=$(stat --format=%U "$file")
        last_modified=$(stat --format=%y "$file")

        echo "File: $file"
        echo "Access: $permissions Size(B): $size Owner: $owner"
        echo "Modify: $last_modified"
    else
        echo "Error: File '$file' not found."
    fi
}
#Part 3
# Check the command and execute corresponding function
case "$1" in
    file)
        if [ "$2" == "getinfo" ]; then
            shift 2  # Remove 'file' and 'getinfo' from the argument list
            file_name="$1"

            if [ -n "$file_name" ]; then
                case "$2" in
                    --size | -s)
                        get_file_info "$file_name"
                        ;;
                    --permissions | -p)
                        get_file_info "$file_name"
                        ;;
                    --owner | -o)
                        get_file_info "$file_name"
                        ;;
                    --last-modified | -m)
                        get_file_info "$file_name"
                        ;;
                    *)
                        echo "Error: Invalid option. Usage: internsctl file getinfo [options] <file-name>"
                        ;;
                esac
            else
                echo "Error: Missing file name. Usage: internsctl file getinfo [options] <file-name>"
            fi
        else
            echo "Error: Invalid sub-command for 'file'. Usage: internsctl file getinfo [options] <file-name>"
        fi
        ;;
    *)
        echo "Error: Unknown command. Usage: internsctl [file]"
        ;;
esac

