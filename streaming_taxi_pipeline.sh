
#Taxi rides Dataflow

#in google could shell:



gcloud auth list

gcloud config list projects

gcloud compute project-info describe
#this gives you the defualt regions for the project
--metadata google-compute-default-region=europe-west4,google-compute-default-zone=europe-west4-a\
--project $GOOGLE_CLOUD_PROJECT
#this is how to change ther egion


bq mk taxirides

#streaming data; yayyyy

bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime



export BUCKET_NAME=<your-unique-name>


gsutil mb gs://$BUCKET_NAME/



/*

'''

Run the Pipeline
From the Navigation menu find the Big Data section and click on Dataflow.

Click on + Create job from template at the top of the screen.

Enter a Job name for your Cloud Dataflow job.

Under Dataflow Template, select the Pub/Sub Topic to BigQuery template.

Under Input Pub/Sub topic, enter:

projects/pubsub-public-data/topics/taxirides-realtime
Under BigQuery output table, enter the name of the table that was created:

<myprojectid>:taxirides.realtime
Add your bucket as Temporary Location:

gs://Your_Bucket_Name/temp


'''
*/
