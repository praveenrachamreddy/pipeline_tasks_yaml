#!/bin/bash

# Set the project/namespace where the secrets will be created
PROJECT=my-project

# Create the first secret
oc create secret generic my-secret-1 --from-literal=USERNAME=user1 --from-literal=PASSWORD=pass1 -n $PROJECT

# Create the second secret
oc create secret generic my-secret-2 --from-literal=API_KEY=key123 --from-literal=SECRET_KEY=secret456 -n $PROJECT

# Verify that the secrets were created successfully
oc get secrets -n $PROJECT
