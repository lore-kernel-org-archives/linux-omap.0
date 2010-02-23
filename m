From: Muralidharan Karicheri <mkaricheri@gmail.com>
Subject: Re: [PATCH-V1 09/10] VPFE Capture: Add support for USERPTR mode of
	operation
Date: Tue, 23 Feb 2010 18:22:59 -0500
Message-ID: <55a3e0ce1002231522q6a3fb7cak530e8b970dcbdee5@mail.gmail.com>
References: <hvaibhav@ti.com>
	 <1266914073-30135-10-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39776 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab0BWXXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 18:23:01 -0500
In-Reply-To: <1266914073-30135-10-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, hverkuil@xs4all.nl, Muralidharan Karicheri <m-karicheri2@ti.com>

Vaibhav,

There are changes to vpfe capture on Arago tree on top of this. For
example, vpfe_uservirt_to_phys() is removed and is replaced with
videobuf_iolock(). So please get the latest changes to upstream.

Murali

On Tue, Feb 23, 2010 at 3:34 AM,  <hvaibhav@ti.com> wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Muralidharan Karicheri <m-karicheri2@ti.com>
> ---
> =A0drivers/media/video/ti-media/vpfe_capture.c | =A0 94 +++++++++++++=
+++++++++----
> =A01 files changed, 79 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/media/video/ti-media/vpfe_capture.c b/drivers/me=
dia/video/ti-media/vpfe_capture.c
> index cece265..7d4ab44 100644
> --- a/drivers/media/video/ti-media/vpfe_capture.c
> +++ b/drivers/media/video/ti-media/vpfe_capture.c
> @@ -538,7 +538,24 @@ static void vpfe_schedule_next_buffer(struct vpf=
e_device *vpfe_dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct videobuf_buffer, queue);
> =A0 =A0 =A0 =A0list_del(&vpfe_dev->next_frm->queue);
> =A0 =A0 =A0 =A0vpfe_dev->next_frm->state =3D VIDEOBUF_ACTIVE;
> - =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_dev->next_frm);
> + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D vpfe_dev->cur_frm->boff;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_de=
v->next_frm);
> +
> + =A0 =A0 =A0 ccdc_dev->hw_ops.setfbaddr(addr);
> +}
> +
> +static void vpfe_schedule_bottom_field(struct vpfe_device *vpfe_dev)
> +{
> + =A0 =A0 =A0 unsigned long addr;
> +
> + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D vpfe_dev->cur_frm->boff;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_de=
v->cur_frm);
> +
> + =A0 =A0 =A0 addr +=3D vpfe_dev->field_off;
> =A0 =A0 =A0 =A0ccdc_dev->hw_ops.setfbaddr(addr);
> =A0}
>
> @@ -559,7 +576,6 @@ static irqreturn_t vpfe_isr(int irq, void *dev_id=
)
> =A0{
> =A0 =A0 =A0 =A0struct vpfe_device *vpfe_dev =3D dev_id;
> =A0 =A0 =A0 =A0enum v4l2_field field;
> - =A0 =A0 =A0 unsigned long addr;
> =A0 =A0 =A0 =A0int fid;
>
> =A0 =A0 =A0 =A0v4l2_dbg(1, debug, &vpfe_dev->v4l2_dev, "\nStarting vp=
fe_isr...\n");
> @@ -604,10 +620,7 @@ static irqreturn_t vpfe_isr(int irq, void *dev_i=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the CCDC memory add=
ress
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (field =3D=3D V4L2_=
=46IELD_SEQ_TB) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid=
eobuf_to_dma_contig(vpfe_dev->cur_frm);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr +=3D=
 vpfe_dev->field_off;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ccdc_de=
v->hw_ops.setfbaddr(addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vpfe_sc=
hedule_bottom_field(vpfe_dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto clear_intr;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1234,7 +1247,10 @@ static int vpfe_videobuf_setup(struct videobuf=
_queue *vq,
> =A0 =A0 =A0 =A0struct vpfe_device *vpfe_dev =3D fh->vpfe_dev;
>
> =A0 =A0 =A0 =A0v4l2_dbg(1, debug, &vpfe_dev->v4l2_dev, "vpfe_buffer_s=
etup\n");
> - =A0 =A0 =A0 *size =3D config_params.device_bufsize;
> + =A0 =A0 =A0 *size =3D vpfe_dev->fmt.fmt.pix.sizeimage;
> + =A0 =A0 =A0 if (vpfe_dev->memory =3D=3D V4L2_MEMORY_MMAP &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vpfe_dev->fmt.fmt.pix.sizeimage > confi=
g_params.device_bufsize)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *size =3D config_params.device_bufsize;
>
> =A0 =A0 =A0 =A0if (*count < config_params.min_numbuffers)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*count =3D config_params.min_numbuffer=
s;
> @@ -1243,6 +1259,46 @@ static int vpfe_videobuf_setup(struct videobuf=
_queue *vq,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/*
> + * vpfe_uservirt_to_phys: This function is used to convert user
> + * space virtual address to physical address.
> + */
> +static u32 vpfe_uservirt_to_phys(struct vpfe_device *vpfe_dev, u32 v=
irtp)
> +{
> + =A0 =A0 =A0 struct mm_struct *mm =3D current->mm;
> + =A0 =A0 =A0 unsigned long physp =3D 0;
> + =A0 =A0 =A0 struct vm_area_struct *vma;
> +
> + =A0 =A0 =A0 vma =3D find_vma(mm, virtp);
> +
> + =A0 =A0 =A0 /* For kernel direct-mapped memory, take the easy way *=
/
> + =A0 =A0 =A0 if (virtp >=3D PAGE_OFFSET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D virt_to_phys((void *)virtp);
> + =A0 =A0 =A0 else if (vma && (vma->vm_flags & VM_IO) && (vma->vm_pgo=
ff))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will catch, kernel-allocated, m=
maped-to-usermode addr */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D (vma->vm_pgoff << PAGE_SHIFT)=
 + (virtp - vma->vm_start);
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* otherwise, use get_user_pages() for =
general userland pages */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int res, nr_pages =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct page *pages;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 down_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D get_user_pages(current, current=
->mm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0virtp, nr_pages, 1, 0, &pages, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D nr_pages)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D __pa(page_add=
ress(&pages[0]) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(virtp & ~PAGE_MASK));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_dbg(1, debug, &vpf=
e_dev->v4l2_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "get_us=
er_pages failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return physp;
> +}
> +
> =A0static int vpfe_videobuf_prepare(struct videobuf_queue *vq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 videobuf_buffer *vb,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum v=
4l2_field field)
> @@ -1259,6 +1315,18 @@ static int vpfe_videobuf_prepare(struct videob=
uf_queue *vq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vb->size =3D vpfe_dev->fmt.fmt.pix.siz=
eimage;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vb->field =3D field;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vb->baddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_dbg(1, debug, &vpf=
e_dev->v4l2_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "buffer=
 address is 0\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb->boff =3D vpfe_uservirt_to_phys(vpfe=
_dev, vb->baddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Make sure user addresses are aligned=
 to 32 bytes */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ALIGN(vb->boff, 32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0vb->state =3D VIDEOBUF_PREPARED;
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -1327,13 +1395,6 @@ static int vpfe_reqbufs(struct file *file, voi=
d *priv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D req_buf->memory) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we don't support user ptr IO */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_dbg(1, debug, &vpfe_dev->v4l2_dev,=
 "vpfe_reqbufs:"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" USERPTR IO not sup=
ported\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-EINVAL;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0ret =3D mutex_lock_interruptible(&vpfe_dev->lock);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1541,7 +1602,10 @@ static int vpfe_streamon(struct file *file, vo=
id *priv,
> =A0 =A0 =A0 =A0vpfe_dev->cur_frm->state =3D VIDEOBUF_ACTIVE;
> =A0 =A0 =A0 =A0/* Initialize field_id and started member */
> =A0 =A0 =A0 =A0vpfe_dev->field_id =3D 0;
> - =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_dev->cur_frm);
> + =A0 =A0 =A0 if (V4L2_MEMORY_USERPTR =3D=3D vpfe_dev->memory)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D vpfe_dev->cur_frm->boff;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D videobuf_to_dma_contig(vpfe_de=
v->cur_frm);
>
> =A0 =A0 =A0 =A0/* Calculate field offset */
> =A0 =A0 =A0 =A0vpfe_calculate_offsets(vpfe_dev);
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Murali Karicheri
mkaricheri@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
