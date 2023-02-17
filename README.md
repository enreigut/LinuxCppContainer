# LinuxCppContainer
This is a default good to go container in Linux for UNIX C/C++ coding. It installs g++ compiler and ubuntu.

If you want to generate a template project, you will need to run the _createProject.sh_: 

`./createPorjcte.sh -n ${PROJECT_NAME}`

This will generate a simple project structure:
```
- PROJECT_NAME  +
                |_  builds
                |_  include
                |_  src +
                |       |_ main.cpp
                |_  PROJECT_NAME_compile_and_run.sh
```

To compile and run the program you just need to execute the _`PROJECT_NAME_compile_and_run.sh`_. This will generate the `.o` file inside the builds folder.