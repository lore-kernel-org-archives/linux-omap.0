From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 17/28] [OMAPZOOM] OMAP: CAM: Add MMS Kernel changes
Date: Wed, 15 Oct 2008 20:30:31 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256884F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41766 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbYJPBai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:30:38 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1UWqU015144
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:30:37 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1UWGB016539
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:30:32 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: Add MMS Kernel changes

This adds MMS changes to the OMAP34xx camera driver. Including:
- HQ capture

NOTE: Credits to MMS crew for all this.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/omap_previewer.c |  392 +++++++++++++++++++++++--------
 drivers/media/video/isp/omap_previewer.h |   22 +
 2 files changed, 309 insertions(+), 105 deletions(-)

Index: omapkernel/drivers/media/video/isp/omap_previewer.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/omap_previewer.c    2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/isp/omap_previewer.c 2008-10-15 19:53:07.000000000 -0500
@@ -38,6 +38,24 @@

 #define OMAP_PREV_NAME         "omap-previewer"

+#define BIT_SET(var, shift, mask, val)         \
+       do {                                    \
+               var = (var & ~(mask << shift))  \
+                       | (val << shift);       \
+       } while (0)
+
+/*
+#define OMAP_ISP_PREVIEWER_DEBUG
+*/
+#undef OMAP_ISP_PREVIEWER_DEBUG
+
+#ifdef OMAP_ISP_PREVIEWER_DEBUG
+#define DPRINTK_PREVIEWER(format, ...) \
+       printk(KERN_DEBUG "PREV: " format, ## __VA_ARGS__)
+#else
+#define DPRINTK_PREVIEWER(format, ...)
+#endif
+
 static int prev_major = -1;
 static struct device *prev_dev;
 static struct class *prev_class;
@@ -45,6 +63,7 @@
 static struct platform_driver omap_previewer_driver;

 static u32 prev_bufsize;
+static u32 lsc_bufsize;

 /**
  * prev_calculate_crop - Calculate crop size according to device parameters
@@ -119,6 +138,10 @@
                isppreview_enable_hmed(0);

        if (config->features & PREV_DARK_FRAME_SUBTRACT) {
+               DPRINTK_PREVIEWER("[%s] darkaddr %08x, darklineoffset %d\n",
+                                               __func__,
+                                               config->drkf_params.addr,
+                                               config->drkf_params.offset);
                isppreview_set_darkaddr(config->drkf_params.addr);
                isppreview_config_darklineoffset(config->drkf_params.offset);
                isppreview_enable_drkframe(1);
@@ -200,28 +223,11 @@
                goto err_einval;
        }

-       if (params->features & PREV_DARK_FRAME_SUBTRACT)
-               if (!params->drkf_params.addr
-                                       || (params->drkf_params.offset % 32)) {
-                       dev_err(prev_dev, "validate_params: dark frame "
-                                                               "address\n");
-                       goto err_einval;
-               }
-
-       if (params->features & PREV_LENS_SHADING)
-               if ((params->lens_shading_shift > 7)
-                                       || !params->drkf_params.addr
-                                       || (params->drkf_params.offset % 32)) {
-                       dev_err(prev_dev, "validate_params: lens shading "
-                                                               "shift\n");
-                       goto err_einval;
-               }
-
        if ((params->size_params.in_pitch <= 0)
                                || (params->size_params.in_pitch % 32)) {
                params->size_params.in_pitch =
                                (params->size_params.hsize * 2) & 0xFFE0;
-               dev_err(prev_dev, "\nError in in_pitch; new value = %d",
+               dev_err(prev_dev, "Error in in_pitch; new value = %d",
                                                params->size_params.in_pitch);
        }

@@ -248,6 +254,40 @@
                complete(&device->wfc);
 }

+#define ISP_CTRL_SBL_SHARED_RPORTB     (1 << 28)
+#define ISP_CTRL_SBL_SHARED_RPORTA     (1 << 27)
+#define SBL_SHARED_RPORTB              28
+#define CBUFF1_BCF_CTRL                        24
+#define CBUFF0_BCF_CTRL                        22
+#define SBL_RD_RAM_EN                  18
+#define SHIFT                          6
+
+static void previewer_set_isp_ctrl(void)
+{
+       u32 val;
+
+       val = omap_readl(ISP_CTRL);
+
+       /* Read port used by preview module data read */
+       val &= ~ISP_CTRL_SBL_SHARED_RPORTA;
+
+       /* Read port used by preview module dark frame read */
+       val &= ~ISP_CTRL_SBL_SHARED_RPORTB;
+
+       BIT_SET(val, CBUFF1_BCF_CTRL, 0x3, 0x01);
+       BIT_SET(val, CBUFF0_BCF_CTRL, 0x3, 0x01);
+       BIT_SET(val, SBL_RD_RAM_EN, 0x1, 0x1);
+       BIT_SET(val, SHIFT, 0x3, 0x00);
+
+       /* write ISP CTRL register */
+       omap_writel(val, ISP_CTRL);
+
+#define TCTRL_CTRL  0x480BC050
+#define TCTRL_FRAME 0x480BC054
+       omap_writel(0x00000004, TCTRL_CTRL);
+       omap_writel(0x000C0000, TCTRL_FRAME);
+}
+
 /**
  * prev_do_preview - Performs the Preview process
  * @device: Structure containing ISP preview wrapper global information
@@ -268,25 +308,23 @@
                return -EINVAL;
        }

+       previewer_set_isp_ctrl();
+
        if (device->params->size_params.pixsize == PREV_INWIDTH_8BIT)
                bpp = 1;
        else
                bpp = 2;

        size = device->params->size_params.hsize *
-               device->params->size_params.vsize * bpp;
+                  device->params->size_params.vsize * bpp;

-       ret = isppreview_set_inaddr(device->isp_addr_read);
-       if (ret)
-               goto out;
-
-       ret = isppreview_set_outaddr(device->isp_addr_read);
-       if (ret)
-               goto out;
+       isppreview_config_datapath(PRV_RAW_MEM, PREVIEW_MEM);

        isppreview_try_size(device->params->size_params.hsize,
                                        device->params->size_params.vsize,
-                                       &out_hsize, &out_vsize);
+                                           &out_hsize,
+                                           &out_vsize);
+

        ret = isppreview_config_inlineoffset(device->params->size_params.hsize
                                                * bpp);
@@ -302,10 +340,18 @@
        ret = isppreview_config_size(device->params->size_params.hsize,
                                        device->params->size_params.vsize,
                                        out_hsize, out_vsize);
+
+       device->params->drkf_params.addr = device->isp_addr_lsc;
+
+       prev_hw_setup(device->params);
+
+       ret = isppreview_set_inaddr(device->isp_addr_read);
        if (ret)
                goto out;

-       isppreview_config_datapath(PRV_RAW_MEM, PREVIEW_MEM);
+       ret = isppreview_set_outaddr(device->isp_addr_read);
+       if (ret)
+               goto out;

        ret = isp_set_callback(CBK_PREV_DONE, preview_isr, (void *)device,
                                                                (void *)NULL);
@@ -317,11 +363,6 @@

        wait_for_completion_interruptible(&device->wfc);

-       if (device->isp_addr_read) {
-               ispmmu_unmap(device->isp_addr_read);
-               device->isp_addr_read = 0;
-       }
-
        ret = isp_unset_callback(CBK_PREV_DONE);

        dev_dbg(prev_dev, "prev_do_preview L\n");
@@ -340,11 +381,25 @@
        struct prev_fh *fh = q->priv_data;
        struct prev_device *device = fh->device;

-       ispmmu_unmap(device->isp_addr_read);
-       device->isp_addr_read = 0;
-       spin_lock(&device->vbq_lock);
-       vb->state = VIDEOBUF_NEEDS_INIT;
-       spin_unlock(&device->vbq_lock);
+       if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+               ispmmu_unmap(device->isp_addr_read);
+               device->isp_addr_read = 0;
+               spin_lock(&device->inout_vbq_lock);
+               vb->state = VIDEOBUF_NEEDS_INIT;
+               spin_unlock(&device->inout_vbq_lock);
+       } else if (q->type == V4L2_BUF_TYPE_PRIVATE) {
+               ispmmu_unmap(device->isp_addr_lsc);
+               device->isp_addr_lsc = 0;
+               spin_lock(&device->lsc_vbq_lock);
+               vb->state = VIDEOBUF_NEEDS_INIT;
+               spin_unlock(&device->lsc_vbq_lock);
+       }
+
+       if (vb->memory != V4L2_MEMORY_MMAP) {
+               videobuf_dma_unmap(q, videobuf_to_dma(vb));
+               videobuf_dma_free(videobuf_to_dma(vb));
+       }
+
        dev_dbg(prev_dev, "previewer_vbq_release\n");
 }

@@ -364,25 +419,52 @@
        struct prev_device *device = fh->device;
        u32 bpp = 1;

-       spin_lock(&device->vbq_lock);
-       if (*cnt <= 0)
-               *cnt = VIDEO_MAX_FRAME;
-
-       if (*cnt > VIDEO_MAX_FRAME)
-               *cnt = VIDEO_MAX_FRAME;
-
-       if (!device->params->size_params.hsize ||
-               !device->params->size_params.vsize) {
-               dev_err(prev_dev, "Can't setup buffer size\n");
-               spin_unlock(&device->vbq_lock);
+       if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+               spin_lock(&device->inout_vbq_lock);
+
+               if (*cnt <= 0)
+                       *cnt = 1;
+
+               if (*cnt > VIDEO_MAX_FRAME)
+                       *cnt = VIDEO_MAX_FRAME;
+
+               if (!device->params->size_params.hsize ||
+                       !device->params->size_params.vsize) {
+                               dev_err(prev_dev, "Can't setup buffer size\n");
+                               spin_unlock(&device->inout_vbq_lock);
+                       return -EINVAL;
+               }
+
+               if (device->params->size_params.pixsize == PREV_INWIDTH_10BIT)
+                       bpp = 2;
+               *size = prev_bufsize = bpp * device->params->size_params.hsize
+                                       * device->params->size_params.vsize;
+               spin_unlock(&device->inout_vbq_lock);
+       } else if (q->type == V4L2_BUF_TYPE_PRIVATE) {
+               spin_lock(&device->lsc_vbq_lock);
+               if (*cnt <= 0)
+                       *cnt = 1;
+
+               if (*cnt > 1)
+                       *cnt = 1;
+
+               if (!device->params->size_params.hsize ||
+                       !device->params->size_params.vsize) {
+                       dev_err(prev_dev, "Can't setup lsc buffer size\n");
+                       spin_unlock(&device->lsc_vbq_lock);
+                       return -EINVAL;
+               }
+
+               /* upsampled lsc table size - for now bpp = 2 */
+               bpp = 2;
+               *size = lsc_bufsize = bpp * device->params->size_params.hsize
+                       * device->params->size_params.vsize;
+
+               spin_unlock(&device->lsc_vbq_lock);
+       } else {
                return -EINVAL;
        }

