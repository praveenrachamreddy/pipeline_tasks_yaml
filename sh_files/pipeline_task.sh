#!/bin/bash
# Define variables for pipeline and task configurations
PIPELINE_CONFIG="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pipeline/pipeline.yaml"
TASK1_GIT_KUSTOMIZE="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/git-kustomize.yaml"
TASK2_SEND_MAIL="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/logs.yaml"
TASK2_BUILDAH="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/tasks/buildah.yaml"
TASK3_APPROVAL="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/approval_task_code/approval_task.yaml"
FRONTEND_CONFIGMAP="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/approval_task_code/frontend_cm.yaml"
BACKEND_CONFIGMAP="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/approval_task_code/frontend_cm.yaml"
NEXUS_TEMPLATE="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/Templates/nexus.yaml"
SONARQUBE_TEMPLATE="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/Templates/sonarqube.yaml"
PVC="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/pvc/pvc.yaml"
SECRET="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/secret/server-secret.yaml"
APPROVAL_DEPLOYMENT="https://github.com/sumitbiswal98/pipeline_tasks_yaml/raw/main/approval_task_code/dep_by_cm.yaml"


# Create pipeline and tasks
oc apply -f $PIPELINE_CONFIG
oc apply -f $TASK1_GIT_KUSTOMIZE
oc apply -f $TASK2_SEND_MAIL
oc apply -f $TASK3_APPROVAL
oc apply -f $FRONTEND_CONFIGMAP
oc apply -f $BACKEND_CONFIGMAP
oc apply -f $NEXUS_TEMPLATE
oc apply -f $SONARQUBE_TEMPLATE
oc apply -f $PVC
oc apply -f $SECRET
oc apply -f $APPROVAL_DEPLOYMENT
