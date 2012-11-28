From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields to dispc_features
Date: Wed, 28 Nov 2012 16:11:25 +0530
Message-ID: <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53516 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab2K1Kq3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 05:46:29 -0500
In-Reply-To: <cover.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The register fields in dss_reg_fields specific to DISPC are moved from struct
omap_dss_features to corresponding dispc_reg_fields, initialized in struct
dispc_features, thereby enabling local access.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   87 ++++++++++++++++++++++++++++----
 drivers/video/omap2/dss/dss.h          |    4 ++
 drivers/video/omap2/dss/dss_features.c |   28 ----------
 drivers/video/omap2/dss/dss_features.h |    7 ---
 4 files changed, 80 insertions(+), 46 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 9f259ba..21fc522 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -80,6 +80,16 @@ struct dispc_irq_stats {
 	unsigned irqs[32];
 };
 
+enum dispc_feat_reg_field {
+	FEAT_REG_FIRHINC,
+	FEAT_REG_FIRVINC,
+	FEAT_REG_FIFOLOWTHRESHOLD,
+	FEAT_REG_FIFOHIGHTHRESHOLD,
+	FEAT_REG_FIFOSIZE,
+	FEAT_REG_HORIZONTALACCU,
+	FEAT_REG_VERTICALACCU,
+};
+
 struct dispc_features {
 	u8 sw_start;
 	u8 fp_start;
@@ -107,6 +117,8 @@ struct dispc_features {
 
 	u32 buffer_size_unit;
 	u32 burst_size_unit;
+
+	struct register_field *reg_fields;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -1150,7 +1162,8 @@ static void dispc_init_fifos(void)
 
 	unit = dispc.feat->buffer_size_unit;
 
-	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
+	start = dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].start;
+	end = dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].end;
 
 	for (fifo = 0; fifo < dispc.feat->num_fifos; ++fifo) {
 		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
@@ -1214,8 +1227,10 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 	low /= unit;
 	high /= unit;
 
-	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
-	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
+	hi_start = dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD].start;
+	hi_end = dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD].end;
+	lo_start = dispc.feat->reg_fields[FEAT_REG_FIFOLOWTHRESHOLD].start;
+	lo_end = dispc.feat->reg_fields[FEAT_REG_FIFOLOWTHRESHOLD].end;
 
 	DSSDBG("fifo(%d) threshold (bytes), old %u/%u, new %u/%u\n",
 			plane,
@@ -1297,10 +1312,11 @@ static void dispc_ovl_set_fir(enum omap_plane plane,
 	if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
 		u8 hinc_start, hinc_end, vinc_start, vinc_end;
 
-		dss_feat_get_reg_field(FEAT_REG_FIRHINC,
-					&hinc_start, &hinc_end);
-		dss_feat_get_reg_field(FEAT_REG_FIRVINC,
-					&vinc_start, &vinc_end);
+		hinc_start = dispc.feat->reg_fields[FEAT_REG_FIRHINC].start;
+		hinc_end = dispc.feat->reg_fields[FEAT_REG_FIRHINC].end;
+		vinc_start = dispc.feat->reg_fields[FEAT_REG_FIRVINC].start;
+		vinc_end = dispc.feat->reg_fields[FEAT_REG_FIRVINC].end;
+
 		val = FLD_VAL(vinc, vinc_start, vinc_end) |
 				FLD_VAL(hinc, hinc_start, hinc_end);
 
@@ -1316,8 +1332,10 @@ static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 	u32 val;
 	u8 hor_start, hor_end, vert_start, vert_end;
 
-	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
-	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
+	hor_start = dispc.feat->reg_fields[FEAT_REG_HORIZONTALACCU].start;
+	hor_end = dispc.feat->reg_fields[FEAT_REG_HORIZONTALACCU].end;
+	vert_start = dispc.feat->reg_fields[FEAT_REG_VERTICALACCU].start;
+	vert_end = dispc.feat->reg_fields[FEAT_REG_VERTICALACCU].end;
 
 	val = FLD_VAL(vaccu, vert_start, vert_end) |
 			FLD_VAL(haccu, hor_start, hor_end);
@@ -1330,8 +1348,10 @@ static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 	u32 val;
 	u8 hor_start, hor_end, vert_start, vert_end;
 
-	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
-	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
+	hor_start = dispc.feat->reg_fields[FEAT_REG_HORIZONTALACCU].start;
+	hor_end = dispc.feat->reg_fields[FEAT_REG_HORIZONTALACCU].end;
+	vert_start = dispc.feat->reg_fields[FEAT_REG_VERTICALACCU].start;
+	vert_end = dispc.feat->reg_fields[FEAT_REG_VERTICALACCU].end;
 
 	val = FLD_VAL(vaccu, vert_start, vert_end) |
 			FLD_VAL(haccu, hor_start, hor_end);
@@ -4084,6 +4104,46 @@ static void _omap_dispc_initial_config(void)
 	dispc_ovl_enable_zorder_planes();
 }
 
+static struct register_field omap2_dispc_reg_fields[] = {
+	[FEAT_REG_FIRHINC]			= { 11,  0 },
+	[FEAT_REG_FIRVINC]			= { 27, 16 },
+	[FEAT_REG_FIFOLOWTHRESHOLD]		= {  8,  0 },
+	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 24, 16 },
+	[FEAT_REG_FIFOSIZE]			= {  8,  0 },
+	[FEAT_REG_HORIZONTALACCU]		= {  9,  0 },
+	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
+};
+
+static struct register_field omap3_dispc_reg_fields[] = {
+	[FEAT_REG_FIRHINC]			= { 12,  0 },
+	[FEAT_REG_FIRVINC]			= { 28, 16 },
+	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 11,  0 },
+	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 27, 16 },
+	[FEAT_REG_FIFOSIZE]			= { 10,  0 },
+	[FEAT_REG_HORIZONTALACCU]		= {  9,  0 },
+	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
+};
+
+static struct register_field omap4_dispc_reg_fields[] = {
+	[FEAT_REG_FIRHINC]			= { 12,  0 },
+	[FEAT_REG_FIRVINC]			= { 28, 16 },
+	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 15,  0 },
+	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 31, 16 },
+	[FEAT_REG_FIFOSIZE]			= { 15,  0 },
+	[FEAT_REG_HORIZONTALACCU]		= { 10,  0 },
+	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
+};
+
+static struct register_field omap5_dispc_reg_fields[] = {
+	[FEAT_REG_FIRHINC]			= { 12,  0 },
+	[FEAT_REG_FIRVINC]			= { 28, 16 },
+	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 15,  0 },
+	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 31, 16 },
+	[FEAT_REG_FIFOSIZE]			= { 15,  0 },
+	[FEAT_REG_HORIZONTALACCU]		= { 10,  0 },
+	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
+};
+
 static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.sw_start		=	5,
 	.fp_start		=	15,
