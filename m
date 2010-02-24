From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V1 09/10] VPFE Capture: Add support for USERPTR mode of
 	operation
Date: Wed, 24 Feb 2010 11:07:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DA99712@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1266914073-30135-10-git-send-email-hvaibhav@ti.com>
 <55a3e0ce1002231522q6a3fb7cak530e8b970dcbdee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab0BXFhk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 00:37:40 -0500
In-Reply-To: <55a3e0ce1002231522q6a3fb7cak530e8b970dcbdee5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Muralidharan Karicheri <mkaricheri@gmail.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>


> -----Original Message-----
> From: Muralidharan Karicheri [mailto:mkaricheri@gmail.com]
> Sent: Wednesday, February 24, 2010 4:53 AM
> To: Hiremath, Vaibhav
> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org;
> hverkuil@xs4all.nl; Karicheri, Muralidharan
> Subject: Re: [PATCH-V1 09/10] VPFE Capture: Add support for USERPTR m=
ode of
> operation
>=20
> Vaibhav,
>=20
> There are changes to vpfe capture on Arago tree on top of this. For
> example, vpfe_uservirt_to_phys() is removed and is replaced with
> videobuf_iolock(). So please get the latest changes to upstream.
>=20
[Hiremath, Vaibhav] No, the Arago version doesn't support USERPTR mode =
at all,


1386		if (V4L2_MEMORY_USERPTR =3D=3D req_buf->memory) {
1386                 /* we don't support user ptr IO */
1387                 v4l2_dbg(1, debug, &vpfe_dev->v4l2_dev, "vpfe_reqb=
ufs:"
1388                          " USERPTR IO not supported\n");
1389                 return  -EINVAL;
1390         }

And also, I have received important comment from Mauro, which expects s=
ome code tobe moved to generic VideoBuf layer. I will be submitting pat=
ch for the same separately.

Thanks,
Vaibhav

