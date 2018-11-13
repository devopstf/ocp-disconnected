# Disconnected OCP 3.11 cluster deployment

The files in this repo are intended to be used as part of a disconnected installation of OCP 3.11

You can find here an ansible playbook for pulling, retagging, and pushing the images you need, as described
within RH documentation, to an internal docker registry the machines within your cluster(s) can reach.

Images required within the documentation are splitted into three (or four) different groups:

* Required images (tagged with the selected version label, i.e. ``v3.11.zz``) for infrastructure components
* Required images (``latest`` tag) for optional components (CFME, and GlusterFS)
* Builder images (tagged with the selected version label, i.e. ``v3.11.zz``) for ``s2i``.
* ``etcd`` image from RHEL 7 repos, named ``registry.redhat.io/rhel7/etcd:3.2.22``.

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

You can find additional playbooks named ``builder-images.yml``, and ``latest-images.yml``

2. You'll be prompted for RH registry credentials

3. Images will be pulled, retagged, and pushed to your local registry at ``localhost:5000``.

4. Pulled images will be removed.

# Shell script Usage

If you've been able to use ``docker save`` and ``docker load`` for bundling images into ``.tar`` balls,
and transferring them to bastion host machine, you can use ``retag.sh`` script for having them retagged,
and pushed to local docker registry running in ``localhost:5000``.