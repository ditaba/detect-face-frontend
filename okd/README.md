# Advantage creating source image build S2i pipeline-okd

## Work

```
imageStream-detectface-builder.yaml
buildConfig-detectface-builder.yaml
```

Commands:

```
$ oc create -f imageStream-detectface-builder.yaml
$ oc create -f buildConfig-detectface-builder.yaml
$ oc get builds
$ oc logs -f detectface-frontend-builder-1-build
```

## Not work

```
$ oc create -f imageStream-detectface-appimage.yaml
$ oc create -f buildConfig-detectface-appimage.yaml
$ oc get build
$ oc logs -f detectface-frontend-appimage-1-build
$ oc get bc
$ oc start-build detectface-frontend-builder
$ oc logs -f detectface-frontend-builder-2-build
$ oc get bc
$ oc start-build detectface-frontend-appimage
$ oc logs -f detectface-frontend-appimage-2-build
$ oc logs -f detectface-frontend-appimage-2-build
$ history 50
```

Logs:

```
Di Ta@LAPTOP-D83E7CN2 MINGW64 /d/study/udemy/reactjs/detect-face-prontend/okd (openshift)
$ oc logs -f detectface-frontend-appimage-2-build
Using 172.30.1.1:5000/detectface-frontend-s2i/detectface-frontend-builder@sha256:b55e40347d98b28d6ba53365afe5d40aacdb13591a53037baa46410a17135079 as the s2i builder image
/bin/sh: 1: /usr/libexec/s2i/assemble: Permission denied
error: build error: non-zero (13) exit code from 172.30.1.1:5000/detectface-frontend-s2i/detectface-frontend-builder@sha256:b55e40347d98b28d6ba53365afe5d40aacdb13591a53037baa46410a17135079
```
