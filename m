From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/22] OMAPDSS: DSI: dsi_runtime_get/put in pll_init
Date: Wed, 12 Nov 2014 13:52:13 +0200
Message-ID: <1415793144-11723-12-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36455 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaKLLxB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:01 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When DPI uses the DSI PLL for pixel clock, the DPI code will call
dsi_runtime_get/put to keep the DSI block enabled. A much simpler way to
handle this is to do dsi_runtime_get/put in DSI's dsi_pll_init() and
dsi_pll_uninit(), thus removing the need for DSI to call the runtime PM
functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 17 +----------------
 drivers/video/fbdev/omap2/dss/dsi.c | 10 ++++++++--
 drivers/video/fbdev/omap2/dss/dss.h | 10 ----------
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 0b9af5d3e650..81dd5e61e75e 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -402,10 +402,6 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_src_sel;
 
 	if (dpi->dsidev) {
-		r = dsi_runtime_get(dpi->dsidev);
-		if (r)
-			goto err_get_dsi;
-
 		r = dsi_pll_init(dpi->dsidev);
 		if (r)
 			goto err_dsi_pll_init;
@@ -432,9 +428,6 @@ err_set_mode:
 	if (dpi->dsidev)
 		dsi_pll_uninit(dpi->dsidev, true);
 err_dsi_pll_init:
-	if (dpi->dsidev)
-		dsi_runtime_put(dpi->dsidev);
-err_get_dsi:
 err_src_sel:
 	dispc_runtime_put();
 err_get_dispc:
@@ -459,7 +452,6 @@ static void dpi_display_disable(struct omap_dss_device *dssdev)
 	if (dpi->dsidev) {
 		dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 		dsi_pll_uninit(dpi->dsidev, true);
-		dsi_runtime_put(dpi->dsidev);
 	}
 
 	dispc_runtime_put();
@@ -554,18 +546,11 @@ static int dpi_verify_dsi_pll(struct platform_device *dsidev)
 
 	/* do initial setup with the PLL to see if it is operational */
 
-	r = dsi_runtime_get(dsidev);
-	if (r)
-		return r;
-
 	r = dsi_pll_init(dsidev);
-	if (r) {
-		dsi_runtime_put(dsidev);
+	if (r)
 		return r;
-	}
 
 	dsi_pll_uninit(dsidev, true);
-	dsi_runtime_put(dsidev);
 
 	return 0;
 }
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 22cc91851e94..e8415b5e877e 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1144,7 +1144,7 @@ static u32 dsi_get_errors(struct platform_device *dsidev)
 	return e;
 }
 
-int dsi_runtime_get(struct platform_device *dsidev)
+static int dsi_runtime_get(struct platform_device *dsidev)
 {
 	int r;
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -1156,7 +1156,7 @@ int dsi_runtime_get(struct platform_device *dsidev)
 	return r < 0 ? r : 0;
 }
 
-void dsi_runtime_put(struct platform_device *dsidev)
+static void dsi_runtime_put(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
@@ -1674,6 +1674,10 @@ int dsi_pll_init(struct platform_device *dsidev)
 	if (r)
 		return r;
 
+	r = dsi_runtime_get(dsidev);
+	if (r)
+		return r;
+
 	dsi_enable_pll_clock(dsidev, 1);
 	/*
 	 * Note: SCP CLK is not required on OMAP3, but it is required on OMAP4.
@@ -1717,6 +1721,7 @@ err1:
 err0:
 	dsi_disable_scp_clk(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
+	dsi_runtime_put(dsidev);
 	return r;
 }
 
@@ -1733,6 +1738,7 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 
 	dsi_disable_scp_clk(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
+	dsi_runtime_put(dsidev);
 
 	DSSDBG("PLL uninit done\n");
 }
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index e14a75b743a4..4c268985235c 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -268,9 +268,6 @@ struct file_operations;
 int dsi_init_platform_driver(void) __init;
 void dsi_uninit_platform_driver(void) __exit;
 
-int dsi_runtime_get(struct platform_device *dsidev);
-void dsi_runtime_put(struct platform_device *dsidev);
-
 void dsi_dump_clocks(struct seq_file *s);
 
 void dsi_irq_handler(void);
@@ -291,13 +288,6 @@ int dsi_pll_init(struct platform_device *dsidev);
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
 struct platform_device *dsi_get_dsidev_from_id(int module);
 #else
-static inline int dsi_runtime_get(struct platform_device *dsidev)
-{
-	return 0;
-}
-static inline void dsi_runtime_put(struct platform_device *dsidev)
-{
-}
 static inline u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
 {
 	WARN("%s: DSI not compiled in, returning pixel_size as 0\n", __func__);
-- 
2.1.3

