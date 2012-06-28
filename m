From: Archit Taneja <archit@ti.com>
Subject: [PATCH 12/12] OMAPDSS: OVERLAY: Clean up replication checking
Date: Thu, 28 Jun 2012 20:00:42 +0530
Message-ID: <1340893842-10626-14-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42380 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2F1OdA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:33:00 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Replication logic for an overlay depends on the color mode in which it is
configured and the video port width of the manager it is connected to.

video port width now held in dss_lcd_mgr_config in the manager's private
data in APPLY. Use this instead of referring to the omap_dss_device connected to
the manager.

Replication is enabled in the case of TV manager, the video_port_width is set to
a default value of 24 for TV manager.

Make the replication checking an overlay function since it's more of an overlay
characteristic than a display characteristic.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |    2 +-
 drivers/video/omap2/dss/display.c |   34 ----------------------------------
 drivers/video/omap2/dss/dss.h     |    4 ++--
 drivers/video/omap2/dss/overlay.c |   13 +++++++++++++
 4 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b9c6e75..89ee677 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -571,7 +571,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	mp = get_mgr_priv(ovl->manager);
 
-	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
+	replication = dss_ovl_use_replication(mp->lcd_config, oi->color_mode);
 
 	r = dispc_ovl_setup(ovl->id, oi, replication, &mp->timings);
 	if (r) {
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 1d8198e..9433b92 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -316,40 +316,6 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_default_get_timings);
 
-/* Checks if replication logic should be used. Only use for active matrix,
- * when overlay is in RGB12U or RGB16 mode, and LCD interface is
- * 18bpp or 24bpp */
-bool dss_use_replication(struct omap_dss_device *dssdev,
-		enum omap_color_mode mode)
-{
-	int bpp;
-
-	if (mode != OMAP_DSS_COLOR_RGB12U && mode != OMAP_DSS_COLOR_RGB16)
-		return false;
-
-	switch (dssdev->type) {
-	case OMAP_DISPLAY_TYPE_DPI:
-		bpp = dssdev->phy.dpi.data_lines;
-		break;
-	case OMAP_DISPLAY_TYPE_HDMI:
-	case OMAP_DISPLAY_TYPE_VENC:
-	case OMAP_DISPLAY_TYPE_SDI:
-		bpp = 24;
-		break;
-	case OMAP_DISPLAY_TYPE_DBI:
-		bpp = dssdev->ctrl.pixel_size;
-		break;
-	case OMAP_DISPLAY_TYPE_DSI:
-		bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
-		break;
-	default:
-		BUG();
-		return false;
-	}
-
-	return bpp > 16;
-}
-
 void dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index cb859e3..018b27c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -222,8 +222,6 @@ void dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
 void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
-bool dss_use_replication(struct omap_dss_device *dssdev,
-		enum omap_color_mode mode);
 
 /* manager */
 int dss_init_overlay_managers(struct platform_device *pdev);
@@ -255,6 +253,8 @@ int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info);
 int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
 		const struct omap_video_timings *mgr_timings);
+bool dss_ovl_use_replication(struct dss_lcd_mgr_config config,
+		enum omap_color_mode mode);
 
 /* DSS */
 int dss_init_platform_driver(void) __init;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index c492bb0..0a129dc 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -677,3 +677,16 @@ int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
 
 	return 0;
 }
+
+/*
+ * Checks if replication logic should be used. Only use when overlay is in
+ * RGB12U or RGB16 mode, and video port width interface is 18bpp or 24bpp
+ */
+bool dss_ovl_use_replication(struct dss_lcd_mgr_config config,
+		enum omap_color_mode mode)
+{
+	if (mode != OMAP_DSS_COLOR_RGB12U && mode != OMAP_DSS_COLOR_RGB16)
+		return false;
+
+	return config.video_port_width > 16;
+}
-- 
1.7.9.5

