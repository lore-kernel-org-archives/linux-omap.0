From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 5/28] [OMAPZOOM] OMAP: CAM: ISP: Core Fixes
Date: Wed, 15 Oct 2008 20:19:52 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256883B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49935 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbYJPBT7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:19:59 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1Jrwc006803
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:19:58 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1JrTc006251
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:19:53 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: Core Fixes

This patch Adds the following changes:
 - Removes useless headers
 - Add DMA cache flush for fixing green line problem on streaming
 - Aligns color effects handling with CDP release
 - Removes IRQ registers saving/restore on context save/restore
 - Removes isp_open and isp_close, and adds isp_release_resources
   instead.
 - Fixes V4L2 control handling operation, now responds properly when
   calling vidioc_g_ctrl IOCTL with V4L2_CTRL_FLAG_NEXT_CTRL flag.
 - Simplify isp_stop code.
 - Boundary checking fixes.
 - Removes IOCTL declares from isp header.
 - Add resizer output boundaries.
 - Corrected ISPCCDC_BLKCMP_GR_CY_SHIFT value.

Signed-off-by: Mohit Jalori <mjalori@ti.com>
Signed-off-by: Dominic Curran <dcurran@ti.com>
Signed-off-by: Vaibhav Hiremat <hvaibhav@ti.com>
Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c    |  245 ++++++++++++++++++++++++---------------
 drivers/media/video/isp/isp.h    |   22 ---
 drivers/media/video/isp/ispreg.h |    4
 3 files changed, 161 insertions(+), 110 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c       2008-10-14 12:12:13.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.c    2008-10-14 12:16:12.000000000 -0500
@@ -30,12 +30,11 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <asm/irq.h>
 #include <linux/bitops.h>
 #include <linux/scatterlist.h>
 #include <asm/mach-types.h>
-#include <mach/clock.h>
-#include <mach/io.h>
 #include <linux/device.h>
 #include <linux/videodev2.h>

@@ -108,7 +107,7 @@
                        .type = V4L2_CTRL_TYPE_INTEGER,
                        .name = "Color Effects",
                        .minimum = PREV_DEFAULT_COLOR,
-                       .maximum = PREV_SEPIA_COLOR,
+                       .maximum = PREV_BW_COLOR,
                        .step = 1,
                        .default_value = PREV_DEFAULT_COLOR,
                },
@@ -219,8 +218,6 @@
 /* Structure for saving/restoring ISP module registers */
 static struct isp_reg isp_reg_list[] = {
        {ISP_SYSCONFIG, 0},
-       {ISP_IRQ0ENABLE, 0},
-       {ISP_IRQ1ENABLE, 0},
        {ISP_TCTRL_GRESET_LENGTH, 0},
        {ISP_TCTRL_PSTRB_REPLAY, 0},
        {ISP_CTRL, 0},
@@ -277,26 +274,39 @@
        return i;
 }

-/**
- * isp_open - Reserve ISP submodules for operation
- **/
-void isp_open(void)
+static int find_next_vctrl(int id)
 {
-       ispccdc_request();
-       isppreview_request();
-       ispresizer_request();
-       return;
+       int i;
+       u32 best = (u32)-1;
+
+       for (i = 0; i < ARRAY_SIZE(video_control); i++) {
+               if (video_control[i].qc.id > id
+                   && (best == (u32)-1
+                       || video_control[i].qc.id
+                       < video_control[best].qc.id)) {
+                       best = i;
+               }
+       }
+
+       if (best == (u32)-1)
+               return -EINVAL;
+
+       return best;
 }
-EXPORT_SYMBOL(isp_set_pipeline);

 /**
- * isp_close - Free ISP submodules
+ * isp_release_resources - Free ISP submodules
  **/
-void isp_close(void)
+void isp_release_resources(void)
 {
-       ispccdc_free();
-       isppreview_free();
-       ispresizer_free();
+       if (ispmodule_obj.isp_pipeline & OMAP_ISP_CCDC)
+               ispccdc_free();
+
+       if (ispmodule_obj.isp_pipeline & OMAP_ISP_PREVIEW)
+               isppreview_free();
+
+       if (ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER)
+               ispresizer_free();
        return;
 }
 EXPORT_SYMBOL(omapisp_unset_callback);
