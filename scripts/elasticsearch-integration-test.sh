#!/bin/bash

# elasticsearch integration test for Socorro

elasticsearch_urls=${elasticsearch_urls:-"http://localhost:9200"}

echo -n "INFO: setting up environment..."
. socorro-virtualenv/bin/activate >> setup.log 2>&1
if [ $? != 0 ]
then
  fatal 1 "could not activate virtualenv"
fi
export PYTHONPATH=.
echo " Done."

echo -n "INFO: running elasticsearch integration"
python socorro/integrationtest/test_elasticsearch_storage_app.py --elasticsearch_urls=$elasticsearch_urls --elasticsearch_index=socorro_integration_test --elasticsearch_emails_index=socorro_integration_test
