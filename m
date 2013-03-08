From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/14] OMAPDSS: DSI: add new clock calculation code
Date: Fri, 8 Mar 2013 13:52:44 +0200
Message-ID: <1362743569-10289-10-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57918 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933917Ab3CHLxZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:25 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add new way to iterate over DSI PLL and HSDIV clock divisors.
dsi_pll_calc() and dss_hsdiv_calc() provide a generic way to go over
all the divisors, within given clock range. The functions will call a
callback function for each divider set, making the function reusable for
all use cases.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   69 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h |   12 +++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index aabe472..c8d5574 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1280,6 +1280,75 @@ static int dsi_pll_power(struct platform_device *dsidev,
 	return 0;
 }
 
+unsigned long dsi_get_pll_clkin(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	return clk_get_rate(dsi->sys_clk);
+}
+
+bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,
+		unsigned long out_min, dsi_hsdiv_calc_func func, void *data)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int regm, regm_start, regm_stop;
+	unsigned long out_max;
+	unsigned long out;
+
+	out_min = out_min ? out_min : 1;
+	out_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+
+	regm_start = max(DIV_ROUND_UP(pll, out_max), 1ul);
+	regm_stop = min(pll / out_min, dsi->regm_dispc_max);
+
+	for (regm = regm_start; regm <= regm_stop; ++regm) {
+		out = pll / regm;
+
+		if (func(regm, out, data))
+			return true;
+	}
+
+	return false;
+}
+
+bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
+		unsigned long pll_min, unsigned long pll_max,
+		dsi_pll_calc_func func, void *data)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int regn, regn_start, regn_stop;
+	int regm, regm_start, regm_stop;
+	unsigned long fint, pll;
+	const unsigned long pll_hw_max = 1800000000;
+	unsigned long fint_hw_min, fint_hw_max;
+
+	fint_hw_min = dsi->fint_min;
+	fint_hw_max = dsi->fint_max;
+
+	regn_start = max(DIV_ROUND_UP(clkin, fint_hw_max), 1ul);
+	regn_stop = min(clkin / fint_hw_min, dsi->regn_max);
+
+	pll_max = pll_max ? pll_max : ULONG_MAX;
+
+	for (regn = regn_start; regn <= regn_stop; ++regn) {
+		fint = clkin / regn;
+
+		regm_start = max(DIV_ROUND_UP(DIV_ROUND_UP(pll_min, fint), 2),
+				1ul);
+		regm_stop = min3(pll_max / fint / 2,
+				pll_hw_max / fint / 2,
+				dsi->regm_max);
+
+		for (regm = regm_start; regm <= regm_stop; ++regm) {
+			pll = 2 * regm * fint;
+
+			if (func(regn, regm, fint, pll, data))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /* calculate clock rates using dividers in cinfo */
 static int dsi_calc_clock_rates(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4180302..dde6cc1 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -295,6 +295,18 @@ void dsi_dump_clocks(struct seq_file *s);
 void dsi_irq_handler(void);
 u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt);
 
+unsigned long dsi_get_pll_clkin(struct platform_device *dsidev);
+
+typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fint,
+		unsigned long pll, void *data);
+typedef bool (*dsi_hsdiv_calc_func)(int regm_dispc, unsigned long dispc,
+		void *data);
+bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,
+		unsigned long out_min, dsi_hsdiv_calc_func func, void *data);
+bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
+		unsigned long pll_min, unsigned long pll_max,
+		dsi_pll_calc_func func, void *data);
+
 unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo);
-- 
1.7.10.4

