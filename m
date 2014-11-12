From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/22] OMAPDSS: DSI: always power on hsclk & hsdiv
Date: Wed, 12 Nov 2014 13:52:05 +0200
Message-ID: <1415793144-11723-4-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36448 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbaKLLwt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:49 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DSS PLL has support to power on the PLL's highspeed clock output
and HSDIV output separately. In practice both need to powered on, as in
most OMAP's that's the only working configuration. We already do that in
dsi_pll_init(), by overriding the passed arguments so that both are
always powered.

Simplify the code by removing the support for choosing which outputs to
power on.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  4 ++--
 drivers/video/fbdev/omap2/dss/dsi.c | 23 +++--------------------
 drivers/video/fbdev/omap2/dss/dss.h |  6 ++----
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index ebc294f8dfdb..aa095c4927ec 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -405,7 +405,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 		if (r)
 			goto err_get_dsi;
 
-		r = dsi_pll_init(dpi->dsidev, 0, 1);
+		r = dsi_pll_init(dpi->dsidev);
 		if (r)
 			goto err_dsi_pll_init;
 	}
@@ -557,7 +557,7 @@ static int dpi_verify_dsi_pll(struct platform_device *dsidev)
 	if (r)
 		return r;
 
-	r = dsi_pll_init(dsidev, 0, 1);
+	r = dsi_pll_init(dsidev);
 	if (r) {
 		dsi_runtime_put(dsidev);
 		return r;
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index b7acdcd76f73..0083f6500949 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1672,21 +1672,13 @@ err:
 	return r;
 }
 
-int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
-		bool enable_hsdiv)
+int dsi_pll_init(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r = 0;
-	enum dsi_pll_power_state pwstate;
 
 	DSSDBG("PLL init\n");
 
-	/*
-	 * It seems that on many OMAPs we need to enable both to have a
-	 * functional HSDivider.
-	 */
-	enable_hsclk = enable_hsdiv = true;
-
 	r = dsi_regulator_init(dsidev);
 	if (r)
 		return r;
@@ -1718,16 +1710,7 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 	 * fill the whole display. No idea about this */
 	dispc_pck_free_enable(0);
 
-	if (enable_hsclk && enable_hsdiv)
-		pwstate = DSI_PLL_POWER_ON_ALL;
-	else if (enable_hsclk)
-		pwstate = DSI_PLL_POWER_ON_HSCLK;
-	else if (enable_hsdiv)
-		pwstate = DSI_PLL_POWER_ON_DIV;
-	else
-		pwstate = DSI_PLL_POWER_OFF;
-
-	r = dsi_pll_power(dsidev, pwstate);
+	r = dsi_pll_power(dsidev, DSI_PLL_POWER_ON_ALL);
 
 	if (r)
 		goto err1;
@@ -4487,7 +4470,7 @@ static int dsi_display_init_dsi(struct platform_device *dsidev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
 
-	r = dsi_pll_init(dsidev, true, true);
+	r = dsi_pll_init(dsidev);
 	if (r)
 		goto err0;
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 4617b4d9f78d..2defcaedbef5 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -296,8 +296,7 @@ bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
 unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo);
-int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
-		bool enable_hsdiv);
+int dsi_pll_init(struct platform_device *dsidev);
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
 struct platform_device *dsi_get_dsidev_from_id(int module);
 #else
@@ -324,8 +323,7 @@ static inline int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	WARN("%s: DSI not compiled in\n", __func__);
 	return -ENODEV;
 }
-static inline int dsi_pll_init(struct platform_device *dsidev,
-		bool enable_hsclk, bool enable_hsdiv)
+static inline int dsi_pll_init(struct platform_device *dsidev)
 {
 	WARN("%s: DSI not compiled in\n", __func__);
 	return -ENODEV;
-- 
2.1.3

