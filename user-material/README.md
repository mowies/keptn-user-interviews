# User Interview Tasks

## General starting information

The following tasks should be done on your own. You can use any online resources to solve the tasks,
especially the Keptn documentation (https://keptn.sh). You will get some additional material in the form
of prepared YAML files in this folder.

## Task 1 - Scale a workload using KeptnMetrics and an HPA

### Preparation

1. Fetch the kubeconfig for the test cluster by using
   ```shell
   gcloud container clusters get-credentials --zone <zone-name> --project <project-name> <cluster-name>
   ```
2. Get familiar with the software that is already deployed on the cluster, most notably, Prometheus.

### Main tasks

1. Install Keptn on your cluster. Please use the `keptn-lifecycle-toolkit-system` namespace for installation, 
   and make use of the Helm chart to install Keptn.

## Task 2 - Set up a post deployment task for you app
