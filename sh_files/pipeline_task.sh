#!/bin/bash
# Define variables for pipeline and task configurations
PIPELINE_CONFIG="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pipeline/pipeline.yaml"
TASK1_GIT_KUSTOMIZE="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/git-kustomize.yaml"
TASK2_SEND_MAIL="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/logs.yaml"
TASK2_BUILDAH="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/buildah.yaml"
TASK3_APPROVAL="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/approval_task_code/approval_task.yaml"

# Create pipeline and tasks
oc apply -f $PIPELINE_CONFIG
oc apply -f $TASK1_GIT_KUSTOMIZE
oc apply -f $TASK2_SEND_MAIL
#oc apply -f $TASK2_BUILDAH
oc apply -f $TASK_APPROVAL


# Set the name and size of the PVC

#secret
kubectl apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/secret/secret-mail.yaml 

#pvc
kubectl apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pvc/pvc.yaml

#Templates-nexus
oc apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/Templates/nexus.yaml

#Templates-sonarqube
oc apply -f https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/Templates/sonarqube.yaml

