From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH] remoteproc: allocate vrings on demand,
 free when not needed
Date: Mon, 21 May 2012 11:40:10 -0500
Message-ID: <CACY--9Hrus_FmCPvmLnqvGXdd++UYYDJ7-VxS24vSdjq-n7+Eg@mail.gmail.com>
References: <1337515228-31910-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6085772855385464970=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337515228-31910-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Michal Simek <monstr@monstr.eu>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6085772855385464970==
Content-Type: multipart/alternative; boundary=14dae9340d31348c6704c08e8ee6

--14dae9340d31348c6704c08e8ee6
Content-Type: text/plain; charset=ISO-8859-1

Looks good to me.

 Tested-by: Fernando Guzman Lugo <fernando.lugo@ti.com>

Regards,
Fernando.

On Sun, May 20, 2012 at 7:00 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:

> Dynamically allocate the vrings' DMA when the remote processor
> is about to be powered on (i.e. when ->find_vqs() is invoked),
> and release them as soon as it is powered off (i.e. when ->del_vqs()
> is invoked).
>

The obvious and immediate benefit is better memory utilization, since
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
>  drivers/remoteproc/remoteproc_core.c     |  109
> +++++++++++++++---------------
>  drivers/remoteproc/remoteproc_internal.h |    2 +
>  drivers/remoteproc/remoteproc_virtio.c   |   13 +++-
>  3 files changed, 67 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index e756a0d..40e2b2d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -279,34 +279,17 @@ rproc_load_segments(struct rproc *rproc, const u8
> *elf_data, size_t len)
>        return ret;
>  }
>
> -static int
> -__rproc_handle_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc,
> int i)
> +int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  {
>        struct rproc *rproc = rvdev->rproc;
>        struct device *dev = rproc->dev;
> -       struct fw_rsc_vdev_vring *vring = &rsc->vring[i];
> +       struct rproc_vring *rvring = &rvdev->vring[i];
>        dma_addr_t dma;
>        void *va;
>        int ret, size, notifyid;
>
> -       dev_dbg(dev, "vdev rsc: vring%d: da %x, qsz %d, align %d\n",
> -                               i, vring->da, vring->num, vring->align);
> -
> -       /* make sure reserved bytes are zeroes */
> -       if (vring->reserved) {
> -               dev_err(dev, "vring rsc has non zero reserved bytes\n");
> -               return -EINVAL;
> -       }
> -
> -       /* verify queue size and vring alignment are sane */
> -       if (!vring->num || !vring->align) {
> -               dev_err(dev, "invalid qsz (%d) or alignment (%d)\n",
> -                                               vring->num, vring->align);
> -               return -EINVAL;
> -       }
> -
>        /* actual size of vring (in bytes) */
> -       size = PAGE_ALIGN(vring_size(vring->num, vring->align));
> +       size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
>
>        if (!idr_pre_get(&rproc->notifyids, GFP_KERNEL)) {
>                dev_err(dev, "idr_pre_get failed\n");
> @@ -316,6 +299,7 @@ __rproc_handle_vring(struct rproc_vdev *rvdev, struct
> fw_rsc_vdev *rsc, int i)
>        /*
>         * Allocate non-cacheable memory for the vring. In the future
>         * this call will also configure the IOMMU for us
> +        * TODO: let the rproc know the da of this vring
>         */
>        va = dma_alloc_coherent(dev, size, &dma, GFP_KERNEL);
>        if (!va) {
> @@ -323,44 +307,67 @@ __rproc_handle_vring(struct rproc_vdev *rvdev,
> struct fw_rsc_vdev *rsc, int i)
>                return -EINVAL;
>        }
>
> -       /* assign an rproc-wide unique index for this vring */
> -       /* TODO: assign a notifyid for rvdev updates as well */
> -       ret = idr_get_new(&rproc->notifyids, &rvdev->vring[i], &notifyid);
> +       /*
> +        * Assign an rproc-wide unique index for this vring
> +        * TODO: assign a notifyid for rvdev updates as well
> +        * TODO: let the rproc know the notifyid of this vring
> +        * TODO: support predefined notifyids (via resource table)
> +        */
> +       ret = idr_get_new(&rproc->notifyids, rvring, &notifyid);
>        if (ret) {
>                dev_err(dev, "idr_get_new failed: %d\n", ret);
>                dma_free_coherent(dev, size, va, dma);
>                return ret;
>        }
>
> -       /* let the rproc know the da and notifyid of this vring */
> -       /* TODO: expose this to remote processor */
> -       vring->da = dma;
> -       vring->notifyid = notifyid;
> -
>        dev_dbg(dev, "vring%d: va %p dma %x size %x idr %d\n", i, va,
>                                        dma, size, notifyid);
>
> -       rvdev->vring[i].len = vring->num;
> -       rvdev->vring[i].align = vring->align;
> -       rvdev->vring[i].va = va;
> -       rvdev->vring[i].dma = dma;
> -       rvdev->vring[i].notifyid = notifyid;
> -       rvdev->vring[i].rvdev = rvdev;
> +       rvring->va = va;
> +       rvring->dma = dma;
> +       rvring->notifyid = notifyid;
>
>        return 0;
>  }
>
> -static void __rproc_free_vrings(struct rproc_vdev *rvdev, int i)
> +static int
> +rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int
> i)
>  {
>        struct rproc *rproc = rvdev->rproc;
> +       struct device *dev = rproc->dev;
> +       struct fw_rsc_vdev_vring *vring = &rsc->vring[i];
> +       struct rproc_vring *rvring = &rvdev->vring[i];
>
> -       for (i--; i >= 0; i--) {
> -               struct rproc_vring *rvring = &rvdev->vring[i];
> -               int size = PAGE_ALIGN(vring_size(rvring->len,
> rvring->align));
> +       dev_dbg(dev, "vdev rsc: vring%d: da %x, qsz %d, align %d\n",
> +                               i, vring->da, vring->num, vring->align);
> +
> +       /* make sure reserved bytes are zeroes */
> +       if (vring->reserved) {
> +               dev_err(dev, "vring rsc has non zero reserved bytes\n");
> +               return -EINVAL;
> +       }
>
> -               dma_free_coherent(rproc->dev, size, rvring->va,
> rvring->dma);
> -               idr_remove(&rproc->notifyids, rvring->notifyid);
> +       /* verify queue size and vring alignment are sane */
> +       if (!vring->num || !vring->align) {
> +               dev_err(dev, "invalid qsz (%d) or alignment (%d)\n",
> +                                               vring->num, vring->align);
> +               return -EINVAL;
>        }
> +
> +       rvring->len = vring->num;
> +       rvring->align = vring->align;
> +       rvring->rvdev = rvdev;
> +
> +       return 0;
> +}
> +
> +void rproc_free_vring(struct rproc_vring *rvring)
> +{
> +       int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
> +       struct rproc *rproc = rvring->rvdev->rproc;
> +
> +       dma_free_coherent(rproc->dev, size, rvring->va, rvring->dma);
> +       idr_remove(&rproc->notifyids, rvring->notifyid);
>  }
>
>  /**
> @@ -425,11 +432,11 @@ static int rproc_handle_vdev(struct rproc *rproc,
> struct fw_rsc_vdev *rsc,
>
>        rvdev->rproc = rproc;
>
> -       /* allocate the vrings */
> +       /* parse the vrings */
>        for (i = 0; i < rsc->num_of_vrings; i++) {
> -               ret = __rproc_handle_vring(rvdev, rsc, i);
> +               ret = rproc_parse_vring(rvdev, rsc, i);
>                if (ret)
> -                       goto free_vrings;
> +                       goto free_rvdev;
>        }
>
>        /* remember the device features */
> @@ -440,12 +447,11 @@ static int rproc_handle_vdev(struct rproc *rproc,
> struct fw_rsc_vdev *rsc,
>        /* it is now safe to add the virtio device */
>        ret = rproc_add_virtio_dev(rvdev, rsc->id);
>        if (ret)
> -               goto free_vrings;
> +               goto free_rvdev;
>
>        return 0;
>
> -free_vrings:
> -       __rproc_free_vrings(rvdev, i);
> +free_rvdev:
>        kfree(rvdev);
>        return ret;
>  }
> @@ -1265,18 +1271,11 @@ EXPORT_SYMBOL(rproc_shutdown);
>  void rproc_release(struct kref *kref)
>  {
>        struct rproc *rproc = container_of(kref, struct rproc, refcount);
> -       struct rproc_vdev *rvdev, *rvtmp;
>
>        dev_info(rproc->dev, "removing %s\n", rproc->name);
>
>        rproc_delete_debug_dir(rproc);
>
> -       /* clean up remote vdev entries */
> -       list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node) {
> -               __rproc_free_vrings(rvdev, RVDEV_NUM_VRINGS);
> -               list_del(&rvdev->node);
> -       }
> -
>        /*
>         * At this point no one holds a reference to rproc anymore,
>         * so we can directly unroll rproc_alloc()
> @@ -1547,7 +1546,7 @@ EXPORT_SYMBOL(rproc_free);
>  */
>  int rproc_unregister(struct rproc *rproc)
>  {
> -       struct rproc_vdev *rvdev;
> +       struct rproc_vdev *rvdev, *tmp;
>
>        if (!rproc)
>                return -EINVAL;
> @@ -1556,7 +1555,7 @@ int rproc_unregister(struct rproc *rproc)
>        wait_for_completion(&rproc->firmware_loading_complete);
>
>        /* clean up remote vdev entries */
> -       list_for_each_entry(rvdev, &rproc->rvdevs, node)
> +       list_for_each_entry_safe(rvdev, tmp, &rproc->rvdevs, node)
>                rproc_remove_virtio_dev(rvdev);
>
>        /* the rproc is downref'ed as soon as it's removed from the klist */
> diff --git a/drivers/remoteproc/remoteproc_internal.h
> b/drivers/remoteproc/remoteproc_internal.h
> index 9f336d6..f4957cf 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -41,4 +41,6 @@ void rproc_create_debug_dir(struct rproc *rproc);
>  void rproc_init_debugfs(void);
>  void rproc_exit_debugfs(void);
>
> +void rproc_free_vring(struct rproc_vring *rvring);
> +int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  #endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/drivers/remoteproc/remoteproc_virtio.c
> b/drivers/remoteproc/remoteproc_virtio.c
> index ecf6121..26a7144 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -77,14 +77,17 @@ static struct virtqueue *rp_find_vq(struct
> virtio_device *vdev,
>        struct rproc_vring *rvring;
>        struct virtqueue *vq;
>        void *addr;
> -       int len, size;
> +       int len, size, ret;
>
>        /* we're temporarily limited to two virtqueues per rvdev */
>        if (id >= ARRAY_SIZE(rvdev->vring))
>                return ERR_PTR(-EINVAL);
>
> -       rvring = &rvdev->vring[id];
> +       ret = rproc_alloc_vring(rvdev, id);
> +       if (ret)
> +               return ERR_PTR(ret);
>
> +       rvring = &rvdev->vring[id];
>        addr = rvring->va;
>        len = rvring->len;
>
> @@ -103,6 +106,7 @@ static struct virtqueue *rp_find_vq(struct
> virtio_device *vdev,
>                                        rproc_virtio_notify, callback,
> name);
>        if (!vq) {
>                dev_err(rproc->dev, "vring_new_virtqueue %s failed\n",
> name);
> +               rproc_free_vring(rvring);
>                return ERR_PTR(-ENOMEM);
>        }
>
> @@ -125,6 +129,7 @@ static void rproc_virtio_del_vqs(struct virtio_device
> *vdev)
>                rvring = vq->priv;
>                rvring->vq = NULL;
>                vring_del_virtqueue(vq);
> +               rproc_free_vring(rvring);
>        }
>  }
>
> @@ -228,8 +233,12 @@ static struct virtio_config_ops
> rproc_virtio_config_ops = {
>  static void rproc_vdev_release(struct device *dev)
>  {
>        struct virtio_device *vdev = dev_to_virtio(dev);
> +       struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
>        struct rproc *rproc = vdev_to_rproc(vdev);
>
> +       list_del(&rvdev->node);
> +       kfree(rvdev);
> +
>        kref_put(&rproc->refcount, rproc_release);
>  }
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--14dae9340d31348c6704c08e8ee6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>Looks good to me.<div><br></div><div>=A0Tested-by: Fernando Guzman =
Lugo &lt;<a href=3D"mailto:fernando.lugo@ti.com">fernando.lugo@ti.com</a>&g=
t;</div><div><br></div><div>Regards,</div><div>Fernando.<br><br><div class=
=3D"gmail_quote">
On Sun, May 20, 2012 at 7:00 AM, Ohad Ben-Cohen <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:ohad@wizery.com" target=3D"_blank">ohad@wizery.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
Dynamically allocate the vrings&#39; DMA when the remote processor<br>
is about to be powered on (i.e. when -&gt;find_vqs() is invoked),<br>
and release them as soon as it is powered off (i.e. when -&gt;del_vqs()<br>
is invoked).<br>=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The obvious and immediate benefit is better memory utilization, since<br>
memory for the vrings is now only allocated when the relevant remote<br>
processor is being used.<br>
<br>
Additionally, this approach also makes recovery of a (crashing)<br>
remote processor easier: one just needs to remove the relevant<br>
vdevs, and the entire vrings cleanup takes place automagically.<br>
<br>
Tested-by: Fernando Guzman Lugo &lt;<a href=3D"mailto:fernando.lugo@ti.com"=
>fernando.lugo@ti.com</a>&gt;<br>
Signed-off-by: Ohad Ben-Cohen &lt;<a href=3D"mailto:ohad@wizery.com">ohad@w=
izery.com</a>&gt;<br>
---<br>
=A0drivers/remoteproc/remoteproc_core.c =A0 =A0 | =A0109 +++++++++++++++---=
------------<br>
=A0drivers/remoteproc/remoteproc_internal.h | =A0 =A02 +<br>
=A0drivers/remoteproc/remoteproc_virtio.c =A0 | =A0 13 +++-<br>
=A03 files changed, 67 insertions(+), 57 deletions(-)<br>
<br>
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remo=
teproc_core.c<br>
index e756a0d..40e2b2d 100644<br>
--- a/drivers/remoteproc/remoteproc_core.c<br>
+++ b/drivers/remoteproc/remoteproc_core.c<br>
@@ -279,34 +279,17 @@ rproc_load_segments(struct rproc *rproc, const u8 *el=
f_data, size_t len)<br>
 =A0 =A0 =A0 =A0return ret;<br>
=A0}<br>
<br>
-static int<br>
-__rproc_handle_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, in=
t i)<br>
+int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct rproc *rproc =3D rvdev-&gt;rproc;<br>
 =A0 =A0 =A0 =A0struct device *dev =3D rproc-&gt;dev;<br>
