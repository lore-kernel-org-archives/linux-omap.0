From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] CAM: Alloc ISP Workaround buffer at driver init.
Date: Fri, 30 Jan 2009 18:28:24 -0600
Message-ID: <200901301828.24949.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38108 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbZAaA2b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2009 19:28:31 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0V0SPg3008988
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 18:28:30 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n0V0SP9i002949
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 18:28:25 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH] CAM: Alloc ISP Workaround buffer at driver init.

This patch allows the ISP Workaround buffer to be allocated at boot time.
Previously the buffer was being allocated everytime a handle to the driver
was opened.
Because the ISP Workaround buffer can be very large then there is
significant benefit for the buffer to be allocated only once during camera 
driver initialization.

Signed-off-by: Pallavi Kulkarni <p-kulkarni@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    1 +
 arch/arm/configs/omap_zoom2_defconfig   |    1 +
 drivers/media/video/Kconfig             |    8 ++++++++
 drivers/media/video/isp/isp.c           |   30 +++++++++++++++++++++++++++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

================================================================================

Index: omapzoom04/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- omapzoom04.orig/arch/arm/configs/omap_3430sdp_defconfig
+++ omapzoom04/arch/arm/configs/omap_3430sdp_defconfig
@@ -1077,6 +1077,7 @@ CONFIG_VIDEO_OMAP24XX_TVOUT=y
 CONFIG_VIDEO_OMAP3=y
 CONFIG_VIDEO_OMAP34XX_ISP_PREVIEWER=y
 CONFIG_VIDEO_OMAP34XX_ISP_RESIZER=y
+CONFIG_VIDEO_OMAP3_BUFFALLOC=y
 # CONFIG_VIDEO_OMAP2 is not set
 # CONFIG_V4L_USB_DRIVERS is not set
 # CONFIG_SOC_CAMERA is not set
Index: omapzoom04/arch/arm/configs/omap_zoom2_defconfig
===================================================================
--- omapzoom04.orig/arch/arm/configs/omap_zoom2_defconfig
+++ omapzoom04/arch/arm/configs/omap_zoom2_defconfig
@@ -1032,6 +1032,7 @@ CONFIG_VIDEO_OMAP24XX_TVOUT=y
 CONFIG_VIDEO_OMAP3=y
 CONFIG_VIDEO_OMAP34XX_ISP_PREVIEWER=y
 CONFIG_VIDEO_OMAP34XX_ISP_RESIZER=y
+CONFIG_VIDEO_OMAP3_BUFFALLOC=y
 # CONFIG_VIDEO_OMAP2 is not set
 # CONFIG_SOC_CAMERA is not set
 # CONFIG_VIDEO_SH_MOBILE_CEU is not set
Index: omapzoom04/drivers/media/video/Kconfig
===================================================================
--- omapzoom04.orig/drivers/media/video/Kconfig
+++ omapzoom04/drivers/media/video/Kconfig
@@ -842,6 +842,14 @@ config VIDEO_OMAP3
 
 source "drivers/media/video/isp/Kconfig"
 
+config VIDEO_OMAP3_BUFFALLOC
+	bool "OMAP3430 ISP Workaround: Allocate memory at driver init"
+	depends on VIDEO_OMAP3 && ARCH_OMAP3430
+	default y
+	---help---
+	  This option is for allocating the workaround buffer at
+	  camera init time.
+
 config VIDEO_OMAP2
 	tristate "OMAP 2 Camera support (EXPERIMENTAL)"
 	select VIDEOBUF_GEN
Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -1185,6 +1185,15 @@ u32 isp_buf_allocation(void)
 		return -ENOMEM;
 	}
 	num_sc = dma_map_sg(NULL, sglist_alloc, ISP_BUFFER_MAX_PAGES, 1);
+	return 0;
+}
+
+/**
+ *  isp_buf_mmap - Create MMU scatter-gather list.
+ *
+ **/
+u32 isp_buf_mmap(void)
+{
 	buff_addr_mapped = ispmmu_map_sg(sglist_alloc, ISP_BUFFER_MAX_PAGES);
 	if (!buff_addr_mapped) {
 		printk(KERN_ERR "ispmmu_map_sg mapping failed ");
@@ -1340,9 +1349,14 @@ u32 isp_calc_pipeline(struct v4l2_pix_fo
 		isppreview_config_datapath(PRV_RAW_CCDC, PREVIEW_MEM);
 		ispresizer_config_datapath(RSZ_MEM_YUV);
 		if (alloc_done == 0) {
+#if !defined(CONFIG_VIDEO_OMAP3_BUFFALLOC)
 			rval = isp_buf_allocation();
 			if (rval)
 				return -EINVAL;
+#endif
+			rval = isp_buf_mmap();
+			if (rval)
+				return -EINVAL;
 		}
 #else
 		isppreview_config_datapath(PRV_RAW_CCDC, PREVIEW_RSZ);
@@ -2367,7 +2381,7 @@ int isp_put(void)
 		if (--isp_obj.ref_count == 0) {
 			isp_save_ctx();
 			off_mode = 1;
-#if ISP_WORKAROUND
+#if ISP_WORKAROUND && !defined(CONFIG_VIDEO_OMAP3_BUFFALLOC)
 			isp_buf_free();
 #endif
 			isp_release_resources();
@@ -2420,6 +2434,9 @@ EXPORT_SYMBOL(isp_restore_context);
  **/
 static int __init isp_init(void)
 {
+#if ISP_WORKAROUND && defined(CONFIG_VIDEO_OMAP3_BUFFALLOC)
+	int rval;
+#endif
 	DPRINTK_ISPCTRL("+isp_init for Omap 3430 Camera ISP\n");
 	isp_obj.ref_count = 0;
 
@@ -2427,6 +2444,14 @@ static int __init isp_init(void)
 	spin_lock_init(&isp_obj.isp_temp_buf_lock);
 	spin_lock_init(&isp_obj.lock);
 
+#if ISP_WORKAROUND && defined(CONFIG_VIDEO_OMAP3_BUFFALLOC)
+	if (alloc_done == 0) {
+		rval = isp_buf_allocation();
+		if (rval)
+			return -EINVAL;
+	}
+#endif
+
 	if (request_irq(INT_34XX_CAM_IRQ, omap34xx_isp_isr, IRQF_SHARED,
 				"Omap 34xx Camera ISP", &ispirq_obj)) {
 		DPRINTK_ISPCTRL("Could not install ISR\n");
@@ -2459,6 +2484,9 @@ static void __exit isp_cleanup(void)
 	isp_hist_cleanup();
 	isp_ccdc_cleanup();
 	free_irq(INT_34XX_CAM_IRQ, &ispirq_obj);
+#if ISP_WORKAROUND && defined(CONFIG_VIDEO_OMAP3_BUFFALLOC)
+	isp_buf_free();
+#endif
 }
 
 /**
