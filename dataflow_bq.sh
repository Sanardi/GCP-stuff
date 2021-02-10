

#in the Cloud shell:

gcloud auth list

gcloud config list project

export PROJECT=sanardi

echo $PROJECT

export BUCKET_NAME='sanardi-scripts'


<<COMMENT If the account is not present in IAM or does not have the editor role, follow the steps below to assign the required role.

In the Google Cloud console, on the Navigation menu, click Home.

Copy the project number (e.g. 729328892908).

On the Navigation menu, click IAM & Admin > IAM.

At the top of the IAM page, click Add.

For New members, type:

{project-number}-compute@developer.gserviceaccount.com
Replace {project-number} with your project number.

For Role, select Project (or Basic) > Editor. Click Save.
COMMENT

gsutil -m cp -R gs://spls/gsp290/dataflow-python-examples .

gsutil mb -c regional -l us-central1 gs://$PROJECT


#gsutil mb gs://$BUCKET_NAME/


gsutil cp gs://spls/gsp290/data_files/usa_names.csv gs://$PROJECT/data_files/
gsutil cp gs://spls/gsp290/data_files/head_usa_names.csv gs://$PROJECT/data_files/

<<COMMENT Open Code Editor
Navigate to the source code by clicking on the Open Editor icon in Cloud Shell:

editor.png

If prompted click on Open in New Window. It will open the code editor in new window.

You will now build a Dataflow pipeline with a TextIO source and a BigQueryIO destination to ingest data into BigQuery. More specifically, it will:

Ingest the files from Cloud Storage.
Filter out the header row in the files.
Convert the lines read to dictionary objects.
Output the rows to BigQuery.

COMMENT

cd dataflow-python-examples/
# Here we set up the python environment.
# Pip is a tool, similar to maven in the java world
sudo pip install virtualenv

#Dataflow requires python 3.7
virtualenv -p python3 venv

source venv/bin/activate
pip install apache-beam[gcp]==2.24.0


python dataflow_python_examples/data_ingestion.py --project=$PROJECT --region=us-central1 --runner=DataflowRunner --staging_location=gs://$PROJECT/test --temp_location gs://$PROJECT/test --input gs://$PROJECT/data_files/head_usa_names.csv --save_main_session

#Return to the Cloud Console and open the Navigation menu > Dataflow to view the status of your job.
#Click on the name of your job to watch it's progress. Once your Job Status is Succeeded.

#Navigate to BigQuery (Navigation menu > BigQuery) see that your data has been populated.

python dataflow_python_examples/data_enrichment.py --project=$PROJECT --region=us-central1 --runner=DataflowRunner --staging_location=gs://$PROJECT/test --temp_location gs://$PROJECT/test --input gs://$PROJECT/data_files/head_usa_names.csv --save_main_session
