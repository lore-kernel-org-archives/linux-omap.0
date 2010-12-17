From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: [PATCH v2]: OMAP: DSS2: Adding check_timings and set_timings for
 panel-taal
Date: Fri, 17 Dec 2010 20:27:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB0322F8686D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50496 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab0LQO6B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 09:58:01 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBHEvvcn006933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 08:58:00 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oBHEvvl2012849
	for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 20:27:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>

Adding two APIs for panel-taal: check_timings and set_timings

These are required by omapfb in case we wish to set default mode through bootargs.
e.g.: omapfb.mode="lcd:640x480-16" (display device:width X height - bits per pixel)

omapfb_set_def_mode function in omapfb-main.c essentially needs these functions
otherwise it would return -EINVAL and default mode sent through bootargs
would be ignored.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e1c765d..0bb2c30 100644
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
1.7.0.4

