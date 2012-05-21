From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH] remoteproc: allocate vrings on demand, free when not needed
Date: Mon, 21 May 2012 11:49:10 -0500
Message-ID: <CACY--9FBeNHDVMtLC09OtMm=t3ZFw2Gtipn+8ojAEqHAJebSnQ@mail.gmail.com>
References: <1337515228-31910-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337515228-31910-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>
List-Id: linux-omap@vger.kernel.org

Looks good to me.

 Tested-by: Fernando Guzman Lugo <fernando.lugo@ti.com>

Regards,
=46ernando.


On Sun, May 20, 2012 at 7:00 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
>
> Dynamically allocate the vrings' DMA when the remote processor
> is about to be powered on (i.e. when ->find_vqs() is invoked),
> and release them as soon as it is powered off (i.e. when ->del_vqs()
> is invoked).
>
> The obvious and immediate benefit is better memory utilization, since
> memory for the vrings is now only allocated when the relevant remote
> processor is being used.
>
> Additionally, this approach also makes recovery of a (crashing)
> remote processor easier: one just needs to remove the relevant
> vdevs, and the entire vrings cleanup takes place automagically.
>
> Tested-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> =A0drivers/remoteproc/remoteproc_core.c =A0 =A0 | =A0109
> +++++++++++++++---------------
> =A0drivers/remoteproc/remoteproc_internal.h | =A0 =A02 +
> =A0drivers/remoteproc/remoteproc_virtio.c =A0 | =A0 13 +++-
> =A03 files changed, 67 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index e756a0d..40e2b2d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -279,34 +279,17 @@ rproc_load_segments(struct rproc *rproc, const =
u8
> *elf_data, size_t len)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int
> -__rproc_handle_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *r=
sc,
> int i)
> +int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
> =A0{
> =A0 =A0 =A0 =A0struct rproc *rproc =3D rvdev->rproc;
> =A0 =A0 =A0 =A0struct device *dev =3D rproc->dev;
> - =A0 =A0 =A0 struct fw_rsc_vdev_vring *vring =3D &rsc->vring[i];
> + =A0 =A0 =A0 struct rproc_vring *rvring =3D &rvdev->vring[i];
> =A0 =A0 =A0 =A0dma_addr_t dma;
> =A0 =A0 =A0 =A0void *va;
> =A0 =A0 =A0 =A0int ret, size, notifyid;
>
> - =A0 =A0 =A0 dev_dbg(dev, "vdev rsc: vring%d: da %x, qsz %d, align %=
d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, vrin=
g->da, vring->num, vring->align);
> -
> - =A0 =A0 =A0 /* make sure reserved bytes are zeroes */
> - =A0 =A0 =A0 if (vring->reserved) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "vring rsc has non zero re=
served bytes\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* verify queue size and vring alignment are sane */
> - =A0 =A0 =A0 if (!vring->num || !vring->align) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid qsz (%d) or align=
ment (%d)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vring->num, vring->align);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* actual size of vring (in bytes) */
> - =A0 =A0 =A0 size =3D PAGE_ALIGN(vring_size(vring->num, vring->align=
));
> + =A0 =A0 =A0 size =3D PAGE_ALIGN(vring_size(rvring->len, rvring->ali=
gn));
>
> =A0 =A0 =A0 =A0if (!idr_pre_get(&rproc->notifyids, GFP_KERNEL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "idr_pre_get failed\n");
> @@ -316,6 +299,7 @@ __rproc_handle_vring(struct rproc_vdev *rvdev, st=
ruct
> fw_rsc_vdev *rsc, int i)
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Allocate non-cacheable memory for the vring. In the=
 future
> =A0 =A0 =A0 =A0 * this call will also configure the IOMMU for us
> + =A0 =A0 =A0 =A0* TODO: let the rproc know the da of this vring
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0va =3D dma_alloc_coherent(dev, size, &dma, GFP_KERNEL)=
;
> =A0 =A0 =A0 =A0if (!va) {
> @@ -323,44 +307,67 @@ __rproc_handle_vring(struct rproc_vdev *rvdev,
> struct fw_rsc_vdev *rsc, int i)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* assign an rproc-wide unique index for this vring */
> - =A0 =A0 =A0 /* TODO: assign a notifyid for rvdev updates as well */
> - =A0 =A0 =A0 ret =3D idr_get_new(&rproc->notifyids, &rvdev->vring[i]=
, &notifyid);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Assign an rproc-wide unique index for this vring
> + =A0 =A0 =A0 =A0* TODO: assign a notifyid for rvdev updates as well
> + =A0 =A0 =A0 =A0* TODO: let the rproc know the notifyid of this vrin=
g
> + =A0 =A0 =A0 =A0* TODO: support predefined notifyids (via resource t=
able)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D idr_get_new(&rproc->notifyids, rvring, &notifyi=
d);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "idr_get_new failed: %d\n=
", ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_free_coherent(dev, size, va, dma);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* let the rproc know the da and notifyid of this vring=
 */
> - =A0 =A0 =A0 /* TODO: expose this to remote processor */
> - =A0 =A0 =A0 vring->da =3D dma;
> - =A0 =A0 =A0 vring->notifyid =3D notifyid;
> -
> =A0 =A0 =A0 =A0dev_dbg(dev, "vring%d: va %p dma %x size %x idr %d\n",=
 i, va,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0dma, size, notifyid);
>
> - =A0 =A0 =A0 rvdev->vring[i].len =3D vring->num;
> - =A0 =A0 =A0 rvdev->vring[i].align =3D vring->align;
> - =A0 =A0 =A0 rvdev->vring[i].va =3D va;
> - =A0 =A0 =A0 rvdev->vring[i].dma =3D dma;
> - =A0 =A0 =A0 rvdev->vring[i].notifyid =3D notifyid;
> - =A0 =A0 =A0 rvdev->vring[i].rvdev =3D rvdev;
> + =A0 =A0 =A0 rvring->va =3D va;
> + =A0 =A0 =A0 rvring->dma =3D dma;
> + =A0 =A0 =A0 rvring->notifyid =3D notifyid;
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void __rproc_free_vrings(struct rproc_vdev *rvdev, int i)
> +static int
> +rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc,=
 int
> i)
> =A0{
> =A0 =A0 =A0 =A0struct rproc *rproc =3D rvdev->rproc;
> + =A0 =A0 =A0 struct device *dev =3D rproc->dev;
> + =A0 =A0 =A0 struct fw_rsc_vdev_vring *vring =3D &rsc->vring[i];
> + =A0 =A0 =A0 struct rproc_vring *rvring =3D &rvdev->vring[i];
>
> - =A0 =A0 =A0 for (i--; i >=3D 0; i--) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rproc_vring *rvring =3D &rvdev->=
vring[i];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int size =3D PAGE_ALIGN(vring_size(rvri=
ng->len,
> rvring->align));
> + =A0 =A0 =A0 dev_dbg(dev, "vdev rsc: vring%d: da %x, qsz %d, align %=
d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, vrin=
g->da, vring->num, vring->align);
> +
> + =A0 =A0 =A0 /* make sure reserved bytes are zeroes */
> + =A0 =A0 =A0 if (vring->reserved) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "vring rsc has non zero re=
served bytes\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(rproc->dev, size, rvr=
ing->va,
> rvring->dma);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 idr_remove(&rproc->notifyids, rvring->n=
otifyid);
> + =A0 =A0 =A0 /* verify queue size and vring alignment are sane */
> + =A0 =A0 =A0 if (!vring->num || !vring->align) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid qsz (%d) or align=
ment (%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vring->num, vring->align);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 rvring->len =3D vring->num;
> + =A0 =A0 =A0 rvring->align =3D vring->align;
> + =A0 =A0 =A0 rvring->rvdev =3D rvdev;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +void rproc_free_vring(struct rproc_vring *rvring)
> +{
> + =A0 =A0 =A0 int size =3D PAGE_ALIGN(vring_size(rvring->len, rvring-=
>align));
> + =A0 =A0 =A0 struct rproc *rproc =3D rvring->rvdev->rproc;
> +
> + =A0 =A0 =A0 dma_free_coherent(rproc->dev, size, rvring->va, rvring-=
>dma);
> + =A0 =A0 =A0 idr_remove(&rproc->notifyids, rvring->notifyid);
> =A0}
>
> =A0/**
> @@ -425,11 +432,11 @@ static int rproc_handle_vdev(struct rproc *rpro=
c,
> struct fw_rsc_vdev *rsc,
>
> =A0 =A0 =A0 =A0rvdev->rproc =3D rproc;
>
> - =A0 =A0 =A0 /* allocate the vrings */
> + =A0 =A0 =A0 /* parse the vrings */
> =A0 =A0 =A0 =A0for (i =3D 0; i < rsc->num_of_vrings; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __rproc_handle_vring(rvdev, rsc=
, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D rproc_parse_vring(rvdev, rsc, i=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_vrings;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_rvdev;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* remember the device features */
> @@ -440,12 +447,11 @@ static int rproc_handle_vdev(struct rproc *rpro=
c,
> struct fw_rsc_vdev *rsc,
> =A0 =A0 =A0 =A0/* it is now safe to add the virtio device */
> =A0 =A0 =A0 =A0ret =3D rproc_add_virtio_dev(rvdev, rsc->id);
> =A0 =A0 =A0 =A0if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_vrings;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_rvdev;
>
> =A0 =A0 =A0 =A0return 0;
>
> -free_vrings:
> - =A0 =A0 =A0 __rproc_free_vrings(rvdev, i);
> +free_rvdev:
> =A0 =A0 =A0 =A0kfree(rvdev);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -1265,18 +1271,11 @@ EXPORT_SYMBOL(rproc_shutdown);
> =A0void rproc_release(struct kref *kref)
> =A0{
> =A0 =A0 =A0 =A0struct rproc *rproc =3D container_of(kref, struct rpro=
c, refcount);
> - =A0 =A0 =A0 struct rproc_vdev *rvdev, *rvtmp;
>
> =A0 =A0 =A0 =A0dev_info(rproc->dev, "removing %s\n", rproc->name);
>
> =A0 =A0 =A0 =A0rproc_delete_debug_dir(rproc);
>
> - =A0 =A0 =A0 /* clean up remote vdev entries */
> - =A0 =A0 =A0 list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, =
node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __rproc_free_vrings(rvdev, RVDEV_NUM_VR=
INGS);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&rvdev->node);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * At this point no one holds a reference to rproc any=
more,
> =A0 =A0 =A0 =A0 * so we can directly unroll rproc_alloc()
> @@ -1547,7 +1546,7 @@ EXPORT_SYMBOL(rproc_free);
> =A0*/
> =A0int rproc_unregister(struct rproc *rproc)
> =A0{
> - =A0 =A0 =A0 struct rproc_vdev *rvdev;
> + =A0 =A0 =A0 struct rproc_vdev *rvdev, *tmp;
>
> =A0 =A0 =A0 =A0if (!rproc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -1556,7 +1555,7 @@ int rproc_unregister(struct rproc *rproc)
> =A0 =A0 =A0 =A0wait_for_completion(&rproc->firmware_loading_complete)=
;
>
> =A0 =A0 =A0 =A0/* clean up remote vdev entries */
> - =A0 =A0 =A0 list_for_each_entry(rvdev, &rproc->rvdevs, node)
> + =A0 =A0 =A0 list_for_each_entry_safe(rvdev, tmp, &rproc->rvdevs, no=
de)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rproc_remove_virtio_dev(rvdev);
>
> =A0 =A0 =A0 =A0/* the rproc is downref'ed as soon as it's removed fro=
m the klist
> */
> diff --git a/drivers/remoteproc/remoteproc_internal.h
> b/drivers/remoteproc/remoteproc_internal.h
> index 9f336d6..f4957cf 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -41,4 +41,6 @@ void rproc_create_debug_dir(struct rproc *rproc);
> =A0void rproc_init_debugfs(void);
> =A0void rproc_exit_debugfs(void);
>
> +void rproc_free_vring(struct rproc_vring *rvring);
> +int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> =A0#endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/drivers/remoteproc/remoteproc_virtio.c
> b/drivers/remoteproc/remoteproc_virtio.c
> index ecf6121..26a7144 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -77,14 +77,17 @@ static struct virtqueue *rp_find_vq(struct
> virtio_device *vdev,
> =A0 =A0 =A0 =A0struct rproc_vring *rvring;
> =A0 =A0 =A0 =A0struct virtqueue *vq;
> =A0 =A0 =A0 =A0void *addr;
> - =A0 =A0 =A0 int len, size;
> + =A0 =A0 =A0 int len, size, ret;
>
> =A0 =A0 =A0 =A0/* we're temporarily limited to two virtqueues per rvd=
ev */
> =A0 =A0 =A0 =A0if (id >=3D ARRAY_SIZE(rvdev->vring))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);
>
> - =A0 =A0 =A0 rvring =3D &rvdev->vring[id];
> + =A0 =A0 =A0 ret =3D rproc_alloc_vring(rvdev, id);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(ret);
>
> + =A0 =A0 =A0 rvring =3D &rvdev->vring[id];
> =A0 =A0 =A0 =A0addr =3D rvring->va;
> =A0 =A0 =A0 =A0len =3D rvring->len;
>
> @@ -103,6 +106,7 @@ static struct virtqueue *rp_find_vq(struct
> virtio_device *vdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0rproc_virtio_notify, callback,
> name);
> =A0 =A0 =A0 =A0if (!vq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(rproc->dev, "vring_new_virtque=
ue %s failed\n",
> name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rproc_free_vring(rvring);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOMEM);
> =A0 =A0 =A0 =A0}
>
> @@ -125,6 +129,7 @@ static void rproc_virtio_del_vqs(struct virtio_de=
vice
> *vdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rvring =3D vq->priv;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rvring->vq =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vring_del_virtqueue(vq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rproc_free_vring(rvring);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -228,8 +233,12 @@ static struct virtio_config_ops
> rproc_virtio_config_ops =3D {
> =A0static void rproc_vdev_release(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct virtio_device *vdev =3D dev_to_virtio(dev);
> + =A0 =A0 =A0 struct rproc_vdev *rvdev =3D vdev_to_rvdev(vdev);
> =A0 =A0 =A0 =A0struct rproc *rproc =3D vdev_to_rproc(vdev);
>
> + =A0 =A0 =A0 list_del(&rvdev->node);
> + =A0 =A0 =A0 kfree(rvdev);
> +
> =A0 =A0 =A0 =A0kref_put(&rproc->refcount, rproc_release);
> =A0}
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
