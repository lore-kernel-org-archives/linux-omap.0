From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] Set the dcsub value for the OV3640 sensor.
Date: Wed, 7 Jan 2009 15:24:11 -0600
Message-ID: <200901071524.11815.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbZAGVYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jan 2009 16:24:18 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n07LOC4w031330
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 15:24:17 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n07LOC7H015119
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 15:24:12 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH] Set the dcsub value for the OV3640 sensor.

Explicitly set the dcsub (black level subtraction) value for the OV3640 sensor.
For the OV3640 sensor the manufacturer recommends a BLC of 16 (for 10-bit data).
This is a constant value that can be read from the sensors BLC9[3:0] register. 
The reg value (0x4) is for 8-bit data, so for 10-bit data this value should be 
left shifted by 2 (0x10).

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    1 +
 arch/arm/mach-omap2/board-ldp.c     |    1 +
 drivers/media/video/ov3640.h        |    2 ++
 3 files changed, 4 insertions(+)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -756,6 +756,7 @@ static struct isp_interface_config ov364
 	.prev_sph = 2,
 	.prev_slv = 1,
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
+	.dcsub = OV3640_BLACK_LEVEL_10BIT,
 	.u.csi.crc = 0x0,
 	.u.csi.mode = 0x0,
 	.u.csi.edge = 0x0,
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -625,6 +625,7 @@ static struct isp_interface_config ov364
 	.prev_sph = 2,
 	.prev_slv = 1,
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
+	.dcsub = OV3640_BLACK_LEVEL_10BIT,
 	.u.csi.crc = 0x0,
 	.u.csi.mode = 0x0,
 	.u.csi.edge = 0x0,
Index: omapzoom04/drivers/media/video/ov3640.h
===================================================================
--- omapzoom04.orig/drivers/media/video/ov3640.h
+++ omapzoom04/drivers/media/video/ov3640.h
@@ -62,6 +62,8 @@
 #define OV3640_MAX_COLOR		2
 #define OV3640_COLOR_STEP		1
 
+#define OV3640_BLACK_LEVEL_10BIT	16
+
 #define SENSOR_DETECTED		1
 #define SENSOR_NOT_DETECTED	0
 
