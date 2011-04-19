From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/19] OMAP: DSS2: DSI: Add DSI pad muxing support
Date: Tue, 19 Apr 2011 12:22:15 +0300
Message-ID: <1303204942-25450-13-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49313 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753237Ab1DSJXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:00 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dsi_mux_pads function pointer to omap_dss_board_info, and use the
function pointer in DSI code to configure the DSI pads either to normal
DSI operation, or to pull down when in ULPS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    1 +
 drivers/video/omap2/dss/dsi.c             |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index a65479c..bd0f08e 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -235,6 +235,7 @@ struct omap_dss_board_info {
 	int num_devices;
 	struct omap_dss_device **devices;
 	struct omap_dss_device *default_device;
+	void (*dsi_mux_pads)(bool enable);
 };
 
 #if defined(CONFIG_OMAP2_DSS_MODULE) || defined(CONFIG_OMAP2_DSS)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d15014e..f1e14ca 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -244,6 +244,8 @@ static struct
 	void __iomem	*base;
 	int irq;
 
+	void (*dsi_mux_pads)(bool enable);
+
 	struct dsi_clock_info current_cinfo;
 
 	bool vdds_dsi_enabled;
@@ -2035,6 +2037,9 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	DSSDBGF();
 
+	if (dsi.dsi_mux_pads)
+		dsi.dsi_mux_pads(true);
+
 	dsi_enable_scp_clk();
 
 	/* A dummy read using the SCP interface to any DSIPHY register is
@@ -2122,6 +2127,8 @@ err_cio_pwr:
 		dsi_cio_disable_lane_override();
 err_scp_clk_dom:
 	dsi_disable_scp_clk();
+	if (dsi.dsi_mux_pads)
+		dsi.dsi_mux_pads(false);
 	return r;
 }
 
@@ -2129,6 +2136,8 @@ static void dsi_cio_uninit(void)
 {
 	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk();
+	if (dsi.dsi_mux_pads)
+		dsi.dsi_mux_pads(false);
 }
 
 static int _dsi_wait_reset(void)
@@ -3993,10 +4002,16 @@ static void dsi_calc_clock_param_ranges(void)
 
 static int dsi_init(struct platform_device *pdev)
 {
+	struct omap_display_platform_data *dss_plat_data;
+	struct omap_dss_board_info *board_info;
 	u32 rev;
 	int r, i;
 	struct resource *dsi_mem;
 
+	dss_plat_data = pdev->dev.platform_data;
+	board_info = dss_plat_data->board_data;
+	dsi.dsi_mux_pads = board_info->dsi_mux_pads;
+
 	spin_lock_init(&dsi.irq_lock);
 	spin_lock_init(&dsi.errors_lock);
 	dsi.errors = 0;
-- 
1.7.1