- =A0 =A0 =A0 struct fw_rsc_vdev_vring *vring =3D &amp;rsc-&gt;vring[i];<br=
>
+ =A0 =A0 =A0 struct rproc_vring *rvring =3D &amp;rvdev-&gt;vring[i];<br>
 =A0 =A0 =A0 =A0dma_addr_t dma;<br>
 =A0 =A0 =A0 =A0void *va;<br>
 =A0 =A0 =A0 =A0int ret, size, notifyid;<br>
<br>
- =A0 =A0 =A0 dev_dbg(dev, &quot;vdev rsc: vring%d: da %x, qsz %d, align %d=
\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, vring-&gt;=
da, vring-&gt;num, vring-&gt;align);<br>
-<br>
- =A0 =A0 =A0 /* make sure reserved bytes are zeroes */<br>
- =A0 =A0 =A0 if (vring-&gt;reserved) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;vring rsc has non zero res=
erved bytes\n&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
- =A0 =A0 =A0 }<br>
-<br>
- =A0 =A0 =A0 /* verify queue size and vring alignment are sane */<br>
- =A0 =A0 =A0 if (!vring-&gt;num || !vring-&gt;align) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;invalid qsz (%d) or alignm=
ent (%d)\n&quot;,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 vring-&gt;num, vring-&gt;align);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
- =A0 =A0 =A0 }<br>
-<br>
 =A0 =A0 =A0 =A0/* actual size of vring (in bytes) */<br>
