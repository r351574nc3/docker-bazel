# docker-bazel
Dockerized bazel build system

## Usage

Instruction for using the docker container.

**Set an alias**

```
alias bazel='docker run --rm -v $PWD:/workspace -w /workspace
--privileged bazel-0.4.4-jessie bazel --output_base=.output'
```

The above will create a local `.output` path in your workspace. This
is useful because it will prevent continuous fetching of external
dependencies.

**Use bazel as normal**

```
bazel build //myapp
```
