From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 26/28] [OMAPZOOM] OMAP: CAM: Add CSI2 changes to Camera
 driver
Date: Wed, 15 Oct 2008 20:36:37 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256885C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41995 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbYJPBgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:36:45 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1adBM018570
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:36:44 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1addF022252
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:36:39 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: Add CSI2 changes to Camera driver

This adds CSI2 related changes to the main OMAP34xx camera driver.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/omap34xxcam.c |    4 +++-
 drivers/media/video/omap34xxcam.h |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

Index: omapkernel/drivers/media/video/omap34xxcam.c
===================================================================
--- omapkernel.orig/drivers/media/video/omap34xxcam.c	2008-10-14 18:51:51.000000000 -0500
+++ omapkernel/drivers/media/video/omap34xxcam.c	2008-10-14 18:52:19.000000000 -0500
@@ -37,6 +37,7 @@
 #include "omap34xxcam.h"
 #include "isp/isph3a.h"
 #include "isp/isp_af.h"
+#include "isp/ispcsi2.h"
 
 #define OMAP34XXCAM_VERSION KERNEL_VERSION(0, 0, 0)
 
@@ -478,7 +479,8 @@
 		 best_pix_in->width, best_pix_in->height,
 		 best_pix_out.width, best_pix_out.height);
 
-	return isp_try_fmt_cap(best_pix_in, wanted_pix_out); }
+	return isp_try_fmt_cap(best_pix_in, wanted_pix_out);
+}
 
 static int s_pix_parm(struct omap34xxcam_videodev *vdev,
 		      struct v4l2_pix_format *best_pix,
Index: omapkernel/drivers/media/video/omap34xxcam.h
===================================================================
--- omapkernel.orig/drivers/media/video/omap34xxcam.h	2008-10-14 18:48:38.000000000 -0500
+++ omapkernel/drivers/media/video/omap34xxcam.h	2008-10-14 18:52:19.000000000 -0500
@@ -45,6 +45,29 @@
 struct omap34xxcam_device;
 struct omap34xxcam_videodev;
 
+struct omap34xxcam_hw_csi2_lanes_data {
+	unsigned polarity:1;
+	unsigned position:3;
+};
+
+struct omap34xxcam_hw_csi2_lanes {
+	struct omap34xxcam_hw_csi2_lanes_data data[4];
+	struct omap34xxcam_hw_csi2_lanes_data clock;
+};
+
+struct omap34xxcam_hw_csi2_phy {
+	u8 ths_term;
+	u8 ths_settle;
+	u8 tclk_term;
+	unsigned tclk_miss:1;
+	u8 tclk_settle;
+};
+
+struct omap34xxcam_hw_csi2 {
+	struct omap34xxcam_hw_csi2_lanes lanes;
+	struct omap34xxcam_hw_csi2_phy phy;
+};
+
 struct omap34xxcam_sensor_config {
 	int xclk;
 	int sensor_isp;
@@ -68,11 +91,15 @@
 	int dev_index; /* Index in omap34xxcam_sensors */
 	int dev_minor; /* Video device minor number */
 	int dev_type; /* OMAP34XXCAM_SLAVE_* */
+	int interface_type; /* Interface type */
 	union {
 		struct omap34xxcam_sensor_config sensor;
 		struct omap34xxcam_lens_config lens;
 		struct omap34xxcam_flash_config flash;
 	} u;
+	union {
+		struct omap34xxcam_hw_csi2 hw_csi2;
+	} csi2;
 };
 
 /**
