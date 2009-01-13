From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 2/2] OMAP3: CAM: Make MT9P012 DW9710 OV3640 depend
 on OMAP3
Date: Tue, 13 Jan 2009 11:02:13 -0600
Message-ID: <A24693684029E5489D1D202277BE8944164DF4AA@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33605 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070AbZAMRCU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 12:02:20 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0DH2EOA004193
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:02:19 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0DH2EPY008655
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 11:02:14 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From da51df52f8b583e5060963941810fa9f6d3feedd Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 13 Jan 2009 10:53:34 -0600
Subject: [PATCH 2/2] OMAP3: CAM: Make MT9P012 DW9710 OV3640 depend on OMAP3

This patch adds dependency on sensor drivers to work only
when omap3 camera is enabled, as this is the only tested
environment.

NOTE: This is really a temporary fix, until the driver
works in some other environment/platform.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Reported-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/media/video/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 84be126..6467b4c 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -305,7 +305,7 @@ config VIDEO_OV9640
 
 config VIDEO_MT9P012
 	tristate "Micron MT9P012 raw sensor driver (5MP)"
-	depends on I2C && VIDEO_V4L2
+	depends on I2C && VIDEO_V4L2 && VIDEO_OMAP3
 	---help---
 	  This is a Video4Linux2 sensor-level driver for the Micron
 	  MT9P012 camera.  It is currently working with the TI OMAP3
@@ -313,7 +313,7 @@ config VIDEO_MT9P012
 
 config VIDEO_DW9710
 	tristate "Lens driver for DW9710"
-	depends on I2C && VIDEO_V4L2
+	depends on I2C && VIDEO_V4L2 && VIDEO_OMAP3
 	---help---
 	  This is a Video4Linux2 lens driver for the Dongwoon
 	  DW9710 coil.  It is currently working with the TI OMAP3
@@ -321,7 +321,7 @@ config VIDEO_DW9710
 
 config VIDEO_OV3640
 	tristate "OmniVision ov3640 smart sensor driver (3MP)"
-	depends on I2C && VIDEO_V4L2
+	depends on I2C && VIDEO_V4L2 && VIDEO_OMAP3
 	---help---
 	  This is a Video4Linux2 sensor-level driver for the OmniVision
 	  OV3640 camera.  It is currently working with the TI OMAP3
@@ -329,7 +329,7 @@ config VIDEO_OV3640
 
 config VIDEO_OV3640_CSI2
 	bool "CSI2 bus support for OmniVision ov3640 sensor"
-	depends on I2C && VIDEO_V4L2 && VIDEO_OV3640
+	depends on I2C && VIDEO_V4L2 && VIDEO_OV3640 && VIDEO_OMAP3
 	---help---
 	  This enables the use of the CSI2 serial bus for the ov3640
 	  camera.
-- 
1.5.6.5

