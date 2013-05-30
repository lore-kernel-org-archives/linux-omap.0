From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/32] OMAPDRM: fix overlay manager handling
Date: Thu, 30 May 2013 12:34:32 +0300
Message-ID: <1369906493-27538-12-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42769 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030327Ab3E3Jfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:35:36 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently omapdrm creates crtcs, which map directly to DSS overlay
managers, only on demand at init time. This would make it difficult to
manage connecting the display entities in the future, as the code cannot
just search for a suitable overlay manager.

We cannot fix this the sane way, which would be to create crtcs for each
overlay manager, because we need an overlay for each crtc. With limited
number of overlays, that's not possible.

So the solution for now is to detach the overlay manager from the crtc.
crtcs are still created on demand at init time, but all overlay managers
are always initialized by the omapdss.

This way we can create and connect whole display pipelines from the
overlay manager to the display, regardless of which crtcs omapdrm would
create.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 22 +++++++++++++++-------
 drivers/gpu/drm/omapdrm/omap_drv.c  |  2 ++
 drivers/gpu/drm/omapdrm/omap_drv.h  |  1 +
 drivers/video/omap2/dss/apply.c     |  3 ---
 drivers/video/omap2/dss/dispc.c     |  4 ++++
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 79b200a..02075bf 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -40,7 +40,7 @@ struct omap_crtc {
 	 * mgr->id.)  Eventually this will be replaced w/ something
 	 * more common-panel-framework-y
 	 */
-	struct omap_overlay_manager mgr;
+	struct omap_overlay_manager *mgr;
 
 	struct omap_video_timings timings;
 	bool enabled;
@@ -90,6 +90,9 @@ uint32_t pipe2vbl(struct drm_crtc *crtc)
  * job of sequencing the setup of the video pipe in the proper order
  */
 
+/* ovl-mgr-id -> crtc */
+static struct omap_crtc *omap_crtcs[8];
+
 /* we can probably ignore these until we support command-mode panels: */
 static void omap_crtc_start_update(struct omap_overlay_manager *mgr)
 {
@@ -107,7 +110,7 @@ static void omap_crtc_disable(struct omap_overlay_manager *mgr)
 static void omap_crtc_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings)
 {
-	struct omap_crtc *omap_crtc = container_of(mgr, struct omap_crtc, mgr);
+	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
 	DBG("%s", omap_crtc->name);
 	omap_crtc->timings = *timings;
 	omap_crtc->full_update = true;
@@ -116,7 +119,7 @@ static void omap_crtc_set_timings(struct omap_overlay_manager *mgr,
 static void omap_crtc_set_lcd_config(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config)
 {
-	struct omap_crtc *omap_crtc = container_of(mgr, struct omap_crtc, mgr);
+	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
 	DBG("%s", omap_crtc->name);
 	dispc_mgr_set_lcd_config(omap_crtc->channel, config);
 }
@@ -569,7 +572,7 @@ static void omap_crtc_pre_apply(struct omap_drm_apply *apply)
 	} else {
 		if (encoder) {
 			omap_encoder_set_enabled(encoder, false);
-			omap_encoder_update(encoder, &omap_crtc->mgr,
+			omap_encoder_update(encoder, omap_crtc->mgr,
 					&omap_crtc->timings);
 			omap_encoder_set_enabled(encoder, true);
 			omap_crtc->full_update = false;
@@ -595,6 +598,11 @@ static const char *channel_names[] = {
 		[OMAP_DSS_CHANNEL_LCD2] = "lcd2",
 };
 
+void omap_crtc_pre_init(void)
+{
+	dss_install_mgr_ops(&mgr_ops);
+}
+
 /* initialize crtc */
 struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct drm_plane *plane, enum omap_channel channel, int id)
@@ -635,9 +643,7 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_irq_register(dev, &omap_crtc->error_irq);
 
 	/* temporary: */
-	omap_crtc->mgr.id = channel;
-
-	dss_install_mgr_ops(&mgr_ops);
+	omap_crtc->mgr = omap_dss_get_overlay_manager(channel);
 
 	/* TODO: fix hard-coded setup.. add properties! */
 	info = &omap_crtc->info;
@@ -651,6 +657,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 
 	omap_plane_install_properties(omap_crtc->plane, &crtc->base);
 
+	omap_crtcs[channel] = omap_crtc;
+
 	return crtc;
 
 fail:
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 691e760..f8947f9 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -98,6 +98,8 @@ static int omap_modeset_init(struct drm_device *dev)
 	int num_crtcs;
 	int i, id = 0;
 
+	omap_crtc_pre_init();
+
 	drm_mode_config_init(dev);
 
 	omap_drm_irq_install(dev);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 215a20d..14f17da 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -157,6 +157,7 @@ const struct omap_video_timings *omap_crtc_timings(struct drm_crtc *crtc);
 enum omap_channel omap_crtc_channel(struct drm_crtc *crtc);
 int omap_crtc_apply(struct drm_crtc *crtc,
 		struct omap_drm_apply *apply);
+void omap_crtc_pre_init(void);
 struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct drm_plane *plane, enum omap_channel channel, int id);
 
diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 74d1d00..c844071 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1577,7 +1577,6 @@ int omapdss_compat_init(void)
 
 	apply_init_priv();
 
-	dss_init_overlay_managers();
 	dss_init_overlay_managers_sysfs(pdev);
 	dss_init_overlays(pdev);
 
@@ -1642,7 +1641,6 @@ err_disp_sysfs:
 
 err_mgr_ops:
 	dss_uninit_overlay_managers_sysfs(pdev);
-	dss_uninit_overlay_managers();
 	dss_uninit_overlays(pdev);
 
 	compat_refcnt--;
@@ -1671,7 +1669,6 @@ void omapdss_compat_uninit(void)
 	dss_uninstall_mgr_ops();
 
 	dss_uninit_overlay_managers_sysfs(pdev);
-	dss_uninit_overlay_managers();
 	dss_uninit_overlays(pdev);
 out:
 	mutex_unlock(&compat_init_lock);
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b33b016..83d7bb9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3710,6 +3710,8 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc_runtime_put();
 
+	dss_init_overlay_managers();
+
 	dss_debugfs_create_file("dispc", dispc_dump_regs);
 
 	return 0;
@@ -3723,6 +3725,8 @@ static int __exit omap_dispchw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
+	dss_uninit_overlay_managers();
+
 	return 0;
 }
 
-- 
1.8.1.2

