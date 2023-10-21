# Groupe de studer_j 984729

## Schema
Kubernetes architecture Master/Worker
https://geekflare.com/kubernetes-architecture/

## Provision
Dans le dossier provision/ mettre des script bash de toute les installations, afin de ne pas perdre nos config lors d'un reboot machine

## Vagrant
Demarrer une VM : `Vagrant up`
Connection ssh à une VM : `Vagrant ssh`
Détruire une vm : `Vagrant destroy`
Lors du up de master choisir 1 pour la carte bridge

## Correction
Voir tous les workers
````
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
sudo join kube...
````

## Kubernetes
Pour afficher la version :

    kubectl version

Lister tout les pods kube de tout les namespaces :

    kubectl get pods --all-namespaces

Afficher tout les namespaces `kubectl get namespace` <br>
Afficher le namespace actuelle `kubectl config get-contexts` <br>
Afficher les services du namespace actuel `kubectl get services` <br>
Afficher les pods d'un namespace `kubectl get pods --namespace=test` <br>
Afficher les pods d'une node `kubectl get pods -o wide | grep worker` <br>
Delete tout les pods d'un namespace `kubectl -n my-namespace delete pod,svc --all` <br>
mémo pour la suite `-k=kustomize` `-f=filename`<br>
Install pods `kubectl apply -k ./`<br>
Uninstall pods `kubectl delete -k ./`<br>

## Setup 
`vagrant up`
`kubectl get nodes`

## Setup monitoring
`kubectl create namespace monitoring`
`kubectl apply -f /vagrant/deployment/monitoring/`
`kubectl create deployment grafana -n monitoring --image=docker.io/grafana/grafana:latest`
`kubectl -n monitoring expose deployment grafana --type="NodePort" --port 3000`
`kubectl create deployment loki -n monitoring --image=docker.io/grafana/loki:main`
`kubectl -n monitoring expose deployment loki --type="NodePort" --port 3100`
`kubectl create deployment promtail -n monitoring --image=docker.io/grafana/promtail:main`
`kubectl -n monitoring expose deployment promtail --type="NodePort" --port 3101`


`kubectl get svc -n monitoring` => get external port
visit prom http://192.168.50.10:30000/
visit graphana http://192.168.50.10:32391/
visit loki http://192.168.50.10:30399

add prom public url to graphana source

loki 12019
