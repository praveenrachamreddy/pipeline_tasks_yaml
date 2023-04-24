#!/bin/bash
# Define variables for pipeline and task configurations
PIPELINE_CONFIG="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pipeline/pipeline.yaml"
TASK1_GIT_KUSTOMIZE="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/git-kustomize.yaml"
TASK2_SEND_MAIL="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/logs.yaml"
TASK2_BUILDAH="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/buildah.yaml"

# Create pipeline and tasks
oc apply -f $PIPELINE_CONFIG
oc apply -f $TASK1_GIT_KUSTOMIZE
oc apply -f $TASK2_SEND_MAIL
#oc apply -f $TASK2_BUILDAH

# Set the project/namespace where the PVC will be created
PROJECT=sumit

# Set the name and size of the PVC
PVC_NAME=source
PVC_SIZE=1Gi

# Create the PVC
oc create -f - <<EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: $PVC_NAME
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: $PVC_SIZE
EOF



#pvc
oc create -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pvc/mail_pvc.yaml

#secret
kubectl apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/secret/secret-mail.yaml 

#pvc
kubectl apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pvc/pvc.yaml

#Templates-nexus
oc apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/Templates/nexus.yaml

#Templates-sonarqube
oc apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/Templates/sonarqube.yaml

