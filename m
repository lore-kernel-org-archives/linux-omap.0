From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: DSI: Improve dsi_mux_pads parameters
Date: Mon, 22 Aug 2011 11:26:38 +0300
Message-ID: <1314001599-17951-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:60768 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755042Ab1HVI1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:27:04 -0400
In-Reply-To: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dsi_mux_pads() needs to know about the DSI HW module and the DSI lanes
used. Split the function into two, enable and disable, which take
necessary arguments, and add empty implementations for both.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   14 +++++++++++++
 drivers/video/omap2/dss/dsi.c |   42 ++++++++++++++++++++++++++++++----------
 include/video/omapdss.h       |    3 +-
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 0339605..74f0aff 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -75,6 +75,15 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
+static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
+{
+	return 0;
+}
+
+static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
+{
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -97,6 +106,11 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
 	}
 
+	if (board_data->dsi_enable_pads == NULL)
+		board_data->dsi_enable_pads = omap_dsi_enable_pads;
+	if (board_data->dsi_disable_pads == NULL)
+		board_data->dsi_disable_pads = omap_dsi_disable_pads;
+
 	pdata.board_data = board_data;
 	pdata.board_data->get_context_loss_count =
 		omap_pm_get_dev_context_loss_count;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 713e1d9..ae6bf1d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -274,7 +274,8 @@ struct dsi_data {
 	struct clk *dss_clk;
 	struct clk *sys_clk;
 
-	void (*dsi_mux_pads)(bool enable);
+	int (*enable_pads)(int dsi_id, unsigned lane_mask);
+	void (*disable_pads)(int dsi_id, unsigned lane_mask);
 
 	struct dsi_clock_info current_cinfo;
 
@@ -2355,6 +2356,24 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+static unsigned dsi_get_lane_mask(struct omap_dss_device *dssdev)
+{
+	unsigned lanes = 0;
+
+	if (dssdev->phy.dsi.clk_lane != 0)
+		lanes |= 1 << (dssdev->phy.dsi.clk_lane - 1);
+	if (dssdev->phy.dsi.data1_lane != 0)
+		lanes |= 1 << (dssdev->phy.dsi.data1_lane - 1);
+	if (dssdev->phy.dsi.data2_lane != 0)
+		lanes |= 1 << (dssdev->phy.dsi.data2_lane - 1);
+	if (dssdev->phy.dsi.data3_lane != 0)
+		lanes |= 1 << (dssdev->phy.dsi.data3_lane - 1);
+	if (dssdev->phy.dsi.data4_lane != 0)
+		lanes |= 1 << (dssdev->phy.dsi.data4_lane - 1);
+
+	return lanes;
+}
+
 static int dsi_cio_init(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -2365,8 +2384,9 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	DSSDBGF();
 
-	if (dsi->dsi_mux_pads)
-		dsi->dsi_mux_pads(true);
+	r = dsi->enable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	if (r)
+		return r;
 
 	dsi_enable_scp_clk(dsidev);
 
@@ -2462,19 +2482,18 @@ err_cio_pwr:
 		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
 	dsi_disable_scp_clk(dsidev);
-	if (dsi->dsi_mux_pads)
-		dsi->dsi_mux_pads(false);
+	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
 	return r;
 }
 
-static void dsi_cio_uninit(struct platform_device *dsidev)
+static void dsi_cio_uninit(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
-	if (dsi->dsi_mux_pads)
-		dsi->dsi_mux_pads(false);
+	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
 }
 
 static void dsi_config_tx_fifo(struct platform_device *dsidev,
@@ -4161,7 +4180,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 
 	return 0;
 err3:
-	dsi_cio_uninit(dsidev);
+	dsi_cio_uninit(dssdev);
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
@@ -4190,7 +4209,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
-	dsi_cio_uninit(dsidev);
+	dsi_cio_uninit(dssdev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
 
@@ -4481,7 +4500,8 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
 	dss_plat_data = dsidev->dev.platform_data;
 	board_info = dss_plat_data->board_data;
-	dsi->dsi_mux_pads = board_info->dsi_mux_pads;
+	dsi->enable_pads = board_info->dsi_enable_pads;
+	dsi->disable_pads = board_info->dsi_disable_pads;
 
 	spin_lock_init(&dsi->irq_lock);
 	spin_lock_init(&dsi->errors_lock);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 105b05d..9301805 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -242,7 +242,8 @@ struct omap_dss_board_info {
 	int num_devices;
 	struct omap_dss_device **devices;
 	struct omap_dss_device *default_device;
-	void (*dsi_mux_pads)(bool enable);
+	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
+	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
 };
 
 /* Init with the board info */
-- 
1.7.4.1