@@ -1075,7 +1085,7 @@

        return;
 }
-EXPORT_SYMBOL(isp_open);
+EXPORT_SYMBOL(isp_set_pipeline);

 /**
  * omapisp_unset_callback - Unsets all the callbacks associated with ISP module
@@ -1099,7 +1109,6 @@
        }
        omap_writel(omap_readl(ISP_IRQ0STATUS) | ISP_INT_CLR, ISP_IRQ0STATUS);
 }
-EXPORT_SYMBOL(isp_close);

 /**
  * isp_start - Starts ISP submodule
@@ -1122,53 +1131,29 @@
  **/
 void isp_stop()
 {
-       int timeout;
+       int timeout = 0;

        spin_lock(&isp_obj.isp_temp_buf_lock);
        ispmodule_obj.isp_temp_state = ISP_FREE_RUNNING;
        spin_unlock(&isp_obj.isp_temp_buf_lock);
-       omapisp_unset_callback();
-
-       if ((ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER) &&
-                                               is_ispresizer_enabled()) {
-               ispresizer_enable(0);
-               timeout = 0;
-               while (ispresizer_busy() && (timeout < 20)) {
-                       timeout++;
-                       mdelay(10);
-               }
-       }
-
-       if ((ispmodule_obj.isp_pipeline & OMAP_ISP_PREVIEW) &&
-                                               is_isppreview_enabled()) {
-               isppreview_enable(0);
-               timeout = 0;
-               while (isppreview_busy() && (timeout < 20)) {
-                       timeout++;
-                       mdelay(10);
-               }
-       }

-       if (ispmodule_obj.isp_pipeline & OMAP_ISP_CCDC) {
-               ispccdc_enable_lsc(0);
-               ispccdc_enable(0);
-               timeout = 0;
-               while (ispccdc_busy() && (timeout < 20)) {
-                       timeout++;
-                       mdelay(10);
+       omapisp_unset_callback();
+       ispccdc_enable_lsc(0);
+       ispccdc_enable(0);
+       isppreview_enable(0);
+       ispresizer_enable(0);
+       isp_save_ctx();
+       omap_writel(omap_readl(ISP_SYSCONFIG) |
+               ISP_SYSCONFIG_SOFTRESET, ISP_SYSCONFIG);
+       while (!(omap_readl(ISP_SYSSTATUS) & 0x1)) {
+               timeout++;
+               if (timeout >= 10) {
+                       printk(KERN_ALERT "isp.c: cannot reset ISP\n");
+                       return;
                }
+               msleep(1);
        }
-       if (ispccdc_busy() || isppreview_busy() || ispresizer_busy()) {
-               isp_save_ctx();
-               omap_writel(omap_readl(ISP_SYSCONFIG) |
-                       ISP_SYSCONFIG_SOFTRESET, ISP_SYSCONFIG);
-               timeout = 0;
-               while ((!(omap_readl(ISP_SYSSTATUS) & 0x1)) && timeout < 20) {
-                       timeout++;
-                       mdelay(1);
-               }
        isp_restore_ctx();
-       }
 }

 /**
@@ -1196,15 +1181,20 @@
 void isp_calc_pipeline(struct v4l2_pix_format *pix_input,
                                        struct v4l2_pix_format *pix_output)
 {
-       ispmodule_obj.isp_pipeline = OMAP_ISP_CCDC;
+       isp_release_resources();
        if ((pix_input->pixelformat == V4L2_PIX_FMT_SGRBG10) &&
                (pix_output->pixelformat != V4L2_PIX_FMT_SGRBG10)) {
-               ispmodule_obj.isp_pipeline |= (OMAP_ISP_PREVIEW |
-                                                       OMAP_ISP_RESIZER);
+                       ispmodule_obj.isp_pipeline = OMAP_ISP_CCDC |
+                                       OMAP_ISP_PREVIEW | OMAP_ISP_RESIZER;
+                       ispccdc_request();
+                       isppreview_request();
+                       ispresizer_request();
                ispccdc_config_datapath(CCDC_RAW, CCDC_OTHERS_VP);
                isppreview_config_datapath(PRV_RAW_CCDC, PREVIEW_RSZ);
                ispresizer_config_datapath(RSZ_OTFLY_YUV);
        } else {
+               ispmodule_obj.isp_pipeline = OMAP_ISP_CCDC;
+               ispccdc_request();
                if (pix_input->pixelformat == V4L2_PIX_FMT_SGRBG10)
                        ispccdc_config_datapath(CCDC_RAW, CCDC_OTHERS_MEM);
                else
@@ -1301,22 +1291,24 @@
                break;
        case PREV_DONE:
                if (is_isppreview_enabled()) {
-                       if (ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER) {
-                               if (!ispmodule_obj.applyCrop && (ispmodule_obj.
-                                                       isp_temp_state ==
-                                                       ISP_BUF_INIT))
-                                       ispresizer_enable(1);
-                               if (ispmodule_obj.applyCrop &&
-                                                       !ispresizer_busy()) {
-                                       ispresizer_enable(0);
-                                       ispresizer_applycrop();
-                                       ispmodule_obj.applyCrop = 0;
-                               }
+               if (ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER) {
+                       spin_lock(&isp_obj.isp_temp_buf_lock);
+                       if (!ispmodule_obj.applyCrop &&
+                                       (ispmodule_obj.isp_temp_state ==
+                                       ISP_BUF_INIT))
+                               ispresizer_enable(1);
+                       spin_unlock(&isp_obj.isp_temp_buf_lock);
+                       if (ispmodule_obj.applyCrop &&
+                               !ispresizer_busy()) {
+                               ispresizer_enable(0);
+                               ispresizer_applycrop();
+                               ispmodule_obj.applyCrop = 0;
                        }
                        isppreview_config_shadow_registers();
                        isph3a_update_wb();
-                       if (ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER)
-                               return;
+               }
+               if (ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER)
+                       return;
                }
                break;
        case RESZ_DONE:
@@ -1339,7 +1331,7 @@
                spin_unlock(&isp_obj.isp_temp_buf_lock);
                return;
        default:
-               break;
+               return;
        }

        spin_lock_irqsave(&ispsg.lock, flags);
@@ -1374,6 +1366,29 @@
 EXPORT_SYMBOL(isp_stop);

 /**
+ * isp_vbq_sync - Walks the pages table and flushes the cache for
+ *                each page.
+ **/
+int isp_vbq_sync(struct videobuf_buffer *vb)
+{
+       struct videobuf_dmabuf *vdma;
+       u32 sg_element_addr;
+       int i;
+
+       vdma = videobuf_to_dma(vb);
+
+       for (i = 0; i < vdma->sglen; i++) {
+               sg_element_addr = sg_dma_address(vdma->sglist + i);
+               /* Page align address */
+               sg_element_addr &= ~(PAGE_SIZE-1);
+
+               dma_sync_single_for_cpu(NULL, sg_element_addr,
+                               PAGE_SIZE, DMA_FROM_DEVICE);
+       }
+       return 0;
+}
+
+/**
  * isp_sgdma_process - Sets operations and config for specified SG DMA
  * @sgdma: SG-DMA function to work on.
  * @irq: Flag to specify if an IRQ is associated with the DMA completion.
@@ -1397,23 +1412,42 @@
                                ispccdc_enable(1);
                                isp_start();
                                *dma_notify = 0;
-                               ispmodule_obj.isp_temp_state = ISP_BUF_TRAN;
+                               spin_lock(&isp_obj.isp_temp_buf_lock);
+                               if (ispmodule_obj.isp_pipeline
+                                       & OMAP_ISP_RESIZER) {
+                                       ispmodule_obj.isp_temp_state =
+                                               ISP_BUF_INIT;
+                               } else
+                                       ispmodule_obj.isp_temp_state =
+                                               ISP_BUF_TRAN;
+                               spin_unlock(&isp_obj.isp_temp_buf_lock);
                        } else {
+                               spin_lock(&isp_obj.isp_temp_buf_lock);
                                if (ispmodule_obj.isp_temp_state ==
                                                        ISP_FREE_RUNNING) {
                                        isp_set_sgdma_callback(sgdma_state,
                                                                func_ptr);
                                        isp_set_buf(sgdma_state);
-                                       ispccdc_enable(1);
-                                       ispmodule_obj.isp_temp_state =
-                                                               ISP_BUF_TRAN;
+                                       /* Non startup case */
+                                       if (ispmodule_obj.isp_pipeline
+                                       & OMAP_ISP_RESIZER) {
+                                               ispmodule_obj.isp_temp_state =
+                                                       ISP_BUF_INIT;
+                                       } else {
+                                               ispmodule_obj.isp_temp_state =
+                                                       ISP_BUF_TRAN;
+                                               ispccdc_enable(1);
+                                       }
                                }
+                               spin_unlock(&isp_obj.isp_temp_buf_lock);
                        }
                } else {
                        isp_set_sgdma_callback(sgdma_state, func_ptr);
                        isp_set_buf(sgdma_state);
-                       ispccdc_enable(1);
-                       ispmodule_obj.isp_temp_state = ISP_BUF_INIT;
+                       /* Non startup case */
+                       if (!(ispmodule_obj.isp_pipeline
+                               & OMAP_ISP_RESIZER))
+                               ispccdc_enable(1);

                        if (*dma_notify) {
                                isp_start();
@@ -1423,6 +1457,7 @@
        } else {
                spin_lock(&isp_obj.isp_temp_buf_lock);
                isp_CCDC_VD01_disable();
+               ispresizer_enable(0);
                ispmodule_obj.isp_temp_state = ISP_FREE_RUNNING;
                spin_unlock(&isp_obj.isp_temp_buf_lock);
        }
@@ -1453,6 +1488,7 @@

        if ((sglen < 0) || ((sglen > 0) & !sglist))
                return -EINVAL;
+       isp_vbq_sync(vb);

        spin_lock_irqsave(&ispsg.lock, flags);

@@ -1531,9 +1567,12 @@
 {
        int i;

-       i = find_vctrl(a->id);
-       if (i == -EINVAL)
-               a->flags = V4L2_CTRL_FLAG_DISABLED;
+       if (a->id & V4L2_CTRL_FLAG_NEXT_CTRL) {
+               a->id &= ~V4L2_CTRL_FLAG_NEXT_CTRL;
+               i = find_next_vctrl(a->id);
+       } else {
+               i = find_vctrl(a->id);
+       }

        if (i < 0)
                return -EINVAL;
@@ -1604,7 +1643,7 @@
                        isppreview_update_contrast(&new_value);
                break;
        case V4L2_CID_PRIVATE_ISP_COLOR_FX:
-               if (new_value > PREV_SEPIA_COLOR)
+               if (new_value > PREV_BW_COLOR)
                        rval = -EINVAL;
                else
                        isppreview_set_color(&new_value);
@@ -1897,6 +1936,15 @@
                                        struct v4l2_pix_format *pix_output)
 {
        int rval = 0;
+
+       if (pix_output->width <= ISPRSZ_MIN_OUTPUT ||
+               pix_output->height <= ISPRSZ_MIN_OUTPUT)
+               return -EINVAL;
+
+       if (pix_output->width >= ISPRSZ_MAX_OUTPUT ||
+               pix_output->height > ISPRSZ_MAX_OUTPUT)
+               return -EINVAL;
+
        ispmodule_obj.ccdc_input_width = pix_input->width;
        ispmodule_obj.ccdc_input_height = pix_input->height;
        ispmodule_obj.resizer_output_width = pix_output->width;
@@ -1907,6 +1955,12 @@
                                        ispmodule_obj.ccdc_input_height,
                                        &ispmodule_obj.ccdc_output_width,
                                        &ispmodule_obj.ccdc_output_height);
+               if (rval) {
+                       printk(KERN_ERR "ISP_ERR: The dimensions %dx%d are not"
+                                       " supported\n", pix_input->width,
+                                       pix_input->height);
+                       return rval;
+               }
                pix_output->width = ispmodule_obj.ccdc_output_width;
                pix_output->height = ispmodule_obj.ccdc_output_height;
        }