-       if (device->params->size_params.pixsize == PREV_INWIDTH_10BIT)
-               bpp = 2;
-       *size = prev_bufsize = bpp * device->params->size_params.hsize
-                                       * device->params->size_params.vsize;
-       spin_unlock(&device->vbq_lock);
        dev_dbg(prev_dev, "previewer_vbq_setup\n");
        return 0;
 }
@@ -407,38 +489,103 @@
        struct videobuf_dmabuf *dma = videobuf_to_dma(vb);

        dev_dbg(prev_dev, "previewer_vbq_prepare E\n");
-       spin_lock(&device->vbq_lock);
-       if (vb->baddr) {
-               vb->size = prev_bufsize;
-               vb->bsize = prev_bufsize;
-       } else {
-               spin_unlock(&device->vbq_lock);
-               dev_err(prev_dev, "No user buffer allocated\n");
-               goto out;
-       }

-       vb->width = device->params->size_params.hsize;
-       vb->height = device->params->size_params.vsize;
-       vb->field = field;
-       spin_unlock(&device->vbq_lock);
+       if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+               spin_lock(&device->inout_vbq_lock);
+
+               if (vb->baddr) {
+                       vb->size = prev_bufsize;
+                       vb->bsize = prev_bufsize;
+                       DPRINTK_PREVIEWER("[%s] bsize = %d\n", __func__,
+                                                               vb->bsize);
+               } else {
+                       spin_unlock(&device->inout_vbq_lock);
+                       dev_err(prev_dev, "No user buffer allocated\n");
+                       goto out;
+               }
+
+               vb->width = device->params->size_params.hsize;
+               vb->height = device->params->size_params.vsize;
+               vb->field = field;
+               spin_unlock(&device->inout_vbq_lock);
+
+               if (vb->state == VIDEOBUF_NEEDS_INIT) {
+                       DPRINTK_PREVIEWER("[%s] baddr = %08x\n", __func__,
+                                                               (int)vb->baddr);
+                       err = videobuf_iolock(q, vb, NULL);
+                       if (!err) {
+                               isp_addr = ispmmu_map_sg(dma->sglist,
+                                                               dma->sglen);
+
+                               if (!isp_addr) {
+                                       err = -EIO;
+                               } else {
+                                       device->isp_addr_read = isp_addr;
+                                       DPRINTK_PREVIEWER("[%s] "
+                                               "isp_addr_read = %08x\n",
+                                               __func__, isp_addr);
+                               }
+                       }
+               }

