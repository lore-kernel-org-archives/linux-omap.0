From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DSS remove ctx stuff
Date: Mon, 18 Nov 2013 14:50:06 +0200
Message-ID: <1384779009-10512-4-git-send-email-tomi.valkeinen@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52139 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab3KRMuS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:50:18 -0500
In-Reply-To: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The DSS core driver's suspend/resume can be cleaned up by storing the
required registers to a 'dss_context' struct, instead of having a 512
byte block of memory where the registers are directly stored.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 77 ++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bd01608..a5f674f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -39,8 +39,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-#define DSS_SZ_REGS			SZ_512
-
 struct dss_reg {
 	u16 idx;
 };
@@ -71,6 +69,13 @@ struct dss_features {
 	int (*dpi_select_source)(enum omap_channel channel);
 };
 
+struct dss_context {
+	bool valid;
+	u32 control;
+	u32 sdi_control;
+	u32 pll_control;
+};
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -88,8 +93,7 @@ static struct {
 	enum omap_dss_clk_source dispc_clk_source;
 	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
-	bool		ctx_valid;
-	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+	struct dss_context ctx;
 
 	const struct dss_features *feat;
 } dss;
@@ -112,49 +116,6 @@ static inline u32 dss_read_reg(const struct dss_reg idx)
 	return __raw_readl(dss.base + idx.idx);
 }
 
-#define SR(reg) \
-	dss.ctx[(DSS_##reg).idx / sizeof(u32)] = dss_read_reg(DSS_##reg)
-#define RR(reg) \
-	dss_write_reg(DSS_##reg, dss.ctx[(DSS_##reg).idx / sizeof(u32)])
-
-static void dss_save_context(void)
-{
-	DSSDBG("dss_save_context\n");
-
-	SR(CONTROL);
-
-	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
-			OMAP_DISPLAY_TYPE_SDI) {
-		SR(SDI_CONTROL);
-		SR(PLL_CONTROL);
-	}
-
-	dss.ctx_valid = true;
-
-	DSSDBG("context saved\n");
-}
-
-static void dss_restore_context(void)
-{
-	DSSDBG("dss_restore_context\n");
-
-	if (!dss.ctx_valid)
-		return;
-
-	RR(CONTROL);
-
-	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
-			OMAP_DISPLAY_TYPE_SDI) {
-		RR(SDI_CONTROL);
-		RR(PLL_CONTROL);
-	}
-
-	DSSDBG("context restored\n");
-}
-
-#undef SR
-#undef RR
-
 int dss_get_ctx_loss_count(void)
 {
 	struct platform_device *core_pdev = dss_get_core_pdev();
@@ -927,7 +888,16 @@ static int __exit omap_dsshw_remove(struct platform_device *pdev)
 
 static int dss_runtime_suspend(struct device *dev)
 {
-	dss_save_context();
+	dss.ctx.control = dss_read_reg(DSS_CONTROL);
+
+	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
+			OMAP_DISPLAY_TYPE_SDI) {
+		dss.ctx.sdi_control = dss_read_reg(DSS_SDI_CONTROL);
+		dss.ctx.pll_control = dss_read_reg(DSS_PLL_CONTROL);
+	}
+
+	dss.ctx.valid = true;
+
 	dss_set_min_bus_tput(dev, 0);
 	return 0;
 }
@@ -946,7 +916,16 @@ static int dss_runtime_resume(struct device *dev)
 	if (r)
 		return r;
 
-	dss_restore_context();
+	if (dss.ctx.valid) {
+		dss_write_reg(DSS_CONTROL, dss.ctx.control);
+
+		if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
+				OMAP_DISPLAY_TYPE_SDI) {
+			dss_write_reg(DSS_SDI_CONTROL, dss.ctx.sdi_control);
+			dss_write_reg(DSS_PLL_CONTROL, dss.ctx.pll_control);
+		}
+	}
+
 	return 0;
 }
 
-- 
1.8.3.2

