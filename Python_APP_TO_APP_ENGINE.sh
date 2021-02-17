#cloud NLP API

gcloud auth list

gcloud config list project

#Create an API Key
#First, you will set an environment variable with your PROJECT_ID which you will use throughout this codelab:

export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)

#crate a service acount to acces API
gcloud iam service-accounts create my-natlang-sa \
  --display-name "my natural language service account"

#create credentials fotr this service acount:

gcloud iam service-accounts keys create ~/key.json \
  --iam-account my-natlang-sa@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com

#Finally, set the GOOGLE_APPLICATION_CREDENTIALS environment variable. The environment variable should be set to the full path of the credentials JSON file you created, which you can see in the output from the previous command:

export GOOGLE_APPLICATION_CREDENTIALS="/home/USER/key.json"

/*

Make an Entity Analysis Request
In order to perform next steps please connect to the instance provisioned for you via ssh. Open the navigation menu and select Compute Engine. You should see the following provisioned linux instance:
Click on the SSH button. You will be brought to an interactive shell. Remain in this SSH session for the rest of the lab.

Now you\'ll try out the Natural Language API\'s entity analysis with the following sentence:

Michelangelo Caravaggio, Italian painter, is known for \'The Calling of Saint Matthew\'

Run the following gcloud command in the VMs terminal that you SSHd into:
*/

gcloud ml language analyze-entities --content="Michelangelo Caravaggio, Italian painter, is known for 'The Calling of Saint Matthew'." > result.json

cat result.json

#for the output
