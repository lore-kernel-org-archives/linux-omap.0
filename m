From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Clean up DISPC color mode validation checks
Date: Thu, 25 Nov 2010 17:58:10 +0530
Message-ID: <1290688090-27319-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54380 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0KYM2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 07:28:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The supported set of color modes varies for different DISPC pipelines(plane)
and omap version. This makes the checks for validation of a color mode more
complicated as new omap versions are added.

A dss_feature function is created which tells if a color_mode is supported
for a plane on the current omap revision.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   53 +++-----------------------------
 drivers/video/omap2/dss/dss_features.c |    7 ++++
 drivers/video/omap2/dss/dss_features.h |    2 +
 3 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1863bce..9f8c69f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1640,29 +1640,12 @@ static int _dispc_setup_plane(enum omap_plane plane,
 				height, pos_y, out_height);
 	}
 
+	if (!dss_feat_color_mode_supported(plane, color_mode))
+		return -EINVAL;
+
 	if (plane == OMAP_DSS_GFX) {
 		if (width != out_width || height != out_height)
 			return -EINVAL;
-
-		switch (color_mode) {
-		case OMAP_DSS_COLOR_ARGB16:
-		case OMAP_DSS_COLOR_ARGB32:
-		case OMAP_DSS_COLOR_RGBA32:
-			if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
-				return -EINVAL;
-		case OMAP_DSS_COLOR_RGBX32:
-			if (cpu_is_omap24xx())
-				return -EINVAL;
-			/* fall through */
-		case OMAP_DSS_COLOR_RGB12U:
-		case OMAP_DSS_COLOR_RGB16:
-		case OMAP_DSS_COLOR_RGB24P:
-		case OMAP_DSS_COLOR_RGB24U:
-			break;
-
-		default:
-			return -EINVAL;
-		}
 	} else {
 		/* video plane */
 
@@ -1676,35 +1659,9 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		   out_height > height * 8)
 			return -EINVAL;
 
-		switch (color_mode) {
-		case OMAP_DSS_COLOR_RGBX32:
-		case OMAP_DSS_COLOR_RGB12U:
-			if (cpu_is_omap24xx())
-				return -EINVAL;
-			/* fall through */
-		case OMAP_DSS_COLOR_RGB16:
-		case OMAP_DSS_COLOR_RGB24P:
-		case OMAP_DSS_COLOR_RGB24U:
-			break;
-
-		case OMAP_DSS_COLOR_ARGB16:
-		case OMAP_DSS_COLOR_ARGB32:
-		case OMAP_DSS_COLOR_RGBA32:
-			if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
-				return -EINVAL;
-			if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
-					plane == OMAP_DSS_VIDEO1)
-				return -EINVAL;
-			break;
-
-		case OMAP_DSS_COLOR_YUV2:
-		case OMAP_DSS_COLOR_UYVY:
+		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY)
 			cconv = 1;
-			break;
-
-		default:
-			return -EINVAL;
-		}
 
 		/* Must use 5-tap filter? */
 		five_taps = height > out_height * 2;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8ab54ab..63589fa 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -216,6 +216,13 @@ enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
 	return omap_current_dss_features->supported_color_modes[plane];
 }
 
+bool dss_feat_color_mode_supported(enum omap_plane plane,
+		enum omap_color_mode color_mode)
+{
+	return omap_current_dss_features->supported_color_modes[plane] &
+			color_mode;
+}
+
 /* DSS has_feature check */
 bool dss_has_feature(enum dss_feat_id id)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 161d378..b9c70be 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -49,6 +49,8 @@ int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
+bool dss_feat_color_mode_supported(enum omap_plane plane,
+		enum omap_color_mode color_mode);
 
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
-- 
1.7.0.4

