# k8s-bashlord
K8s bash shortcuts for scrubs like me.

To get `bash-lord` working you already need `gcloud` and `kubectl` setup and configured.

[Setting up kubectl on a Mac](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-with-homebrew-on-macos)
[Setting up gcloud on a Mac](https://cloud.google.com/sdk/docs/quickstart-macos)

To setup zshrc or bash short cut, add the following to the file:

```
export PATH=/path/to/bashlord.sh/script:$PATH

alias bash-lord="bash-lord.sh"
```

```
source .zshrc
```

If you type bash-lord in your terminal you should get
`line 124: 1: Error: No options provided. For a complete list of options type bash-lord help`

### Some basic commands:

```
For GCloud basic get and set:
1. "bash-lord g project get all" will get all projects mapped to your user. Warning: This doesn't have a limit set.
2. "bash-lord g project get sairajmadhavan" will get all projects that contain sairajmadhavan ie. partial matches are supported.
3. "bash-lord g project set sairajmadhavan" will set the project to sairajmadhavan if it exists. Do a get before set and provide accurate value.


For K8s execute in the following order:
1. "bash-lord k" to list all clusters in your current Gcloud project
2. "bash-lord k cluster-name zone" to fetch cluster endpoint and auth data for that cluster and zone.
3. "bash-lord k current" displays current context
4. "bash-lord k set contexts namespace" sets context to --current and --namespace to the namespace provided.
5. "bash-lord k get pods" displays all pods.
6. "bash-lord k get secrets" displays all secrets.
7. "bash-lord k get contexts" displays all available contexts.
8. "bash-lord k set context-name" switches to a context.
```

Contributions are welcome. Please fork the repo and create a PR to contribute.