- =A0 =A0 =A0 size =3D PAGE_ALIGN(vring_size(vring-&gt;num, vring-&gt;align=
));<br>
+ =A0 =A0 =A0 size =3D PAGE_ALIGN(vring_size(rvring-&gt;len, rvring-&gt;ali=
gn));<br>
<br>
 =A0 =A0 =A0 =A0if (!idr_pre_get(&amp;rproc-&gt;notifyids, GFP_KERNEL)) {<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, &quot;idr_pre_get failed\n&quo=
t;);<br>
@@ -316,6 +299,7 @@ __rproc_handle_vring(struct rproc_vdev *rvdev, struct f=
w_rsc_vdev *rsc, int i)<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * Allocate non-cacheable memory for the vring. In the futu=
re<br>
 =A0 =A0 =A0 =A0 * this call will also configure the IOMMU for us<br>
+ =A0 =A0 =A0 =A0* TODO: let the rproc know the da of this vring<br>
 =A0 =A0 =A0 =A0 */<br>
 =A0 =A0 =A0 =A0va =3D dma_alloc_coherent(dev, size, &amp;dma, GFP_KERNEL);=
<br>
 =A0 =A0 =A0 =A0if (!va) {<br>
@@ -323,44 +307,67 @@ __rproc_handle_vring(struct rproc_vdev *rvdev, struct=
 fw_rsc_vdev *rsc, int i)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 /* assign an rproc-wide unique index for this vring */<br>
- =A0 =A0 =A0 /* TODO: assign a notifyid for rvdev updates as well */<br>
- =A0 =A0 =A0 ret =3D idr_get_new(&amp;rproc-&gt;notifyids, &amp;rvdev-&gt;=
vring[i], &amp;notifyid);<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Assign an rproc-wide unique index for this vring<br>
+ =A0 =A0 =A0 =A0* TODO: assign a notifyid for rvdev updates as well<br>
+ =A0 =A0 =A0 =A0* TODO: let the rproc know the notifyid of this vring<br>
+ =A0 =A0 =A0 =A0* TODO: support predefined notifyids (via resource table)<=
br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 ret =3D idr_get_new(&amp;rproc-&gt;notifyids, rvring, &amp;no=
tifyid);<br>
 =A0 =A0 =A0 =A0if (ret) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, &quot;idr_get_new failed: %d\n=
&quot;, ret);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_free_coherent(dev, size, va, dma);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 /* let the rproc know the da and notifyid of this vring */<br=
>
- =A0 =A0 =A0 /* TODO: expose this to remote processor */<br>
- =A0 =A0 =A0 vring-&gt;da =3D dma;<br>
- =A0 =A0 =A0 vring-&gt;notifyid =3D notifyid;<br>
-<br>
 =A0 =A0 =A0 =A0dev_dbg(dev, &quot;vring%d: va %p dma %x size %x idr %d\n&q=
uot;, i, va,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0dma, size, notifyid);<br>
<br>
- =A0 =A0 =A0 rvdev-&gt;vring[i].len =3D vring-&gt;num;<br>
- =A0 =A0 =A0 rvdev-&gt;vring[i].align =3D vring-&gt;align;<br>
- =A0 =A0 =A0 rvdev-&gt;vring[i].va =3D va;<br>
- =A0 =A0 =A0 rvdev-&gt;vring[i].dma =3D dma;<br>
- =A0 =A0 =A0 rvdev-&gt;vring[i].notifyid =3D notifyid;<br>
- =A0 =A0 =A0 rvdev-&gt;vring[i].rvdev =3D rvdev;<br>
+ =A0 =A0 =A0 rvring-&gt;va =3D va;<br>
+ =A0 =A0 =A0 rvring-&gt;dma =3D dma;<br>
+ =A0 =A0 =A0 rvring-&gt;notifyid =3D notifyid;<br>
<br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
<br>
-static void __rproc_free_vrings(struct rproc_vdev *rvdev, int i)<br>
+static int<br>
+rproc_parse_vring(struct rproc_vdev *rvdev, struct fw_rsc_vdev *rsc, int i=
)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct rproc *rproc =3D rvdev-&gt;rproc;<br>
+ =A0 =A0 =A0 struct device *dev =3D rproc-&gt;dev;<br>
+ =A0 =A0 =A0 struct fw_rsc_vdev_vring *vring =3D &amp;rsc-&gt;vring[i];<br=
>
+ =A0 =A0 =A0 struct rproc_vring *rvring =3D &amp;rvdev-&gt;vring[i];<br>
<br>
- =A0 =A0 =A0 for (i--; i &gt;=3D 0; i--) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rproc_vring *rvring =3D &amp;rvdev-&gt=
;vring[i];<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 int size =3D PAGE_ALIGN(vring_size(rvring-&gt=
;len, rvring-&gt;align));<br>
+ =A0 =A0 =A0 dev_dbg(dev, &quot;vdev rsc: vring%d: da %x, qsz %d, align %d=
\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, vring-&gt;=
da, vring-&gt;num, vring-&gt;align);<br>
+<br>
+ =A0 =A0 =A0 /* make sure reserved bytes are zeroes */<br>
+ =A0 =A0 =A0 if (vring-&gt;reserved) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;vring rsc has non zero res=
erved bytes\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_free_coherent(rproc-&gt;dev, size, rvring=
-&gt;va, rvring-&gt;dma);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 idr_remove(&amp;rproc-&gt;notifyids, rvring-&=
gt;notifyid);<br>
+ =A0 =A0 =A0 /* verify queue size and vring alignment are sane */<br>
+ =A0 =A0 =A0 if (!vring-&gt;num || !vring-&gt;align) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;invalid qsz (%d) or alignm=
ent (%d)\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 vring-&gt;num, vring-&gt;align);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
 =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 rvring-&gt;len =3D vring-&gt;num;<br>
