From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] ISP: Set dcsub in omap board file.
Date: Mon, 15 Dec 2008 19:53:12 -0600
Message-ID: <200812151953.12449.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52709 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbYLPBxT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Dec 2008 20:53:19 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mBG1rDmj004723
	for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 19:53:18 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id mBG1rDnl006505
	for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 19:53:13 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] ISP: Set dcsub in omap board file.

The dcsub (black level) is currently hardcoded to the MT9P012
sensors value in the ISP CCDC module.
This patch removes the hardcode and moves the setup of this 
value to the camera section of the board file.
Other sensor currently use a dcsub value of 0 (default).

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    1 +
 drivers/media/video/isp/isp.c       |    1 +
 drivers/media/video/isp/isp.h       |    1 +
 drivers/media/video/isp/ispccdc.c   |   16 ++++++++++++++--
 drivers/media/video/isp/ispccdc.h   |    2 ++
 5 files changed, 19 insertions(+), 2 deletions(-)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -632,6 +632,7 @@ static struct isp_interface_config mt9p0
 	.prev_sph = 2,
 	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_OR,
+	.dcsub = 42,
 	.u.par.par_bridge = 0x0,
 	.u.par.par_clk_pol = 0x0,
 };
Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -951,6 +951,7 @@ int isp_configure_interface(struct isp_i
 	/* Set sensor specific fields in CCDC and Previewer module.*/
 	isppreview_set_skip(config->prev_sph, config->prev_slv);
 	ispccdc_set_wenlog(config->wenlog);
+	ispccdc_set_dcsub(config->dcsub);
 
 	return 0;
 }
Index: omapzoom04/drivers/media/video/isp/isp.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.h
+++ omapzoom04/drivers/media/video/isp/isp.h
@@ -195,6 +195,7 @@ struct isp_interface_config {
 	u32 prev_sph;
 	u32 prev_slv;
 	u32 wenlog;
+	u32 dcsub;
 	union {
 		struct par {
 			unsigned par_bridge:2;
Index: omapzoom04/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/ispccdc.c
+++ omapzoom04/drivers/media/video/isp/ispccdc.c
@@ -83,6 +83,7 @@ static struct isp_ccdc {
 	u8 lsc_en;
 	struct mutex mutexlock; /* For checking/modifying ccdc_inuse */
 	u32 wenlog;
+	u32 dcsub;
 } ispccdc_obj;
 
 static struct ispccdc_lsc_config lsc_config;
@@ -327,6 +328,16 @@ void ispccdc_set_wenlog(u32 wenlog)
 EXPORT_SYMBOL(ispccdc_set_wenlog);
 
 /**
+ * Set the value to be used for ISPCCDC_DCSUB.
+ *  dcsub - Value of black level.
+ */
+void ispccdc_set_dcsub(u32 dcsub)
+{
+	ispccdc_obj.dcsub = dcsub;
+}
+EXPORT_SYMBOL(ispccdc_set_dcsub);
+
+/**
  * ispccdc_request - Reserves the CCDC module.
  *
  * Reserves the CCDC module and assures that is used only once at a time.
@@ -626,7 +637,7 @@ int ispccdc_config_datapath(enum ccdc_in
 		syncif.vdpol = 0;
 		ispccdc_config_sync_if(syncif);
 		ispccdc_config_imgattr(colptn);
-		blkcfg.dcsubval = 42;
+		blkcfg.dcsubval = ispccdc_obj.dcsub;
 		ispccdc_config_black_clamp(blkcfg);
 		if (is_isplsc_activated()) {
 			ispccdc_config_lsc(&lsc_config);
@@ -673,7 +684,7 @@ int ispccdc_config_datapath(enum ccdc_in
 		ispccdc_config_sync_if(syncif);
 		ispccdc_config_imgattr(colptn);
 		/* Config DC sub */
-		blkcfg.dcsubval = 42;
+		blkcfg.dcsubval = ispccdc_obj.dcsub;
 		ispccdc_config_black_clamp(blkcfg);
 		break;
 	case CCDC_YUV_BT:
@@ -1577,6 +1588,7 @@ EXPORT_SYMBOL(ispccdc_print_status);
 int __init isp_ccdc_init(void)
 {
 	ispccdc_obj.ccdc_inuse = 0;
+	ispccdc_obj.dcsub = 0;
 	ispccdc_config_crop(0, 0, 0, 0);
 	mutex_init(&ispccdc_obj.mutexlock);
 
Index: omapzoom04/drivers/media/video/isp/ispccdc.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/ispccdc.h
+++ omapzoom04/drivers/media/video/isp/ispccdc.h
@@ -211,4 +211,6 @@ int omap34xx_isp_ccdc_config(void *users
 
 void ispccdc_set_wenlog(u32 wenlog);
 
+void ispccdc_set_dcsub(u32 dcsub);
+
 #endif		/* OMAP_ISP_CCDC_H */
