# Private GKE cluster with ShareVPC on Google Cloud
Using this terraform module, we can setup 2 separate GKE clusters that are hosted on the subnets of a same network using the SharedVPC architecture.

The things that are setup here are:

* GKE cluster 1 `prod-cluster`
* GKE cluster 2 `dev-cluster`
* IAM Policy Bindings required for the SharedVPC architecture
* Required subnets and ip ranges on the shared vpc network
* a bastion vm created on the host project to connect to GKE clusters using IAP
* a CloudNAT for all the things to connect to internet

The entire setup is hosted on a private network and is not exposed to the internet so you need a way direct ingress traffic which is not covered here.

Make sure that you've already enabled SharedVPC on your host project and attached the service projects already.

Update the locals.tf file with correct values. Current values are arbitrary.

Feel free to suggest/request improvements.
