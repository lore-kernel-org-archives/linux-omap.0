From: Mayuresh Janorkar <mayur@ti.com>
Subject: [RESEND][PATCH v2] OMAP: DSS: Adding two APIs for panel-taal: check_timings and set_timings
Date: Wed, 16 Feb 2011 19:24:42 +0530
Message-ID: <1297864482-16903-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53594 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab1BPNZp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 08:25:45 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GDPiEe004128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 07:25:44 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Mayuresh Janorkar <mayur@ti.com>

check_timings and set_timings APIS are not present for panel-taal.

OMAPFB provides a bootarg omapfb.mode for setting mode parameters which include display,
resolution, bits-per-pixel.

OMAPFB expects panel driver to have check_timings and set_timings APIs.
These are checked by omapfb in case we wish to set default mode through bootargs.
e.g.: omapfb.mode="lcd:864x480-16" (display device:width X height - bits per pixel)

omapfb_set_def_mode function in omapfb-main.c essentially needs these functions
otherwise it would return -EINVAL and default mode sent through bootargs
would be ignored.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 61026f9..aded08c 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -476,6 +476,31 @@ static void taal_get_timings(struct omap_dss_device *dssdev,
 	*timings = dssdev->panel.timings;
 }
 
+static void taal_set_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	/*
+	 * TAAL panel's timing struct has only x_res and y_res
+	 * other timing parameters are not set
+	 */
+	dssdev->panel.timings.x_res = timings->x_res;
+	dssdev->panel.timings.y_res = timings->y_res;
+}
+
+static int taal_check_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	/*
+	 * TAAL panel's timing struct has only x_res and y_res
+	 * other timing parameters are not set
+	 */
+	if (!timings || timings->x_res != dssdev->panel.timings.x_res ||
+		timings->y_res != dssdev->panel.timings.y_res)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void taal_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres)
 {
@@ -1563,6 +1588,8 @@ static struct omap_dss_driver taal_driver = {
 	.memory_read	= taal_memory_read,
 
 	.get_timings	= taal_get_timings,
+	.set_timings	= taal_set_timings,
+	.check_timings	= taal_check_timings,
 
 	.driver         = {
 		.name   = "taal",
-- 
1.7.1

