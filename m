From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/14] OMAPDSS: Add enum dss_pll_id
Date: Tue, 27 Jan 2015 12:50:29 +0200
Message-ID: <1422355842-11234-2-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbbA0Ku5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 05:50:57 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

In some cases we need global identifiers for the DSS PLLs, for example
when configuring clock muxing on DRA7. For this purpose let's add a
'enum dss_pll_id'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c      | 1 +
 drivers/video/fbdev/omap2/dss/dss.h      | 7 +++++++
 drivers/video/fbdev/omap2/dss/hdmi_pll.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 3e44c580b1f8..5081f6fb1737 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -5238,6 +5238,7 @@ static int dsi_init_pll_data(struct platform_device *dsidev)
 	}
 
 	pll->name = dsi->module_id == 0 ? "dsi0" : "dsi1";
+	pll->id = dsi->module_id == 0 ? DSS_PLL_DSI1 : DSS_PLL_DSI2;
 	pll->clkin = clk;
 	pll->base = dsi->pll_base;
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 14fb0c23f4a2..1826ee96265b 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -100,6 +100,12 @@ enum dss_writeback_channel {
 	DSS_WB_LCD3_MGR =	7,
 };
 
+enum dss_pll_id {
+	DSS_PLL_DSI1,
+	DSS_PLL_DSI2,
+	DSS_PLL_HDMI,
+};
+
 struct dss_pll;
 
 #define DSS_PLL_MAX_HSDIVS 4
@@ -150,6 +156,7 @@ struct dss_pll_hw {
 
 struct dss_pll {
 	const char *name;
+	enum dss_pll_id id;
 
 	struct clk *clkin;
 	struct regulator *regulator;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
index ac83ef5cfd7d..b808f7c72d83 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi_pll.c
@@ -185,6 +185,7 @@ static int dsi_init_pll_data(struct platform_device *pdev, struct hdmi_pll_data
 	}
 
 	pll->name = "hdmi";
+	pll->id = DSS_PLL_HDMI;
 	pll->base = hpll->base;
 	pll->clkin = clk;
 
-- 
2.2.2