@@ -1920,6 +1974,12 @@
                                        ispmodule_obj.preview_input_height,
                                        &ispmodule_obj.preview_output_width,
                                        &ispmodule_obj.preview_output_height);
+               if (rval) {
+                       printk(KERN_ERR "ISP_ERR: The dimensions %dx%d are not"
+                                       " supported\n", pix_input->width,
+                                       pix_input->height);
+                       return rval;
+               }
                pix_output->width = ispmodule_obj.preview_output_width;
                pix_output->height = ispmodule_obj.preview_output_height;
        }
@@ -1933,6 +1993,12 @@
                                        &ispmodule_obj.resizer_input_height,
                                        &ispmodule_obj.resizer_output_width,
                                        &ispmodule_obj.resizer_output_height);
+               if (rval) {
+                       printk(KERN_ERR "ISP_ERR: The dimensions %dx%d are not"
+                                       " supported\n", pix_input->width,
+                                       pix_input->height);
+                       return rval;
+               }
                pix_output->width = ispmodule_obj.resizer_output_width;
                pix_output->height = ispmodule_obj.resizer_output_height;
        }
@@ -2096,11 +2162,14 @@
                if (--isp_obj.ref_count == 0) {
                        isp_save_ctx();
                        off_mode = 1;
-
+                       isp_release_resources();
+                       ispmodule_obj.isp_pipeline = 0;
                        clk_disable(isp_obj.cam_ick);
                        clk_disable(isp_obj.cam_mclk);
                        clk_put(isp_obj.cam_ick);
                        clk_put(isp_obj.cam_mclk);
+                       memset(&ispcroprect, 0, sizeof(ispcroprect));
+                       memset(&cur_rect, 0, sizeof(cur_rect));
                }
        mutex_unlock(&(isp_obj.isp_mutex));
        DPRINTK_ISPCTRL("isp_put: new %d\n", isp_obj.ref_count);
