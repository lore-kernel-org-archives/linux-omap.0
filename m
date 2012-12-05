From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 2/6] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields to dispc_features
Date: Wed, 5 Dec 2012 15:46:04 +0530
Message-ID: <08d6240ab26427a9e437421c2cc76ade29036817.1354702077.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41526 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab2LEKTx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 05:19:53 -0500
In-Reply-To: <cover.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The register fields in dss_reg_fields specific to DISPC are moved from struct
omap_dss_features to corresponding dispc_reg_fields, initialized in struct
dispc_features, thereby enabling local access.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |  114 ++++++++++++++++++++++++--------
 drivers/video/omap2/dss/dss.h          |    4 ++
 drivers/video/omap2/dss/dss_features.c |   28 --------
 drivers/video/omap2/dss/dss_features.h |    7 --
 4 files changed, 89 insertions(+), 64 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index bbba83f..ee4b152 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -80,6 +80,16 @@ struct dispc_irq_stats {
 	unsigned irqs[32];
 };
 
+struct dispc_reg_fields {
+	struct omapdss_reg_field firhinc;
+	struct omapdss_reg_field firvinc;
+	struct omapdss_reg_field fifo_low_thresh;
+	struct omapdss_reg_field fifo_high_thresh;
+	struct omapdss_reg_field fifosize;
+	struct omapdss_reg_field hori_accu;
+	struct omapdss_reg_field vert_accu;
+};
+
 struct dispc_features {
 	u8 sw_start;
 	u8 fp_start;
@@ -110,6 +120,8 @@ struct dispc_features {
 
 	u32 buffer_size_unit; /* in bytes */
 	u32 burst_size_unit; /* in bytes */
+
+	struct dispc_reg_fields *reg_fields;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -1137,17 +1149,17 @@ static void dispc_mgr_set_size(enum omap_channel channel, u16 width,
 
 static void dispc_init_fifos(void)
 {
-	u32 size;
+	u32 size, unit;
 	int fifo;
-	u8 start, end;
-	u32 unit;
+	const struct omapdss_reg_field *fifo_field;
 
 	unit = dispc.feat->buffer_size_unit;
 
-	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
+	fifo_field = &dispc.feat->reg_fields->fifosize;
 
 	for (fifo = 0; fifo < dispc.feat->num_fifos; ++fifo) {
-		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
+		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo),
+					fifo_field->start, fifo_field->end);
 		size *= unit;
 		dispc.fifo_size[fifo] = size;
 
@@ -1197,8 +1209,8 @@ static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 {
-	u8 hi_start, hi_end, lo_start, lo_end;
 	u32 unit;
+	const struct omapdss_reg_field *hi_field, *lo_field;
 
 	unit = dispc.feat->buffer_size_unit;
 
@@ -1208,20 +1220,20 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 	low /= unit;
 	high /= unit;
 
-	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
-	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
+	hi_field = &dispc.feat->reg_fields->fifo_high_thresh;
+	lo_field = &dispc.feat->reg_fields->fifo_low_thresh;
 
 	DSSDBG("fifo(%d) threshold (bytes), old %u/%u, new %u/%u\n",
 			plane,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
-				lo_start, lo_end) * unit,
+				lo_field->start, lo_field->end) * unit,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
-				hi_start, hi_end) * unit,
+				hi_field->start, hi_field->end) * unit,
 			low * unit, high * unit);
 
 	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
-			FLD_VAL(high, hi_start, hi_end) |
-			FLD_VAL(low, lo_start, lo_end));
+			FLD_VAL(high, hi_field->start, hi_field->end) |
+			FLD_VAL(low, lo_field->start, lo_field->end));
 }
 
 void dispc_enable_fifomerge(bool enable)
