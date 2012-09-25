From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 09/18] OMAPDSS: DISPC: Add writeback register offsets and dss features structs
Date: Tue, 25 Sep 2012 11:49:44 +0530
Message-ID: <1348553993-8083-10-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48595 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab2IYGUX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:23 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Since writeback has many overlay like properties, and most of it's registers are
similar to that of overlays, it's possible to reuse most of the overlay related
DISPC code for writeback when considering it as a plane. Writeback was added as
a plane in the omap_plane field as OMAP_DSS_WB.

Add the writeback register offsets in dispc.h, add minimal WB plane related info
needed in dss_features. Add a function which returns the number of writeback
pipelines an OMAP version has.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.h        |   33 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |   19 ++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 53 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 42e56cc..222363c 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -373,6 +373,7 @@ static inline u16 DISPC_BA0_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0000;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0008;
 	default:
 		BUG();
@@ -388,6 +389,7 @@ static inline u16 DISPC_BA1_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0004;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x000C;
 	default:
 		BUG();
@@ -407,6 +409,8 @@ static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane plane)
 		return 0x04BC;
 	case OMAP_DSS_VIDEO3:
 		return 0x0310;
+	case OMAP_DSS_WB:
+		return 0x0118;
 	default:
 		BUG();
 		return 0;
@@ -425,6 +429,8 @@ static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane plane)
 		return 0x04C0;
 	case OMAP_DSS_VIDEO3:
 		return 0x0314;
+	case OMAP_DSS_WB:
+		return 0x011C;
 	default:
 		BUG();
 		return 0;
@@ -454,6 +460,7 @@ static inline u16 DISPC_SIZE_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x000C;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x00A8;
 	default:
 		BUG();
@@ -470,6 +477,7 @@ static inline u16 DISPC_ATTR_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0010;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0070;
 	default:
 		BUG();
@@ -489,6 +497,8 @@ static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane plane)
 		return 0x04DC;
 	case OMAP_DSS_VIDEO3:
 		return 0x032C;
+	case OMAP_DSS_WB:
+		return 0x0310;
 	default:
 		BUG();
 		return 0;
@@ -504,6 +514,7 @@ static inline u16 DISPC_FIFO_THRESH_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0014;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x008C;
 	default:
 		BUG();
@@ -537,6 +548,7 @@ static inline u16 DISPC_ROW_INC_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x001C;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x00A4;
 	default:
 		BUG();
@@ -553,6 +565,7 @@ static inline u16 DISPC_PIX_INC_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0020;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0098;
 	default:
 		BUG();
@@ -602,6 +615,7 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0024;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0090;
 	default:
 		BUG();
@@ -621,6 +635,8 @@ static inline u16 DISPC_FIR2_OFFSET(enum omap_plane plane)
 		return 0x055C;
 	case OMAP_DSS_VIDEO3:
 		return 0x0424;
+	case OMAP_DSS_WB:
+		return 0x290;
 	default:
 		BUG();
 		return 0;
@@ -637,6 +653,7 @@ static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0028;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0094;
 	default:
 		BUG();
@@ -655,6 +672,7 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x002C;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0000;
 	default:
 		BUG();
@@ -674,6 +692,8 @@ static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane plane)
 		return 0x0560;
 	case OMAP_DSS_VIDEO3:
 		return 0x0428;
+	case OMAP_DSS_WB:
+		return 0x0294;
 	default:
 		BUG();
 		return 0;
@@ -690,6 +710,7 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0030;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0004;
 	default:
 		BUG();
@@ -709,6 +730,8 @@ static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane plane)
 		return 0x0564;
 	case OMAP_DSS_VIDEO3:
 		return 0x042C;
+	case OMAP_DSS_WB:
+		return 0x0298;
 	default:
 		BUG();
 		return 0;
@@ -726,6 +749,7 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO2:
 		return 0x0034 + i * 0x8;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0010 + i * 0x8;
 	default:
 		BUG();
@@ -746,6 +770,8 @@ static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0568 + i * 0x8;
 	case OMAP_DSS_VIDEO3:
 		return 0x0430 + i * 0x8;
+	case OMAP_DSS_WB:
+		return 0x02A0 + i * 0x8;
 	default:
 		BUG();
 		return 0;
@@ -763,6 +789,7 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO2:
 		return 0x0038 + i * 0x8;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0014 + i * 0x8;
 	default:
 		BUG();
@@ -783,6 +810,8 @@ static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x056C + i * 0x8;
 	case OMAP_DSS_VIDEO3:
 		return 0x0434 + i * 0x8;
+	case OMAP_DSS_WB:
+		return 0x02A4 + i * 0x8;
 	default:
 		BUG();
 		return 0;
@@ -799,6 +828,7 @@ static inline u16 DISPC_CONV_COEF_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0074 + i * 0x4;
 	default:
 		BUG();
@@ -818,6 +848,7 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO2:
 		return 0x00B4 + i * 0x4;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0050 + i * 0x4;
 	default:
 		BUG();
@@ -838,6 +869,8 @@ static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x05A8 + i * 0x4;
 	case OMAP_DSS_VIDEO3:
 		return 0x0470 + i * 0x4;
+	case OMAP_DSS_WB:
+		return 0x02E0 + i * 0x4;
 	default:
 		BUG();
 		return 0;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8b6c79f..5968fd8 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -46,6 +46,7 @@ struct omap_dss_features {
 
 	const int num_mgrs;
 	const int num_ovls;
+	const int num_wbs;
 	const enum omap_display_type *supported_displays;
 	const enum omap_dss_output_id *supported_outputs;
 	const enum omap_color_mode *supported_color_modes;
@@ -265,6 +266,16 @@ static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
 	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
 	OMAP_DSS_COLOR_RGBX32,
+
+	/* OMAP_DSS_WB */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
+	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
+	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
+	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
+	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
+	OMAP_DSS_COLOR_RGBX32,
 };
 
 static const enum omap_overlay_caps omap2_dss_overlay_caps[] = {
@@ -576,6 +587,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
+	.num_wbs = 1,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_outputs = omap4_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
@@ -597,6 +609,7 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
+	.num_wbs = 1,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_outputs = omap4_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
@@ -618,6 +631,7 @@ static const struct omap_dss_features omap4_dss_features = {
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
+	.num_wbs = 1,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_outputs = omap4_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
@@ -674,6 +688,11 @@ int dss_feat_get_num_ovls(void)
 	return omap_current_dss_features->num_ovls;
 }
 
+int dss_feat_get_num_wbs(void)
+{
+	return omap_current_dss_features->num_wbs;
+}
+
 unsigned long dss_feat_get_param_min(enum dss_range_param param)
 {
 	return omap_current_dss_features->dss_params[param].min;
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index fb8ed59..66fd9f7 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -102,6 +102,7 @@ enum dss_range_param {
 /* DSS Feature Functions */
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
+int dss_feat_get_num_wbs(void);
 unsigned long dss_feat_get_param_min(enum dss_range_param param);
 unsigned long dss_feat_get_param_max(enum dss_range_param param);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
-- 
1.7.9.5

