From: Archit Taneja <archit@ti.com>
Subject: [PATCH 06/12] OMAPDSS: SDI: Configure dss_lcd_mgr_config struct with lcd manager parameters
Date: Thu, 28 Jun 2012 20:00:36 +0530
Message-ID: <1340893842-10626-8-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41724 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab2F1Oc2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:28 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a dss_lcd_mgr_config struct instance in SDI. Fill up all the parameters
of the struct with configurations held by the panel, and the configurations
required by SDI.

Use these to write to the DISPC registers. These direct register writes would be
later replaced by a function which applies the configuration using the shadow
register programming model.

Create function sdi_config_lcd_manager() which fills the mgr_config parameters
and writes to the DISPC registers

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/sdi.c |   42 +++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0b2659f..f6cd96c 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -32,18 +32,34 @@
 static struct {
 	bool update_enabled;
 	struct regulator *vdds_sdi_reg;
-} sdi;
 
-static void sdi_basic_init(struct omap_dss_device *dssdev)
+	struct dss_lcd_mgr_config mgr_config;
+} sdi;
 
+static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 {
-	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_BYPASS);
-	dispc_mgr_enable_stallmode(dssdev->manager->id, false);
+	sdi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+	sdi.mgr_config.stallmode = false;
+	sdi.mgr_config.fifohandcheck = false;
+
+	sdi.mgr_config.video_port_width = 24;
+	sdi.mgr_config.lcden_sig_polarity = 1;
+
+	dispc_mgr_set_io_pad_mode(sdi.mgr_config.io_pad_mode);
+	dispc_mgr_enable_stallmode(dssdev->manager->id,
+			sdi.mgr_config.stallmode);
+	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
+			sdi.mgr_config.fifohandcheck);
 
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id, 24);
-	dispc_lcd_enable_signal_polarity(1);
+	dispc_mgr_set_clock_div(dssdev->manager->id,
+			&sdi.mgr_config.clock_info);
+
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
+			sdi.mgr_config.video_port_width);
+	dispc_lcd_enable_signal_polarity(sdi.mgr_config.lcden_sig_polarity);
+
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
 }
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
@@ -51,8 +67,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	struct omap_video_timings *t = &dssdev->panel.timings;
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
-	u16 lck_div, pck_div;
-	unsigned long fck;
 	unsigned long pck;
 	int r;
 
@@ -75,8 +89,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	sdi_basic_init(dssdev);
-
 	/* 15.5.9.1.2 */
 	dssdev->panel.timings.pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 	dssdev->panel.timings.hsync_vsync_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
@@ -85,11 +97,9 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_calc_clock_div;
 
-	fck = dss_cinfo.fck;
-	lck_div = dispc_cinfo.lck_div;
-	pck_div = dispc_cinfo.pck_div;
+	sdi.mgr_config.clock_info = dispc_cinfo;
 
-	pck = fck / lck_div / pck_div / 1000;
+	pck = dss_cinfo.fck / dispc_cinfo.lck_div / dispc_cinfo.pck_div / 1000;
 
 	if (pck != t->pixel_clock) {
 		DSSWARN("Could not find exact pixel clock. Requested %d kHz, "
@@ -106,7 +116,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_set_dss_clock_div;
 
-	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	sdi_config_lcd_manager(dssdev);
 
 	dss_sdi_init(dssdev->phy.sdi.datapairs);
 	r = dss_sdi_enable();
-- 
1.7.9.5

