# Quarkus Performance Test

## Objective

We will compare the performance of three **scenarios**:

1. Java `ear` inside a Wildfly container inside a docker container.
2. Quarkus JVM `jar` inside a docker container.
3. Quarkus native image inside a docker container.

To compare the resource consumption we will use the following **tools**:

* The [elk](https://www.elastic.co/es/what-is/elk-stack) stack &rarr; Process the metrics and shows them in a kibana dashboard.
* [Metricbeat](https://www.elastic.co/guide/en/beats/metricbeat/current/index.html) &rarr; Get docker metrics from my host machine.

## Resources

1. We will start from an [elk stack playground](https://github.com/RamonPradoMoreno/elk-docker-playground).
2. Two microservices:
   * For scenario 1, the [code](https://github.com/RamonPradoMoreno/hello-rest) and the [docker image](https://hub.docker.com/r/rpardom/simple_rest/tags). 
   * For scenarios 2 and 3, the [code](https://github.com/RamonPradoMoreno/hello-rest-quarkus) and the [docker image](https://hub.docker.com/r/rpardom/simple_rest/tags).

## Setup

### Install Metricbeat

Metricbeat needs to be installed and configured in the machine running docker.

1. Download the package and install, for Fedora:

   ```bash
   curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.2-x86_64.rpm && sudo dnf install metricbeat-7.6.2-x86_64.rpm
   ```

   [More Info](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-installation.html)

### Configure Metricbeat

1. Go to `/usr/share/metricbeat/bin` (if you don't have that directory check [here](https://www.elastic.co/guide/en/beats/metricbeat/current/directory-layout.html))

2. Enable the modules that you want to use:

   ```bash
   sudo metricbeat modules enable docker
   ```

3. Connect your local *metricbeat* with the contenerized *kibana* and *elasticsearch*:

   ```bash
   sudo nano /etc/metricbeat/metricbeat.yml
   ```

   ```bash
   # Where you see "setup.kibana:" Add to the file the kibana host:
   # careful! avoid tabulations
   setup.kibana:
   host: "localhost:5601"
   # The elasticsearch address is already configured.
   ```

### Start the system

1. Start you elk playground:

   ```bash
   docker-compose up -d
   ```

2. Start sending docker metrics to the elk stack by running in your local machine:

   ```bash
   sudo service metricbeat start
   ```

3. Import our dashboard:

   1. Open kibana in a browser: `localhost:5601`
   2. Go to management (last option in side bar) &rarr; Saved Objects &rarr; import 
   3. Select our dashboard from: `conf/kibana/docker_monitorization_dashboard.ndjson`
   4. Go to the dashboard section (third options in side bar)
   5. It will ask you to create an index pattern, insert: `metricbeat*` 
   6. Choose `@timestamp` as Time Filter field name.
   7. Enjoy the monitorization :stuck_out_tongue_winking_eye:

## Load Test the containers

If you want to send multiple requests to the service check `/testbech`. There is another readme inside explaining the process and some results obtained for this test.