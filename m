From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 08/13] OMAP: DSS2: improve DSS clk src selection
Date: Mon,  8 Feb 2010 17:56:07 +0200
Message-ID: <1265644572-3578-9-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-8-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45749 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0BHPyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:54:13 -0500
In-Reply-To: <1265644572-3578-8-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

dss_select_clk_source() was rather confusing. Selecting the source with
enums is much clearer.

The clk source selection is also stored into memory, so that we know what
is the selected source, even when clocks are off. This is important during
setup, as we need to what clocks to turn on before the clocks are turned
on.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dpi.c |    4 +-
 drivers/video/omap2/dss/dsi.c |    9 +++++--
 drivers/video/omap2/dss/dss.c |   42 +++++++++++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h |   14 ++++++++++--
 4 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 69ce31a..c5091ed 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -57,7 +57,7 @@ static int dpi_set_dsi_clk(bool is_tft, unsigned long pck_req,
 	if (r)
 		return r;
 
-	dss_select_clk_source(0, 1);
+	dss_select_dispc_clk_source(DSS_SRC_DSI1_PLL_FCLK);
 
 	r = dispc_set_clock_div(&dispc_cinfo);
 	if (r)
@@ -238,7 +238,7 @@ static void dpi_display_disable(struct omap_dss_device *dssdev)
 	dispc_enable_lcd_out(0);
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	dss_select_clk_source(0, 0);
+	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
 	dsi_pll_uninit();
 	dss_clk_disable(DSS_CLK_FCK2);
 #endif
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 036f422..4fdb628 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3203,7 +3203,8 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err1;
 
-	dss_select_clk_source(true, true);
+	dss_select_dispc_clk_source(DSS_SRC_DSI1_PLL_FCLK);
+	dss_select_dsi_clk_source(DSS_SRC_DSI2_PLL_FCLK);
 
 	DSSDBG("PLL OK\n");
 
@@ -3247,7 +3248,8 @@ err4:
 err3:
 	dsi_complexio_uninit();
 err2:
-	dss_select_clk_source(false, false);
+	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
+	dss_select_dsi_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
 err1:
 	dsi_pll_uninit();
 err0:
@@ -3259,7 +3261,8 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev)
 	if (dssdev->driver->disable)
 		dssdev->driver->disable(dssdev);
 
-	dss_select_clk_source(false, false);
+	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
+	dss_select_dsi_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
 	dsi_complexio_uninit();
 	dsi_pll_uninit();
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 0a26b7d..8254a42 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -68,6 +68,9 @@ static struct {
 	struct dss_clock_info cache_dss_cinfo;
 	struct dispc_clock_info cache_dispc_cinfo;
 
+	enum dss_clk_source dsi_clk_source;
+	enum dss_clk_source dispc_clk_source;
+
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
@@ -247,23 +250,42 @@ void dss_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-void dss_select_clk_source(bool dsi, bool dispc)
+void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
+{
+	int b;
+
+	BUG_ON(clk_src != DSS_SRC_DSI1_PLL_FCLK &&
+			clk_src != DSS_SRC_DSS1_ALWON_FCLK);
+
+	b = clk_src == DSS_SRC_DSS1_ALWON_FCLK ? 0 : 1;
+
+	REG_FLD_MOD(DSS_CONTROL, b, 0, 0);	/* DISPC_CLK_SWITCH */
+
+	dss.dispc_clk_source = clk_src;
+}
+
+void dss_select_dsi_clk_source(enum dss_clk_source clk_src)
 {
-	u32 r;
-	r = dss_read_reg(DSS_CONTROL);
-	r = FLD_MOD(r, dsi, 1, 1);	/* DSI_CLK_SWITCH */
-	r = FLD_MOD(r, dispc, 0, 0);	/* DISPC_CLK_SWITCH */
-	dss_write_reg(DSS_CONTROL, r);
+	int b;
+
+	BUG_ON(clk_src != DSS_SRC_DSI2_PLL_FCLK &&
+			clk_src != DSS_SRC_DSS1_ALWON_FCLK);
+
+	b = clk_src == DSS_SRC_DSS1_ALWON_FCLK ? 0 : 1;
+
+	REG_FLD_MOD(DSS_CONTROL, b, 1, 1);	/* DSI_CLK_SWITCH */
+
+	dss.dsi_clk_source = clk_src;
 }
 
-int dss_get_dsi_clk_source(void)
+enum dss_clk_source dss_get_dispc_clk_source(void)
 {
-	return FLD_GET(dss_read_reg(DSS_CONTROL), 1, 1);
+	return dss.dispc_clk_source;
 }
 
-int dss_get_dispc_clk_source(void)
+enum dss_clk_source dss_get_dsi_clk_source(void)
 {
-	return FLD_GET(dss_read_reg(DSS_CONTROL), 0, 0);
+	return dss.dsi_clk_source;
 }
 
 /* calculate clock rates using dividers in cinfo */
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 41145af..3713dc6 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -119,6 +119,12 @@ enum dss_clock {
 	DSS_CLK_96M	= 1 << 4,
 };
 
+enum dss_clk_source {
+	DSS_SRC_DSI1_PLL_FCLK,
+	DSS_SRC_DSI2_PLL_FCLK,
+	DSS_SRC_DSS1_ALWON_FCLK,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -219,9 +225,11 @@ void dss_sdi_init(u8 datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
 
-void dss_select_clk_source(bool dsi, bool dispc);
-int dss_get_dsi_clk_source(void);
-int dss_get_dispc_clk_source(void);
+void dss_select_dispc_clk_source(enum dss_clk_source clk_src);
+void dss_select_dsi_clk_source(enum dss_clk_source clk_src);
+enum dss_clk_source dss_get_dispc_clk_source(void);
+enum dss_clk_source dss_get_dsi_clk_source(void);
+
 void dss_set_venc_output(enum omap_dss_venc_type type);
 void dss_set_dac_pwrdn_bgz(bool enable);
 
-- 
1.6.5

