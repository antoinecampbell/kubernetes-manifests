from flask import Flask
from kubernetes import config, client

app = Flask(__name__)
config.load_incluster_config()
batchV1Api = client.BatchV1Api()


@app.route("/")
def hello():
    return "Hello, World!"


@app.route("/job")
def start_job():
    job = client.V1Job(
        metadata=client.V1ObjectMeta(
            name="python-job",
        ),
        spec=client.V1JobSpec(
            ttl_seconds_after_finished=30,
            backoff_limit=1,
            template=client.V1PodTemplateSpec(
                spec=client.V1PodSpec(
                    containers=[
                        client.V1Container(
                            name="python-job",
                            image="local/python-job",
                            image_pull_policy="IfNotPresent"
                        )
                    ],
                    restart_policy="Never"
                )
            )
        )
    )
    response = batchV1Api.create_namespaced_job(
        namespace="default",
        body=job
    )
    print(response)
    print(job.to_str())
    return "Started Job."


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
