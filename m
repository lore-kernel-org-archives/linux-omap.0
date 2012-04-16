From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DISPC: Clean up manager timing/size functions
Date: Mon, 16 Apr 2012 12:53:44 +0530
Message-ID: <1334561027-28569-4-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765Ab2DPHYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 03:24:32 -0400
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Clean up the DISPC manager timings related function by:

- Create a common function to set size for LCD and TV.
- Create a common function to check timings for LCD and TV.
- Add dss params to get the range of manager size.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   47 +++++++++++++++++--------------
 drivers/video/omap2/dss/dpi.c          |    2 +-
 drivers/video/omap2/dss/dss.h          |    3 +-
 drivers/video/omap2/dss/dss_features.c |    6 ++++
 drivers/video/omap2/dss/dss_features.h |    2 +
 5 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f1e5337..46bcb55 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -983,21 +983,13 @@ static void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, shift, shift);
 }
 
-static void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width,
+static void dispc_mgr_set_size(enum omap_channel channel, u16 width,
 		u16 height)
 {
 	u32 val;
-	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
-	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
-}
 
-static void dispc_mgr_set_digit_size(u16 width, u16 height)
-{
-	u32 val;
-	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	dispc_write_reg(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT), val);
+	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
 }
 
 static void dispc_read_plane_fifo_sizes(void)
@@ -2286,6 +2278,12 @@ void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable)
 		REG_FLD_MOD(DISPC_CONTROL, enable, 11, 11);
 }
 
+static bool _dispc_mgr_size_ok(u16 width, u16 height)
+{
+	return width <= dss_feat_get_param_max(FEAT_PARAM_MGR_WIDTH) &&
+		height <= dss_feat_get_param_max(FEAT_PARAM_MGR_HEIGHT);
+}
+
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
 		int vsw, int vfp, int vbp)
 {
@@ -2310,11 +2308,20 @@ static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
 	return true;
 }
 
-bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
+bool dispc_mgr_timings_ok(enum omap_channel channel,
+		struct omap_video_timings *timings)
 {
-	return _dispc_lcd_timings_ok(timings->hsw, timings->hfp,
-			timings->hbp, timings->vsw,
-			timings->vfp, timings->vbp);
+	bool timings_ok;
+
+	timings_ok = _dispc_mgr_size_ok(timings->x_res, timings->y_res);
+
+	if (dispc_mgr_is_lcd(channel))
+		timings_ok =  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
+						timings->hfp, timings->hbp,
+						timings->vsw, timings->vfp,
+						timings->vbp);
+
+	return timings_ok;
 }
 
 static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
@@ -2350,16 +2357,14 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 	DSSDBG("channel %d xres %u yres %u\n", channel, timings->x_res,
 			timings->y_res);
 
-	if (dispc_mgr_is_lcd(channel)) {
-		if (!dispc_lcd_timings_ok(timings))
-			BUG();
+	if (!dispc_mgr_timings_ok(channel, timings))
+		BUG();
 
+	if (dispc_mgr_is_lcd(channel)) {
 		_dispc_mgr_set_lcd_timings(channel, timings->hsw, timings->hfp,
 				timings->hbp, timings->vsw, timings->vfp,
 				timings->vbp);
 
-		dispc_mgr_set_lcd_size(channel, timings->x_res, timings->y_res);
-
 		xtot = timings->x_res + timings->hfp + timings->hsw +
 				timings->hbp;
 		ytot = timings->y_res + timings->vfp + timings->vsw +
@@ -2374,9 +2379,9 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 			timings->vsw, timings->vfp, timings->vbp);
 
 		DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
-	} else {
-		dispc_mgr_set_digit_size(timings->x_res, timings->y_res);
 	}
+
+	dispc_mgr_set_size(channel, timings->x_res, timings->y_res);
 }
 
 static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 7dd7f9d..cec1166 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -312,7 +312,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	struct dispc_clock_info dispc_cinfo;
 
-	if (!dispc_lcd_timings_ok(timings))
+	if (!dispc_mgr_timings_ok(dssdev->manager->id, timings))
 		return -EINVAL;
 
 	if (timings->pixel_clock == 0)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index da91822..1dc336b 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -411,7 +411,8 @@ void dispc_enable_fifomerge(bool enable);
 void dispc_enable_gamma_table(bool enable);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
-bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
+bool dispc_mgr_timings_ok(enum omap_channel channel,
+		struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
 void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index ce14aa6..1d10a01 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -311,6 +311,8 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 	 * scaler cannot scale a image with width more than 768.
 	 */
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 768 },
+	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
+	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const struct dss_param_range omap3_dss_param_range[] = {
@@ -324,6 +326,8 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
+	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
+	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const struct dss_param_range omap4_dss_param_range[] = {
@@ -337,6 +341,8 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
+	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
+	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
 static const enum dss_feat_id omap2_dss_feat_list[] = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index c332e7d..3736367 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -91,6 +91,8 @@ enum dss_range_param {
 	FEAT_PARAM_DSIPLL_LPDIV,
 	FEAT_PARAM_DOWNSCALE,
 	FEAT_PARAM_LINEWIDTH,
+	FEAT_PARAM_MGR_WIDTH,
+	FEAT_PARAM_MGR_HEIGHT,
 };
 
 /* DSS Feature Functions */
-- 
1.7.5.4

