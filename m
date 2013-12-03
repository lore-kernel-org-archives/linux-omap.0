From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 1/4] OMAPDSS: Add DSS features for AM43xx
Date: Tue, 3 Dec 2013 14:03:45 +0530
Message-ID: <1386059629-1234-2-git-send-email-sathyap@ti.com>
References: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56696 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab3LCIeJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Dec 2013 03:34:09 -0500
In-Reply-To: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com
Cc: Sathya Prakash M R <sathyap@ti.com>

Add DSS features for AM43xx.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/mach-omap2/display.c          |    2 +
 drivers/video/omap2/dss/dispc.c        |    1 +
 drivers/video/omap2/dss/dpi.c          |    2 +
 drivers/video/omap2/dss/dsi.c          |    1 +
 drivers/video/omap2/dss/dss.c          |   11 ++++++
 drivers/video/omap2/dss/dss_features.c |   67 ++++++++++++++++++++++++++++++++
 include/video/omapdss.h                |    1 +
 7 files changed, 85 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index a4e536b..d1cac1c 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -316,6 +316,8 @@ static enum omapdss_version __init omap_display_get_version(void)
 		return OMAPDSS_VER_OMAP4;
 	else if (soc_is_omap54xx())
 		return OMAPDSS_VER_OMAP5;
+	else if (soc_is_am43xx())
+		return OMAPDSS_VER_AM43xx;
 	else
 		return OMAPDSS_VER_UNKNOWN;
 }
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 4ec59ca..1b4aed5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3622,6 +3622,7 @@ static int __init dispc_init_features(struct platform_device *pdev)
 	case OMAPDSS_VER_OMAP34xx_ES3:
 	case OMAPDSS_VER_OMAP3630:
 	case OMAPDSS_VER_AM35xx:
+	case OMAPDSS_VER_AM43xx:
 		src = &omap34xx_rev3_0_dispc_feats;
 		break;
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index bd48cde..7ee7f86 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -64,6 +64,7 @@ static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 	case OMAPDSS_VER_OMAP34xx_ES3:
 	case OMAPDSS_VER_OMAP3630:
 	case OMAPDSS_VER_AM35xx:
+	case OMAPDSS_VER_AM43xx:
 		return NULL;
 
 	case OMAPDSS_VER_OMAP4430_ES1:
@@ -593,6 +594,7 @@ static enum omap_channel dpi_get_channel(void)
 	case OMAPDSS_VER_OMAP34xx_ES3:
 	case OMAPDSS_VER_OMAP3630:
 	case OMAPDSS_VER_AM35xx:
+	case OMAPDSS_VER_AM43xx:
 		return OMAP_DSS_CHANNEL_LCD;
 
 	case OMAPDSS_VER_OMAP4430_ES1:
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6056b27..d68b49b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5082,6 +5082,7 @@ static enum omap_channel dsi_get_channel(int module_id)
 {
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
+	case OMAPDSS_VER_AM43xx:
 		DSSWARN("DSI not supported\n");
 		return OMAP_DSS_CHANNEL_LCD;
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bd01608..0b60746 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -795,6 +795,13 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
 };
 
+static const struct dss_features am43xx_dss_feats __initconst = {
+	.fck_div_max		=	0,
+	.dss_fck_multiplier	=	0,
+	.parent_clk_name	=	NULL,
+	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+};
+
 static int __init dss_init_features(struct platform_device *pdev)
 {
 	const struct dss_features *src;
@@ -831,6 +838,10 @@ static int __init dss_init_features(struct platform_device *pdev)
 		src = &omap54xx_dss_feats;
 		break;
 
+	case OMAPDSS_VER_AM43xx:
+		src = &am43xx_dss_feats;
+		break;
+
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f8fd6db..79df1a2 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -93,6 +93,17 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
 	[FEAT_REG_DSIPLL_REGM_DSI]		= { 26, 23 },
 };
 
