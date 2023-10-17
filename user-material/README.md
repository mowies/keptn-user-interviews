# User Interview Tasks

## General starting information

The following tasks should be done on your own. You can use any online resources to solve the tasks,
especially the Keptn documentation (https://keptn.sh). You will get some additional material in the form
of prepared YAML files in this folder.

## Task 1 - Scale a workload using KeptnMetrics and an HPA

In this task, we will set up Keptn on a prepared cluster that already has some auxiliary software installed.
We will then install a small NginX app and scale it using Keptn metrics and a HorizontalPodAutoscaler.

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


## Task 2 - Set up a pre deployment task for you app

In this task, we will re-use the previous cluster and Keptn installation.
We will set up a simple workload with a KeptnApp and then enhance it with a pre deployment task.

### Preparation

1. Fetch the kubeconfig for the test cluster by using
   ```shell
   gcloud container clusters get-credentials --zone <zone-name> --project <project-name> <cluster-name>
   ```
2. Get familiar with the software that is already deployed on the cluster.

### Main tasks
1. Please use the same cluster as before and also, re-use the same Keptn installation as before.
2. For all further steps, please use the `keptn-user-interview-2` namespace.
3. In the `task2` folder, you will find a NginX demo app similar to the one from task 1.
   This time you will need to enhance that app with some Keptn CRDs around it.
4. Please set up a `KeptnApp` resource that manages the NginX demo app. You can use an arbitrary SemVer for the
   `version` field in the `KeptnApp` resource. But make sure that the version of the workload corresponds to the
   `app.kubernetes.io/version` of the NginX demo app.
5. Now, it's time to set up a pre-deployment task for the sample app.
   Please set up a pre-deployment task with name `pre-task-1`. It should run a simple request to the numbers API
   at `http://numbersapi.com/42` and return the result as a log line.
6. After implementing the task, you can deploy it to the cluster.
7. Using the name from the created pre-deployment task, reference the newly created task in the KeptnApp.
8. Then, deploy the KeptnApp and test deployment into the cluster.
9. You should see the pod first stay in pending state until the pre-deployment task was run and finished successfully.
