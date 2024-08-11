we are planning to run an environment with 3 services, FE with Vue, BE with Golang, and Mongo as the DB

we already dockerize the app > can check on https://github.com/ignatiusbarry69?tab=packages it is generated from dockerfile in repository a433-microservices

what we need is:
git
docker
minikube
helm

do the usual installation for git and docker > can check on their documentation
we also need to install minikube, we wont use the full kubernetes solely because of resource restriction
dont forget to install helm as for right now, im using snap helm --classic to install it this might not be the best way

minikube start

dont forget to configure the git on the host
git config --global user.name "ignatiusbarry69"
git config --global user.email "ignatius.barry@ti.ukdw.ac.id"

do whatever it is depending on the situation, when we setup the git to link to github it will ask for password, that password is the github token, while the username is our github username
git clone
git remove origin
git remote add origin <the git link form github/gitlab/bitbucket>
git add git commit git push > then there will be an instruction what to do next

prepare the manifests file by "touching" them one by one but i prefer use script
then declare what we need

then run them all by script

i still dont know why, but even after use nodeport for the service, i cant access the service/pod from internet, but it does accessible from localhost (im using ec2 at this moment) 
nb: me in the future, please update this when you know whats the problem

ok now all set, whats left to be done is monitoring
add the repos we need
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

optional you can declaratively create the namespace for monitoring

helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace
helm install grafana grafana/grafana --namespace monitoring

since for somereason i cant access the kube objects inside this minikube outside of localhost, we need to port forward several service so i can configure the prometheus, grafana, and check how the fe doing

open the port forward from the ubuntu host
kubectl port-forward -n monitoring service/grafana 3000:80

export POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $POD_NAME 9090:9090

then we can access it through ssh -i "vockey.pem" -L 3000:localhost:3000 ubuntu@54.237.231.201(public ip) from our windows on another network

thats pretty much it, one thing to notice maybe is the url to set datasource on grafana, it wont recognize the localhost:9090 idk why, prolly cause we use portforwarding, 
so we need to use http://prometheus-server.monitoring.svc.cluster.local instead

