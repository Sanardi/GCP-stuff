#pass args: -p project -b bucketname l-link to github repo

#in the Cloud shell:

gcloud auth list

gcloud config list project


#gcloud config set compute/zone us-east1-b
#gcloud config set compute/region us-east1

#export PROJECT=sanardi
while getopts p:b:l: option
do
case "${option}"
in
p) PROJECT=${OPTARG};;
b) BUCKET_NAME=${OPTARG};;
l) LINK=${OPTARG};;

esac
done


echo $PROJECT

echo $BUCKET_NAME

echo $LINK
