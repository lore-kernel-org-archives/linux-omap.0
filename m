From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/14] OMAPDSS: DSS: Add DRA7xx base support
Date: Tue, 27 Jan 2015 12:50:36 +0200
Message-ID: <1422355842-11234-9-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56824 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755987AbbA0KvG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:06 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add base support for DRA7xx to DSS core.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c               | 40 +++++++++++++++++++++++
 drivers/video/fbdev/omap2/dss/dss.h               |  2 ++
 drivers/video/fbdev/omap2/dss/dss_features.c      |  1 +
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |  1 +
 4 files changed, 44 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 1884c29ef482..8c79839fbe87 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -605,6 +605,26 @@ static int dss_dpi_select_source_omap5(int port, enum omap_channel channel)
 	return 0;
 }
 
+static int dss_dpi_select_source_dra7xx(int port, enum omap_channel channel)
+{
+	switch (port) {
+	case 0:
+		return dss_dpi_select_source_omap5(port, channel);
+	case 1:
+		if (channel != OMAP_DSS_CHANNEL_LCD2)
+			return -EINVAL;
+		break;
+	case 2:
+		if (channel != OMAP_DSS_CHANNEL_LCD3)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int dss_dpi_select_source(int port, enum omap_channel channel)
 {
 	return dss.feat->dpi_select_source(port, channel);
@@ -686,6 +706,12 @@ static const enum omap_display_type omap34xx_ports[] = {
 	OMAP_DISPLAY_TYPE_SDI,
 };
 
+static const enum omap_display_type dra7xx_ports[] = {
+	OMAP_DISPLAY_TYPE_DPI,
+	OMAP_DISPLAY_TYPE_DPI,
+	OMAP_DISPLAY_TYPE_DPI,
+};
+
 static const struct dss_features omap24xx_dss_feats __initconst = {
 	/*
 	 * fck div max is really 16, but the divider range has gaps. The range
@@ -744,6 +770,15 @@ static const struct dss_features am43xx_dss_feats __initconst = {
 	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
+static const struct dss_features dra7xx_dss_feats __initconst = {
+	.fck_div_max		=	64,
+	.dss_fck_multiplier	=	1,
+	.parent_clk_name	=	"dpll_per_x2_ck",
+	.dpi_select_source	=	&dss_dpi_select_source_dra7xx,
+	.ports			=	dra7xx_ports,
+	.num_ports		=	ARRAY_SIZE(dra7xx_ports),
+};
+
 static int __init dss_init_features(struct platform_device *pdev)
 {
 	const struct dss_features *src;
@@ -784,6 +819,10 @@ static int __init dss_init_features(struct platform_device *pdev)
 		src = &am43xx_dss_feats;
 		break;
 
+	case OMAPDSS_VER_DRA7xx:
+		src = &dra7xx_dss_feats;
+		break;
+
 	default:
 		return -ENODEV;
 	}
@@ -1003,6 +1042,7 @@ static const struct of_device_id dss_of_match[] = {
 	{ .compatible = "ti,omap3-dss", },
 	{ .compatible = "ti,omap4-dss", },
 	{ .compatible = "ti,omap5-dss", },
+	{ .compatible = "ti,dra7-dss", },
 	{},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index d6c9c3d3db14..4bca36a591ca 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -104,6 +104,8 @@ enum dss_pll_id {
 	DSS_PLL_DSI1,
 	DSS_PLL_DSI2,
 	DSS_PLL_HDMI,
+	DSS_PLL_VIDEO1,
+	DSS_PLL_VIDEO2,
 };
 
 struct dss_pll;
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 0e6f3f54749f..376270b777f8 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -943,6 +943,7 @@ void dss_features_init(enum omapdss_version version)
 		break;
 
 	case OMAPDSS_VER_OMAP5:
+	case OMAPDSS_VER_DRA7xx:
 		omap_current_dss_features = &omap5_dss_features;
 		break;
 
diff --git a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
index 2f0822ee3ff9..42b87f95267c 100644
--- a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
+++ b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
@@ -186,6 +186,7 @@ static const struct of_device_id omapdss_of_match[] __initconst = {
 	{ .compatible = "ti,omap3-dss", },
 	{ .compatible = "ti,omap4-dss", },
 	{ .compatible = "ti,omap5-dss", },
+	{ .compatible = "ti,dra7-dss", },
 	{},
 };
 
-- 
2.2.2

