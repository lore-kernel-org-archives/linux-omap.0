From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] OMAPDSS: DISPC: get dss clock rate from dss driver
Date: Wed, 12 Dec 2012 14:27:08 +0200
Message-ID: <1355315229-25238-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46479 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2LLM1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 07:27:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Dispc currently gets dispc's fck with clk_get() and uses clk_get_rate()
to get the rate for scaling calculations. This causes a problem with
common clock framework, as omapdss uses the dispc functions inside a
spinlock, and common clock framework uses a mutex in clk_get_rate().

Looking at the DSS clock tree, the above use of the dispc fck is not
quite correct. The DSS_FCLK from PRCM goes to DSS core block, which has
a mux to select the clock for DISPC from various options, so the current
use of dispc fck bypasses that. Fortunately we never change the dispc
clock mux for now.

To fix the issue with clk_get_rate(), this patch caches the dss clock
rate in dss.c when it is set. Dispc will then ask for the clock rate
from dss. While this is not very elegant, it does fix the issue, and
it's not totally wrong when considering that the dispc fck actually
comes via dss.

In the future we should probably look into common clock framework and
see if that could be used to represent the DSS clock tree properly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 drivers/video/omap2/dss/dss.c   |   12 ++++++++++++
 drivers/video/omap2/dss/dss.h   |    1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index fedbd2c..08137a8 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2970,7 +2970,7 @@ unsigned long dispc_fclk_rate(void)
 
 	switch (dss_get_dispc_clk_source()) {
 	case OMAP_DSS_CLK_SRC_FCK:
-		r = clk_get_rate(dispc.dss_clk);
+		r = dss_get_dispc_clk_rate();
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		dsidev = dsi_get_dsidev_from_id(0);
@@ -3002,7 +3002,7 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 
 		switch (dss_get_lcd_clk_source(channel)) {
 		case OMAP_DSS_CLK_SRC_FCK:
-			r = clk_get_rate(dispc.dss_clk);
+			r = dss_get_dispc_clk_rate();
 			break;
 		case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 			dsidev = dsi_get_dsidev_from_id(0);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 833f162..054c2a2 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -77,6 +77,7 @@ static struct {
 
 	struct clk	*dpll4_m4_ck;
 	struct clk	*dss_clk;
+	unsigned long	dss_clk_rate;
 
 	unsigned long	cache_req_pck;
 	unsigned long	cache_prate;
@@ -489,6 +490,10 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 			return -EINVAL;
 	}
 
+	dss.dss_clk_rate = clk_get_rate(dss.dss_clk);
+
+	WARN_ONCE(dss.dss_clk_rate != cinfo->fck, "clk rate mismatch");
+
 	DSSDBG("fck = %ld (%d)\n", cinfo->fck, cinfo->fck_div);
 
 	return 0;
@@ -502,6 +507,11 @@ unsigned long dss_get_dpll4_rate(void)
 		return 0;
 }
 
+unsigned long dss_get_dispc_clk_rate(void)
+{
+	return dss.dss_clk_rate;
+}
+
 static int dss_setup_default_clock(void)
 {
 	unsigned long max_dss_fck, prate;
@@ -953,6 +963,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_runtime_get;
 
+	dss.dss_clk_rate = clk_get_rate(dss.dss_clk);
+
 	/* Select DPLL */
 	REG_FLD_MOD(DSS_CONTROL, 0, 0, 0);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ebe9e08..610c8e5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -237,6 +237,7 @@ void dss_overlay_kobj_uninit(struct omap_overlay *ovl);
 int dss_init_platform_driver(void) __init;
 void dss_uninit_platform_driver(void);
 
+unsigned long dss_get_dispc_clk_rate(void);
 int dss_dpi_select_source(enum omap_channel channel);
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
-- 
1.7.10.4