+ =A0 =A0 =A0 rvring-&gt;align =3D vring-&gt;align;<br>
+ =A0 =A0 =A0 rvring-&gt;rvdev =3D rvdev;<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+void rproc_free_vring(struct rproc_vring *rvring)<br>
+{<br>
+ =A0 =A0 =A0 int size =3D PAGE_ALIGN(vring_size(rvring-&gt;len, rvring-&gt=
;align));<br>
+ =A0 =A0 =A0 struct rproc *rproc =3D rvring-&gt;rvdev-&gt;rproc;<br>
+<br>
+ =A0 =A0 =A0 dma_free_coherent(rproc-&gt;dev, size, rvring-&gt;va, rvring-=
&gt;dma);<br>
+ =A0 =A0 =A0 idr_remove(&amp;rproc-&gt;notifyids, rvring-&gt;notifyid);<br=
>
=A0}<br>
<br>
=A0/**<br>
@@ -425,11 +432,11 @@ static int rproc_handle_vdev(struct rproc *rproc, str=
uct fw_rsc_vdev *rsc,<br>
<br>
 =A0 =A0 =A0 =A0rvdev-&gt;rproc =3D rproc;<br>
<br>
- =A0 =A0 =A0 /* allocate the vrings */<br>
+ =A0 =A0 =A0 /* parse the vrings */<br>
 =A0 =A0 =A0 =A0for (i =3D 0; i &lt; rsc-&gt;num_of_vrings; i++) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __rproc_handle_vring(rvdev, rsc, i);<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D rproc_parse_vring(rvdev, rsc, i);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_vrings;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_rvdev;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0/* remember the device features */<br>
