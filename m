From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 3/3] ISP: Remove unneeded Previewer offset settings.
Date: Thu, 26 Feb 2009 16:40:02 -0600
Message-ID: <200902261640.02952.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41002 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281AbZBZWkJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:40:09 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1QMe3aF030301
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:40:08 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1QMe2WU006026
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:40:03 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 3/3] ISP: Remove unneeded Previewer offset settings.

Before this patch set the component order was controlled by chnaging offsets in 
the Previewer module.
This was rather unsatifactory because output component order from CCDC differed 
depending on sensor.

The 2nd patch in this series fixes this and causes the CCDC output component 
order to be consistent for all sensors regardless of the input order.

This means that input component order is always the same for Previewer, and 
therefore there is no need to compensate for different offsets in Previewer.

This patch removed the Preveiwer offset compensation from the board file, whic is 
now unnecessary.


Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    6 ------
 arch/arm/mach-omap2/board-ldp.c     |    2 --
 arch/arm/mach-omap2/board-zoom2.c   |    2 --
 drivers/media/video/isp/isp.c       |    1 -
 drivers/media/video/isp/isp.h       |    2 --
 5 files changed, 13 deletions(-)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -657,8 +657,6 @@ static struct isp_interface_config mt9p0
 	.strobe = 0x0,
 	.prestrobe = 0x0,
 	.shutter = 0x0,
-	.prev_sph = 2,
-	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_OR,
 	.dcsub = 42,
 	.raw_fmt_in = ISPCCDC_INPUT_FMT_GR_BG,
@@ -782,8 +780,6 @@ static struct isp_interface_config ov364
 	.strobe = 0x0,
 	.prestrobe = 0x0,
 	.shutter = 0x0,
-	.prev_sph = 2,
-	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
 	.dcsub = OV3640_BLACK_LEVEL_10BIT,
 	.raw_fmt_in = ISPCCDC_INPUT_FMT_BG_GR,
@@ -992,8 +988,6 @@ static struct isp_interface_config imx04
 	.strobe 		= 0x0,
 	.prestrobe 		= 0x0,
 	.shutter 		= 0x0,
-	.prev_sph 		= 2,
-	.prev_slv 		= 0,
 	.wenlog 		= ISPCCDC_CFG_WENLOG_OR,
 	.dcsub 			= IMX046_BLACK_LEVEL_AVG,
 	.raw_fmt_in		= ISPCCDC_INPUT_FMT_RG_GB,
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -622,8 +622,6 @@ static struct isp_interface_config ov364
 	.strobe = 0x0,
 	.prestrobe = 0x0,
 	.shutter = 0x0,
-	.prev_sph = 2,
-	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
 	.dcsub = OV3640_BLACK_LEVEL_10BIT,
 	.raw_fmt_in = ISPCCDC_INPUT_FMT_BG_GR,
Index: omapzoom04/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-zoom2.c
+++ omapzoom04/arch/arm/mach-omap2/board-zoom2.c
@@ -368,8 +368,6 @@ static struct isp_interface_config imx04
 	.strobe 		= 0x0,
 	.prestrobe 		= 0x0,
 	.shutter 		= 0x0,
-	.prev_sph 		= 2,
-	.prev_slv 		= 0,
 	.wenlog 		= ISPCCDC_CFG_WENLOG_OR,
 	.dcsub 			= IMX046_BLACK_LEVEL_AVG,
 	.raw_fmt_in		= ISPCCDC_INPUT_FMT_RG_GB,
Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -949,7 +949,6 @@ int isp_configure_interface(struct isp_i
 						ISPCCDC_VDINT);
 
 	/* Set sensor specific fields in CCDC and Previewer module.*/
-	isppreview_set_skip(config->prev_sph, config->prev_slv);
 	ispccdc_set_wenlog(config->wenlog);
 	ispccdc_set_dcsub(config->dcsub);
 	ispccdc_set_crop_offset(config->raw_fmt_in);
Index: omapzoom04/drivers/media/video/isp/isp.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.h
+++ omapzoom04/drivers/media/video/isp/isp.h
@@ -202,8 +202,6 @@ struct isp_interface_config {
 	int strobe;
 	int prestrobe;
 	int shutter;
-	u32 prev_sph;
-	u32 prev_slv;
 	u32 wenlog;
 	u32 dcsub;
 	enum ispccdc_raw_fmt raw_fmt_in;
