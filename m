From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/12] OMAPDSS: DPI: Configure dss_lcd_mgr_config struct with lcd manager parameters
Date: Thu, 28 Jun 2012 20:00:33 +0530
Message-ID: <1340893842-10626-5-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41713 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216Ab2F1OcQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:16 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a dss_lcd_mgr_config struct instance in DPI. Fill up all the parameters
of the struct with configurations held by the panel, and the configurations
required by DPI.

Use these to write to the DISPC registers. These direct register writes would be
later replaced by a function which applies the configuration using the shadow
register programming model.

The DISPC_DIVISORo registers were written in the functions dpi_set_dispc_clk()
and dpi_set_dsi_clk(), now they just fill up the dispc_clock_info parameter in
mgr_config. They are written later in dpi_config_lcd_manager.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index af01430..a3a012b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -38,6 +38,8 @@
 static struct {
 	struct regulator *vdds_dsi_reg;
 	struct platform_device *dsidev;
+
+	struct dss_lcd_mgr_config mgr_config;
 } dpi;
 
 static struct platform_device *dpi_get_dsidev(enum omap_dss_clk_source clk)
@@ -100,7 +102,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(clks->dispc.fclk_src);
 
-	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	dpi.mgr_config.clock_info = dispc_cinfo;
 
 	*fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
 	*lck_div = dispc_cinfo.lck_div;
@@ -125,7 +127,7 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	dpi.mgr_config.clock_info = dispc_cinfo;
 
 	*fck = dss_cinfo.fck;
 	*lck_div = dispc_cinfo.lck_div;
@@ -166,15 +168,32 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void dpi_basic_init(struct omap_dss_device *dssdev)
+static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
 {
-	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
-	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
+	dpi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	dpi.mgr_config.stallmode = false;
+	dpi.mgr_config.fifohandcheck = false;
+
+	dpi.mgr_config.video_port_width = dssdev->phy.dpi.data_lines;
+
+	dpi.mgr_config.lcden_sig_polarity = false;
+
+	dispc_mgr_set_io_pad_mode(dpi.mgr_config.io_pad_mode);
+	dispc_mgr_enable_stallmode(dssdev->manager->id,
+			dpi.mgr_config.stallmode);
+	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
+			dpi.mgr_config.fifohandcheck);
 
 	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			dssdev->phy.dpi.data_lines);
+			dpi.mgr_config.video_port_width);
+
+	dispc_mgr_set_clock_div(dssdev->manager->id,
+			&dpi.mgr_config.clock_info);
+
+	dispc_lcd_enable_signal_polarity(dpi.mgr_config.lcden_sig_polarity);
+
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
 }
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
@@ -213,8 +232,6 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	dpi_basic_init(dssdev);
-
 	if (dpi_use_dsi_pll(dssdev)) {
 		r = dsi_runtime_get(dpi.dsidev);
 		if (r)
@@ -229,6 +246,8 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_set_mode;
 
+	dpi_config_lcd_manager(dssdev);
+
 	mdelay(2);
 
 	r = dss_mgr_enable(dssdev->manager);
-- 
1.7.9.5