@@ -440,12 +447,11 @@ static int rproc_handle_vdev(struct rproc *rproc, str=
uct fw_rsc_vdev *rsc,<br>
 =A0 =A0 =A0 =A0/* it is now safe to add the virtio device */<br>
 =A0 =A0 =A0 =A0ret =3D rproc_add_virtio_dev(rvdev, rsc-&gt;id);<br>
 =A0 =A0 =A0 =A0if (ret)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_vrings;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_rvdev;<br>
<br>
 =A0 =A0 =A0 =A0return 0;<br>
<br>
-free_vrings:<br>
- =A0 =A0 =A0 __rproc_free_vrings(rvdev, i);<br>
+free_rvdev:<br>
 =A0 =A0 =A0 =A0kfree(rvdev);<br>
 =A0 =A0 =A0 =A0return ret;<br>
=A0}<br>
@@ -1265,18 +1271,11 @@ EXPORT_SYMBOL(rproc_shutdown);<br>
=A0void rproc_release(struct kref *kref)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct rproc *rproc =3D container_of(kref, struct rproc, re=
fcount);<br>
- =A0 =A0 =A0 struct rproc_vdev *rvdev, *rvtmp;<br>
<br>
 =A0 =A0 =A0 =A0dev_info(rproc-&gt;dev, &quot;removing %s\n&quot;, rproc-&g=
t;name);<br>
<br>
 =A0 =A0 =A0 =A0rproc_delete_debug_dir(rproc);<br>
