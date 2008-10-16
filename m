From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 14/28] [OMAPZOOM] OMAP: CAM: Add LSC workaround to ISP driver
Date: Wed, 15 Oct 2008 20:26:36 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568846@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36676 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbYJPB0n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:26:43 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1QbAc028632
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:26:42 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1QbJP012590
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:26:37 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Pallavi Kulkarni <p-kulkarni@ti.com>

OMAP: CAM: Add LSC workaround to ISP driver

This adds software workaround for silicon errata of mutual SDRAM
use of LSC and resizer. This errata was about data corruption
when Lens Shading Compensation table was loaded by CCDC as the 
resizer was working.

Signed-off-by: Pallavi Kulkarni <p-kulkarni@ti.com>
Signed-off-by: Margarita Olaya <magi.olaya@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c        |  114 ++++++++++++++++++++++++++++++++++-
 drivers/media/video/isp/isp.h        |    4 +
 drivers/media/video/isp/ispresizer.c |   22 ++++++
 3 files changed, 138 insertions(+), 2 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c	2008-10-14 12:22:23.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.c	2008-10-14 12:34:05.000000000 -0500
@@ -37,6 +37,7 @@
 #include <asm/mach-types.h>
 #include <linux/device.h>
 #include <linux/videodev2.h>
+#include <linux/vmalloc.h>
 
 #include "isp.h"
 #include "ispmmu.h"
@@ -48,6 +49,14 @@
 #include "isppreview.h"
 #include "ispresizer.h"
 