@@ -4100,6 +4160,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.num_fifos		=	3,
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
+	.reg_fields		=	omap2_dispc_reg_fields,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -4118,6 +4179,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.num_fifos		=	3,
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
+	.reg_fields		=	omap3_dispc_reg_fields,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -4136,6 +4198,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.num_fifos		=	3,
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
+	.reg_fields		=	omap3_dispc_reg_fields,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
@@ -4155,6 +4218,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.gfx_fifo_workaround	=	true,
 	.buffer_size_unit	=	16,
 	.burst_size_unit	=	16,
+	.reg_fields		=	omap4_dispc_reg_fields,
 };
 
 static const struct dispc_features omap54xx_dispc_feats __initconst = {
@@ -4174,6 +4238,7 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.gfx_fifo_workaround	=	true,
 	.buffer_size_unit	=	16,
 	.burst_size_unit	=	16,
+	.reg_fields		=	omap5_dispc_reg_fields,
 };
 
 static int __init dispc_init_features(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 84a7f6a..aa273d8 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -143,6 +143,10 @@ struct reg_field {
 	u8 low;
 };
 
+struct register_field {
+	u8 start, end;
+};
+
 struct dss_lcd_mgr_config {
 	enum dss_io_pad_mode io_pad_mode;
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 092e21b..defdfc0 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -60,13 +60,6 @@ struct omap_dss_features {
 static const struct omap_dss_features *omap_current_dss_features;
 
 static const struct dss_reg_field omap2_dss_reg_fields[] = {
-	[FEAT_REG_FIRHINC]			= { 11, 0 },
-	[FEAT_REG_FIRVINC]			= { 27, 16 },
-	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 8, 0 },
-	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 24, 16 },
-	[FEAT_REG_FIFOSIZE]			= { 8, 0 },
-	[FEAT_REG_HORIZONTALACCU]		= { 9, 0 },
-	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
 	[FEAT_REG_DSIPLL_REGN]			= { 0, 0 },
 	[FEAT_REG_DSIPLL_REGM]			= { 0, 0 },
@@ -75,13 +68,6 @@ static const struct dss_reg_field omap2_dss_reg_fields[] = {
 };
 
 static const struct dss_reg_field omap3_dss_reg_fields[] = {
-	[FEAT_REG_FIRHINC]			= { 12, 0 },
-	[FEAT_REG_FIRVINC]			= { 28, 16 },
-	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 11, 0 },
-	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 27, 16 },
-	[FEAT_REG_FIFOSIZE]			= { 10, 0 },
-	[FEAT_REG_HORIZONTALACCU]		= { 9, 0 },
-	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
 	[FEAT_REG_DSIPLL_REGN]			= { 7, 1 },
 	[FEAT_REG_DSIPLL_REGM]			= { 18, 8 },
@@ -90,13 +76,6 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
 };
 
 static const struct dss_reg_field omap4_dss_reg_fields[] = {
-	[FEAT_REG_FIRHINC]			= { 12, 0 },
-	[FEAT_REG_FIRVINC]			= { 28, 16 },
-	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 15, 0 },
-	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 31, 16 },
-	[FEAT_REG_FIFOSIZE]			= { 15, 0 },
-	[FEAT_REG_HORIZONTALACCU]		= { 10, 0 },
-	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 8 },
 	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
 	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
@@ -105,13 +84,6 @@ static const struct dss_reg_field omap4_dss_reg_fields[] = {
 };
 
 static const struct dss_reg_field omap5_dss_reg_fields[] = {
-	[FEAT_REG_FIRHINC]			= { 12, 0 },
-	[FEAT_REG_FIRVINC]			= { 28, 16 },
-	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 15, 0 },
-	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 31, 16 },
-	[FEAT_REG_FIFOSIZE]			= { 15, 0 },
-	[FEAT_REG_HORIZONTALACCU]		= { 10, 0 },
-	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 7 },
 	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
 	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 16658e1..42a1bd1 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -72,13 +72,6 @@ enum dss_feat_id {
 
 /* DSS register field id */
 enum dss_feat_reg_field {
-	FEAT_REG_FIRHINC,
-	FEAT_REG_FIRVINC,
-	FEAT_REG_FIFOHIGHTHRESHOLD,
-	FEAT_REG_FIFOLOWTHRESHOLD,
-	FEAT_REG_FIFOSIZE,
-	FEAT_REG_HORIZONTALACCU,
-	FEAT_REG_VERTICALACCU,
 	FEAT_REG_DISPC_CLK_SWITCH,
 	FEAT_REG_DSIPLL_REGN,
 	FEAT_REG_DSIPLL_REGM,
-- 
1.7.10

