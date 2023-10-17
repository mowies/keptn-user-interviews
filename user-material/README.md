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
2. For all further steps, please use the `keptn-user-interview-1` namespace.
3. Deploy the NginX demo app from file `task1/nginx-app.yaml`. This will set up a Deployment and a Service.
4. To set up an HPA, you first need a `KeptnMetricsProvider` and a `KeptnMetric`.
5. For the `KeptnMetricsProvider`, please use the name `prometheus` and the following URL pointing to the
   already prepared Prometheus instance:
   ```
   http://observability-stack-kube-p-prometheus.monitoring.svc:9090
   ```

6. For the `KeptnMetric`, we will use the average CPU usage of the cluster. The PromQL query for this looks
   as follows:
   ```
   round(avg(container_cpu_cfs_throttled_periods_total{container="nginx"}))
   ```
   Please use the above query and reference the previously created `KeptnMetricsProvider` to set up the
   `KeptnMetric`.

7. After applying the two new resources to the cluster and waiting a few seconds, you should see some values
   appear, when fetching the KeptnMetric resources with:
   ```shell
   kubectl get keptnmetrics -A
   ```
8. It's time to set up the HPA. Please use the provided `task1/hpa.yaml` file with a stub of an HPA and use the Keptn and
   Kubernetes docs to figure out how to reference a `KeptnMetric` with it. Use a target value of `"5"` for the HPA.
9. After applying the HPA and waiting a little bit, we should see some scaling of the NginX deployment
   kicking in and as a result, we should have 10 NginX pods in the end.


## Task 2 - Set up a post deployment task for you app

### Preparation

1. Fetch the kubeconfig for the test cluster by using
   ```shell
   gcloud container clusters get-credentials --zone <zone-name> --project <project-name> <cluster-name>
   ```
2. Get familiar with the software that is already deployed on the cluster.

### Main tasks
1. Install Keptn on your cluster. Please use the `keptn-lifecycle-toolkit-system` namespace for installation,
   and make use of the Helm chart to install Keptn.
2. For all further steps, please use the `keptn-user-interview-2` namespace.
