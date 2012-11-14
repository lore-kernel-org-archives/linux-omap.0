From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/2] OMAPDSS: Add overlay manager width and height limits as a dispc feature
Date: Wed, 14 Nov 2012 13:50:15 +0530
Message-ID: <1352881216-7490-2-git-send-email-archit@ti.com>
References: <1352881216-7490-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187Ab2KNIUp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 03:20:45 -0500
In-Reply-To: <1352881216-7490-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The overlay manager width and height vary in OMAP5 vary from previous OMAPs in
terms of maximum limit and register field positions. Add parameters in
dispc_features for these. Remove params related to manager width and height from
dss_features. We do this because we want to maintain a feature list for
individual IPs.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   28 +++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss_features.c |    8 --------
 drivers/video/omap2/dss/dss_features.h |    2 --
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index bab9d6b..29e6aa1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -87,6 +87,10 @@ struct dispc_features {
 	u16 sw_max;
 	u16 vp_max;
 	u16 hp_max;
+	u8 mgr_width_start;
+	u8 mgr_height_start;
+	u16 mgr_width_max;
+	u16 mgr_height_max;
 	int (*calc_scaling) (enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
@@ -1128,7 +1132,9 @@ static void dispc_mgr_set_size(enum omap_channel channel, u16 width,
 {
 	u32 val;
 
-	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
+	val = FLD_VAL(height - 1, dispc.feat->mgr_height_start, 16) |
+		FLD_VAL(width - 1, dispc.feat->mgr_width_start, 0);
+
 	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
 }
 
@@ -2985,8 +2991,8 @@ void dispc_mgr_set_lcd_config(enum omap_channel channel,
 
 static bool _dispc_mgr_size_ok(u16 width, u16 height)
 {
-	return width <= dss_feat_get_param_max(FEAT_PARAM_MGR_WIDTH) &&
-		height <= dss_feat_get_param_max(FEAT_PARAM_MGR_HEIGHT);
+	return width <= dispc.feat->mgr_width_max &&
+		height <= dispc.feat->mgr_height_max;
 }
 
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
@@ -4067,6 +4073,10 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.sw_max			=	64,
 	.vp_max			=	255,
 	.hp_max			=	256,
+	.mgr_width_start	=	10,
+	.mgr_height_start	=	26,
+	.mgr_width_max		=	2048,
+	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
 	.calc_core_clk		=	calc_core_clk_24xx,
 	.num_fifos		=	3,
@@ -4079,6 +4089,10 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.sw_max			=	64,
 	.vp_max			=	255,
 	.hp_max			=	256,
+	.mgr_width_start	=	10,
+	.mgr_height_start	=	26,
+	.mgr_width_max		=	2048,
+	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
@@ -4091,6 +4105,10 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.sw_max			=	256,
 	.vp_max			=	4095,
 	.hp_max			=	4096,
+	.mgr_width_start	=	10,
+	.mgr_height_start	=	26,
+	.mgr_width_max		=	2048,
+	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
@@ -4103,6 +4121,10 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.sw_max			=	256,
 	.vp_max			=	4095,
 	.hp_max			=	4096,
+	.mgr_width_start	=	10,
+	.mgr_height_start	=	26,
+	.mgr_width_max		=	2048,
+	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8dcecbc..1d125c6 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -429,8 +429,6 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 	 * scaler cannot scale a image with width more than 768.
 	 */
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 768 },
-	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
-	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const struct dss_param_range omap3_dss_param_range[] = {
@@ -445,8 +443,6 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
-	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
-	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const struct dss_param_range omap4_dss_param_range[] = {
@@ -461,8 +457,6 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
-	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
-	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const struct dss_param_range omap5_dss_param_range[] = {
@@ -477,8 +471,6 @@ static const struct dss_param_range omap5_dss_param_range[] = {
 	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
-	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
-	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const enum dss_feat_id omap2_dss_feat_list[] = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index fc492ef..385b0af 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -98,8 +98,6 @@ enum dss_range_param {
 	FEAT_PARAM_DSI_FCK,
 	FEAT_PARAM_DOWNSCALE,
 	FEAT_PARAM_LINEWIDTH,
-	FEAT_PARAM_MGR_WIDTH,
-	FEAT_PARAM_MGR_HEIGHT,
 };
 
 /* DSS Feature Functions */
-- 
1.7.9.5