-       if (vb->state == VIDEOBUF_NEEDS_INIT) {
-               err = videobuf_iolock(q, vb, NULL);
                if (!err) {
-                       isp_addr = ispmmu_map_sg(dma->sglist, dma->sglen);
-                       if (!isp_addr)
-                               err = -EIO;
-                       else
-                               device->isp_addr_read = isp_addr;
+                       vb->state = VIDEOBUF_PREPARED;
+                       flush_cache_user_range(NULL, vb->baddr, (vb->baddr +
+                                                               vb->bsize));
+               } else {
+                       previewer_vbq_release(q, vb);
                }
-       }

-       if (!err) {
-               vb->state = VIDEOBUF_PREPARED;
-               flush_cache_user_range(NULL, vb->baddr,
-                                       (vb->baddr + vb->bsize));
-       } else
-               previewer_vbq_release(q, vb);
+       } else if (q->type == V4L2_BUF_TYPE_PRIVATE) {
+
+               spin_lock(&device->lsc_vbq_lock);
+
+               if (vb->baddr) {
+                       vb->size = lsc_bufsize;
+                       vb->bsize = lsc_bufsize;
+                       DPRINTK_PREVIEWER("[%s] bsize = %d\n", __func__,
+                                                               vb->bsize);
+               } else {
+                       spin_unlock(&device->lsc_vbq_lock);
+                       dev_err(prev_dev, "No user buffer allocated\n");
+                       goto out;
+               }
+
+               vb->width = device->params->size_params.hsize;
+               vb->height = device->params->size_params.vsize;
+               vb->field = field;
+               spin_unlock(&device->lsc_vbq_lock);
+
+               if (vb->state == VIDEOBUF_NEEDS_INIT) {
+                       DPRINTK_PREVIEWER("[%s] baddr = %08x\n", __func__,
+                                                               (int)vb->baddr);
+                       err = videobuf_iolock(q, vb, NULL);
+                       if (!err) {
+                               isp_addr = ispmmu_map_sg(dma->sglist,
+                                                               dma->sglen);
+                               if (!isp_addr) {
+                                       err = -EIO;
+                               } else {
+                                       device->isp_addr_lsc = isp_addr;
+                                       DPRINTK_PREVIEWER("[%s] isp_addr_lsc ="
+                                                               " %08x\n",
+                                                               __func__,
+                                                               isp_addr);
+                               }
+                       }
+               }
+
+               if (!err) {
+                       vb->state = VIDEOBUF_PREPARED;
+                       flush_cache_user_range(NULL, vb->baddr, (vb->baddr +
+                                                               vb->bsize));
+               } else {
+                       previewer_vbq_release(q, vb);
+               }
+
+       } else {
+               return -EINVAL;
+       }

        dev_dbg(prev_dev, "previewer_vbq_prepare L\n");
 out:
