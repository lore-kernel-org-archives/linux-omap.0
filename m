From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/10] OMAP: DSS2: Add overlay caps to DSS features
Date: Mon, 22 Aug 2011 11:27:44 +0300
Message-ID: <1314001671-18123-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:53160 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756705Ab1HVI2J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:09 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support to define overlay capabilities into dss_features. The
features are set to overlay->caps at initialization time.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   55 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/overlay.c      |    4 +--
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b415c4e..6bf508d 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -47,6 +47,7 @@ struct omap_dss_features {
 	const int num_ovls;
 	const enum omap_display_type *supported_displays;
 	const enum omap_color_mode *supported_color_modes;
+	const enum omap_overlay_caps *overlay_caps;
 	const char * const *clksrc_names;
 	const struct dss_param_range *dss_params;
 
@@ -211,6 +212,50 @@ static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_RGBX32,
 };
 
+static const enum omap_overlay_caps omap2_dss_overlay_caps[] = {
+	/* OMAP_DSS_GFX */
+	0,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_OVL_CAP_SCALE,
+
+	/* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_OVL_CAP_SCALE,
+};
+
+static const enum omap_overlay_caps omap3430_dss_overlay_caps[] = {
+	/* OMAP_DSS_GFX */
+	0,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_OVL_CAP_SCALE,
+
+	/* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_OVL_CAP_SCALE,
+};
+
+static const enum omap_overlay_caps omap3630_dss_overlay_caps[] = {
+	/* OMAP_DSS_GFX */
+	0,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_OVL_CAP_SCALE,
+
+	/* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_OVL_CAP_SCALE,
+};
+
+static const enum omap_overlay_caps omap4_dss_overlay_caps[] = {
+	/* OMAP_DSS_GFX */
+	0,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_OVL_CAP_SCALE,
+
+	/* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_OVL_CAP_SCALE,
+};
+
 static const char * const omap2_dss_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "N/A",
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "N/A",
@@ -275,6 +320,7 @@ static const struct omap_dss_features omap2_dss_features = {
 	.num_ovls = 3,
 	.supported_displays = omap2_dss_supported_displays,
 	.supported_color_modes = omap2_dss_supported_color_modes,
+	.overlay_caps = omap2_dss_overlay_caps,
 	.clksrc_names = omap2_dss_clk_source_names,
 	.dss_params = omap2_dss_param_range,
 	.buffer_size_unit = 1,
@@ -299,6 +345,7 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.num_ovls = 3,
 	.supported_displays = omap3430_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
+	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
 	.buffer_size_unit = 1,
@@ -322,6 +369,7 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.num_ovls = 3,
 	.supported_displays = omap3630_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
+	.overlay_caps = omap3630_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
 	.buffer_size_unit = 1,
@@ -346,6 +394,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.num_ovls = 3,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap4_dss_supported_color_modes,
+	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 	.buffer_size_unit = 16,
@@ -370,6 +419,7 @@ static const struct omap_dss_features omap4_dss_features = {
 	.num_ovls = 3,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap4_dss_supported_color_modes,
+	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 	.buffer_size_unit = 16,
@@ -407,6 +457,11 @@ enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
 	return omap_current_dss_features->supported_color_modes[plane];
 }
 
+enum omap_overlay_caps dss_feat_get_overlay_caps(enum omap_plane plane)
+{
+	return omap_current_dss_features->overlay_caps[plane];
+}
+
 bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b7398cb..fd09196 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -90,6 +90,7 @@ unsigned long dss_feat_get_param_min(enum dss_range_param param);
 unsigned long dss_feat_get_param_max(enum dss_range_param param);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
+enum omap_overlay_caps dss_feat_get_overlay_caps(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode);
 const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index bf1abeb..8cbc1ae 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -618,19 +618,16 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 0:
 			ovl->name = "gfx";
 			ovl->id = OMAP_DSS_GFX;
-			ovl->caps = 0;
 			ovl->info.global_alpha = 255;
 			break;
 		case 1:
 			ovl->name = "vid1";
 			ovl->id = OMAP_DSS_VIDEO1;
-			ovl->caps = OMAP_DSS_OVL_CAP_SCALE;
 			ovl->info.global_alpha = 255;
 			break;
 		case 2:
 			ovl->name = "vid2";
 			ovl->id = OMAP_DSS_VIDEO2;
-			ovl->caps = OMAP_DSS_OVL_CAP_SCALE;
 			ovl->info.global_alpha = 255;
 			break;
 		}
@@ -641,6 +638,7 @@ void dss_init_overlays(struct platform_device *pdev)
 		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
 		ovl->wait_for_go = &dss_ovl_wait_for_go;
 
+		ovl->caps = dss_feat_get_overlay_caps(ovl->id);
 		ovl->supported_modes =
 			dss_feat_get_supported_color_modes(ovl->id);
 
-- 
1.7.4.1

