#!/bin/bash

# Set the project/namespace where the PVC will be created
PROJECT=sumit

# Set the name and size of the PVC
PVC_NAME=my-pvc
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

# Verify that the PVC was created successfully
oc get pvc -n $PROJECT


