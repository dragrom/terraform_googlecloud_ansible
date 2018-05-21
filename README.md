**This is a demonstration to use Terraform+ansible+docker+kubernetes with Google Cloud**

**Decision to use Google Cloud instead of AWS**

 For this project I had a choice between Goocle Cloud and AWS as well as the Cloud Computing platform. We chose Google Cloud because it is more usable to use with Kubernetes. <br />


 AWS doesn’t have a managed Kubernetes installation like GKE does. GKE, on the other hand, has Google backing and integrates with all of Google’s other tooling. It comes with built-in logging, log management and monitoring at both the host and container levels. Unlike AWS, it can give you automatic autoscaling, automatic hardware management and automatic version updates. It generally gives you a production-ready cluster with a more batteries-included approach than if you were building everything by hand on AWS. <br />
The biggest problem we had with Google Cloud was that we were unable to create users and teraform projects (the modules were written, but they were returning runtime errors), so we manually created a system user on the project ( when you use Google Cloud for the first time, it automatically creates a project called My First Project). <br />
	
**Let's start to create the infrastructure** <br />

In the create_infrastracture directory there are all you need to create a VPC network (with subnets and firewall rules) and Kubernetes cluster and pods. <br />
First of all, you will need to install terraform on your computer. For this, you can have a look to https://www.terraform.io/downloads.html web page <br />
Go to create_infrastructure directory </br>
 - run teraform init: this command will initialize the terraform environment, will download providers 
 - run terraform plan to see all changes what will be applied. 
 - run terraform apply to apply you changes <br />

In this exemple, will create a VPC network with subnetworks and firewalls, one Kubernetes cluster and 2 containers based oon nginx image (to provide an exemple for LB working) <br />
When terraform finish to run, you can see the outputs by running terraform output:
terraform output endpoint = 35.233.44.52 host_name = lb_ip = 35.233.21.3 <br />
	The lb_ip is the load balancer IP. If you compythis ip on the web brouser, you will se the web page provided by nginx <br />

**Deploy the application using ansible**

For thi I decide to try ansible-container: http://docs.ansible.com/ansible-container/.<br />
The interesting part of ansible-container is deploy command.
The deploy command pushes images to a remote registry, and generates an Ansible playbook that can be used to deploy the application to a cloud platform.

The cloud platform is determined by the engine used to generate the deployment. Supported engines include: docker, k8s, and openshift. The default is docker. Use the --engine option to choose the engine. For example:

$ ansible-container --engine k8s deploy

The deploy command maps your container.yml file to a cloud configuration, depending on the engine. See the Container.yml Specification for details on how directives are mapped, and for cloud specific options.

At the time ansible-container support for three engines:

    k8s Kubernetes
    docker Docker engine
    openshift RedHat Openshift
    
    <br />
