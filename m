From: Archit Taneja <archit@ti.com>
Subject: [PATCH 07/12] OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface drivers
Date: Thu, 28 Jun 2012 20:00:37 +0530
Message-ID: <1340893842-10626-9-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab2F1Occ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:32 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Replace the DISPC fuctions used to configure LCD channel related manager
parameters with dss_mgr_set_lcd_config() in APPLY. This function ensures that
the DISPC registers are written at the right time by using the shadow register
programming model.

The LCD manager configurations is stored as a private data of manager in APPLY.
It is treated as an extra info as it's the panel drivers which trigger this
apply via interface drivers, and not a DSS2 user like omapfb or omapdrm.

Storing LCD manager related properties in APPLY also prevents the need to refer
to the panel connected to the manager for information. This helps in making the
DSS driver less dependent on panel.

A helper function is added to check whether the manager is LCD or TV. The direct
DISPC register writes are removed from the interface drivers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   65 +++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dpi.c   |   16 +---------
 drivers/video/omap2/dss/dsi.c   |   17 +---------
 drivers/video/omap2/dss/dss.h   |   10 ++++++
 drivers/video/omap2/dss/rfbi.c  |   13 +-------
 drivers/video/omap2/dss/sdi.c   |   15 +--------
 6 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 3ce7a3e..bb4ec63 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -104,6 +104,7 @@ struct mgr_priv_data {
 	bool shadow_extra_info_dirty;
 
 	struct omap_video_timings timings;
+	struct dss_lcd_mgr_config lcd_config;
 };
 
 static struct {
@@ -137,6 +138,7 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 void dss_apply_init(void)
 {
 	const int num_ovls = dss_feat_get_num_ovls();
+	struct mgr_priv_data *mp;
 	int i;
 
 	spin_lock_init(&data_lock);
@@ -168,6 +170,16 @@ void dss_apply_init(void)
 
 		op->user_info = op->info;
 	}
+
+	/*
+	 * Initialize some of the lcd_config fields for TV manager, this lets
+	 * us prevent checking if the manager is LCD or TV at some places
+	 */
+	mp = &dss_data.mgr_priv_data_array[OMAP_DSS_CHANNEL_DIGIT];
+
+	mp->lcd_config.video_port_width = 24;
+	mp->lcd_config.clock_info.lck_div = 1;
+	mp->lcd_config.clock_info.pck_div = 1;
 }
 
 static bool ovl_manual_update(struct omap_overlay *ovl)
@@ -633,6 +645,24 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
 
 	dispc_mgr_set_timings(mgr->id, &mp->timings);
 
+	/* lcd_config parameters */
+	if (dss_mgr_is_lcd(mgr->id)) {
+		dispc_mgr_set_io_pad_mode(mp->lcd_config.io_pad_mode);
+
+		dispc_mgr_enable_stallmode(mgr->id, mp->lcd_config.stallmode);
+		dispc_mgr_enable_fifohandcheck(mgr->id,
+			mp->lcd_config.fifohandcheck);
+
+		dispc_mgr_set_clock_div(mgr->id, &mp->lcd_config.clock_info);
+
+		dispc_mgr_set_tft_data_lines(mgr->id,
+			mp->lcd_config.video_port_width);
+
+		dispc_lcd_enable_signal_polarity(mp->lcd_config.lcden_sig_polarity);
+
+		dispc_mgr_set_lcd_type_tft(mgr->id);
+	}
+
 	mp->extra_info_dirty = false;
 	if (mp->updating)
 		mp->shadow_extra_info_dirty = true;
@@ -1292,6 +1322,41 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 	mutex_unlock(&apply_lock);
 }
 
+static void dss_apply_mgr_lcd_config(struct omap_overlay_manager *mgr,
+		struct dss_lcd_mgr_config config)
+{
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	mp->lcd_config = config;
+	mp->extra_info_dirty = true;
+}
+
+void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
+		struct dss_lcd_mgr_config config)
+{
+	unsigned long flags;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	mutex_lock(&apply_lock);
+
+	if (mp->enabled)
+		goto out;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	dss_apply_mgr_lcd_config(mgr, config);
+
+	dss_write_regs();
+	dss_set_go_bits();
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	wait_pending_extra_info_updates();
+
+out:
+	mutex_unlock(&apply_lock);
+}
+
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index a3a012b..c10c0f8 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -179,21 +179,7 @@ static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
 
 	dpi.mgr_config.lcden_sig_polarity = false;
 
