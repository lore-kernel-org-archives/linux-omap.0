From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: Re: [RFC PATCH v1 4/7] media: videobuf2: introduce VIDEOBUF2_PAGE memops
Date: Fri, 2 Dec 2011 10:35:00 -0600
Message-ID: <CAKnK67SDyFCbLjpwzY9JQiBHJTgpF9uXOq+GUBW7oWv_5gZzbA@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <1322817178-8931-5-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322817178-8931-5-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Sylwester Nawrocki <snjw23@gmail.com>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ming,

On Fri, Dec 2, 2011 at 3:12 AM, Ming Lei <ming.lei@canonical.com> wrote=
:
> DMA contig memory resource is very limited and precious, also
> accessing to it from CPU is very slow on some platform.
>
> For some cases(such as the comming face detection driver), DMA Stream=
ing
> buffer is enough, so introduce VIDEOBUF2_PAGE to allocate continuous
> physical memory but letting video device driver to handle DMA buffer =
mapping
> and unmapping things.
>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/media/video/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/media/video/videobuf2-page.c | =A0115 ++++++++++++++++++++=
++++++++++++++
> =A0include/media/videobuf2-page.h =A0 =A0 =A0 | =A0 20 ++++++
> =A04 files changed, 140 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/media/video/videobuf2-page.c
> =A0create mode 100644 include/media/videobuf2-page.h
>
> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfi=
g
> index 4e8a0c4..5684a00 100644
> --- a/drivers/media/video/Kconfig
> +++ b/drivers/media/video/Kconfig
> @@ -60,6 +60,10 @@ config VIDEOBUF2_VMALLOC
> =A0 =A0 =A0 =A0select VIDEOBUF2_MEMOPS
> =A0 =A0 =A0 =A0tristate
>
> +config VIDEOBUF2_PAGE
> + =A0 =A0 =A0 select VIDEOBUF2_CORE
> + =A0 =A0 =A0 select VIDEOBUF2_MEMOPS
> + =A0 =A0 =A0 tristate
>
> =A0config VIDEOBUF2_DMA_SG
> =A0 =A0 =A0 =A0#depends on HAS_DMA
> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makef=
ile
> index ddeaa6c..bc797f2 100644
> --- a/drivers/media/video/Makefile
> +++ b/drivers/media/video/Makefile
> @@ -125,6 +125,7 @@ obj-$(CONFIG_VIDEO_BTCX) =A0+=3D btcx-risc.o
> =A0obj-$(CONFIG_VIDEOBUF2_CORE) =A0 =A0 =A0 =A0 =A0 +=3D videobuf2-co=
re.o
> =A0obj-$(CONFIG_VIDEOBUF2_MEMOPS) =A0 =A0 =A0 =A0 +=3D videobuf2-memo=
ps.o
> =A0obj-$(CONFIG_VIDEOBUF2_VMALLOC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 videobuf2-vmalloc.o
> +obj-$(CONFIG_VIDEOBUF2_PAGE) =A0 =A0 =A0 =A0 =A0 +=3D videobuf2-page=
=2Eo
> =A0obj-$(CONFIG_VIDEOBUF2_DMA_CONTIG) =A0 =A0 +=3D videobuf2-dma-cont=
ig.o
> =A0obj-$(CONFIG_VIDEOBUF2_DMA_SG) =A0 =A0 =A0 =A0 +=3D videobuf2-dma-=
sg.o
>
> diff --git a/drivers/media/video/videobuf2-page.c b/drivers/media/vid=
eo/videobuf2-page.c
> new file mode 100644
> index 0000000..b3f003a
> --- /dev/null
> +++ b/drivers/media/video/videobuf2-page.c
> @@ -0,0 +1,115 @@
> +/*
> + * videobuf2-page.c - page memory allocator for videobuf2
> + *
> + * Copyright (C) 2011 Canonical Ltd.
> + *
> + * Author: Ming Lei <ming.lei@canonical.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-memops.h>
> +
> +struct vb2_page_buf {
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*vaddr;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size;
> + =A0 =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
refcount;
> + =A0 =A0 =A0 struct vb2_vmarea_handler =A0 =A0 =A0 handler;
> +};
> +
> +static void vb2_page_put(void *buf_priv);
> +
> +static void *vb2_page_alloc(void *alloc_ctx, unsigned long size)
> +{
> + =A0 =A0 =A0 struct vb2_page_buf *buf;
> +
> + =A0 =A0 =A0 buf =3D kzalloc(sizeof *buf, GFP_KERNEL);
> + =A0 =A0 =A0 if (!buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 buf->size =3D size;
> + =A0 =A0 =A0 buf->vaddr =3D (void *)__get_free_pages(GFP_KERNEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_order(buf->size));
> + =A0 =A0 =A0 buf->handler.refcount =3D &buf->refcount;
> + =A0 =A0 =A0 buf->handler.put =3D vb2_page_put;
> + =A0 =A0 =A0 buf->handler.arg =3D buf;
> +
> + =A0 =A0 =A0 if (!buf->vaddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "page of size %ld faile=
d\n", buf->size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 atomic_inc(&buf->refcount);
> + =A0 =A0 =A0 printk(KERN_DEBUG "Allocated page buffer of size %ld at=
 vaddr=3D%p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf->size, buf->vaddr);
> +
> + =A0 =A0 =A0 return buf;
> +}
> +
> +static void vb2_page_put(void *buf_priv)
> +{
> + =A0 =A0 =A0 struct vb2_page_buf *buf =3D buf_priv;
> +
> + =A0 =A0 =A0 if (atomic_dec_and_test(&buf->refcount)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "%s: Freeing page mem=
 at vaddr=3D%p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, buf->vaddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_pages((unsigned long)buf->vaddr, g=
et_order(buf->size));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(buf);
> + =A0 =A0 =A0 }
> +}
> +
> +static void *vb2_page_vaddr(void *buf_priv)
> +{
> + =A0 =A0 =A0 struct vb2_page_buf *buf =3D buf_priv;
> +
> + =A0 =A0 =A0 BUG_ON(!buf);
> +
> + =A0 =A0 =A0 if (!buf->vaddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Address of an unalloca=
ted plane requested\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return buf->vaddr;
> +}
> +
> +static unsigned int vb2_page_num_users(void *buf_priv)
> +{
> + =A0 =A0 =A0 struct vb2_page_buf *buf =3D buf_priv;
> + =A0 =A0 =A0 return atomic_read(&buf->refcount);
> +}
> +
> +static int vb2_page_mmap(void *buf_priv, struct vm_area_struct *vma)
> +{
> + =A0 =A0 =A0 struct vb2_page_buf *buf =3D buf_priv;
> +
> + =A0 =A0 =A0 if (!buf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "No memory to map\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
> + =A0 =A0 =A0 return vb2_mmap_pfn_range(vma, virt_to_phys(buf->vaddr)=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf->size, &vb2_common_=
vm_ops,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &buf->handler);
> +}
> +
> +const struct vb2_mem_ops vb2_page_memops =3D {
> + =A0 =A0 =A0 .alloc =A0 =A0 =A0 =A0 =A0=3D vb2_page_alloc,
> + =A0 =A0 =A0 .put =A0 =A0 =A0 =A0 =A0 =A0=3D vb2_page_put,
> + =A0 =A0 =A0 .vaddr =A0 =A0 =A0 =A0 =A0=3D vb2_page_vaddr,
> + =A0 =A0 =A0 .mmap =A0 =A0 =A0 =A0 =A0 =3D vb2_page_mmap,
> + =A0 =A0 =A0 .num_users =A0 =A0 =A0=3D vb2_page_num_users,
> +};
> +EXPORT_SYMBOL_GPL(vb2_page_memops);
> +
> +MODULE_DESCRIPTION("page memory handling routines for videobuf2");
> +MODULE_AUTHOR("Ming Lei");
> +MODULE_LICENSE("GPL");
> diff --git a/include/media/videobuf2-page.h b/include/media/videobuf2=
-page.h
> new file mode 100644
> index 0000000..29b3e20
> --- /dev/null
> +++ b/include/media/videobuf2-page.h
> @@ -0,0 +1,20 @@
> +/*
> + * videobuf2-vmalloc.h - vmalloc memory allocator for videobuf2
> + *
> + * Copyright (C) 2010 Samsung Electronics
> + *
> + * Author: Pawel Osciak <pawel@osciak.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef _MEDIA_VIDEOBUF2_VMALLOC_H
> +#define _MEDIA_VIDEOBUF2_VMALLOC_H

Copy-paste much? :)

=46ix header and match above define with something that matches the act=
ual file:

#ifndef _MEDIA_VIDEOBUF2_PAGE_H
#define _MEDIA_VIDEOBUF2_PAGE_H

Regards,
Sergio

> +
> +#include <media/videobuf2-core.h>
> +
> +extern const struct vb2_mem_ops vb2_page_memops;
> +
> +#endif
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