+static const struct dss_reg_field am43xx_dss_reg_fields[] = {
+	[FEAT_REG_FIRHINC]			= { 12, 0 },
+	[FEAT_REG_FIRVINC]			= { 28, 16 },
+	[FEAT_REG_FIFOLOWTHRESHOLD]	= { 11, 0 },
+	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 27, 16 },
+	[FEAT_REG_FIFOSIZE]		= { 10, 0 },
+	[FEAT_REG_HORIZONTALACCU]		= { 9, 0 },
+	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
+	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
+};
+
 static const struct dss_reg_field omap4_dss_reg_fields[] = {
 	[FEAT_REG_FIRHINC]			= { 12, 0 },
 	[FEAT_REG_FIRVINC]			= { 28, 16 },
@@ -149,6 +160,11 @@ static const enum omap_display_type omap3630_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_VENC,
 };
 
+static const enum omap_display_type am43xx_dss_supported_displays[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI,
+};
+
 static const enum omap_display_type omap4_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI,
@@ -200,6 +216,11 @@ static const enum omap_dss_output_id omap3630_dss_supported_outputs[] = {
 	OMAP_DSS_OUTPUT_VENC,
 };
 
+static const enum omap_dss_output_id am43xx_dss_supported_outputs[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI,
+};
+
 static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DSS_OUTPUT_DBI | OMAP_DSS_OUTPUT_DSI1,
@@ -444,6 +465,13 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
 };
 
+static const struct dss_param_range am43xx_dss_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
+	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
+	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
+	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
+};
+
 static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
@@ -520,6 +548,21 @@ static const enum dss_feat_id am35xx_dss_feat_list[] = {
 	FEAT_OMAP3_DSI_FIFO_BUG,
 };
 
+static const enum dss_feat_id am43xx_dss_feat_list[] = {
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_LINEBUFFERSPLIT,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FIXED_ZORDER,
+	FEAT_FIFO_MERGE,
+};
+
 static const enum dss_feat_id omap3630_dss_feat_list[] = {
 	FEAT_LCDENABLEPOL,
 	FEAT_LCDENABLESIGNAL,
@@ -681,6 +724,26 @@ static const struct omap_dss_features am35xx_dss_features = {
 	.burst_size_unit = 8,
 };
 
+static const struct omap_dss_features am43xx_dss_features = {
+	.reg_fields = am43xx_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(am43xx_dss_reg_fields),
+
+	.features = am43xx_dss_feat_list,
+	.num_features = ARRAY_SIZE(am43xx_dss_feat_list),
+
+	.num_mgrs = 1,
+	.num_ovls = 3,
+	.supported_displays = am43xx_dss_supported_displays,
+	.supported_outputs = am43xx_dss_supported_outputs,
+	.supported_color_modes = omap3_dss_supported_color_modes,
+	.overlay_caps = omap3430_dss_overlay_caps,
+	.clksrc_names = omap2_dss_clk_source_names,
+	.dss_params = am43xx_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA,
+	.buffer_size_unit = 1,
+	.burst_size_unit = 8,
+};
+
 static const struct omap_dss_features omap3630_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
@@ -927,6 +990,10 @@ void dss_features_init(enum omapdss_version version)
 		omap_current_dss_features = &am35xx_dss_features;
 		break;
 
+	case OMAPDSS_VER_AM43xx:
+		omap_current_dss_features = &am43xx_dss_features;
+		break;
+
 	default:
 		DSSWARN("Unsupported OMAP version");
 		break;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3d7c51a..7513146 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -319,6 +319,7 @@ enum omapdss_version {
 	OMAPDSS_VER_OMAP4430_ES2,	/* OMAP4430 ES2.0, 2.1, 2.2 */
 	OMAPDSS_VER_OMAP4,		/* All other OMAP4s */
 	OMAPDSS_VER_OMAP5,
+	OMAPDSS_VER_AM43xx,
 };
 
 /* Board specific data */
-- 
1.7.9.5