> Murali
>=20
> On Tue, Feb 23, 2010 at 3:34 AM,  <hvaibhav@ti.com> wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Muralidharan Karicheri <m-karicheri2@ti.com>
> > ---
> > =A0drivers/media/video/ti-media/vpfe_capture.c | =A0 94
> ++++++++++++++++++++++----
> > =A01 files changed, 79 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/media/video/ti-media/vpfe_capture.c
> b/drivers/media/video/ti-media/vpfe_capture.c
> > index cece265..7d4ab44 100644
> > --- a/drivers/media/video/ti-media/vpfe_capture.c
> > +++ b/drivers/media/video/ti-media/vpfe_capture.c
> > @@ -538,7 +538,24 @@ static void vpfe_schedule_next_buffer(struct
> vpfe_device *vpfe_dev)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct videobuf_buffer, queue);
> > =A0 =A0 =A0 =A0list_del(&vpfe_dev->next_frm->queue);
> > =A0 =A0 =A0 =A0vpfe_dev->next_frm->state =3D VIDEOBUF_ACTIVE;
> > - =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_dev->next_frm);
> > + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D vpfe_dev->cur_frm->boff;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_=
dev->next_frm);
> > +
> > + =A0 =A0 =A0 ccdc_dev->hw_ops.setfbaddr(addr);
> > +}
> > +
> > +static void vpfe_schedule_bottom_field(struct vpfe_device *vpfe_de=
v)
> > +{
> > + =A0 =A0 =A0 unsigned long addr;
> > +
> > + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D vpfe_dev->cur_frm->boff;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_=
dev->cur_frm);
> > +
> > + =A0 =A0 =A0 addr +=3D vpfe_dev->field_off;
> > =A0 =A0 =A0 =A0ccdc_dev->hw_ops.setfbaddr(addr);
> > =A0}
> >
> > @@ -559,7 +576,6 @@ static irqreturn_t vpfe_isr(int irq, void *dev_=
id)
> > =A0{
> > =A0 =A0 =A0 =A0struct vpfe_device *vpfe_dev =3D dev_id;
> > =A0 =A0 =A0 =A0enum v4l2_field field;
> > - =A0 =A0 =A0 unsigned long addr;
> > =A0 =A0 =A0 =A0int fid;
> >
> > =A0 =A0 =A0 =A0v4l2_dbg(1, debug, &vpfe_dev->v4l2_dev, "\nStarting
> vpfe_isr...\n");
> > @@ -604,10 +620,7 @@ static irqreturn_t vpfe_isr(int irq, void *dev=
_id)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the CCDC memory a=
ddress
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (field =3D=3D V4L=
2_FIELD_SEQ_TB) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =
=3D
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v=
ideobuf_to_dma_contig(vpfe_dev-
> >cur_frm);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =
+=3D vpfe_dev->field_off;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccdc_=
dev->hw_ops.setfbaddr(addr);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vpfe_=
schedule_bottom_field(vpfe_dev);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto clear_intr;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > @@ -1234,7 +1247,10 @@ static int vpfe_videobuf_setup(struct
> videobuf_queue *vq,
> > =A0 =A0 =A0 =A0struct vpfe_device *vpfe_dev =3D fh->vpfe_dev;
> >
> > =A0 =A0 =A0 =A0v4l2_dbg(1, debug, &vpfe_dev->v4l2_dev, "vpfe_buffer=
_setup\n");
> > - =A0 =A0 =A0 *size =3D config_params.device_bufsize;
> > + =A0 =A0 =A0 *size =3D vpfe_dev->fmt.fmt.pix.sizeimage;
> > + =A0 =A0 =A0 if (vpfe_dev->memory =3D=3D V4L2_MEMORY_MMAP &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vpfe_dev->fmt.fmt.pix.sizeimage >
> config_params.device_bufsize)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D config_params.device_bufsiz=
e;
> >
> > =A0 =A0 =A0 =A0if (*count < config_params.min_numbuffers)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*count =3D config_params.min_numbuff=
ers;
> > @@ -1243,6 +1259,46 @@ static int vpfe_videobuf_setup(struct
> videobuf_queue *vq,
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> >
> > +/*
> > + * vpfe_uservirt_to_phys: This function is used to convert user
> > + * space virtual address to physical address.
> > + */
> > +static u32 vpfe_uservirt_to_phys(struct vpfe_device *vpfe_dev, u32=
 virtp)
> > +{
> > + =A0 =A0 =A0 struct mm_struct *mm =3D current->mm;
> > + =A0 =A0 =A0 unsigned long physp =3D 0;
> > + =A0 =A0 =A0 struct vm_area_struct *vma;
> > +
> > + =A0 =A0 =A0 vma =3D find_vma(mm, virtp);
> > +
> > + =A0 =A0 =A0 /* For kernel direct-mapped memory, take the easy way=
 */
> > + =A0 =A0 =A0 if (virtp >=3D PAGE_OFFSET)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D virt_to_phys((void *)virtp)=
;
> > + =A0 =A0 =A0 else if (vma && (vma->vm_flags & VM_IO) && (vma->vm_p=
goff))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will catch, kernel-allocated,=
 mmaped-to-usermode
> addr */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D (vma->vm_pgoff << PAGE_SHIF=
T) + (virtp - vma-
> >vm_start);
> > + =A0 =A0 =A0 else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* otherwise, use get_user_pages() fo=
r general userland
> pages */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int res, nr_pages =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct page *pages;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 down_read(&current->mm->mmap_sem);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D get_user_pages(current, curre=
nt->mm,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0virtp, nr_pages, 1, 0, &pages, NULL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up_read(&current->mm->mmap_sem);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D nr_pages)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D __pa(page_a=
ddress(&pages[0]) +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(virtp & ~PAGE_MASK));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_dbg(1, debug, &v=
pfe_dev->v4l2_dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "get_=
user_pages failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 return physp;
> > +}
> > +
> > =A0static int vpfe_videobuf_prepare(struct videobuf_queue *vq,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct videobuf_buffer *vb,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum=
 v4l2_field field)
> > @@ -1259,6 +1315,18 @@ static int vpfe_videobuf_prepare(struct
> videobuf_queue *vq,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vb->size =3D vpfe_dev->fmt.fmt.pix.s=
izeimage;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vb->field =3D field;
> > =A0 =A0 =A0 =A0}
> > +
> > + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vb->baddr) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_dbg(1, debug, &v=
pfe_dev->v4l2_dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "buff=
er address is 0\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb->boff =3D vpfe_uservirt_to_phys(vp=
fe_dev, vb->baddr);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Make sure user addresses are align=
ed to 32 bytes */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ALIGN(vb->boff, 32))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0vb->state =3D VIDEOBUF_PREPARED;
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> > @@ -1327,13 +1395,6 @@ static int vpfe_reqbufs(struct file *file, v=
oid
> *priv,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D req_buf->memory) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we don't support user ptr IO */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_dbg(1, debug, &vpfe_dev->v4l2_de=
v, "vpfe_reqbufs:"
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" USERPTR IO not s=
upported\n");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-EINVAL;
> > - =A0 =A0 =A0 }
> > -
> > =A0 =A0 =A0 =A0ret =3D mutex_lock_interruptible(&vpfe_dev->lock);
> > =A0 =A0 =A0 =A0if (ret)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> > @@ -1541,7 +1602,10 @@ static int vpfe_streamon(struct file *file, =
void
> *priv,
> > =A0 =A0 =A0 =A0vpfe_dev->cur_frm->state =3D VIDEOBUF_ACTIVE;
> > =A0 =A0 =A0 =A0/* Initialize field_id and started member */
> > =A0 =A0 =A0 =A0vpfe_dev->field_id =3D 0;
> > - =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_dev->cur_frm);
> > + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D vpfe_dev->cur_frm->boff;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_=
dev->cur_frm);
> >
> > =A0 =A0 =A0 =A0/* Calculate field offset */
> > =A0 =A0 =A0 =A0vpfe_calculate_offsets(vpfe_dev);
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-med=
ia" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
>=20
>=20
> --
> Murali Karicheri
> mkaricheri@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
