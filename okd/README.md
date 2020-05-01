# Advantage creating source image build S2i pipeline-okd

### Work

```
oc create -f imageStream-detectface-builder.yaml
oc create -f buildConfig-detectface-builder.yaml
oc get builds
oc logs -f detectface-frontend-builder-1-build
oc create -f imageStream-detectface-appimage.yaml
oc create -f buildConfig-detectface-appimage.yaml
oc get build
oc logs -f detectface-frontend-appimage-1-build
oc get bc
oc start-build detectface-frontend-builder
oc logs -f detectface-frontend-builder-2-build
oc get bc
oc start-build detectface-frontend-appimage
oc logs -f detectface-frontend-appimage-2-build
oc logs -f detectface-frontend-appimage-2-build
history 50

```

### Not work
