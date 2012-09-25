From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 04/18] OMAPDSS: OVERLAY: Add position and replication as overlay caps
Date: Tue, 25 Sep 2012 11:49:39 +0530
Message-ID: <1348553993-8083-5-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50205 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab2IYGUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 02:20:08 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add position and replication as overlay caps, and pass overlay caps as an
argument to the corresponding functions. Adding position and replication to
overlay caps seems a bit unnecessary, but it allows us to use the
corresponding functions for writeback too.

These caps will be set for all overlays, but not for writeback. This is done
so writeback can reuse dispc_ovl_setup() to the maximum.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   20 ++++++++++++-----
 drivers/video/omap2/dss/dss_features.c |   38 +++++++++++++++++++++-----------
 include/video/omapdss.h                |    2 ++
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 955db56..0ff1c07 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -698,9 +698,15 @@ static void dispc_ovl_set_ba1_uv(enum omap_plane plane, u32 paddr)
 	dispc_write_reg(DISPC_OVL_BA1_UV(plane), paddr);
 }
 
-static void dispc_ovl_set_pos(enum omap_plane plane, int x, int y)
+static void dispc_ovl_set_pos(enum omap_plane plane,
+		enum omap_overlay_caps caps, int x, int y)
 {
-	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
+	u32 val;
+
+	if ((caps & OMAP_DSS_OVL_CAP_POS) == 0)
+		return;
+
+	val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
 
 	dispc_write_reg(DISPC_OVL_POSITION(plane), val);
 }
@@ -1051,11 +1057,15 @@ static void dispc_ovl_set_vid_color_conv(enum omap_plane plane, bool enable)
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-static void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
+static void dispc_ovl_enable_replication(enum omap_plane plane,
+		enum omap_overlay_caps caps, bool enable)
 {
 	static const unsigned shifts[] = { 5, 10, 10, 10 };
 	int shift;
 
+	if ((caps & OMAP_DSS_OVL_CAP_REPLICATION) == 0)
+		return;
+
 	shift = shifts[plane];
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, shift, shift);
 }
@@ -2383,7 +2393,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, in_width,
 			in_height, out_width, out_height);
 
-	dispc_ovl_set_pos(plane, oi->pos_x, pos_y);
+	dispc_ovl_set_pos(plane, caps, oi->pos_x, pos_y);
 
 	dispc_ovl_set_input_size(plane, in_width, in_height);
 
@@ -2403,7 +2413,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	dispc_ovl_set_pre_mult_alpha(plane, caps, oi->pre_mult_alpha);
 	dispc_ovl_setup_global_alpha(plane, caps, oi->global_alpha);
 
-	dispc_ovl_enable_replication(plane, replication);
+	dispc_ovl_enable_replication(plane, caps, replication);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 63d109f..8b6c79f 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -269,54 +269,66 @@ static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
 
 static const enum omap_overlay_caps omap2_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
-	0,
+	OMAP_DSS_OVL_CAP_POS | OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO1 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO2 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 };
 
 static const enum omap_overlay_caps omap3430_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
-	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA,
+	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO1 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO2 */
-	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
+		OMAP_DSS_OVL_CAP_POS | OMAP_DSS_OVL_CAP_REPLICATION,
 };
 
 static const enum omap_overlay_caps omap3630_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
-	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA | OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
+	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA | OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA |
+		OMAP_DSS_OVL_CAP_POS | OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO1 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO2 */
 	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
-		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 };
 
 static const enum omap_overlay_caps omap4_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
 	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA | OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA |
-		OMAP_DSS_OVL_CAP_ZORDER,
+		OMAP_DSS_OVL_CAP_ZORDER | OMAP_DSS_OVL_CAP_POS |
+		OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO1 */
 	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
-		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER,
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER |
+		OMAP_DSS_OVL_CAP_POS | OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO2 */
 	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
-		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER,
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER |
+		OMAP_DSS_OVL_CAP_POS | OMAP_DSS_OVL_CAP_REPLICATION,
 
 	/* OMAP_DSS_VIDEO3 */
 	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
-		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER,
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER |
+		OMAP_DSS_OVL_CAP_POS | OMAP_DSS_OVL_CAP_REPLICATION,
 };
 
 static const char * const omap2_dss_clk_source_names[] = {
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e65e2e9..46097bd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -187,6 +187,8 @@ enum omap_overlay_caps {
 	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA = 1 << 1,
 	OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA = 1 << 2,
 	OMAP_DSS_OVL_CAP_ZORDER = 1 << 3,
+	OMAP_DSS_OVL_CAP_POS = 1 << 4,
+	OMAP_DSS_OVL_CAP_REPLICATION = 1 << 5,
 };
 
 enum omap_overlay_manager_caps {
-- 
1.7.9.5

