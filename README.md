# Streaming Data Backend #

This is a simple application to ingest csv data through file submitting having specific columns.
It could be easily generalized to ingest different formats coming from different sources.

### Running the application ###

A Vagrantfile has been created to avoid any effort configuring the environment.
Consult the vagrant [documentation](https://www.vagrantup.com/intro/index.html) for specific information about how it works.

Ensure to have at least 4gb of ram for vagrant, otherwise set the `vb.memory` option 
to something more sensible in the Vagrantfile.

After cloning the repository, change directory to the root directory containing the Vagrantfile.
To start up the vagrant vm run `vagrant up`. 

If needed for debugging purpose, you can login to the vm running `vagrant ssh`. 
Under `/var/log` you can check the logs of logstash, kibana and elasticsearch.
Instead `/vagrant` is the shared directory in the guest machine.

### Submitting data ###

To submit the data-set to the application just copy the input csv file to the
monitored directory sensor-input running for example `cp /path/to/data_measurements_finals.csv sensor-input/data.csv`.
The logstash process will automatically load the file and tail it for new lines.

### Visualizing data ###

Open [Kibana](http://localhost:15601) in the browser to connect to the Kibana process running in the vm.
The first time you use the console, the [index patterns](https://www.elastic.co/guide/en/kibana/current/index-patterns.html) should be configured to enable searching the 
elasticsearch indices. Unfortunately, this settings can not be done programmatically at the moment and has to
be done manually.

When the kibana console opens, click on the `Management` tab on the left, select Index Patterns, 
in the Index Pattern tab write `streaming_data*` and choose `@timestamp` from the drop down menu,
then click on create. 
Repeat the process for the patterns `streaming_data_invalid_input*` and `streaming_data_invalid_date*`.
Now the indices are available for any kibana search.

Now, for complex analysis tasks you would create a [dashboard](https://www.elastic.co/guide/en/kibana/current/dashboard.html) composed of different visualizations.

For simple analysis instead you can just use the `Discover tab`. Select the tab and choose the desired index pattern from the drop down menu on the right.
The select the date range in the top right corner. The quick selection `Last 1 year` should do the trick.
From the histogram you can get a first feeling of the data traffic and in the table underneath you see the records.
Clicking on `Add a filter` underneath the search textbox lets you filter on each field.

For more details on how to use the console, consult the online [documentation](https://www.elastic.co/guide/en/kibana/current/index.html).
