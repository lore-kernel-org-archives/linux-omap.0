From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/10] OMAP2PLUS: DSS2: Clean up DISPC scaling related clock and five tap calculations
Date: Wed, 14 Sep 2011 17:55:13 +0530
Message-ID: <1316003114-24291-6-git-send-email-archit@ti.com>
References: <1316003114-24291-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab1INMYe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:24:34 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECOXpM015713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:33 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECOX8n021779
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:33 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECOXXn001481
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:33 -0500 (CDT)
In-Reply-To: <1316003114-24291-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Move DISPC scaling related code from dispc_ovl_setup() to a new function
dispc_ovl_calc_scaling(). Use overlay caps to check if the overlay can scale or
not. No functional changes are made.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  131 ++++++++++++++++++++++-----------------
 1 files changed, 73 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 307e70e..9f36db7 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1710,14 +1710,74 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 	return dispc_mgr_pclk_rate(channel) * vf * hf;
 }
 
+static int dispc_ovl_calc_scaling(enum omap_plane plane,
+		enum omap_channel channel, u16 width, u16 height,
+		u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, bool *five_taps)
+{
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
+	unsigned long fclk = 0;
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
+		if (width != out_width || height != out_height)
+			return -EINVAL;
+		else
+			return 0;
+	}
+
+	if (out_width < width / maxdownscale ||
+			out_width > width * 8)
+		return -EINVAL;
+
+	if (out_height < height / maxdownscale ||
+			out_height > height * 8)
+		return -EINVAL;
+
+	/* Must use 5-tap filter? */
+	*five_taps = height > out_height * 2;
+
+	if (!*five_taps) {
+		fclk = calc_fclk(channel, width, height, out_width,
+				out_height);
+
+		/* Try 5-tap filter if 3-tap fclk is too high */
+		if (cpu_is_omap34xx() && height > out_height &&
+				fclk > dispc_fclk_rate())
+			*five_taps = true;
+	}
+
+	if (width > (2048 >> *five_taps)) {
+		DSSERR("failed to set up scaling, fclk too low\n");
+		return -EINVAL;
+	}
+
+	if (*five_taps)
+		fclk = calc_fclk_five_taps(channel, width, height,
+				out_width, out_height, color_mode);
+
+	DSSDBG("required fclk rate = %lu Hz\n", fclk);
+	DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
+
+	if (!fclk || fclk > dispc_fclk_rate()) {
+		DSSERR("failed to set up scaling, "
+			"required fclk rate = %lu Hz, "
+			"current fclk rate = %lu Hz\n",
+			fclk, dispc_fclk_rate());
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		bool ilace, enum omap_channel channel, bool replication,
 		u32 fifo_low, u32 fifo_high)
 {
-	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
-	bool five_taps = 0;
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	bool five_taps;
 	bool fieldmode = 0;
-	int cconv = 0;
+	int r, cconv = 0;
 	unsigned offset0, offset1;
 	s32 row_inc;
 	s32 pix_inc;
@@ -1751,61 +1811,16 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
-	if (plane == OMAP_DSS_GFX) {
-		if (oi->width != oi->out_width || oi->height != oi->out_height)
-			return -EINVAL;
-	} else {
-		/* video plane */
-
-		unsigned long fclk = 0;
-
-		if (oi->out_width < oi->width / maxdownscale ||
-		   oi->out_width > oi->width * 8)
-			return -EINVAL;
-
-		if (oi->out_height < oi->height / maxdownscale ||
-		   oi->out_height > oi->height * 8)
-			return -EINVAL;
-
-		if (oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
-				oi->color_mode == OMAP_DSS_COLOR_UYVY ||
-				oi->color_mode == OMAP_DSS_COLOR_NV12)
-			cconv = 1;
-
-		/* Must use 5-tap filter? */
-		five_taps = oi->height > oi->out_height * 2;
-
-		if (!five_taps) {
-			fclk = calc_fclk(channel, oi->width, oi->height,
-					oi->out_width, oi->out_height);
-
-			/* Try 5-tap filter if 3-tap fclk is too high */
-			if (cpu_is_omap34xx() && oi->height > oi->out_height &&
-					fclk > dispc_fclk_rate())
-				five_taps = true;
-		}
-
-		if (oi->width > (2048 >> five_taps)) {
-			DSSERR("failed to set up scaling, fclk too low\n");
-			return -EINVAL;
-		}
-
-		if (five_taps)
-			fclk = calc_fclk_five_taps(channel, oi->width,
-					oi->height, oi->out_width,
-					oi->out_height, oi->color_mode);
-
-		DSSDBG("required fclk rate = %lu Hz\n", fclk);
-		DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
+	r = dispc_ovl_calc_scaling(plane, channel, oi->width, oi->height,
+			oi->out_width, oi->out_height, oi->color_mode,
+			&five_taps);
+	if (r)
+		return r;
 
-		if (!fclk || fclk > dispc_fclk_rate()) {
-			DSSERR("failed to set up scaling, "
-					"required fclk rate = %lu Hz, "
-					"current fclk rate = %lu Hz\n",
-					fclk, dispc_fclk_rate());
-			return -EINVAL;
-		}
-	}
+	if (oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
+			oi->color_mode == OMAP_DSS_COLOR_UYVY ||
+			oi->color_mode == OMAP_DSS_COLOR_NV12)
+		cconv = 1;
 
 	if (ilace && !fieldmode) {
 		/*
@@ -1860,7 +1875,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	dispc_ovl_set_pic_size(plane, oi->width, oi->height);
 
-	if (plane != OMAP_DSS_GFX) {
+	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_ovl_set_scaling(plane, oi->width, oi->height,
 				   oi->out_width, oi->out_height,
 				   ilace, five_taps, fieldmode,
-- 
1.7.1

