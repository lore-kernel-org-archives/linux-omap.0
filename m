From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] ISP: Add default white balance values to board file.
Date: Thu, 26 Feb 2009 18:09:28 -0600
Message-ID: <200902261809.29343.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44903 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755478AbZB0AJh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 19:09:37 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1R09UwT015433
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 18:09:35 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n1R09UKL012744
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 18:09:30 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] ISP: Add default white balance values to board file.

This patch stores the sensors default white balance coefficient values in the 
board file.
This patch keeps the same coef for MT9P012 & OV3640, but changes the coefficients 
for the IMX046.
Changing the coefficients for the IMX046 fixes a yellowish tint in the image.

The patch is based on top of the set of patches labeled 'Component Order'.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c  |   12 ++++++++++++
 arch/arm/mach-omap2/board-ldp.c      |    4 ++++
 arch/arm/mach-omap2/board-zoom2.c    |    4 ++++
 drivers/media/video/isp/isp.c        |    1 +
 drivers/media/video/isp/isp.h        |    3 +++
 drivers/media/video/isp/isppreview.c |   18 ++++++++++++++++++
 drivers/media/video/isp/isppreview.h |    2 ++
 7 files changed, 44 insertions(+)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -660,6 +660,10 @@ static struct isp_interface_config mt9p0
 	.wenlog = ISPCCDC_CFG_WENLOG_OR,
 	.dcsub = 42,
 	.raw_fmt_in = ISPCCDC_INPUT_FMT_GR_BG,
+	.wbal.coef0 = 0x23,
+	.wbal.coef1 = 0x20,
+	.wbal.coef2 = 0x20,
+	.wbal.coef3 = 0x30,
 	.u.par.par_bridge = 0x0,
 	.u.par.par_clk_pol = 0x0,
 };
@@ -783,6 +787,10 @@ static struct isp_interface_config ov364
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
 	.dcsub = OV3640_BLACK_LEVEL_10BIT,
 	.raw_fmt_in = ISPCCDC_INPUT_FMT_BG_GR,
+	.wbal.coef0 = 0x23,
+	.wbal.coef1 = 0x20,
+	.wbal.coef2 = 0x20,
+	.wbal.coef3 = 0x30,
 	.u.csi.crc = 0x0,
 	.u.csi.mode = 0x0,
 	.u.csi.edge = 0x0,
@@ -991,6 +999,10 @@ static struct isp_interface_config imx04
 	.wenlog 		= ISPCCDC_CFG_WENLOG_OR,
 	.dcsub 			= IMX046_BLACK_LEVEL_AVG,
 	.raw_fmt_in		= ISPCCDC_INPUT_FMT_RG_GB,
+	.wbal.coef0		= 0x23,
+	.wbal.coef1		= 0x20,
+	.wbal.coef2		= 0x20,
+	.wbal.coef3		= 0x39,
 	.u.csi.crc 		= 0x0,
 	.u.csi.mode 		= 0x0,
 	.u.csi.edge 		= 0x0,
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -625,6 +625,10 @@ static struct isp_interface_config ov364
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
 	.dcsub = OV3640_BLACK_LEVEL_10BIT,
 	.raw_fmt_in = ISPCCDC_INPUT_FMT_BG_GR,
+	.wbal.coef0 = 0x23,
+	.wbal.coef1 = 0x20,
+	.wbal.coef2 = 0x20,
+	.wbal.coef3 = 0x30,
 	.u.csi.crc = 0x0,
 	.u.csi.mode = 0x0,
 	.u.csi.edge = 0x0,
Index: omapzoom04/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-zoom2.c
+++ omapzoom04/arch/arm/mach-omap2/board-zoom2.c
@@ -371,6 +371,10 @@ static struct isp_interface_config imx04
 	.wenlog 		= ISPCCDC_CFG_WENLOG_OR,
 	.dcsub 			= IMX046_BLACK_LEVEL_AVG,
 	.raw_fmt_in		= ISPCCDC_INPUT_FMT_RG_GB,
+	.wbal.coef0		= 0x23,
+	.wbal.coef1		= 0x20,
+	.wbal.coef2		= 0x20,
+	.wbal.coef3		= 0x39,
 	.u.csi.crc 		= 0x0,
 	.u.csi.mode 		= 0x0,
 	.u.csi.edge 		= 0x0,
Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -952,6 +952,7 @@ int isp_configure_interface(struct isp_i
 	ispccdc_set_wenlog(config->wenlog);
 	ispccdc_set_dcsub(config->dcsub);
 	ispccdc_set_crop_offset(config->raw_fmt_in);
+	isppreview_set_whitebalance(&config->wbal);
 
 	return 0;
 }
Index: omapzoom04/drivers/media/video/isp/isp.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.h
+++ omapzoom04/drivers/media/video/isp/isp.h
@@ -27,6 +27,8 @@
 #include <media/videobuf-dma-sg.h>
 #include <linux/videodev2.h>
 
+#include <mach/isp_user.h>
+
 #include "ispmmu.h"
 
 #define OMAP_ISP_CCDC		(1 << 0)
@@ -205,6 +207,7 @@ struct isp_interface_config {
 	u32 wenlog;
 	u32 dcsub;
 	enum ispccdc_raw_fmt raw_fmt_in;
+	struct ispprev_wbal wbal;
 	union {
 		struct par {
 			unsigned par_bridge:2;
Index: omapzoom04/drivers/media/video/isp/isppreview.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isppreview.c
+++ omapzoom04/drivers/media/video/isp/isppreview.c
@@ -1253,6 +1253,24 @@ void isppreview_enable_chroma_suppressio
 EXPORT_SYMBOL(isppreview_enable_chroma_suppression);
 
 /**
+ * isppreview_set_whitebalance - Change the White Balance parameters.
+ * @prev_wbal: Pointer to structure containing the digital gain and
+ *             white balance coefficient.
+ *
+ * Store and set the Coefficient matrix.
+ **/
+void isppreview_set_whitebalance(struct ispprev_wbal *wbal)
+{
+	params->wbal.coef0 = wbal->coef0;
+	params->wbal.coef1 = wbal->coef1;
+	params->wbal.coef2 = wbal->coef2;
+	params->wbal.coef3 = wbal->coef3;
+
+	isppreview_config_whitebalance(params->wbal);
+}
+EXPORT_SYMBOL(isppreview_set_whitebalance);
+
+/**
  * isppreview_config_whitebalance - Configures the White Balance parameters.
  * @prev_wbal: Structure containing the digital gain and white balance
  *             coefficient.
Index: omapzoom04/drivers/media/video/isp/isppreview.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isppreview.h
+++ omapzoom04/drivers/media/video/isp/isppreview.h
@@ -359,4 +359,6 @@ int omap34xx_isp_tables_update(struct is
 
 void isppreview_set_skip(u32 h, u32 v);
 
+void isppreview_set_whitebalance(struct ispprev_wbal *wbal);
+
 #endif/* OMAP_ISP_PREVIEW_H */