@@ -495,11 +642,17 @@
        device->opened = 1;

        filp->private_data = fh;
-       fh->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+       fh->inout_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+       fh->lsc_type = V4L2_BUF_TYPE_PRIVATE;
        fh->device = device;

-       videobuf_queue_sg_init(&fh->vbq, &device->vbq_ops, NULL,
-                                       &device->vbq_lock, fh->type,
+       videobuf_queue_sg_init(&fh->inout_vbq, &device->vbq_ops, NULL,
+                                       &device->inout_vbq_lock, fh->inout_type,
+                                       V4L2_FIELD_NONE,
+                                       sizeof(struct videobuf_buffer), fh);
+
+       videobuf_queue_sg_init(&fh->lsc_vbq, &device->vbq_ops, NULL,
+                                       &device->lsc_vbq_lock, fh->lsc_type,
                                        V4L2_FIELD_NONE,
                                        sizeof(struct videobuf_buffer), fh);

@@ -521,14 +674,17 @@
 {
        struct prev_fh *fh = filp->private_data;
        struct prev_device *device = fh->device;
-       struct videobuf_queue *q = &fh->vbq;
+       struct videobuf_queue *q1 = &fh->inout_vbq;
+       struct videobuf_queue *q2 = &fh->lsc_vbq;

        device->opened = 0;
        device->params = NULL;
        isppreview_free();
        isp_put();
-       videobuf_mmap_free(q);
+       videobuf_mmap_free(q1);
+       videobuf_mmap_free(q2);
        prev_bufsize = 0;
+       lsc_bufsize = 0;
        filp->private_data = NULL;
        kfree(fh);

@@ -546,10 +702,7 @@
  **/
 static int previewer_mmap(struct file *file, struct vm_area_struct *vma)
 {
-       struct prev_fh *fh = file->private_data;
-       dev_dbg(prev_dev, "previewer_mmap\n");
-
-       return videobuf_mmap_mapper(&fh->vbq, vma);
+       return -EINVAL;
 }

 /**
@@ -590,40 +743,83 @@

        switch (cmd) {
        case PREV_REQBUF:
+       {
+               struct v4l2_requestbuffers *req;
+
                if (mutex_lock_interruptible(&device->prevwrap_mutex))
                        goto err_eintr;
-               ret = videobuf_reqbufs(&fh->vbq, (void *)arg);
+
+               req = (struct v4l2_requestbuffers *) arg;
+
+               if (req->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+                       ret = videobuf_reqbufs(&fh->inout_vbq, (void *) arg);
+               else if (req->type == V4L2_BUF_TYPE_PRIVATE)
+                       ret = videobuf_reqbufs(&fh->lsc_vbq, (void *) arg);
+               else
+                       ret = -EINVAL;
+
                mutex_unlock(&device->prevwrap_mutex);
                break;
+       }

        case PREV_QUERYBUF:
+       {
+               struct v4l2_buffer *b;
+
                if (mutex_lock_interruptible(&device->prevwrap_mutex))
                        goto err_eintr;
-               ret = videobuf_querybuf(&fh->vbq, (void *)arg);
+               b = (struct v4l2_buffer *) arg;
+
+               if (b->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+                       ret = videobuf_querybuf(&fh->inout_vbq, (void *) arg);
+               else if (b->type == V4L2_BUF_TYPE_PRIVATE)
+                       ret = videobuf_querybuf(&fh->lsc_vbq, (void *) arg);
+               else
+                       ret = -EINVAL;
+
                mutex_unlock(&device->prevwrap_mutex);
                break;
+       }

        case PREV_QUEUEBUF:
+       {
+               struct v4l2_buffer *b;
+
                if (mutex_lock_interruptible(&device->prevwrap_mutex))
                        goto err_eintr;
-               ret = videobuf_qbuf(&fh->vbq, (void *)arg);
+
+               b = (struct v4l2_buffer *) arg;
+               if (b->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+                       ret = videobuf_qbuf(&fh->inout_vbq, (void *) arg);
+               else if (b->type == V4L2_BUF_TYPE_PRIVATE)
+                       ret = videobuf_qbuf(&fh->lsc_vbq, (void *) arg);
+               else
+                       ret = -EINVAL;
+
                mutex_unlock(&device->prevwrap_mutex);
                break;
+       }

        case PREV_SET_PARAM:
                if (mutex_lock_interruptible(&device->prevwrap_mutex))
                        goto err_eintr;
+               DPRINTK_PREVIEWER("%s PREV_SET_PARAMS before copy from user:\n",
+                                                               __func__);
                if (copy_from_user(&params, (struct prev_params *)arg,
                                                sizeof(struct prev_params))) {
                        mutex_unlock(&device->prevwrap_mutex);
                        return -EFAULT;
                }
+               DPRINTK_PREVIEWER("%s PREV_SET_PARAMS before prev validate "
+                                                       "params:\n", __func__);
                ret = prev_validate_params(&params);
                if (ret < 0) {
                        dev_err(prev_dev, "Error validating parameters!\n");
                        mutex_unlock(&device->prevwrap_mutex);
                        goto out;
                }
+               DPRINTK_PREVIEWER("%s PREV_SET_PARAMSbefore memcopy:\n",
+                                                               __func__);
                if (device->params)
                        memcpy(device->params, &params,
                                                sizeof(struct prev_params));
@@ -632,7 +828,7 @@
                        return -EINVAL;
                }

-               ret = prev_hw_setup(device->params);
+               /* ret = prev_hw_setup(device->params); */
                mutex_unlock(&device->prevwrap_mutex);
                break;

@@ -654,13 +850,13 @@
                break;

        case PREV_GET_CROPSIZE:
-               {
+       {
                struct prev_cropsize outputsize;
                prev_calculate_crop(device, &outputsize);
                if (copy_to_user((struct prev_cropsize *)arg, &outputsize,
                                                sizeof(struct prev_cropsize)))
                        ret = -EFAULT;
-               }
+       }
                break;

        default:
@@ -792,8 +988,8 @@
        device->vbq_ops.buf_prepare = previewer_vbq_prepare;
        device->vbq_ops.buf_release = previewer_vbq_release;
        device->vbq_ops.buf_queue = previewer_vbq_queue;
-       spin_lock_init(&device->vbq_lock);
-
+       spin_lock_init(&device->inout_vbq_lock);
+       spin_lock_init(&device->lsc_vbq_lock);
        prevdevice = device;
        return 0;

Index: omapkernel/drivers/media/video/isp/omap_previewer.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/omap_previewer.h    2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/isp/omap_previewer.h 2008-10-15 19:54:02.000000000 -0500
@@ -134,29 +134,37 @@
  * @opened: State of the device.
  * @wfc: Wait for completion. Used for locking operations.
  * @prevwrap_mutex: Mutex for preview wrapper use.
- * @vbq_lock: Spinlock for videobuf queues.
+ * @inout_vbq_lock: Spinlock for in/out videobuf queues.
+ * @lsc_vbq_lock: Spinlock for LSC videobuf queues.
  * @vbq_ops: Videobuf queue operations
  * @isp_addr_read: Input/Output address
+ * @isp_addr_read: LSC address
  */
 struct prev_device {
        struct prev_params *params;
        unsigned char opened;
        struct completion wfc;
-       struct mutex prevwrap_mutex; /* For generic internal use */
-       spinlock_t vbq_lock;    /* For videobuffer queue handling */
+       struct mutex prevwrap_mutex;
+       spinlock_t inout_vbq_lock; /* Spinlock for in/out videobuf queues. */
+       spinlock_t lsc_vbq_lock; /* Spinlock for LSC videobuf queues. */
        struct videobuf_queue_ops vbq_ops;
        dma_addr_t isp_addr_read;
+       dma_addr_t isp_addr_lsc;
 };

 /**
  * struct prev_fh - Per-filehandle data structure
- * @type: Used buffer type.
- * @vbq: Videobuffer queue.
+ * @inout_type: Used buffer type for I/O.
+ * @inout_vbq: I/O Videobuffer queue.
+ * @lsc_type: Used buffer type for LSC.
+ * @lsc_vbq: LSC Videobuffer queue.
  * @device: Pointer to device information structure.
  */
 struct prev_fh {
-       enum v4l2_buf_type type;
-       struct videobuf_queue vbq;
+       enum v4l2_buf_type inout_type;
+       struct videobuf_queue inout_vbq;
+       enum v4l2_buf_type lsc_type;
+       struct videobuf_queue lsc_vbq;
        struct prev_device *device;
 };
 #endif
