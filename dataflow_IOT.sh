

#in the Cloud shell:

gcloud auth list

gcloud config list project

export PROJECT_ID=qwiklabs-gcp-02-7feb7713e3a5


export BUCKET_NAME=qwiklabs-gcp-01-7a6f30ecef66-bucket

echo $PROJECT_ID

<<COMMENT In the Cloud Console, click Navigation menu > APIs & Services.
Console_APIs.png

Scroll down in the list of enabled APIs, and confirm that these APIs are enabled:

Cloud IoT API
Cloud Pub/Sub API
Dataflow API
If one or more API is not enabled, click the ENABLE APIS AND SERVICES button at the top. Search for the APIs by name and enable each API for your current project.


Cloud Pub/Sub is an asynchronous global messaging service. By decoupling senders and receivers, it allows for secure and highly available communication between independently written applications. Cloud Pub/Sub delivers low-latency, durable messaging.

In Cloud Pub/Sub, publisher applications and subscriber applications connect with one another through the use of a shared string called a topic. A publisher application creates and sends messages to a topic. Subscriber applications create a subscription to a topic to receive messages from it.

In an IoT solution built with Cloud IoT Core, device telemetry data is forwarded to a Cloud Pub/Sub topic.

To define a new Cloud Pub/Sub topic:

In the Cloud Console, go to Navigation menu > Pub/Sub > Topics.
Click + CREATE TOPIC. The Create a topic dialog shows you a partial URL path.
Note: If you see qwiklabs-resources as your project name, cancel the dialog and return to the Cloud Console. Use the menu to the right of the Google Cloud logo to select the correct project. Then return to this step.
Add this string as your topic name:

iotlab
Click CREATE TOPIC.

In the list of topics, you will see a new topic whose partial URL ends in iotlab. Click the three-dot icon at the right edge of its row to open the context menu. Choose View permissions.

view-permission.png

In the Permissions dialogue, click ADD MEMBER and copy the below member as New members:

cloud-iot@system.gserviceaccount.com
From the Select a role menu, give the new member the Pub/Sub > Pub/Sub Publisher role.

Click Save.

COMMENT


bq mk iotlabdataset


bq mk --schema TIMESTAMP:TIMESTAMP,DEVICE:STRING,TEPERATURE:FLOAT, --table iotlabdataset.sensordata

#his doesnt work, I dont know why. If in doubt make table manually using Console


gsutil mb gs://$BUCKET_NAME/


<<COMMENT In the Cloud Console, go to Navigation menu > Dataflow.

In the top menu bar, click + CREATE JOB FROM TEMPLATE.

In the job-creation dialog, for Job name, enter iotlabflow.

For Regional Endpoint, choose the region as us-central1.

For Dataflow template, choose Pub/Sub Topic to BigQuery. When you choose this template, the form updates to review new fields below.

For Input Pub/Sub topic, enter projects/ followed by your Project ID then add /topics/iotlab. The resulting string will look like this: projects/qwiklabs-gcp-d2e509fed105b3ed/topics/iotlab

The BigQuery output table takes the form of Project ID:dataset.table (:iotlabdataset.sensordata). The resulting string will look like this: qwiklabs-gcp-d2e509fed105b3ed:iotlabdataset.sensordata

For Temporary location, enter gs:// followed by your Cloud Storage bucket name (should be your Project ID if you followed the instructions) then /tmp/. The resulting string will look like this: gs://qwiklabs-gcp-d2e509fed105b3ed-bucket/tmp/

Click SHOW OPTIONAL PARAMETERS.

For Max workers, enter 2.

For Machine type, enter n1-standard-1.

Click RUN JOB.

A new streaming job is started. You can now see a visual representation of the data pipeline.

Prepare your compute engine VM
In your project, a pre-provisioned VM instance named iot-device-simulator will let you run instances of a Python script that emulate an MQTT-connected IoT device. Before you emulate the devices, you will also use this VM instance to populate your Cloud IoT Core device registry.

To connect to the iot-device-simulator VM instance:

In the Cloud Console, go to Navigation menu > Compute Engine > VM Instances. You'll see your VM instance listed as iot-device-simulator.

Click the SSH drop-down arrow and select Open in browser window.

In your SSH session, enter following commands to create a virtual environment.

sudo pip install virtualenv
virtualenv -p python3 venv
source venv/bin/activate

#In your SSH session on the iot-device-simulator VM instance, enter this command to remove the default Cloud SDK installation. (In subsequent steps, you will install the latest version, including the beta component.)

sudo apt-get remove google-cloud-sdk -y

curl https://sdk.cloud.google.com | bash

#End your ssh session on the iot-device-simulator VM instance:

exit
#Start another SSH session on the iot-device-simulator VM instance and execute the following command to activate the virtual environment.

source venv/bin/activate
#Initialize the gcloud SDK.

gcloud init
COMMENT