Index: omapkernel/drivers/media/video/isp/isp.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.h       2008-10-14 12:12:13.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.h    2008-10-14 12:15:43.000000000 -0500
@@ -36,24 +36,6 @@
 /* Our ISP specific controls */
 #define V4L2_CID_PRIVATE_ISP_COLOR_FX          (V4L2_CID_PRIVATE_BASE + 0)

-/* ISP Private IOCTLs */
-#define VIDIOC_PRIVATE_ISP_CCDC_CFG    \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 1, struct ispccdc_update_config)
-#define VIDIOC_PRIVATE_ISP_PRV_CFG \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 2, struct ispprv_update_config)
-#define VIDIOC_PRIVATE_ISP_AEWB_CFG \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 4, struct isph3a_aewb_config)
-#define VIDIOC_PRIVATE_ISP_AEWB_REQ \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 5, struct isph3a_aewb_data)
-#define VIDIOC_PRIVATE_ISP_HIST_CFG \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 6, struct isp_hist_config)
-#define VIDIOC_PRIVATE_ISP_HIST_REQ \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 7, struct isp_hist_data)
-#define VIDIOC_PRIVATE_ISP_AF_CFG \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 8, struct af_configuration)
-#define VIDIOC_PRIVATE_ISP_AF_REQ \
-       _IOWR('V', BASE_VIDIOC_PRIVATE + 9, struct isp_af_data)
-
 #define ISP_TOK_TERM           0xFFFFFFFF      /*
                                                 * terminating token for ISP
                                                 * modules reg list
