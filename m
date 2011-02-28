From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Use dss_features for DISPC overlay code cleanup
Date: Mon, 28 Feb 2011 12:11:51 +0530
Message-ID: <1298875311-5870-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53412 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab1B1GjP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:39:15 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6dFHG013762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:39:15 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add dss_features and register fields to incorporate changes in DISPC pipelines
between OMAP3 and OMAP4.

Register fields added: FEAT_REG_HORIZONTALACCU, FEAT_REG_VERTICALACCU
DSS Features added: FEAT_LINEBUFFERSPLIT, FEAT_ROWREPEATENABLE, FEAT_RESIZECONF

_dispc_set_scaling() and _dispc_set_rotation_attrs() have been cleaned up.

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note:
Patch can be tested on:
http://dev.omapzoom.org/?p=axelcx/kernel-display.git;a=shortlog;h=refs/heads/lo-dss2-Feb25

 drivers/video/omap2/dss/dispc.c        |   52 ++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss_features.c |   31 +++++++++++++++----
 drivers/video/omap2/dss/dss_features.h |    5 +++
 3 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a34ca69..0b6bbd1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1137,10 +1137,16 @@ static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 	u32 val;
 	const struct dispc_reg ac0_reg[] = { DISPC_VID_ACCU0(0),
 				      DISPC_VID_ACCU0(1) };
+	u8 hor_start, hor_end, vert_start, vert_end;
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
+	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
+	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
+
+	val = FLD_VAL(vaccu, vert_start, vert_end) |
+			FLD_VAL(haccu, hor_start, hor_end);
+
 	dispc_write_reg(ac0_reg[plane-1], val);
 }
 
@@ -1149,10 +1155,16 @@ static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 	u32 val;
 	const struct dispc_reg ac1_reg[] = { DISPC_VID_ACCU1(0),
 				      DISPC_VID_ACCU1(1) };
+	u8 hor_start, hor_end, vert_start, vert_end;
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
+	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
+	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
+
+	val = FLD_VAL(vaccu, vert_start, vert_end) |
+			FLD_VAL(haccu, hor_start, hor_end);
+
 	dispc_write_reg(ac1_reg[plane-1], val);
 }
 
