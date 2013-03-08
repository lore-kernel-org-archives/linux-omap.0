From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/20] OMAPDSS: DPI: remove omap_dss_device uses
Date: Fri, 8 Mar 2013 13:51:38 +0200
Message-ID: <1362743515-10152-4-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56449 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3CHLwL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:11 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The role of struct omap_dss_device will change in the future. The exact
details of that are still a bit unclear. However, the less uses of
omap_dss_device we have, the easier the change is in the future.

This patch removes uses of omap_dss_device from dpi.c, where it can be
done neatly, by, for example, passing some lower level parameter in
function parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 4af136a..cb6b280 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -91,11 +91,10 @@ static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
 	}
 }
 
-static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
+static int dpi_set_dsi_clk(enum omap_channel channel,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
 	struct dsi_clock_info dsi_cinfo;
 	struct dispc_clock_info dispc_cinfo;
 	int r;
@@ -109,8 +108,8 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dss_select_lcd_clk_source(mgr->id,
-			dpi_get_alt_clk_src(mgr->id));
+	dss_select_lcd_clk_source(channel,
+			dpi_get_alt_clk_src(channel));
 
 	dpi.mgr_config.clock_info = dispc_cinfo;
 
@@ -121,9 +120,8 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
-		unsigned long pck_req, unsigned long *fck, int *lck_div,
-		int *pck_div)
+static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
+		int *lck_div, int *pck_div)
 {
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
@@ -146,20 +144,19 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_mode(struct omap_dss_device *dssdev)
+static int dpi_set_mode(struct omap_overlay_manager *mgr)
 {
 	struct omap_video_timings *t = &dpi.timings;
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
 	int lck_div = 0, pck_div = 0;
 	unsigned long fck = 0;
 	unsigned long pck;
 	int r = 0;
 
 	if (dpi.dsidev)
-		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
+		r = dpi_set_dsi_clk(mgr->id, t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	else
-		r = dpi_set_dispc_clk(dssdev, t->pixel_clock * 1000, &fck,
+		r = dpi_set_dispc_clk(t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	if (r)
 		return r;
@@ -179,10 +176,8 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
+static void dpi_config_lcd_manager(struct omap_overlay_manager *mgr)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
-
 	dpi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
 	dpi.mgr_config.stallmode = false;
@@ -197,7 +192,7 @@ static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &dpi.output;
 	int r;
 
 	mutex_lock(&dpi.lock);
@@ -230,7 +225,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	r = dss_dpi_select_source(dssdev->channel);
+	r = dss_dpi_select_source(out->manager->id);
 	if (r)
 		goto err_src_sel;
 
@@ -244,11 +239,11 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 			goto err_dsi_pll_init;
 	}
 
-	r = dpi_set_mode(dssdev);
+	r = dpi_set_mode(out->manager);
 	if (r)
 		goto err_set_mode;
 
-	dpi_config_lcd_manager(dssdev);
+	dpi_config_lcd_manager(out->manager);
 
 	mdelay(2);
 
@@ -285,7 +280,7 @@ EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dpi.output.manager;
 
 	mutex_lock(&dpi.lock);
 
@@ -325,7 +320,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
 	int r;
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = dpi.output.manager;
 	int lck_div, pck_div;
 	unsigned long fck;
 	unsigned long pck;
-- 
1.7.10.4

