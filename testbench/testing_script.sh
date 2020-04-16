#!/bin/sh

ab -t 120 -c 10 http://localhost:8090/hello > native.txt &
ab -t 120 -c 10 http://localhost:8091/hello > jvm.txt &
ab -t 120 -c 10 http://localhost:8092/rest-hello-0.0.1/resources/hello > wildfly.txt &
