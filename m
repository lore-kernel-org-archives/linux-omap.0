From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 2/2] OMAPDSS: DISPC: Update Scaling Clock Logic
Date: Wed, 14 Dec 2011 10:22:06 +0530
Message-ID: <1323838326-4512-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755088Ab1LNEwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:52:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Clock requirements for scaling in OMAP2, OMAP3 and OMAP4 are different. In
OMAP2 and OMAP3 the required clock rate is a function of pixel clock, vertical
downscale ratio and horizontal downscale ratio whereas in OMAP4 it is a
function of pixel clock and horizontal downscale ratio only. Selection of 3-tap
vs 5-tap coefficients depends on clock rate line buffer width in OMAP3 whereas
in OMAP4 it is independent of clock rate and line buffer width. In OMAP2 3-tap
for vertical and 5-tap for horizontal scaling is used. In OMAP4 5-tap is used
both for horizontal and vertical scaling for better performance. Also, the
number and width of line buffers differs in OMAP3 and OMAP4.

So, clock functions have been fined tuned for OMAP3 and support has been added
added for OMAP4. This code has been tested on OMAP2, OMAP3 and OMAP4, and
scaling issues due to clock errors have been resolved.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   66 ++++++++++++++++++++++----------
 drivers/video/omap2/dss/dss_features.c |    7 +++
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b981983..6c3feb4 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1554,6 +1554,9 @@ static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
 	u32 fclk = 0;
 	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
 
+	if (height <= out_height && width <= out_width)
+		return (unsigned long) pclk;
+
 	if (height > out_height) {
 		struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
 		unsigned int ppl = dssdev->panel.timings.x_res;
@@ -1608,7 +1611,16 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 	else
 		vf = 1;
 
-	return dispc_mgr_pclk_rate(channel) * vf * hf;
+	if (cpu_is_omap24xx()) {
+		if (vf > 1 && hf > 1)
+			return dispc_mgr_pclk_rate(channel) * 4;
+		else
+			return dispc_mgr_pclk_rate(channel) * 2;
+	} else if (cpu_is_omap34xx()) {
+		return dispc_mgr_pclk_rate(channel) * vf * hf;
+	} else {
+		return dispc_mgr_pclk_rate(channel) * hf;
+	}
 }
 
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
@@ -1618,6 +1630,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
+	const int maxsinglelinewidth =
+				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	unsigned long fclk = 0;
 
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
@@ -1635,28 +1649,40 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 			out_height > height * 8)
 		return -EINVAL;
 
-	/* Must use 5-tap filter? */
-	*five_taps = height > out_height * 2;
-
-	if (!*five_taps) {
+	if (cpu_is_omap24xx()) {
+		if (width > maxsinglelinewidth)
+			DSSERR("Cannot scale max input width exceeded");
+		*five_taps = false;
+		fclk = calc_fclk(channel, width, height, out_width,
+								out_height);
+	} else if (cpu_is_omap34xx()) {
+		if (width > (maxsinglelinewidth * 2)) {
+			DSSERR("Cannot setup scaling");
+			DSSERR("width exceeds maximum width possible");
+			return -EINVAL;
+		}
+		fclk = calc_fclk_five_taps(channel, width, height, out_width,
+						out_height, color_mode);
+		if (width > maxsinglelinewidth) {
+			if (height > out_height && height < out_height * 2)
+				*five_taps = false;
+			else {
+				DSSERR("cannot setup scaling with five taps");
+				return -EINVAL;
+			}
+		}
+		if (!*five_taps)
+			fclk = calc_fclk(channel, width, height, out_width,
+					out_height);
+	} else {
+		if (width > maxsinglelinewidth) {
+			DSSERR("Cannot scale width exceeds max line width");
+			return -EINVAL;
+		}
 		fclk = calc_fclk(channel, width, height, out_width,
 				out_height);
-
-		/* Try 5-tap filter if 3-tap fclk is too high */
-		if (cpu_is_omap34xx() && height > out_height &&
-				fclk > dispc_fclk_rate())
-			*five_taps = true;
 	}
 
-	if (width > (2048 >> *five_taps)) {
-		DSSERR("failed to set up scaling, fclk too low\n");
-		return -EINVAL;
-	}
-
-	if (*five_taps)
-		fclk = calc_fclk_five_taps(channel, width, height,
-				out_width, out_height, color_mode);
-
 	DSSDBG("required fclk rate = %lu Hz\n", fclk);
 	DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
 
@@ -1676,7 +1702,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		u32 fifo_low, u32 fifo_high)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-	bool five_taps = false;
+	bool five_taps = true;
 	bool fieldmode = 0;
 	int r, cconv = 0;
 	unsigned offset0, offset1;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b402699..5e4b829 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -304,6 +304,11 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_FINT]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, 0 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 2 },
+	/*
+	 * Assuming the line width buffer to be 768 pixels as OMAP2 DISPC
+	 * scaler cannot scale a image with width more than 768.
+	 */
+	[FEAT_PARAM_LINEWIDTH]			= { 1, 768 },
 };
 
 static const struct dss_param_range omap3_dss_param_range[] = {
@@ -316,6 +321,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
+	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
 };
 
 static const struct dss_param_range omap4_dss_param_range[] = {
@@ -328,6 +334,7 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
+	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 };
 
 /* OMAP2 DSS Features */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 6a6c05d..cd833bb 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -86,6 +86,7 @@ enum dss_range_param {
 	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
 	FEAT_PARAM_DOWNSCALE,
+	FEAT_PARAM_LINEWIDTH,
 };
 
 /* DSS Feature Functions */
-- 
1.7.1

