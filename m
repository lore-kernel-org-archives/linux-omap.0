From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/12] OMAPDSS: hide dss_select_dispc_clk_source()
Date: Tue, 30 Oct 2012 18:10:06 +0200
Message-ID: <1351613409-21186-10-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933955Ab2J3QKf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:35 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss.c currently exposes functions to configure the dispc source clock
and lcd source clock. There are configured separately from the output
drivers.

However, there is no safe way for the output drivers to handle dispc
clock, as it's shared between the outputs. Thus, if, say, the DSI driver
sets up DSI PLL and configures both the dispc and lcd clock sources to
that DSI PLL, the resulting dispc clock could be too low for, say, HDMI.

Thus the output drivers should really only be concerned about the lcd
clock, which is what the output drivers actually use. There's lot to do
to clean up the dss clock handling, but this patch takes one step
forward and removes the use of dss_select_dispc_clk_source() from the
output drivers.

After this patch, the output drivers only configure the lcd source
clock. On omap4+ the dispc src clock is never changed from the default
PRCM source. On omap3, where the dispc and lcd clocks are actually the
same, setting the lcd clock source sets the dispc clock source.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    6 ++++--
 drivers/video/omap2/dss/dsi.c  |    3 ---
 drivers/video/omap2/dss/dss.c  |    6 ++++--
 drivers/video/omap2/dss/dss.h  |    1 -
 drivers/video/omap2/dss/hdmi.c |    8 --------
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 56748cf..9df62cf 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -77,6 +77,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
+	struct omap_overlay_manager *mgr = dssdev->output->manager;
 	struct dsi_clock_info dsi_cinfo;
 	struct dispc_clock_info dispc_cinfo;
 	int r;
@@ -90,7 +91,8 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
+	dss_select_lcd_clk_source(mgr->id,
+			dssdev->clocks.dispc.channel.lcd_clk_src);
 
 	dpi.mgr_config.clock_info = dispc_cinfo;
 
@@ -272,7 +274,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	dss_mgr_disable(mgr);
 
 	if (dpi_use_dsi_pll(dssdev)) {
-		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
+		dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 		dsi_pll_uninit(dpi.dsidev, true);
 		dsi_runtime_put(dpi.dsidev);
 	}
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 26d1a78..70bd7a5 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4720,7 +4720,6 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err1;
 
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 	dss_select_dsi_clk_source(dsi->module_id, dssdev->clocks.dsi.dsi_fclk_src);
 	dss_select_lcd_clk_source(mgr->id,
 			dssdev->clocks.dispc.channel.lcd_clk_src);
@@ -4755,7 +4754,6 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 err3:
 	dsi_cio_uninit(dsidev);
 err2:
-	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
 	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 
@@ -4782,7 +4780,6 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dsi_vc_enable(dsidev, 2, 0);
 	dsi_vc_enable(dsidev, 3, 0);
 
-	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
 	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dsidev);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 034cc1a..086ed56 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -304,7 +304,7 @@ static void dss_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
+static void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 {
 	struct platform_device *dsidev;
 	int b;
@@ -375,8 +375,10 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 	struct platform_device *dsidev;
 	int b, ix, pos;
 
-	if (!dss_has_feature(FEAT_LCD_CLK_SRC))
+	if (!dss_has_feature(FEAT_LCD_CLK_SRC)) {
+		dss_select_dispc_clk_source(clk_src);
 		return;
+	}
 
 	switch (clk_src) {
 	case OMAP_DSS_CLK_SRC_FCK:
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ae4e618..e8435ea 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -284,7 +284,6 @@ void dss_sdi_init(int datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
 
-void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src);
 void dss_select_dsi_clk_source(int dsi_module,
 		enum omap_dss_clk_source clk_src);
 void dss_select_lcd_clk_source(enum omap_channel channel,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index adcc906..dc6d72c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -552,14 +552,6 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
 
-	/* Select the dispc clock source as PRCM clock, to ensure that it is not
-	 * DSI PLL source as the clock selected by DSI PLL might not be
-	 * sufficient for the resolution selected / that can be changed
-	 * dynamically by user. This can be moved to single location , say
-	 * Boardfile.
-	 */
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
-
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
 
-- 
1.7.10.4

