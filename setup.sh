#!/usr/bin/env bash
# a simple script to automate the task of building and cleaning the whole project

version=0.0.1

case $1 in
    clean)
        rm -rf build web-ui/build web-ui/node_modules && cargo clean
        if [ -f wondarr-${version}.tar.gz ]
        then
            rm wondarr-${version}.tar.gz
        fi
        ;;
    build)
        if [[ $2 == "-f" ]]
        then
            ./$0 clean
        fi

        # create a build folder, this will be where the final project goes
        if [[ -d build ]]
        then
            rm -rf build
        fi
        mkdir build

        # build the web-ui project and move the static files to a folder called templates
        cd web-ui &&
        npm install &&
        npm run build &&
        mkdir ../build/templates &&
        mv build/* ../build/templates/. &&
        mv ../build/templates/index.html ../build/templates/index.html.tera &&

        # go back to the project root so we can build the rocket
        cd .. &&

        # build the rocket server
        cargo build &&
        cp target/debug/wondarr build/.
        ;;
    package)
        if [[ $2 == "-f" ]]
        then
            ./$0 clean
        fi
        ./$0 build &&
        mv build wondarr &&
        tar czvf wondarr-${version}.tar.gz wondarr &&
        mv wondarr build
        ;;
    *)
        echo "Usage: $0 {clean|build|package}"
        echo -e "\tclean\t\tdelete the target and build directories"
        echo -e "\tbuild\t\tbuild the project"
        echo -e "\tpackage\t\tpackage the application for distribution"
        echo -e "\t-f\t\tused with build and package, does a clean first"
        ;;
esac