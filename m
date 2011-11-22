From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/65] OMAPDSS: hide manager's enable/disable()
Date: Tue, 22 Nov 2011 11:21:20 +0200
Message-ID: <1321953724-6350-22-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57560 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757583Ab1KVJXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:22 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_overlay_manager struct contains enable() and disable() functions.
However, these are only meant to be used from inside omapdss, and thus
it's bad to expose the functions.

This patch adds dss_mgr_enable() and dss_mgr_disable() functions to
apply.c, which handle enabling and disabling the output.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   12 +++++++++++-
 drivers/video/omap2/dss/dpi.c     |    4 ++--
 drivers/video/omap2/dss/dsi.c     |    4 ++--
 drivers/video/omap2/dss/dss.h     |    2 ++
 drivers/video/omap2/dss/hdmi.c    |    6 +++---
 drivers/video/omap2/dss/manager.c |   15 ---------------
 drivers/video/omap2/dss/sdi.c     |    4 ++--
 drivers/video/omap2/dss/venc.c    |    4 ++--
 include/video/omapdss.h           |    3 ---
 9 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 32dc6e6..ebc0ae1 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -424,7 +424,7 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 		mc->shadow_dirty = false;
 	}
 
-	mgr->enable(mgr);
+	dispc_mgr_enable(mgr->id, true);
 }
 
 static void dss_apply_irq_handler(void *data, u32 mask)
@@ -654,3 +654,13 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	return r;
 }
 
+void dss_mgr_enable(struct omap_overlay_manager *mgr)
+{
+	dispc_mgr_enable(mgr->id, true);
+}
+
+void dss_mgr_disable(struct omap_overlay_manager *mgr)
+{
+	dispc_mgr_enable(mgr->id, false);
+}
+
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 976ac23..79c4df3 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -223,7 +223,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 	mdelay(2);
 
-	dssdev->manager->enable(dssdev->manager);
+	dss_mgr_enable(dssdev->manager);
 
 	return 0;
 
@@ -249,7 +249,7 @@ EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
-	dssdev->manager->disable(dssdev->manager);
+	dss_mgr_disable(dssdev->manager);
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e5a2dcc..08d3de90 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3976,7 +3976,7 @@ int dsi_video_mode_enable(struct omap_dss_device *dssdev, int channel)
 	dsi_vc_enable(dsidev, channel, true);
 	dsi_if_enable(dsidev, true);
 
-	dssdev->manager->enable(dssdev->manager);
+	dss_mgr_enable(dssdev->manager);
 
 	return 0;
 }
@@ -3995,7 +3995,7 @@ void dsi_video_mode_disable(struct omap_dss_device *dssdev, int channel)
 	dsi_vc_enable(dsidev, channel, true);
 	dsi_if_enable(dsidev, true);
 
-	dssdev->manager->disable(dssdev->manager);
+	dss_mgr_disable(dssdev->manager);
 }
 EXPORT_SYMBOL(dsi_video_mode_disable);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6fbbee4..66fed79 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -169,6 +169,8 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr);
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
 void dss_start_update(struct omap_overlay_manager *mgr);
 int omap_dss_mgr_apply(struct omap_overlay_manager *mgr);
+void dss_mgr_enable(struct omap_overlay_manager *mgr);
+void dss_mgr_disable(struct omap_overlay_manager *mgr);
 
 /* display */
 int dss_suspend_all_devices(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c56378c..e245a2b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -333,7 +333,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
+	dss_mgr_disable(dssdev->manager);
 
 	p = &dssdev->panel.timings;
 
@@ -387,7 +387,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
 
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
+	dss_mgr_enable(dssdev->manager);
 
 	return 0;
 err:
@@ -397,7 +397,7 @@ err:
 
 static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
+	dss_mgr_disable(dssdev->manager);
 
 	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 0);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index f9e691b..780a307 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -585,18 +585,6 @@ static void omap_dss_mgr_get_info(struct omap_overlay_manager *mgr,
 	*info = mgr->info;
 }
 
-static int dss_mgr_enable(struct omap_overlay_manager *mgr)
-{
-	dispc_mgr_enable(mgr->id, 1);
-	return 0;
-}
-
-static int dss_mgr_disable(struct omap_overlay_manager *mgr)
-{
-	dispc_mgr_enable(mgr->id, 0);
-	return 0;
-}
-
 static void omap_dss_add_overlay_manager(struct omap_overlay_manager *manager)
 {
 	++num_managers;
@@ -640,9 +628,6 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->wait_for_go = &dss_mgr_wait_for_go;
 		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
 
-		mgr->enable = &dss_mgr_enable;
-		mgr->disable = &dss_mgr_disable;
-
 		mgr->caps = 0;
 		mgr->supported_displays =
 			dss_feat_get_supported_displays(mgr->id);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 40305ad..02da8be 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -123,7 +123,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err_sdi_enable;
 	mdelay(2);
 
-	dssdev->manager->enable(dssdev->manager);
+	dss_mgr_enable(dssdev->manager);
 
 	return 0;
 
@@ -145,7 +145,7 @@ EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	dssdev->manager->disable(dssdev->manager);
+	dss_mgr_disable(dssdev->manager);
 
 	dss_sdi_disable();
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7533458..101fcd7 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -447,7 +447,7 @@ static void venc_power_on(struct omap_dss_device *dssdev)
 	if (dssdev->platform_enable)
 		dssdev->platform_enable(dssdev);
 
-	dssdev->manager->enable(dssdev->manager);
+	dss_mgr_enable(dssdev->manager);
 }
 
 static void venc_power_off(struct omap_dss_device *dssdev)
@@ -455,7 +455,7 @@ static void venc_power_off(struct omap_dss_device *dssdev)
 	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
 	dss_set_dac_pwrdn_bgz(0);
 
-	dssdev->manager->disable(dssdev->manager);
+	dss_mgr_disable(dssdev->manager);
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 60bf426..04741cd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -448,9 +448,6 @@ struct omap_overlay_manager {
 	int (*apply)(struct omap_overlay_manager *mgr);
 	int (*wait_for_go)(struct omap_overlay_manager *mgr);
 	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
-
-	int (*enable)(struct omap_overlay_manager *mgr);
-	int (*disable)(struct omap_overlay_manager *mgr);
 };
 
 struct omap_dss_device {
-- 
1.7.4.1