<br>
- =A0 =A0 =A0 /* clean up remote vdev entries */<br>
- =A0 =A0 =A0 list_for_each_entry_safe(rvdev, rvtmp, &amp;rproc-&gt;rvdevs,=
 node) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 __rproc_free_vrings(rvdev, RVDEV_NUM_VRINGS);=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&amp;rvdev-&gt;node);<br>
- =A0 =A0 =A0 }<br>
-<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * At this point no one holds a reference to rproc anymore,=
<br>
 =A0 =A0 =A0 =A0 * so we can directly unroll rproc_alloc()<br>
@@ -1547,7 +1546,7 @@ EXPORT_SYMBOL(rproc_free);<br>
 =A0*/<br>
=A0int rproc_unregister(struct rproc *rproc)<br>
=A0{<br>
- =A0 =A0 =A0 struct rproc_vdev *rvdev;<br>
+ =A0 =A0 =A0 struct rproc_vdev *rvdev, *tmp;<br>
<br>
 =A0 =A0 =A0 =A0if (!rproc)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;<br>
@@ -1556,7 +1555,7 @@ int rproc_unregister(struct rproc *rproc)<br>
 =A0 =A0 =A0 =A0wait_for_completion(&amp;rproc-&gt;firmware_loading_complet=
e);<br>
<br>
 =A0 =A0 =A0 =A0/* clean up remote vdev entries */<br>
- =A0 =A0 =A0 list_for_each_entry(rvdev, &amp;rproc-&gt;rvdevs, node)<br>
+ =A0 =A0 =A0 list_for_each_entry_safe(rvdev, tmp, &amp;rproc-&gt;rvdevs, n=
ode)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rproc_remove_virtio_dev(rvdev);<br>
<br>
 =A0 =A0 =A0 =A0/* the rproc is downref&#39;ed as soon as it&#39;s removed =
from the klist */<br>
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/=
remoteproc_internal.h<br>
index 9f336d6..f4957cf 100644<br>
--- a/drivers/remoteproc/remoteproc_internal.h<br>
+++ b/drivers/remoteproc/remoteproc_internal.h<br>
@@ -41,4 +41,6 @@ void rproc_create_debug_dir(struct rproc *rproc);<br>
=A0void rproc_init_debugfs(void);<br>
=A0void rproc_exit_debugfs(void);<br>
<br>
+void rproc_free_vring(struct rproc_vring *rvring);<br>
+int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);<br>
=A0#endif /* REMOTEPROC_INTERNAL_H */<br>
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/re=
moteproc_virtio.c<br>
index ecf6121..26a7144 100644<br>
--- a/drivers/remoteproc/remoteproc_virtio.c<br>
+++ b/drivers/remoteproc/remoteproc_virtio.c<br>
@@ -77,14 +77,17 @@ static struct virtqueue *rp_find_vq(struct virtio_devic=
e *vdev,<br>
 =A0 =A0 =A0 =A0struct rproc_vring *rvring;<br>
 =A0 =A0 =A0 =A0struct virtqueue *vq;<br>
 =A0 =A0 =A0 =A0void *addr;<br>
- =A0 =A0 =A0 int len, size;<br>
+ =A0 =A0 =A0 int len, size, ret;<br>
<br>
 =A0 =A0 =A0 =A0/* we&#39;re temporarily limited to two virtqueues per rvde=
v */<br>
 =A0 =A0 =A0 =A0if (id &gt;=3D ARRAY_SIZE(rvdev-&gt;vring))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);<br>