-	dispc_mgr_set_io_pad_mode(dpi.mgr_config.io_pad_mode);
-	dispc_mgr_enable_stallmode(dssdev->manager->id,
-			dpi.mgr_config.stallmode);
-	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
-			dpi.mgr_config.fifohandcheck);
-
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			dpi.mgr_config.video_port_width);
-
-	dispc_mgr_set_clock_div(dssdev->manager->id,
-			&dpi.mgr_config.clock_info);
-
-	dispc_lcd_enable_signal_polarity(dpi.mgr_config.lcden_sig_polarity);
-
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	dss_mgr_set_lcd_config(dssdev->manager, dpi.mgr_config);
 }
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index df92e24..0ae85e2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4444,22 +4444,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
 	dsi->mgr_config.lcden_sig_polarity = 0;
 
-	dispc_mgr_set_io_pad_mode(dsi->mgr_config.io_pad_mode);
-
-	dispc_mgr_enable_stallmode(dssdev->manager->id,
-			dsi->mgr_config.stallmode);
-	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
-			dsi->mgr_config.fifohandcheck);
-
-	dispc_mgr_set_clock_div(dssdev->manager->id,
-			&dsi->mgr_config.clock_info);
-
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			dsi->mgr_config.video_port_width);
-
-	dispc_lcd_enable_signal_polarity(dsi->mgr_config.lcden_sig_polarity);
-
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	dss_mgr_set_lcd_config(dssdev->manager, dsi->mgr_config);
 
 	return 0;
 err1:
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6688eaf..b4c52ec 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -202,6 +202,8 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		struct omap_video_timings *timings);
+void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
+		struct dss_lcd_mgr_config config);
 const struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr);
 
 bool dss_ovl_is_enabled(struct omap_overlay *ovl);
@@ -235,6 +237,14 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *mgr_timings,
 		struct omap_overlay_info **overlay_infos);
 
+static inline bool dss_mgr_is_lcd(enum omap_channel id)
+{
+	if (id == OMAP_DSS_CHANNEL_LCD || id == OMAP_DSS_CHANNEL_LCD2)
+		return true;
+	else
+		return false;
+}
+
 /* overlay */
 void dss_init_overlays(struct platform_device *pdev);
 void dss_uninit_overlays(struct platform_device *pdev);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 847f694..0376056 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -872,18 +872,7 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	mgr_config.video_port_width = dssdev->ctrl.pixel_size;
 	mgr_config.lcden_sig_polarity = 0;
 
-	dispc_mgr_set_io_pad_mode(mgr_config.io_pad_mode);
-
-	dispc_mgr_enable_stallmode(dssdev->manager->id, mgr_config.stallmode);
-	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
-			mgr_config.fifohandcheck);
-
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			mgr_config.video_port_width);
-
-	dispc_lcd_enable_signal_polarity(mgr_config.lcden_sig_polarity);
-
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	dss_mgr_set_lcd_config(dssdev->manager, mgr_config);
 }
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index f6cd96c..b8dc13c 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -46,20 +46,7 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 	sdi.mgr_config.video_port_width = 24;
 	sdi.mgr_config.lcden_sig_polarity = 1;
 
-	dispc_mgr_set_io_pad_mode(sdi.mgr_config.io_pad_mode);
-	dispc_mgr_enable_stallmode(dssdev->manager->id,
-			sdi.mgr_config.stallmode);
-	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
-			sdi.mgr_config.fifohandcheck);
-
-	dispc_mgr_set_clock_div(dssdev->manager->id,
-			&sdi.mgr_config.clock_info);
-
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			sdi.mgr_config.video_port_width);
-	dispc_lcd_enable_signal_polarity(sdi.mgr_config.lcden_sig_polarity);
-
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	dss_mgr_set_lcd_config(dssdev->manager, sdi.mgr_config);
 }
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
-- 
1.7.9.5

