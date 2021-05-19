Getting started
===============

pip install localstack

localstack start

aws configure --profile localstack  [ enter 'test' and 'test' for AWS creds, and 'us-east-1' for region ]

aws --profile localstack --endpoint-url=http://localhost:4566 kinesis list-streams

should show an empty list of streams