<br>
- =A0 =A0 =A0 rvring =3D &amp;rvdev-&gt;vring[id];<br>
+ =A0 =A0 =A0 ret =3D rproc_alloc_vring(rvdev, id);<br>
+ =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(ret);<br>
<br>
+ =A0 =A0 =A0 rvring =3D &amp;rvdev-&gt;vring[id];<br>
 =A0 =A0 =A0 =A0addr =3D rvring-&gt;va;<br>
 =A0 =A0 =A0 =A0len =3D rvring-&gt;len;<br>
<br>
@@ -103,6 +106,7 @@ static struct virtqueue *rp_find_vq(struct virtio_devic=
e *vdev,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0rproc_virtio_notify, callback, name);<br>
 =A0 =A0 =A0 =A0if (!vq) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(rproc-&gt;dev, &quot;vring_new_virt=
queue %s failed\n&quot;, name);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rproc_free_vring(rvring);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOMEM);<br>
 =A0 =A0 =A0 =A0}<br>
<br>
@@ -125,6 +129,7 @@ static void rproc_virtio_del_vqs(struct virtio_device *=
vdev)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rvring =3D vq-&gt;priv;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rvring-&gt;vq =3D NULL;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vring_del_virtqueue(vq);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rproc_free_vring(rvring);<br>
 =A0 =A0 =A0 =A0}<br>
=A0}<br>
<br>
@@ -228,8 +233,12 @@ static struct virtio_config_ops rproc_virtio_config_op=
s =3D {<br>
=A0static void rproc_vdev_release(struct device *dev)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct virtio_device *vdev =3D dev_to_virtio(dev);<br>
+ =A0 =A0 =A0 struct rproc_vdev *rvdev =3D vdev_to_rvdev(vdev);<br>
 =A0 =A0 =A0 =A0struct rproc *rproc =3D vdev_to_rproc(vdev);<br>
<br>
+ =A0 =A0 =A0 list_del(&amp;rvdev-&gt;node);<br>
+ =A0 =A0 =A0 kfree(rvdev);<br>
+<br>
 =A0 =A0 =A0 =A0kref_put(&amp;rproc-&gt;refcount, rproc_release);<br>
=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.5.4<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-omap&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></blockquote></div><br></div>

--14dae9340d31348c6704c08e8ee6--


--===============6085772855385464970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6085772855385464970==--
