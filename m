From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/2] OMAPDSS: provide default get_timings function for panels
Date: Thu, 15 Mar 2012 20:00:23 +0200
Message-ID: <1331834424-485-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62896 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab2COSAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 14:00:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

With this we can eliminate some duplicate code in panel drivers.
Also lgphilips-lb035q02, nec-nl8048hl11-01b, picodlp and
tpo-td043mtea1 gain support of reading timings over sysfs.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c   |    7 -------
 drivers/video/omap2/displays/panel-generic-dpi.c |    7 -------
 drivers/video/omap2/displays/panel-n8x0.c        |    8 --------
 drivers/video/omap2/displays/panel-taal.c        |    8 --------
 drivers/video/omap2/dss/core.c                   |    2 ++
 drivers/video/omap2/dss/display.c                |    7 +++++++
 drivers/video/omap2/dss/venc.c                   |    7 -------
 include/video/omapdss.h                          |    2 ++
 8 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index dbd59b8..d82f09b 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -738,12 +738,6 @@ static void acx_panel_set_timings(struct omap_dss_device *dssdev,
 	}
 }
 
-static void acx_panel_get_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
 static int acx_panel_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -761,7 +755,6 @@ static struct omap_dss_driver acx_panel_driver = {
 	.resume		= acx_panel_resume,
 
 	.set_timings	= acx_panel_set_timings,
-	.get_timings	= acx_panel_get_timings,
 	.check_timings	= acx_panel_check_timings,
 
 	.get_recommended_bpp = acx_get_recommended_bpp,
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 519c47d..445ea2d 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -460,12 +460,6 @@ static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 	dpi_set_timings(dssdev, timings);
 }
 
-static void generic_dpi_panel_get_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
 static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
@@ -482,7 +476,6 @@ static struct omap_dss_driver dpi_driver = {
 	.resume		= generic_dpi_panel_resume,
 
 	.set_timings	= generic_dpi_panel_set_timings,
-	.get_timings	= generic_dpi_panel_get_timings,
 	.check_timings	= generic_dpi_panel_check_timings,
 
 	.driver         = {
diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 150e8ba..eba98a0 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -610,12 +610,6 @@ static int n8x0_panel_resume(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void n8x0_panel_get_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
 static void n8x0_panel_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres)
 {
@@ -678,8 +672,6 @@ static struct omap_dss_driver n8x0_panel_driver = {
 	.get_resolution	= n8x0_panel_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
-	.get_timings	= n8x0_panel_get_timings,
-
 	.driver         = {
 		.name   = "n8x0_panel",
 		.owner  = THIS_MODULE,
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 80c3f6a..174c004 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -583,12 +583,6 @@ static const struct backlight_ops taal_bl_ops = {
 	.update_status  = taal_bl_update_status,
 };
 
-static void taal_get_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
 static void taal_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres)
 {
@@ -1899,8 +1893,6 @@ static struct omap_dss_driver taal_driver = {
 	.run_test	= taal_run_test,
 	.memory_read	= taal_memory_read,
 
-	.get_timings	= taal_get_timings,
-
 	.driver         = {
 		.name   = "taal",
 		.owner  = THIS_MODULE,
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 86ec12e..767e132 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -434,6 +434,8 @@ int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
 	if (dssdriver->get_recommended_bpp == NULL)
 		dssdriver->get_recommended_bpp =
 			omapdss_default_get_recommended_bpp;
+	if (dssdriver->get_timings == NULL)
+		dssdriver->get_timings = omapdss_default_get_timings;
 
 	return driver_register(&dssdriver->driver);
 }
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index be331dc..0878e0a 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -318,6 +318,13 @@ int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_default_get_recommended_bpp);
 
+void omapdss_default_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+EXPORT_SYMBOL(omapdss_default_get_timings);
+
 /* Checks if replication logic should be used. Only use for active matrix,
  * when overlay is in RGB12U or RGB16 mode, and LCD interface is
  * 18bpp or 24bpp */
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7bb6219..dee2ec4 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -557,12 +557,6 @@ static int venc_panel_resume(struct omap_dss_device *dssdev)
 	return venc_panel_enable(dssdev);
 }
 
-static void venc_get_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
 static void venc_set_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
@@ -641,7 +635,6 @@ static struct omap_dss_driver venc_driver = {
 	.get_resolution	= omapdss_default_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
-	.get_timings	= venc_get_timings,
 	.set_timings	= venc_set_timings,
 	.check_timings	= venc_check_timings,
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 378c7ed..0a0c038 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -646,6 +646,8 @@ struct omap_overlay *omap_dss_get_overlay(int num);
 void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres);
 int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev);
+void omapdss_default_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 
 typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
-- 
1.7.0.4