+#if ISP_WORKAROUND
+void *buff_addr;
+dma_addr_t buff_addr_mapped;
+struct scatterlist *sglist_alloc;
+static int alloc_done, num_sc;
+unsigned long offset_value;
+#endif
+
 /* List of image formats supported via OMAP ISP */
 const static struct v4l2_fmtdesc isp_formats[] = {
 	{
@@ -1110,6 +1119,66 @@
 	omap_writel(omap_readl(ISP_IRQ0STATUS) | ISP_INT_CLR, ISP_IRQ0STATUS);
 }
 
+#if ISP_WORKAROUND
+/**
+ *  isp_buf_allocation - To allocate a 10MB memory
+ *
+ **/
+u32 isp_buf_allocation(void)
+{
+	buff_addr = (void *) vmalloc(buffer_size);
+
+	if (!buff_addr) {
+		printk(KERN_ERR "Cannot allocate memory ");
+		return -ENOMEM;
+	}
+
+	sglist_alloc = videobuf_vmalloc_to_sg(buff_addr, no_of_pages);
+	if (!sglist_alloc) {
+		printk(KERN_ERR "videobuf_vmalloc_to_sg error");
+		return -ENOMEM;
+	}
+	num_sc = dma_map_sg(NULL, sglist_alloc, no_of_pages, 1);
+	buff_addr_mapped = ispmmu_map_sg(sglist_alloc, no_of_pages);
+	if (!buff_addr_mapped) {
+		printk(KERN_ERR "ispmmu_map_sg mapping failed ");
+		return -ENOMEM;
+	}
+	isppreview_set_outaddr(buff_addr_mapped);
+	alloc_done = 1;
+	return 0;
+}
+
+/**
+ *  isp_buf_get - Get the buffer pointer address
+ **/
+dma_addr_t isp_buf_get(void)
+{
+	dma_addr_t retaddr;
+
+	if (alloc_done == 1)
+		retaddr = buff_addr_mapped + offset_value;
+	else
+		retaddr = 0;
+	return retaddr;
+}
+
+/**
+ *  isp_buf_free - To free allocated 10MB memory
+ *
+ **/
+void isp_buf_free(void)
+{
+	if (alloc_done == 1) {
+		ispmmu_unmap(buff_addr_mapped);
+		dma_unmap_sg(NULL, sglist_alloc, no_of_pages, 1);
+		kfree(sglist_alloc);
+		vfree(buff_addr);
+		alloc_done = 0;
+	}
+}
+#endif
+
 /**
  * isp_start - Starts ISP submodule
  *
@@ -1165,9 +1234,11 @@
 	if ((ispmodule_obj.isp_pipeline & OMAP_ISP_RESIZER) &&
 						is_ispresizer_enabled())
 		ispresizer_set_outaddr(sgdma_state->isp_addr);
+#if (ISP_WORKAROUND == 0)
 	else if ((ispmodule_obj.isp_pipeline & OMAP_ISP_PREVIEW) &&
 						is_isppreview_enabled())
 		isppreview_set_outaddr(sgdma_state->isp_addr);
+#endif
 	else if (ispmodule_obj.isp_pipeline & OMAP_ISP_CCDC)
 		ispccdc_set_outaddr(sgdma_state->isp_addr);
 
@@ -1178,9 +1249,13 @@
  * @pix_input: Pointer to V4L2 pixel format structure for input image.
  * @pix_output: Pointer to V4L2 pixel format structure for output image.
  **/
-void isp_calc_pipeline(struct v4l2_pix_format *pix_input,
+u32 isp_calc_pipeline(struct v4l2_pix_format *pix_input,
 					struct v4l2_pix_format *pix_output)
 {
+#if ISP_WORKAROUND
+	int rval;
+#endif
+
 	isp_release_resources();
 	if ((pix_input->pixelformat == V4L2_PIX_FMT_SGRBG10) &&
 		(pix_output->pixelformat != V4L2_PIX_FMT_SGRBG10)) {
@@ -1190,8 +1265,18 @@
 			isppreview_request();
 			ispresizer_request();
 		ispccdc_config_datapath(CCDC_RAW, CCDC_OTHERS_VP);
+#if ISP_WORKAROUND
+		isppreview_config_datapath(PRV_RAW_CCDC, PREVIEW_MEM);
+		ispresizer_config_datapath(RSZ_MEM_YUV);
+		if (alloc_done == 0) {
+			rval = isp_buf_allocation();
+			if (rval)
+				return -EINVAL;
+		}
+#else
 		isppreview_config_datapath(PRV_RAW_CCDC, PREVIEW_RSZ);
 		ispresizer_config_datapath(RSZ_OTFLY_YUV);
+#endif
 	} else {
 		ispmodule_obj.isp_pipeline = OMAP_ISP_CCDC;
 		ispccdc_request();
@@ -1201,7 +1286,7 @@
 			ispccdc_config_datapath(CCDC_YUV_SYNC,
 							CCDC_OTHERS_MEM);
 	}
-	return;
+	return 0;
 }
 
 /**
@@ -1823,6 +1908,10 @@
 {
 	u8 crop_scaling_w;
 	u8 crop_scaling_h;
+#if ISP_WORKAROUND
+	unsigned long org_left, num_pix, new_top;
+#endif
+
 	struct v4l2_pix_format *pix = croppix;
 
 	crop_scaling_w = (ispmodule_obj.preview_output_width * 10) /
@@ -1835,6 +1924,24 @@
 	cur_rect.width = (ispcroprect.width * crop_scaling_w) / 10;
 	cur_rect.height = (ispcroprect.height * crop_scaling_h) / 10;
 
+#if ISP_WORKAROUND
+	org_left = cur_rect.left;
+	while (((int)cur_rect.left & 0xFFFFFFF0) != (int)cur_rect.left)
+		(int)cur_rect.left--;
+
+	num_pix = org_left - cur_rect.left;
+	new_top = (int)(num_pix * 3) / 4;
+	cur_rect.top = cur_rect.top - new_top;
+	cur_rect.height = (2 * new_top) + cur_rect.height;
+
+	cur_rect.width = cur_rect.width + (2 * num_pix);
+	while (((int)cur_rect.width & 0xFFFFFFF0) != (int)cur_rect.width)
+		(int)cur_rect.width--;
+
+	offset_value = ((cur_rect.left * 2) + \
+		((ispmodule_obj.preview_output_width) * 2 * cur_rect.top));
+#endif
+
 	ispresizer_trycrop(cur_rect.left, cur_rect.top, cur_rect.width,
 					cur_rect.height,
 					ispmodule_obj.resizer_output_width,
@@ -2170,6 +2277,9 @@
 			clk_put(isp_obj.cam_mclk);
 			memset(&ispcroprect, 0, sizeof(ispcroprect));
 			memset(&cur_rect, 0, sizeof(cur_rect));
+#if ISP_WORKAROUND
+			isp_buf_free();
+#endif
 		}
 	mutex_unlock(&(isp_obj.isp_mutex));
 	DPRINTK_ISPCTRL("isp_put: new %d\n", isp_obj.ref_count);
Index: omapkernel/drivers/media/video/isp/isp.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.h	2008-10-14 12:22:23.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.h	2008-10-14 12:34:05.000000000 -0500
@@ -68,6 +68,9 @@
 #define ISP_BYTES_PER_PIXEL		2
 #define NUM_ISP_CAPTURE_FORMATS 	(sizeof(isp_formats) /\
 							sizeof(isp_formats[0]))
+#define ISP_WORKAROUND 1
+#define buffer_size (1024 * 1024 * 10)
+#define no_of_pages (buffer_size / (4 * 1024))
 
 typedef int (*isp_vbq_callback_ptr) (struct videobuf_buffer *vb);
 typedef void (*isp_callback_t) (unsigned long status,
@@ -307,6 +310,7 @@
 
 void isp_print_status(void);
 
+dma_addr_t isp_buf_get(void);
 
 int __init isp_ccdc_init(void);
 int __init isp_hist_init(void);
Index: omapkernel/drivers/media/video/isp/ispresizer.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispresizer.c	2008-10-14 12:22:23.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispresizer.c	2008-10-14 12:34:05.000000000 -0500
@@ -29,6 +29,10 @@
 #include "ispreg.h"
 #include "ispresizer.h"
 
+#if ISP_WORKAROUND
+dma_addr_t buff_addr_lsc_wa;
+#endif
+
 /* Default configuration of resizer,filter coefficients,yenh for camera isp */
 static struct isprsz_yenh ispreszdefaultyenh = {0, 0, 0, 0};
 static struct isprsz_coef ispreszdefcoef = {
@@ -498,17 +502,35 @@
 						" \n", output_w , output_h);
 		return -EINVAL;
 	}
+
+#if ISP_WORKAROUND
+	buff_addr_lsc_wa = isp_buf_get();
+	if (buff_addr_lsc_wa) {
+		/* Set Resizer input address and offset adderss */
+		ispresizer_set_inaddr(buff_addr_lsc_wa);
+		ispresizer_config_inlineoffset(omap_readl(ISPPRV_WADD_OFFSET));
+	}
+#endif
+
 	res = omap_readl(ISPRSZ_CNT) & (~(ISPRSZ_CNT_HSTPH_MASK |
 					ISPRSZ_CNT_VSTPH_MASK));
 	omap_writel(res | (ispres_obj.h_startphase << ISPRSZ_CNT_HSTPH_SHIFT) |
 						(ispres_obj.v_startphase <<
 						ISPRSZ_CNT_VSTPH_SHIFT),
 						ISPRSZ_CNT);
+#if ISP_WORKAROUND
+	omap_writel((0x00 <<	ISPRSZ_IN_START_HORZ_ST_SHIFT) |
+					(0x00 <<
+					ISPRSZ_IN_START_VERT_ST_SHIFT),
+					ISPRSZ_IN_START);
+
+#else
 	omap_writel(((ispres_obj.ipwd_crop * 2) <<
 					ISPRSZ_IN_START_HORZ_ST_SHIFT) |
 					(ispres_obj.ipht_crop <<
 					ISPRSZ_IN_START_VERT_ST_SHIFT),
 					ISPRSZ_IN_START);
+#endif
 
 	omap_writel((ispres_obj.inputwidth << ISPRSZ_IN_SIZE_HORZ_SHIFT) |
 						(ispres_obj.inputheight <<
