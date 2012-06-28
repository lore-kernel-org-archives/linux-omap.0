From: Archit Taneja <archit@ti.com>
Subject: [PATCH 05/12] OMAPDSS: DSI: Configure dss_lcd_mgr_config struct with lcd manager parameters
Date: Thu, 28 Jun 2012 20:00:35 +0530
Message-ID: <1340893842-10626-7-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36402 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab2F1OcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:32:23 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a dss_lcd_mgr_config struct instance in DSI. Fill up all the parameters
of the struct with configurations held by the panel, and the configurations
required by DSI.

Use these to write to the DISPC registers. These direct register writes would be
later replaced by a function which applies the configuration using the shadow
register programming model.

The function dsi_configure_dispc_clocks() is now called in
dsi_display_init_dispc(), this lets all the lcd manager related configurations
happen in the same place. The DISPC_DIVISORo register was written in
dsi_configure_dispc_clock(), now it just fills up the dispc_clock_info parameter
in mgr_config. The clock_info is written later in dsi_display_init_dispc().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  117 ++++++++++++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 94ff3aa..df92e24 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -331,6 +331,8 @@ struct dsi_data {
 	unsigned num_lanes_used;
 
 	unsigned scp_clk_refcount;
+
+	struct dss_lcd_mgr_config mgr_config;
 };
 
 struct dsi_packet_sent_handler_data {
@@ -4339,14 +4341,42 @@ EXPORT_SYMBOL(omap_dsi_update);
 
 /* Display funcs */
 
-static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
+static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev,
+		const struct omapdss_lcd_clock_config *lcd_clks)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dispc_clock_info dispc_cinfo;
 	int r;
+	unsigned long long fck;
+
+	fck = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+
+	dispc_cinfo.lck_div = lcd_clks->lck_div;
+	dispc_cinfo.pck_div = lcd_clks->pck_div;
+
+	r = dispc_calc_clock_rates(fck, &dispc_cinfo);
+	if (r) {
+		DSSERR("Failed to calc dispc clocks\n");
+		return r;
+	}
+
+	dsi->mgr_config.clock_info = dispc_cinfo;
+
+	return 0;
+}
+
+static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_video_timings timings;
+	const struct omapdss_clock_config *clks;
+	int r, lcd_id;
+	u32 irq;
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
 		u16 dw, dh;
-		u32 irq;
 
 		dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
@@ -4366,16 +4396,16 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			(void *) dssdev, irq);
 		if (r) {
 			DSSERR("can't get FRAMEDONE irq\n");
-			return r;
+			goto err;
 		}
 
-		dispc_mgr_enable_stallmode(dssdev->manager->id, true);
-		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
+		dsi->mgr_config.stallmode = true;
+		dsi->mgr_config.fifohandcheck = true;
 	} else {
 		timings = dssdev->panel.timings;
 
-		dispc_mgr_enable_stallmode(dssdev->manager->id, false);
-		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 0);
+		dsi->mgr_config.stallmode = false;
+		dsi->mgr_config.fifohandcheck = false;
 	}
 
 	/*
@@ -4391,12 +4421,53 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 
 	dss_mgr_set_timings(dssdev->manager, &timings);
 
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	clks = dss_get_platform_clock_config();
+
+	switch (dssdev->manager->id) {
+	case OMAP_DSS_CHANNEL_LCD:
+		lcd_id = 0;
+		break;
+	case OMAP_DSS_CHANNEL_LCD2:
+		lcd_id = 1;
+		break;
+	default:
+		r = -EINVAL;
+		goto err1;
+	}
+
+	r = dsi_configure_dispc_clocks(dssdev, &clks->lcd[lcd_id]);
+	if (r)
+		goto err1;
+
+	dsi->mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
+	dsi->mgr_config.video_port_width =
+			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+	dsi->mgr_config.lcden_sig_polarity = 0;
+
+	dispc_mgr_set_io_pad_mode(dsi->mgr_config.io_pad_mode);
+
+	dispc_mgr_enable_stallmode(dssdev->manager->id,
+			dsi->mgr_config.stallmode);
+	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
+			dsi->mgr_config.fifohandcheck);
+
+	dispc_mgr_set_clock_div(dssdev->manager->id,
+			&dsi->mgr_config.clock_info);
 
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt));
+			dsi->mgr_config.video_port_width);
+
+	dispc_lcd_enable_signal_polarity(dsi->mgr_config.lcden_sig_polarity);
+
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
 
 	return 0;
+err1:
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE)
+		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
+			(void *) dssdev, irq);
+err:
+	return r;
 }
 
 static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
@@ -4437,30 +4508,6 @@ static int dsi_configure_dsi_clocks(struct platform_device *dsidev,
 	return 0;
 }
 
-static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev,
-		const struct omapdss_lcd_clock_config *lcd_clks)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dispc_clock_info dispc_cinfo;
-	int r;
-	unsigned long long fck;
-
-	fck = dsi_get_pll_hsdiv_dispc_rate(dsidev);
-
-	dispc_cinfo.lck_div = lcd_clks->lck_div;
-	dispc_cinfo.pck_div = lcd_clks->pck_div;
-
-	r = dispc_calc_clock_rates(fck, &dispc_cinfo);
-	if (r) {
-		DSSERR("Failed to calc dispc clocks\n");
-		return r;
-	}
-
-	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
-
-	return 0;
-}
-
 static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -4499,10 +4546,6 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 
 	DSSDBG("PLL OK\n");
 
-	r = dsi_configure_dispc_clocks(dssdev, &clks->lcd[lcd_id]);
-	if (r)
-		goto err2;
-
 	r = dsi_cio_init(dssdev);
 	if (r)
 		goto err2;
-- 
1.7.9.5

