request_file=/vagrant/bootstrap/elasticsearch-templates/streaming_data_template.json

curl -XPUT --data-binary "@$request_file" 'localhost:9200/_template/streaming_data'