@@ -231,9 +213,7 @@
        char idle_mode;
 };

-void isp_open(void);
-
-void isp_close(void);
+void isp_release_resources(void);

 void isp_start(void);

Index: omapkernel/drivers/media/video/isp/ispreg.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispreg.h    2008-10-14 12:12:13.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispreg.h 2008-10-14 12:15:43.000000000 -0500
@@ -408,6 +408,8 @@

 #define ISPPRV_MAXOUTPUT_WIDTH         1280
 #define ISPPRV_MAXOUTPUT_WIDTH_ES2     3300
+#define ISPRSZ_MIN_OUTPUT              64
+#define ISPRSZ_MAX_OUTPUT              3312

 /* Resizer module register offset */
 #define ISPRSZ_PID                     0x480BD000
@@ -867,7 +869,7 @@

 #define ISPCCDC_BLKCMP_B_MG_SHIFT              0
 #define ISPCCDC_BLKCMP_GB_G_SHIFT              8
-#define ISPCCDC_BLKCMP_GR_CY_SHIFT             6
+#define ISPCCDC_BLKCMP_GR_CY_SHIFT             16
 #define ISPCCDC_BLKCMP_R_YE_SHIFT              24

 #define ISPCCDC_FPC_FPNUM_SHIFT                        0
