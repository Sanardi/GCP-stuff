

#in the Cloud shell:

gcloud auth list

gcloud config list project

#for this you need permission to create computer resources:
#gcloud config set compute/zone us-east1-b
#gcloud config set compute/region us-east1

export PROJECT=sanardi

echo $PROJECT

export BUCKET_NAME='sanardi-scripts'

gsutil mb gs://$BUCKET_NAME/

gsutil -m cp -R gs://spls/gsp290/dataflow-python-examples .

#gsutil mb -c regional -l us-central1 gs://$PROJECT

wget http://www.ssa.gov/OACT/babynames/names.zip


#gsutil cp gs://spls/gsp290/data_files/usa_names.csv gs://$PROJECT/data_files/
#gsutil cp gs://spls/gsp290/data_files/head_usa_names.csv gs://$PROJECT/data_files/
