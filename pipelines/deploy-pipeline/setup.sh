CURRENT_NAMESPACE=$(oc project -q)

#Install pipeline in current namespace
oc apply -f serviceaccount.yaml
oc apply -f helm-deploy-pipeline.yaml


# Crete a DEV namespace for the application
oc new-project springboot-camel-example-dev
oc adm policy add-role-to-user -n springboot-camel-example-dev edit system:serviceaccount:$CURRENT_NAMESPACE:deploy-bot
oc create secret docker-registry nexus-credentials --docker-server=nexus-container-registry-nexus.apps.cluster-3bcb.sandbox1869.opentlc.com --docker-username=admin --docker-password=admin123

# Crete a QA namespace for the application
oc new-project springboot-camel-example-qa
oc adm policy add-role-to-user -n springboot-camel-example-qa edit system:serviceaccount:$CURRENT_NAMESPACE:deploy-bot
oc create secret docker-registry nexus-credentials --docker-server=nexus-container-registry-nexus.apps.cluster-3bcb.sandbox1869.opentlc.com --docker-username=admin --docker-password=admin123

oc project $CURRENT_NAMESPACE
 