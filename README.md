# Quarkus Performance Test

## Objective

We will compare the performance of three **scenarios**:

1. Java `ear` inside a Wildfly container inside a docker container.
2. Quarkus JVM `jar` inside a docker container.
3. Quarkus native image inside a docker container.

To compare the resource consumption we will use the following **tools**:

* [cadvisor](https://github.com/google/cadvisor) &rarr; Gets system metrics.
* The [elk](https://www.elastic.co/es/what-is/elk-stack) stack &rarr; Process the metrics and shows them in a kibana dashboard.

## Resources

1. We will start from an [elk stack playground](https://github.com/RamonPradoMoreno/elk-docker-playground).
2. Two microservices:
   * For scenario 1, the [code](https://github.com/RamonPradoMoreno/hello-rest) and the [docker image](https://hub.docker.com/r/rpardom/simple_rest/tags). 
   * For scenarios 2 and 3, the [code](https://github.com/RamonPradoMoreno/hello-rest-quarkus) and the [docker image](https://hub.docker.com/r/rpardom/simple_rest/tags).