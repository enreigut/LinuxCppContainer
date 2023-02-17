#!/bin/bash
set -e

usage="
$(basename "$0") [-h] [-n PROJECT_NAME]
Make the user provide a PROJECT_NAME to create default C++ project structure. This also sets the envirnment variable PROJECT_NAME for the compile and run script. This must only be ran once. The default structure is:
    - PROJECT_NAME
        - builds
        - include
        - src
            - main.cpp
        - PROJECT_NAME_compile_and_run.sh
The possible flags are:
    - h show this help text (optional)
    - n name of project (required)
    
    "
# Utilities functions
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

# Check if required arguments are provided
options=':hn:'
while getopts $options option; do
    case "$option" in
        h) echo "$usage"; exit;;
        n) PROJECT_NAME=$OPTARG;;
        :) err "Missing argument for -%s\n" "$OPTARG" >&1; echo "$usage" >&2; exit 1;;
        \?) err "Illegal option: -%s\n" "$OPTARG" >&1; echo "$usage" >&2; exit 1;;
    esac
done

# Required arguments
if [ ! "$PROJECT_NAME" ]; then
    err "Arguments -n must be provided"
    echo "$usage" >&2; exit 1
fi

# Check if the folder with the name PROJECT_NAME exists
if [ -d "$PROJECT_NAME" ]; then
  err "Error: There is already a file with that name!"; exit 1
fi

# Create Project Structure and script to run it
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"
echo -e "#!/bin/sh\r\n\ng++ -o builds/\"$PROJECT_NAME\" src/main.cpp\r\nbuilds/\"$PROJECT_NAME\"" >> "$PROJECT_NAME"_compile_and_run.sh
sed -i -e 's/\r$//' "$PROJECT_NAME"_compile_and_run.sh
mkdir -p builds
mkdir -p include
mkdir -p src
cd src
echo -e "#include <iostream>\r\n\nint main()\r\n{\r\n\tstd::cout << \"Hello World!\" << std::endl;\r\n\r\n\treturn 0;\r\n}" >> main.cpp