@@ -1289,14 +1301,13 @@ static void dispc_ovl_set_fir(enum omap_plane plane,
 	u32 val;
 
 	if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
-		u8 hinc_start, hinc_end, vinc_start, vinc_end;
+		const struct omapdss_reg_field *hinc_field, *vinc_field;
 
-		dss_feat_get_reg_field(FEAT_REG_FIRHINC,
-					&hinc_start, &hinc_end);
-		dss_feat_get_reg_field(FEAT_REG_FIRVINC,
-					&vinc_start, &vinc_end);
-		val = FLD_VAL(vinc, vinc_start, vinc_end) |
-				FLD_VAL(hinc, hinc_start, hinc_end);
+		hinc_field = &dispc.feat->reg_fields->firhinc;
+		vinc_field = &dispc.feat->reg_fields->firvinc;
+
+		val = FLD_VAL(vinc, vinc_field->start, vinc_field->end) |
+			FLD_VAL(hinc, hinc_field->start, hinc_field->end);
 
 		dispc_write_reg(DISPC_OVL_FIR(plane), val);
 	} else {
@@ -1308,13 +1319,13 @@ static void dispc_ovl_set_fir(enum omap_plane plane,
 static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
-	u8 hor_start, hor_end, vert_start, vert_end;
+	const struct omapdss_reg_field *haccu_field, *vaccu_field;
 
-	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
-	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
+	haccu_field = &dispc.feat->reg_fields->hori_accu;
+	vaccu_field = &dispc.feat->reg_fields->vert_accu;
 
-	val = FLD_VAL(vaccu, vert_start, vert_end) |
-			FLD_VAL(haccu, hor_start, hor_end);
+	val = FLD_VAL(vaccu, vaccu_field->start, vaccu_field->end) |
+		FLD_VAL(haccu, haccu_field->start, haccu_field->end);
 
 	dispc_write_reg(DISPC_OVL_ACCU0(plane), val);
 }
@@ -1322,13 +1333,13 @@ static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
-	u8 hor_start, hor_end, vert_start, vert_end;
+	const struct omapdss_reg_field *haccu_field, *vaccu_field;
 
-	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
-	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
+	haccu_field = &dispc.feat->reg_fields->hori_accu;
+	vaccu_field = &dispc.feat->reg_fields->vert_accu;
 
-	val = FLD_VAL(vaccu, vert_start, vert_end) |
-			FLD_VAL(haccu, hor_start, hor_end);
+	val = FLD_VAL(vaccu, vaccu_field->start, vaccu_field->end) |
+		FLD_VAL(haccu, haccu_field->start, haccu_field->end);
 
 	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
 }
@@ -4048,6 +4059,46 @@ static void _omap_dispc_initial_config(void)
 	dispc_ovl_enable_zorder_planes();
 }
 
+static struct dispc_reg_fields omap2_dispc_reg_fields = {
+	.firhinc		=	{ 11,  0 },
+	.firvinc		=	{ 27, 16 },
+	.fifo_low_thresh	=	{  8,  0 },
+	.fifo_high_thresh	=	{ 24, 16 },
+	.fifosize		=	{  8,  0 },
+	.hori_accu		=	{  9,  0 },
+	.vert_accu		=	{ 25, 16 },
+};
+
+static struct dispc_reg_fields omap3_dispc_reg_fields = {
+	.firhinc		=	{ 12,  0 },
+	.firvinc		=	{ 28, 16 },
+	.fifo_low_thresh	=	{ 11,  0 },
+	.fifo_high_thresh	=	{ 27, 16 },
+	.fifosize		=	{ 10,  0 },
+	.hori_accu		=	{  9,  0 },
+	.vert_accu		=	{ 25, 16 },
+};
+
+static struct dispc_reg_fields omap4_dispc_reg_fields = {
+	.firhinc		=	{ 12,  0 },
+	.firvinc		=	{ 28, 16 },
+	.fifo_low_thresh	=	{ 15,  0 },
+	.fifo_high_thresh	=	{ 31, 16 },
+	.fifosize		=	{ 15,  0 },
+	.hori_accu		=	{ 10,  0 },
+	.vert_accu		=	{ 26, 16 },
+};
+
+static struct dispc_reg_fields omap5_dispc_reg_fields = {
+	.firhinc		=	{ 12,  0 },
+	.firvinc		=	{ 28, 16 },
+	.fifo_low_thresh	=	{ 15,  0 },
+	.fifo_high_thresh	=	{ 31, 16 },
+	.fifosize		=	{ 15,  0 },
+	.hori_accu		=	{ 10,  0 },
+	.vert_accu		=	{ 26, 16 },
+};
+
 static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.sw_start		=	5,
 	.fp_start		=	15,
@@ -4065,6 +4116,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.no_framedone_tv	=	true,
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
+	.reg_fields		=	&omap2_dispc_reg_fields,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -4084,6 +4136,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.no_framedone_tv	=	true,
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
+	.reg_fields		=	&omap3_dispc_reg_fields,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -4103,6 +4156,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.no_framedone_tv	=	true,
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
+	.reg_fields		=	&omap3_dispc_reg_fields,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
@@ -4122,6 +4176,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.gfx_fifo_workaround	=	true,
 	.buffer_size_unit	=	16,
 	.burst_size_unit	=	16,
+	.reg_fields		=	&omap4_dispc_reg_fields,
 };
 
 static const struct dispc_features omap54xx_dispc_feats __initconst = {
@@ -4141,6 +4196,7 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.gfx_fifo_workaround	=	true,
 	.buffer_size_unit	=	16,
 	.burst_size_unit	=	16,
+	.reg_fields		=	&omap5_dispc_reg_fields,
 };
 
 static int __init dispc_init_features(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9ee3c88..18842e2 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -143,6 +143,10 @@ struct reg_field {
 	u8 low;
 };
 
+struct omapdss_reg_field {
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

