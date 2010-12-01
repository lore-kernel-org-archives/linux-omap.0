From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: [PATCH] OMAP: DSS2: Adding check_timings and set_timings for
 panel-taal
Date: Wed, 1 Dec 2010 16:29:42 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB0322C02A6E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49181 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab0LAK7t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 05:59:49 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

This patch would add two APIs for panel-taal:
check_timings and set_timings.

These are required by omapfb in case we wish to set default mode through bootargs.
e.g.: omapfb.mode="lcd:640x480-16" (display device:width X height - bits per pixel)

omapfb_set_def_mode function in omapfb-main.c essentially needs these functions
otherwise it would return -EINVAL and default mode sent through bootargs
would be ignored.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e1c765d..e29c308 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -476,6 +476,29 @@ static void taal_get_timings(struct omap_dss_device *dssdev,
 	*timings = dssdev->panel.timings;
 }
 
+static void taal_set_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	/* TAAL panel's timing struct has only x_res and y_res
+	 * other timing parameters are not set
+	 */
+	dssdev->panel.timings.x_res = timings->x_res;
+	dssdev->panel.timings.y_res = timings->y_res;
+}
+
+static int taal_check_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	/* TAAL panel's timing struct has only x_res and y_res
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
@@ -1563,6 +1586,8 @@ static struct omap_dss_driver taal_driver = {
 	.memory_read	= taal_memory_read,
 
 	.get_timings	= taal_get_timings,
+	.set_timings	= taal_set_timings,
+	.check_timings	= taal_check_timings,
 
 	.driver         = {
 		.name   = "taal",
-- 
1.7.0.4