@@ -1190,16 +1202,25 @@ static void _dispc_set_scaling(enum omap_plane plane,
 	_dispc_set_fir(plane, fir_hinc, fir_vinc);
 
 	l = dispc_read_reg(dispc_reg_att[plane]);
-	l &= ~((0x0f << 5) | (0x3 << 21));
 
+	/* RESIZEENABLE and VERTICALTAPS */
+	l &= ~((0x3 << 5) | (0x1 << 21));
 	l |= fir_hinc ? (1 << 5) : 0;
 	l |= fir_vinc ? (1 << 6) : 0;
+	l |= five_taps ? (1 << 21) : 0;
 
-	l |= hscaleup ? 0 : (1 << 7);
-	l |= vscaleup ? 0 : (1 << 8);
+	/* VRESIZECONF and HRESIZECONF */
+	if (dss_has_feature(FEAT_RESIZECONF)) {
+		l &= ~(0x3 << 7);
+		l |= hscaleup ? 0 : (1 << 7);
+		l |= vscaleup ? 0 : (1 << 8);
+	}
 
-	l |= five_taps ? (1 << 21) : 0;
-	l |= five_taps ? (1 << 22) : 0;
+	/* LINEBUFFERSPLIT */
+	if (dss_has_feature(FEAT_LINEBUFFERSPLIT)) {
+		l &= ~(0x1 << 22);
+		l |= five_taps ? (1 << 22) : 0;
+	}
 
 	dispc_write_reg(dispc_reg_att[plane], l);
 
@@ -1223,9 +1244,11 @@ static void _dispc_set_scaling(enum omap_plane plane,
 static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 		bool mirroring, enum omap_color_mode color_mode)
 {
+	bool row_repeat = false;
+	int vidrot = 0;
+
 	if (color_mode == OMAP_DSS_COLOR_YUV2 ||
 			color_mode == OMAP_DSS_COLOR_UYVY) {
-		int vidrot = 0;
 
 		if (mirroring) {
 			switch (rotation) {
@@ -1259,16 +1282,15 @@ static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 			}
 		}
 
-		REG_FLD_MOD(dispc_reg_att[plane], vidrot, 13, 12);
-
 		if (rotation == OMAP_DSS_ROT_90 || rotation == OMAP_DSS_ROT_270)
-			REG_FLD_MOD(dispc_reg_att[plane], 0x1, 18, 18);
+			row_repeat = true;
 		else
-			REG_FLD_MOD(dispc_reg_att[plane], 0x0, 18, 18);
-	} else {
-		REG_FLD_MOD(dispc_reg_att[plane], 0, 13, 12);
-		REG_FLD_MOD(dispc_reg_att[plane], 0, 18, 18);
+			row_repeat = false;
 	}
+
+	REG_FLD_MOD(dispc_reg_att[plane], vidrot, 13, 12);
+	if (dss_has_feature(FEAT_ROWREPEATENABLE))
+		REG_FLD_MOD(dispc_reg_att[plane], row_repeat ? 1 : 0, 18, 18);
 }
 
 static int color_mode_to_bpp(enum omap_color_mode color_mode)
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 0f2e6a9..f6f319d 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -54,6 +54,8 @@ static const struct dss_reg_field omap2_dss_reg_fields[] = {
 	{ FEAT_REG_FIFOLOWTHRESHOLD, 8, 0 },
 	{ FEAT_REG_FIFOHIGHTHRESHOLD, 24, 16 },
 	{ FEAT_REG_FIFOSIZE, 8, 0 },
+	{ FEAT_REG_HORIZONTALACCU, 9, 0 },
+	{ FEAT_REG_VERTICALACCU, 25, 16 },
 };
 
 static const struct dss_reg_field omap3_dss_reg_fields[] = {
@@ -62,6 +64,18 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
 	{ FEAT_REG_FIFOLOWTHRESHOLD, 11, 0 },
 	{ FEAT_REG_FIFOHIGHTHRESHOLD, 27, 16 },
 	{ FEAT_REG_FIFOSIZE, 10, 0 },
+	{ FEAT_REG_HORIZONTALACCU, 9, 0 },
+	{ FEAT_REG_VERTICALACCU, 25, 16 },
+};
+
+static const struct dss_reg_field omap4_dss_reg_fields[] = {
+	{ FEAT_REG_FIRHINC, 12, 0 },
+	{ FEAT_REG_FIRVINC, 28, 16 },
+	{ FEAT_REG_FIFOLOWTHRESHOLD, 15, 0 },
+	{ FEAT_REG_FIFOHIGHTHRESHOLD, 31, 16 },
+	{ FEAT_REG_FIFOSIZE, 15, 0 },
+	{ FEAT_REG_HORIZONTALACCU, 10, 0 },
+	{ FEAT_REG_VERTICALACCU, 26, 16 },
 };
 
 static const enum omap_display_type omap2_dss_supported_displays[] = {
@@ -141,7 +155,8 @@ static struct omap_dss_features omap2_dss_features = {
 
 	.has_feature	=
 		FEAT_LCDENABLEPOL | FEAT_LCDENABLESIGNAL |
-		FEAT_PCKFREEENABLE | FEAT_FUNCGATED,
+		FEAT_PCKFREEENABLE | FEAT_FUNCGATED |
+		FEAT_ROWREPEATENABLE | FEAT_RESIZECONF,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -157,7 +172,8 @@ static struct omap_dss_features omap3430_dss_features = {
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_FUNCGATED,
+		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
+		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -172,7 +188,9 @@ static struct omap_dss_features omap3630_dss_features = {
 	.has_feature    =
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED,
+		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
+		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
+		FEAT_RESIZECONF,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -182,12 +200,13 @@ static struct omap_dss_features omap3630_dss_features = {
 
 /* OMAP4 DSS Features */
 static struct omap_dss_features omap4_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
+	.reg_fields = omap4_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
 
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
-		FEAT_MGR_LCD2 | FEAT_CORE_CLK_DIV,
+		FEAT_MGR_LCD2 | FEAT_CORE_CLK_DIV |
+		FEAT_GLOBAL_ALPHA_VID1,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 24fcef5..61c05c7 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -35,6 +35,9 @@ enum dss_feat_id {
 	FEAT_MGR_LCD2		= 1 << 7,
 	/* Independent core clk divider */
 	FEAT_CORE_CLK_DIV	= 1 << 8,
+	FEAT_LINEBUFFERSPLIT	= 1 << 9,
+	FEAT_ROWREPEATENABLE	= 1 << 10,
+	FEAT_RESIZECONF		= 1 << 11,
 };
 
 /* DSS register field id */
@@ -44,6 +47,8 @@ enum dss_feat_reg_field {
 	FEAT_REG_FIFOHIGHTHRESHOLD,
 	FEAT_REG_FIFOLOWTHRESHOLD,
 	FEAT_REG_FIFOSIZE,
+	FEAT_REG_HORIZONTALACCU,
+	FEAT_REG_VERTICALACCU,
 };
 
 /* DSS Feature Functions */
-- 
1.7.1

