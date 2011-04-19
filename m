From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/19] OMAP: DSS2: DSI: add option to leave DSI lanes powered on
Date: Tue, 19 Apr 2011 12:22:07 +0300
Message-ID: <1303204942-25450-5-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43131 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422Ab1DSJWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:42 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DSI pins are powered by VDDS_DSI. If VDDS_DSI is off, the DSI pins
are floating even if they are pinmuxed to, say, safe mode and there's a
pull down/up.

This patch gives the panel drivers an option to leave the VDDS_DSI power
enabled while the DSS itself is turned off. This can be used to keep the
DSI lanes in a valid state while DSS is off, if the DSI pins are muxed
for pull down (not done in this patch).

There will be a slight power consumption increase (~100 uA?) when the
VDDS_DSI is left on, but because this option is used when the panel is
left on, the regulator consumption is negligible compared to panel power
consumption.

When the panel is fully turned off the VDDS_DSI is also turned off.

As an added bonus this will give us faster start up time when starting
up the DSS and the regulator is already enabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 +-
 drivers/video/omap2/displays/panel-taal.c |    4 +-
 drivers/video/omap2/dss/dpi.c             |    4 +-
 drivers/video/omap2/dss/dsi.c             |   35 +++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h             |    2 +-
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 43b887b..205c6de 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -591,7 +591,8 @@ int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id);
 void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_dsi_display_disable(struct omap_dss_device *dssdev);
+void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
+		bool disconnect_lanes);
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 490998f..74ce9f8 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -932,7 +932,7 @@ err:
 
 	taal_hw_reset(dssdev);
 
-	omapdss_dsi_display_disable(dssdev);
+	omapdss_dsi_display_disable(dssdev, true);
 err0:
 	return r;
 }
@@ -955,7 +955,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 		taal_hw_reset(dssdev);
 	}
 
-	omapdss_dsi_display_disable(dssdev);
+	omapdss_dsi_display_disable(dssdev, true);
 
 	td->enabled = 0;
 }
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 17d28d7..ba0b8da 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -206,7 +206,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 err4:
 	if (dpi_use_dsi_pll(dssdev))
-		dsi_pll_uninit();
+		dsi_pll_uninit(true);
 err3:
 	if (dpi_use_dsi_pll(dssdev))
 		dss_clk_disable(DSS_CLK_SYSCK);
@@ -227,7 +227,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-		dsi_pll_uninit();
+		dsi_pll_uninit(true);
 		dss_clk_disable(DSS_CLK_SYSCK);
 	}
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5303548..54fc0f6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -246,6 +246,7 @@ static struct
 
 	struct dsi_clock_info current_cinfo;
 
+	bool vdds_dsi_enabled;
 	struct regulator *vdds_dsi_reg;
 
 	struct {
@@ -1445,9 +1446,12 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 	enable_clocks(1);
 	dsi_enable_pll_clock(1);
 
-	r = regulator_enable(dsi.vdds_dsi_reg);
-	if (r)
-		goto err0;
+	if (!dsi.vdds_dsi_enabled) {
+		r = regulator_enable(dsi.vdds_dsi_reg);
+		if (r)
+			goto err0;
+		dsi.vdds_dsi_enabled = true;
+	}
 
 	/* XXX PLL does not come out of reset without this... */
 	dispc_pck_free_enable(1);
@@ -1481,21 +1485,28 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 
 	return 0;
 err1:
-	regulator_disable(dsi.vdds_dsi_reg);
+	if (dsi.vdds_dsi_enabled) {
+		regulator_disable(dsi.vdds_dsi_reg);
+		dsi.vdds_dsi_enabled = false;
+	}
 err0:
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
 	return r;
 }
 
-void dsi_pll_uninit(void)
+void dsi_pll_uninit(bool disconnect_lanes)
 {
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
 
 	dsi.pll_locked = 0;
 	dsi_pll_power(DSI_PLL_POWER_OFF);
-	regulator_disable(dsi.vdds_dsi_reg);
+	if (disconnect_lanes) {
+		WARN_ON(!dsi.vdds_dsi_enabled);
+		regulator_disable(dsi.vdds_dsi_reg);
+		dsi.vdds_dsi_enabled = false;
+	}
 	DSSDBG("PLL uninit done\n");
 }
 
@@ -3642,12 +3653,13 @@ err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 err1:
-	dsi_pll_uninit();
+	dsi_pll_uninit(true);
 err0:
 	return r;
 }
 
-static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev)
+static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
+		bool disconnect_lanes)
 {
 	if (!dsi.ulps_enabled)
 		dsi_enter_ulps();
@@ -3662,7 +3674,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev)
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dsi_complexio_uninit();
-	dsi_pll_uninit();
+	dsi_pll_uninit(disconnect_lanes);
 }
 
 static int dsi_core_init(void)
@@ -3731,7 +3743,8 @@ err0:
 }
 EXPORT_SYMBOL(omapdss_dsi_display_enable);
 
-void omapdss_dsi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
+		bool disconnect_lanes)
 {
 	DSSDBG("dsi_display_disable\n");
 
@@ -3741,7 +3754,7 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev)
 
 	dsi_display_uninit_dispc(dssdev);
 
-	dsi_display_uninit_dsi(dssdev);
+	dsi_display_uninit_dsi(dssdev, disconnect_lanes);
 
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d3b5697..eea5c7d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -294,7 +294,7 @@ int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
 		struct dispc_clock_info *dispc_cinfo);
 int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 		bool enable_hsdiv);
-void dsi_pll_uninit(void);
+void dsi_pll_uninit(bool disconnect_lanes);
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
 		u32 *fifo_low, u32 *fifo_high);
-- 
1.7.1

