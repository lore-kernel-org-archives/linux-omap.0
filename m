From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/8] OMAPDSS: DSI: calculate dsi clock
Date: Thu, 23 Aug 2012 16:45:12 +0300
Message-ID: <1345729514-2441-7-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:51894 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933972Ab2HWNps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:48 -0400
Received: by lahc1 with SMTP id c1so485698lah.26
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:41 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently the way to configure clocks related to DSI (both DSI and DISPC
clocks) happens via omapdss platform data. The reason for this is that
configuring the DSS clocks is a very complex problem, and it's
impossible for the SW to know requirements about things like
interference.

However, for general cases it should be fine to calculate the dividers
for clocks in the SW. The calculated clocks are probably not perfect,
but should work.

This patch adds support to calculate the dividers when using DSI command
mode panels. The panel gives the required DDR clock rate and LP clock
rate, and the DSI driver configures itself and DISPC accordingly.

This patch is somewhat ugly, though. The code does its job by modifying
the platform data where the clock dividers would be if the board file
gave them. This is not how it's going to be in the future, but allows us
to have quite simple patch and keep the backward compatibility.

It also allows the developer to still give the exact dividers from the
board file when there's need for that, as long as the panel driver does
not override them.

There are also other areas for improvement. For example, it would be
better if the panel driver could ask for a DSI clock in a certain range,
as, at least command mode panels, the panel can work fine with many
different clock speeds.

While the patch is not perfect, it allows us to remove the hardcoded
clock dividers from the board file, making it easier to bring up a new
panel and to use device tree from omapdss.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    6 ++
 drivers/video/omap2/dss/dsi.c             |  126 +++++++++++++++++++++++++++++
 include/video/omapdss.h                   |    2 +
 3 files changed, 134 insertions(+)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 77aed0e..ddda96a 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1065,6 +1065,12 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	omapdss_dsi_set_pixel_format(dssdev, OMAP_DSS_DSI_FMT_RGB888);
 	omapdss_dsi_set_operation_mode(dssdev, OMAP_DSS_DSI_CMD_MODE);
 
+	r = omapdss_dsi_set_clocks(dssdev, 216000000, 10000000);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set HS and LP clocks\n");
+		goto err0;
+	}
+
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 96d0024..340c832 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1454,6 +1454,68 @@ found:
 	return 0;
 }
 
+static int dsi_pll_calc_ddrfreq(struct platform_device *dsidev,
+		unsigned long req_clk, struct dsi_clock_info *cinfo)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_clock_info cur, best;
+	unsigned long dss_sys_clk, max_dss_fck, max_dsi_fck;
+	unsigned long req_clkin4ddr;
+
+	DSSDBG("dsi_pll_calc_ddrfreq\n");
+
+	dss_sys_clk = clk_get_rate(dsi->sys_clk);
+
+	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
+
+	memset(&best, 0, sizeof(best));
+	memset(&cur, 0, sizeof(cur));
+
+	cur.clkin = dss_sys_clk;
+
+	req_clkin4ddr = req_clk * 4;
+
+	for (cur.regn = 1; cur.regn < dsi->regn_max; ++cur.regn) {
+		cur.fint = cur.clkin / cur.regn;
+
+		if (cur.fint > dsi->fint_max || cur.fint < dsi->fint_min)
+			continue;
+
+		/* DSIPHY(MHz) = (2 * regm / regn) * clkin */
+		for (cur.regm = 1; cur.regm < dsi->regm_max; ++cur.regm) {
+			unsigned long a, b;
+
+			a = 2 * cur.regm * (cur.clkin/1000);
+			b = cur.regn;
+			cur.clkin4ddr = a / b * 1000;
+
+			if (cur.clkin4ddr > 1800 * 1000 * 1000)
+				break;
+
+			if (abs(cur.clkin4ddr - req_clkin4ddr) <
+					abs(best.clkin4ddr - req_clkin4ddr)) {
+				best = cur;
+				DSSDBG("best %ld\n", best.clkin4ddr);
+			}
+
+			if (cur.clkin4ddr == req_clkin4ddr)
+				goto found;
+		}
+	}
+found:
+	best.regm_dispc = DIV_ROUND_UP(best.clkin4ddr, max_dss_fck);
+	best.dsi_pll_hsdiv_dispc_clk = best.clkin4ddr / best.regm_dispc;
+
+	best.regm_dsi = DIV_ROUND_UP(best.clkin4ddr, max_dsi_fck);
+	best.dsi_pll_hsdiv_dsi_clk = best.clkin4ddr / best.regm_dsi;
+
+	if (cinfo)
+		*cinfo = best;
+
+	return 0;
+}
+
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo)
 {
@@ -4110,6 +4172,70 @@ int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_configure_pins);
 
+int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
+		unsigned long ddr_clk, unsigned long lp_clk)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_clock_info cinfo;
+	struct dispc_clock_info dispc_cinfo;
+	unsigned lp_clk_div;
+	unsigned long dsi_fclk;
+	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+	unsigned long pck;
+	int r;
+
+	DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
+
+	mutex_lock(&dsi->lock);
+
+	r = dsi_pll_calc_ddrfreq(dsidev, ddr_clk, &cinfo);
+	if (r)
+		goto err;
+
+	dssdev->clocks.dsi.regn = cinfo.regn;
+	dssdev->clocks.dsi.regm = cinfo.regm;
+	dssdev->clocks.dsi.regm_dispc = cinfo.regm_dispc;
+	dssdev->clocks.dsi.regm_dsi = cinfo.regm_dsi;
+
+
+	dsi_fclk = cinfo.dsi_pll_hsdiv_dsi_clk;
+	lp_clk_div = DIV_ROUND_UP(dsi_fclk, lp_clk * 2);
+
+	dssdev->clocks.dsi.lp_clk_div = lp_clk_div;
+
+	/* pck = TxByteClkHS * datalanes * 8 / bitsperpixel */
+
+	pck = cinfo.clkin4ddr / 16 * (dsi->num_lanes_used - 1) * 8 / bpp;
+
+	DSSDBG("finding dispc dividers for pck %lu\n", pck);
+
+	dispc_find_clk_divs(pck, cinfo.dsi_pll_hsdiv_dispc_clk, &dispc_cinfo);
+
+	dssdev->clocks.dispc.channel.lck_div = dispc_cinfo.lck_div;
+	dssdev->clocks.dispc.channel.pck_div = dispc_cinfo.pck_div;
+
+
+	dssdev->clocks.dispc.dispc_fclk_src = OMAP_DSS_CLK_SRC_FCK;
+
+	dssdev->clocks.dispc.channel.lcd_clk_src =
+		dsi->module_id == 0 ?
+		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
+		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
+
+	dssdev->clocks.dsi.dsi_fclk_src =
+		dsi->module_id == 0 ?
+		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
+		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI;
+
+	mutex_unlock(&dsi->lock);
+	return 0;
+err:
+	mutex_unlock(&dsi->lock);
+	return r;
+}
+EXPORT_SYMBOL(omapdss_dsi_set_clocks);
+
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index c6ffe88..8a926f8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -738,6 +738,8 @@ int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id);
 void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
 int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 		const struct omap_dsi_pin_config *pin_cfg);
+int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
+		unsigned long ddr_clk, unsigned long lp_clk);
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
-- 
1.7.9.5

