# Disconnected OCP 3.11 cluster deployment

The files in this repo are intended to be used as part of a disconnected installation of OCP 3.11

You can find here a series of ansible playbooks for pulling, retagging, and pushing the images you need, as described
within RH documentation, to an internal docker registry the machines within your cluster(s) can reach.

Images required within the documentation are splitted into different groups:

* Required images (tagged with the selected version label, i.e. ``v3.11.zz``) for infrastructure components, and optional components within ``openshift3`` repository. They are listed within ``openshift3-images`` file.
* Required images (``latest`` tag) for optional components (CFME, and GlusterFS). They are listed within ``cfme-images`` and ``rhgs3-images`` files.
* Builder images (tagged with the selected version label, i.e. ``v3.11.zz``) for ``s2i``. They are listed within ``builder-images`` file.
* The ``etcd`` image from RHEL 7 repos, named ``registry.redhat.io/rhel7/etcd:3.2.22``. It has been listed within ``etcd-images`` file.

# Pre-requisites

* Bastion host properly provisioned with Internet access to RH registries
* Docker installed
* Ansible installed
* Local docker registry container running

```
$ docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  registry:2
```

# Ansible playbook Usage

1. Issue the following command:

```
ansible-playbook openshift3-images.yml
```

You can find additional playbooks named ``builder-images.yml``, ``etcd-images``, ``cfme-images`` and ``rhgs3-images.yml``.

2. You'll be prompted for RH registry credentials

3. Images will be pulled, retagged, pushed to your local registry available at ``localhost:5000``, and removed.

4. Pulled images will be removed.

# Shell scripts Usage

If you've been able to use ``docker save`` and ``docker load`` for bundling images into ``.tar`` balls,
and transferring them to bastion host machine, you can use ``retag-xxxxxxxxxx.sh`` scripts for having them retagged,
pushed to local docker registry running in ``localhost:5000``, and removed.

# Assumptions

We are assuming that:

* As for the scenario based on the shell scripts described before, all the downloaded images are tagged as ``latest``.
* We are considering an air-gapped scenario for deploying an OCP 3.11 cluster.
* We are using a linux box with docker installed, and a local docker registry up & running.
* Our user on such a host machine has sudo/root privileges.
