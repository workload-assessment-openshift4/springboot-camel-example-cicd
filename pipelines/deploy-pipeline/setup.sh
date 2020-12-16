CURRENT_NAMESPACE=$(oc project -q)

#Install pipeline in current namespace
oc apply -f serviceaccount.yaml
oc apply -f helm-deploy-pipeline.yaml


# Crete a DEV namespace for the application
 oc new-project springboot-camel-example-dev
 oc adm policy add-role-to-user -n springboot-camel-example-dev edit: system:serviceaccount:$CURRENT_NAMESPACE:deploy_bot

 oc project $CURRENT_NAMESPACE
 