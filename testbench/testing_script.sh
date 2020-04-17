#!/bin/sh
TEMP=`getopt -o t:c: --long time:,concurrent: -- "$@"`
eval set -- "$TEMP"

while true ; do
    case "$1" in
        -t|--time)
            time=$2 ; shift 2 ;;
        -c|--concurrent)
            concurrent=$2 ; shift 2 ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

echo "Starting 3 tests with $concurrent threads during $time seconds..."
echo "Starting native test..."
ab -t $time -c $concurrent http://localhost:8090/hello > native.txt &
echo "Starting jvm test..."
ab -t $time -c $concurrent http://localhost:8091/hello > jvm.txt &
echo "Starting wildfly test..."
ab -t $time -c $concurrent http://localhost:8092/rest-hello-0.0.1/resources/hello > wildfly.txt &
