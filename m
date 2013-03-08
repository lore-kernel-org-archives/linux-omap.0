From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/14] OMAPDSS: DSI: simplify dsi configuration
Date: Fri, 8 Mar 2013 13:52:38 +0200
Message-ID: <1362743569-10289-4-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57912 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933764Ab3CHLxR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:17 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We have a bunch of dsi functions that are used to do the basic
configuration for DSI. To simplify things, and to make sure we have all
the necessary information, create a single dsi config function, which
does the basic configuration.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   16 ++++---
 drivers/video/omap2/dss/dsi.c             |   74 ++++-------------------------
 include/video/omapdss.h                   |   23 ++++-----
 3 files changed, 31 insertions(+), 82 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index bc4c95e..eb86cba 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -919,6 +919,13 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	u8 id1, id2, id3;
 	int r;
+	struct omap_dss_dsi_config dsi_config = {
+		.mode = OMAP_DSS_DSI_CMD_MODE,
+		.pixel_format = OMAP_DSS_DSI_FMT_RGB888,
+		.timings = &dssdev->panel.timings,
+		.hs_clk = 216000000,
+		.lp_clk = 10000000,
+	};
 
 	r = omapdss_dsi_configure_pins(dssdev, &td->pin_config);
 	if (r) {
@@ -926,14 +933,9 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 	};
 
-	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
-		dssdev->panel.timings.y_res);
-	omapdss_dsi_set_pixel_format(dssdev, OMAP_DSS_DSI_FMT_RGB888);
-	omapdss_dsi_set_operation_mode(dssdev, OMAP_DSS_DSI_CMD_MODE);
-
-	r = omapdss_dsi_set_clocks(dssdev, 216000000, 10000000);
+	r = omapdss_dsi_set_config(dssdev, &dsi_config);
 	if (r) {
-		dev_err(&dssdev->dev, "failed to set HS and LP clocks\n");
+		dev_err(&dssdev->dev, "failed to configure DSI\n");
 		goto err0;
 	}
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5f5b475..901b721 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4278,7 +4278,7 @@ int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_configure_pins);
 
-int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
+static int dsi_set_clocks(struct omap_dss_device *dssdev,
 		unsigned long ddr_clk, unsigned long lp_clk)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -4293,8 +4293,6 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
 
 	DSSDBG("Setting DSI clocks: ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
 
-	mutex_lock(&dsi->lock);
-
 	/* Calculate PLL output clock */
 	r = dsi_pll_calc_ddrfreq(dsidev, ddr_clk * 4, &cinfo);
 	if (r)
@@ -4336,13 +4334,10 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
 		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
 		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI;
 
-	mutex_unlock(&dsi->lock);
 	return 0;
 err:
-	mutex_unlock(&dsi->lock);
 	return r;
 }
-EXPORT_SYMBOL(omapdss_dsi_set_clocks);
 
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
@@ -4884,75 +4879,26 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
-void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
+int omapdss_dsi_set_config(struct omap_dss_device *dssdev,
+		const struct omap_dss_dsi_config *config)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
 
-	dsi->timings = *timings;
-
-	mutex_unlock(&dsi->lock);
-}
-EXPORT_SYMBOL(omapdss_dsi_set_timings);
-
-void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	mutex_lock(&dsi->lock);
+	dsi->timings = *config->timings;
+	dsi->vm_timings = *config->vm_timings;
+	dsi->pix_fmt = config->pixel_format;
+	dsi->mode = config->mode;
 
-	dsi->timings.x_res = w;
-	dsi->timings.y_res = h;
+	dsi_set_clocks(dssdev, config->hs_clk, config->lp_clk);
 
 	mutex_unlock(&dsi->lock);
-}
-EXPORT_SYMBOL(omapdss_dsi_set_size);
 
-void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
-		enum omap_dss_dsi_pixel_format fmt)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	mutex_lock(&dsi->lock);
-
-	dsi->pix_fmt = fmt;
-
-	mutex_unlock(&dsi->lock);
-}
-EXPORT_SYMBOL(omapdss_dsi_set_pixel_format);
-
-void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_dsi_mode mode)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	mutex_lock(&dsi->lock);
-
-	dsi->mode = mode;
-
-	mutex_unlock(&dsi->lock);
-}
-EXPORT_SYMBOL(omapdss_dsi_set_operation_mode);
-
-void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
-		struct omap_dss_dsi_videomode_timings *timings)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	mutex_lock(&dsi->lock);
-
-	dsi->vm_timings = *timings;
-
-	mutex_unlock(&dsi->lock);
+	return 0;
 }
-EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
+EXPORT_SYMBOL(omapdss_dsi_set_config);
 
 /*
  * Return a hardcoded channel for the DSI output. This should work for
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9057e21..4a52197 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -282,6 +282,16 @@ struct omap_dss_dsi_videomode_timings {
 	int window_sync;
 };
 
+struct omap_dss_dsi_config {
+	enum omap_dss_dsi_mode mode;
+	enum omap_dss_dsi_pixel_format pixel_format;
+	const struct omap_video_timings *timings;
+	const struct omap_dss_dsi_videomode_timings *vm_timings;
+
+	unsigned long hs_clk;
+	unsigned long lp_clk;
+};
+
 void dsi_bus_lock(struct omap_dss_device *dssdev);
 void dsi_bus_unlock(struct omap_dss_device *dssdev);
 int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
@@ -805,15 +815,8 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable);
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
-void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings);
-void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h);
-void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
-		enum omap_dss_dsi_pixel_format fmt);
-void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_dsi_mode mode);
-void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
-		struct omap_dss_dsi_videomode_timings *timings);
+int omapdss_dsi_set_config(struct omap_dss_device *dssdev,
+		const struct omap_dss_dsi_config *config);
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
@@ -822,8 +825,6 @@ int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id);
 void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
 int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 		const struct omap_dsi_pin_config *pin_cfg);
-int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
-		unsigned long ddr_clk, unsigned long lp_clk);
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
-- 
1.7.10.4

