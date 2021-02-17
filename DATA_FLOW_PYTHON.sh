#cloud Dataflow

gcloud auth list

gcloud config list project

BUCKET_NAME=givethisaname
echo $BUCKET_NAME

#make a buckets



gsutil mb -c standard -l us-east1 gs://$BUCKET_NAME

python3 --version

pip3 --version

sudo pip3 install -U pip

sudo pip3 install --upgrade virtualenv

virtualenv -p python3.7 env

source env/bin/activate

pip install apache-beam[gcp]

python -m apache_beam.examples.wordcount --output OUTPUT_FILE

#grab name of outpoutfile using ls

cat <file name>

BUCKET=gs://$BUCKET_NAME

python -m apache_beam.examples.wordcount --project $DEVSHELL_PROJECT_ID \
  --runner DataflowRunner \
  --staging_location $BUCKET/staging \
  --temp_location $BUCKET/temp \
  --output $BUCKET/results/output \
  --region us-central1
