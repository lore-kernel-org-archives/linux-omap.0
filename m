From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/9] OMAPDSS: Add support for DPI source selection
Date: Mon, 24 Sep 2012 16:58:34 +0300
Message-ID: <1348495119-8262-5-git-send-email-tomi.valkeinen@ti.com>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:34549 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754900Ab2IXN64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 09:58:56 -0400
Received: by lbbgj3 with SMTP id gj3so6750169lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 06:58:52 -0700 (PDT)
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Anders <x0132446@ti.com>

We can select the video source for DPI output as follows:

OMAP2/3: always LCD1
OMAP4: LCD2 or DIGIT
OMAP5: LCD1/LCD2/LCD3/DIGIT

This patch adds support to select the source, and makes dpi.c call the
function to set the source.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Anders <x0132446@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    5 ++++
 drivers/video/omap2/dss/dss.c |   65 +++++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h |    1 +
 3 files changed, 71 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 5ccce9b..b723388 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -203,6 +203,10 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
+	r = dss_dpi_select_source(dssdev->channel);
+	if (r)
+		goto err_src_sel;
+
 	if (dpi_use_dsi_pll(dssdev)) {
 		r = dsi_runtime_get(dpi.dsidev);
 		if (r)
@@ -237,6 +241,7 @@ err_dsi_pll_init:
 	if (dpi_use_dsi_pll(dssdev))
 		dsi_runtime_put(dpi.dsidev);
 err_get_dsi:
+err_src_sel:
 	dispc_runtime_put();
 err_get_dispc:
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 660813b..2ab1c3e9 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -69,6 +69,7 @@ struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
 	const char *clk_name;
+	int (*dpi_select_source)(enum omap_channel channel);
 };
 
 static struct {
@@ -623,6 +624,65 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
 	return REG_GET(DSS_CONTROL, 15, 15);
 }
 
+static int dss_dpi_select_source_omap2_omap3(enum omap_channel channel)
+{
+	if (channel != OMAP_DSS_CHANNEL_LCD)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dss_dpi_select_source_omap4(enum omap_channel channel)
+{
+	int val;
+
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD2:
+		val = 0;
+		break;
+	case OMAP_DSS_CHANNEL_DIGIT:
+		val = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	REG_FLD_MOD(DSS_CONTROL, val, 17, 17);
+
+	return 0;
+}
+
+static int dss_dpi_select_source_omap5(enum omap_channel channel)
+{
+	int val;
+
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		val = 1;
+		break;
+	case OMAP_DSS_CHANNEL_LCD2:
+		val = 2;
+		break;
+	case OMAP_DSS_CHANNEL_LCD3:
+		val = 3;
+		break;
+	case OMAP_DSS_CHANNEL_DIGIT:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	REG_FLD_MOD(DSS_CONTROL, val, 17, 16);
+
+	return 0;
+}
+
+int dss_dpi_select_source(enum omap_channel channel)
+{
+	return dss.feat->dpi_select_source(channel);
+}
+
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
@@ -701,30 +761,35 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	.fck_div_max		=	16,
 	.dss_fck_multiplier	=	2,
 	.clk_name		=	NULL,
+	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
 	.fck_div_max		=	16,
 	.dss_fck_multiplier	=	2,
 	.clk_name		=	"dpll4_m4_ck",
+	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
 	.fck_div_max		=	32,
 	.dss_fck_multiplier	=	1,
 	.clk_name		=	"dpll4_m4_ck",
+	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
 	.fck_div_max		=	32,
 	.dss_fck_multiplier	=	1,
 	.clk_name		=	"dpll_per_m5x2_ck",
+	.dpi_select_source	=	&dss_dpi_select_source_omap4,
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
 	.fck_div_max		=	64,
 	.dss_fck_multiplier	=	1,
 	.clk_name		=	"dpll_per_h12x2_ck",
+	.dpi_select_source	=	&dss_dpi_select_source_omap5,
 };
 
 static int __init dss_init_features(struct device *dev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5e9fd769..2a51ae9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -277,6 +277,7 @@ void dss_overlay_kobj_uninit(struct omap_overlay *ovl);
 int dss_init_platform_driver(void) __init;
 void dss_uninit_platform_driver(void);
 
+int dss_dpi_select_source(enum omap_channel channel);
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
-- 
1.7.9.5

