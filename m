From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/5] OMAP: DSS2: Add Video 3 pipeline functionality in DISPC
Date: Mon, 19 Jul 2010 17:25:41 +0530
Message-ID: <1279540544-12682-3-git-send-email-archit@ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760621Ab0GSL4F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 07:56:05 -0400
In-Reply-To: <1279540544-12682-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

VID3 and Writeback pipeline registers have a linear relation, this patch
introduces these registers and adds Video3 pipeline support for the dispc
functions.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  172 +++++++++++++++++++++++++++++++++-----
 1 files changed, 149 insertions(+), 23 deletions(-)
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 48167a2..00aad04
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -138,6 +138,33 @@ struct dispc_reg { u16 idx; };
 
 #define DISPC_VID_PRELOAD(n)		DISPC_REG(0x230 + (n)*0x04)
 
+/* DISPC Video plane, n = 0 for VID3, n = 1 for WB */
+#define DISPC_VID3_WB_REG(n, idx)	DISPC_REG(0x0300 + (n)*0x200 + idx)
+
+#define DISPC_VID3_WB_ACCU0(n)		DISPC_VID3_WB_REG(n, 0x0000)
+#define DISPC_VID3_WB_ACCU1(n)		DISPC_VID3_WB_REG(n, 0x0004)
+#define DISPC_VID3_WB_BA0(n)		DISPC_VID3_WB_REG(n, 0x0008)
+#define DISPC_VID3_WB_BA1(n)		DISPC_VID3_WB_REG(n, 0x000C)
+#define DISPC_VID3_WB_ATTRIBUTES(n)	DISPC_VID3_WB_REG(n, 0x0070)
+#define DISPC_VID3_WB_BUF_SIZE_STATUS(n)	DISPC_VID3_WB_REG(n, 0x0088)
+#define DISPC_VID3_WB_BUF_THRESHOLD(n)	DISPC_VID3_WB_REG(n, 0x008C)
+#define DISPC_VID3_WB_FIR(n)		DISPC_VID3_WB_REG(n, 0x0090)
+#define DISPC_VID3_WB_PICTURE_SIZE(n)	DISPC_VID3_WB_REG(n, 0x0094)
+#define DISPC_VID3_WB_PIXEL_INC(n)	DISPC_VID3_WB_REG(n, 0x0098)
+#define DISPC_VID3_WB_ROW_INC(n)	DISPC_VID3_WB_REG(n, 0x00A4)
+#define DISPC_VID3_WB_SIZE(n)		DISPC_VID3_WB_REG(n, 0x00A8)
+
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+#define DISPC_VID3_WB_FIR_COEF_H(n, i)	DISPC_REG(0x0310 + (n)*0x200 + (i)*0x8)
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+#define DISPC_VID3_WB_FIR_COEF_HV(n, i)	DISPC_REG(0x0314 + (n)*0x200 + (i)*0x8)
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+#define DISPC_VID3_WB_FIR_COEF_V(n, i)	DISPC_REG(0x0350 + (n)*0x200 + (i)*0x4)
+/* coef index i = {0, 1, 2, 3, 4} */
+#define DISPC_VID3_WB_CONV_COEF(n, i)	DISPC_REG(0x0374 + (n)*0x200 + (i)*0x4)
+
+#define DISPC_VID3_POSITION		DISPC_REG(0x039C)
+#define DISPC_VID3_PRELOAD		DISPC_REG(0x03A0)
 
 #define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_OCP_ERR | \
@@ -164,7 +191,8 @@ struct omap_dispc_isr_data {
 
 static const struct dispc_reg dispc_reg_att[] = { DISPC_GFX_ATTRIBUTES,
 	DISPC_VID_ATTRIBUTES(0),
-	DISPC_VID_ATTRIBUTES(1) };
+	DISPC_VID_ATTRIBUTES(1),
+	DISPC_VID3_WB_ATTRIBUTES(0) }; /* VID 3 pipeline */
 
 struct dispc_irq_stats {
 	unsigned long last_reset;
@@ -603,21 +631,30 @@ static void _dispc_write_firh_reg(enum omap_plane plane, int reg, u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	dispc_write_reg(DISPC_VID_FIR_COEF_H(plane-1, reg), value);
+	if ((OMAP_DSS_VIDEO1 == plane) || (OMAP_DSS_VIDEO2 == plane))
+		dispc_write_reg(DISPC_VID_FIR_COEF_H(plane-1, reg), value);
+	else if (OMAP_DSS_VIDEO3 == plane)
+		dispc_write_reg(DISPC_VID3_WB_FIR_COEF_H(0, reg), value);
 }
 
 static void _dispc_write_firhv_reg(enum omap_plane plane, int reg, u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	dispc_write_reg(DISPC_VID_FIR_COEF_HV(plane-1, reg), value);
+	if ((OMAP_DSS_VIDEO1 == plane) || (OMAP_DSS_VIDEO2 == plane))
+		dispc_write_reg(DISPC_VID_FIR_COEF_HV(plane-1, reg), value);
+	else if (OMAP_DSS_VIDEO3 == plane)
+		dispc_write_reg(DISPC_VID3_WB_FIR_COEF_HV(0, reg), value);
 }
 
 static void _dispc_write_firv_reg(enum omap_plane plane, int reg, u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	dispc_write_reg(DISPC_VID_FIR_COEF_V(plane-1, reg), value);
+	if ((OMAP_DSS_VIDEO1 == plane) || (OMAP_DSS_VIDEO2 == plane))
+		dispc_write_reg(DISPC_VID_FIR_COEF_V(plane-1, reg), value);
+	else if (OMAP_DSS_VIDEO3 == plane)
+		dispc_write_reg(DISPC_VID3_WB_FIR_COEF_V(0, reg), value);
 }
 
 static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
@@ -801,11 +838,25 @@ static void _dispc_setup_color_conv_coef(void)
 	dispc_write_reg(DISPC_VID_CONV_COEF(1, 2), CVAL(ct->gcb, ct->gcr));
 	dispc_write_reg(DISPC_VID_CONV_COEF(1, 3), CVAL(ct->bcr, ct->by));
 	dispc_write_reg(DISPC_VID_CONV_COEF(1, 4), CVAL(0,       ct->bcb));
-
+	if (cpu_is_omap44xx()) {
+		dispc_write_reg(DISPC_VID3_WB_CONV_COEF(0, 0),
+			CVAL(ct->rcr, ct->ry));
+		dispc_write_reg(DISPC_VID3_WB_CONV_COEF(0, 1),
+			CVAL(ct->gy,  ct->rcb));
+		dispc_write_reg(DISPC_VID3_WB_CONV_COEF(0, 2),
+			CVAL(ct->gcb, ct->gcr));
+		dispc_write_reg(DISPC_VID3_WB_CONV_COEF(0, 3),
+			CVAL(ct->bcr, ct->by));
+		dispc_write_reg(DISPC_VID3_WB_CONV_COEF(0, 4),
+			CVAL(0, ct->bcb));
+	}
 #undef CVAL
 
 	REG_FLD_MOD(DISPC_VID_ATTRIBUTES(0), ct->full_range, 11, 11);
 	REG_FLD_MOD(DISPC_VID_ATTRIBUTES(1), ct->full_range, 11, 11);
+	if (cpu_is_omap44xx())
+		REG_FLD_MOD(DISPC_VID3_WB_ATTRIBUTES(0),
+			ct->full_range, 11, 11);
 }
 
 
@@ -813,7 +864,8 @@ static void _dispc_set_plane_ba0(enum omap_plane plane, u32 paddr)
 {
 	const struct dispc_reg ba0_reg[] = { DISPC_GFX_BA0,
 		DISPC_VID_BA0(0),
-		DISPC_VID_BA0(1) };
+		DISPC_VID_BA0(1),
+		DISPC_VID3_WB_BA0(0) };
 
 	dispc_write_reg(ba0_reg[plane], paddr);
 }
@@ -821,8 +873,9 @@ static void _dispc_set_plane_ba0(enum omap_plane plane, u32 paddr)
 static void _dispc_set_plane_ba1(enum omap_plane plane, u32 paddr)
 {
 	const struct dispc_reg ba1_reg[] = { DISPC_GFX_BA1,
-				      DISPC_VID_BA1(0),
-				      DISPC_VID_BA1(1) };
+		DISPC_VID_BA1(0),
+		DISPC_VID_BA1(1),
+		DISPC_VID3_WB_BA1(0) };
 
 	dispc_write_reg(ba1_reg[plane], paddr);
 }
@@ -831,7 +884,8 @@ static void _dispc_set_plane_pos(enum omap_plane plane, int x, int y)
 {
 	const struct dispc_reg pos_reg[] = { DISPC_GFX_POSITION,
 				      DISPC_VID_POSITION(0),
-				      DISPC_VID_POSITION(1) };
+				      DISPC_VID_POSITION(1),
+				      DISPC_VID3_POSITION };
 
 	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
 	dispc_write_reg(pos_reg[plane], val);
@@ -841,7 +895,9 @@ static void _dispc_set_pic_size(enum omap_plane plane, int width, int height)
 {
 	const struct dispc_reg siz_reg[] = { DISPC_GFX_SIZE,
 				      DISPC_VID_PICTURE_SIZE(0),
-				      DISPC_VID_PICTURE_SIZE(1) };
+				      DISPC_VID_PICTURE_SIZE(1),
+				      DISPC_VID3_WB_PICTURE_SIZE(0) };
+
 	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	dispc_write_reg(siz_reg[plane], val);
 }
@@ -849,9 +905,9 @@ static void _dispc_set_pic_size(enum omap_plane plane, int width, int height)
 static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
 {
 	u32 val;
-	const struct dispc_reg vsi_reg[] = { DISPC_VID_SIZE(0),
-				      DISPC_VID_SIZE(1) };
-
+	struct dispc_reg vsi_reg[] = { DISPC_VID_SIZE(0),
+				      DISPC_VID_SIZE(1),
+				      DISPC_VID3_WB_SIZE(0) };
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
@@ -870,13 +926,16 @@ static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 7, 0);
 	else if (plane == OMAP_DSS_VIDEO2)
 		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 23, 16);
+	else if (plane == OMAP_DSS_VIDEO3)
+		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 31, 24);
 }
 
 static void _dispc_set_pix_inc(enum omap_plane plane, s32 inc)
 {
 	const struct dispc_reg ri_reg[] = { DISPC_GFX_PIXEL_INC,
 				     DISPC_VID_PIXEL_INC(0),
-				     DISPC_VID_PIXEL_INC(1) };
+				     DISPC_VID_PIXEL_INC(1),
+				     DISPC_VID3_WB_PIXEL_INC(0) };
 
 	dispc_write_reg(ri_reg[plane], inc);
 }
@@ -885,7 +944,8 @@ static void _dispc_set_row_inc(enum omap_plane plane, s32 inc)
 {
 	const struct dispc_reg ri_reg[] = { DISPC_GFX_ROW_INC,
 				     DISPC_VID_ROW_INC(0),
-				     DISPC_VID_ROW_INC(1) };
+				     DISPC_VID_ROW_INC(1),
+				     DISPC_VID3_WB_ROW_INC(0) };
 
 	dispc_write_reg(ri_reg[plane], inc);
 }
@@ -944,6 +1004,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 		break;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		shift = 16;
 		break;
 	default:
@@ -993,6 +1054,7 @@ void dispc_set_burst_size(enum omap_plane plane,
 		break;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		shift = 14;
 		break;
 	default:
@@ -1056,7 +1118,8 @@ static void dispc_read_plane_fifo_sizes(void)
 {
 	const struct dispc_reg fsz_reg[] = { DISPC_GFX_FIFO_SIZE_STATUS,
 				      DISPC_VID_FIFO_SIZE_STATUS(0),
-				      DISPC_VID_FIFO_SIZE_STATUS(1) };
+				      DISPC_VID_FIFO_SIZE_STATUS(1),
+				      DISPC_VID3_WB_BUF_SIZE_STATUS(0) };
 	u32 size;
 	int plane;
 
@@ -1067,6 +1130,8 @@ static void dispc_read_plane_fifo_sizes(void)
 			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 8, 0);
 		else if (cpu_is_omap34xx())
 			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 10, 0);
+		else if (cpu_is_omap44xx())
+			size = FLD_GET(dispc_read_reg(fsz_reg[plane]), 15, 0);
 		else
 			BUG();
 
@@ -1085,7 +1150,8 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 {
 	const struct dispc_reg ftrs_reg[] = { DISPC_GFX_FIFO_THRESHOLD,
 				       DISPC_VID_FIFO_THRESHOLD(0),
-				       DISPC_VID_FIFO_THRESHOLD(1) };
+				       DISPC_VID_FIFO_THRESHOLD(1),
+				       DISPC_VID3_WB_BUF_THRESHOLD(0) };
 	enable_clocks(1);
 
 	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
@@ -1097,9 +1163,12 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 	if (cpu_is_omap24xx())
 		dispc_write_reg(ftrs_reg[plane],
 				FLD_VAL(high, 24, 16) | FLD_VAL(low, 8, 0));
-	else
+	else if (cpu_is_omap34xx())
 		dispc_write_reg(ftrs_reg[plane],
 				FLD_VAL(high, 27, 16) | FLD_VAL(low, 11, 0));
+	else if (cpu_is_omap44xx())
+		dispc_write_reg(ftrs_reg[plane],
+				FLD_VAL(high, 31, 16) | FLD_VAL(low, 15, 0));
 
 	enable_clocks(0);
 }
@@ -1118,7 +1187,8 @@ static void _dispc_set_fir(enum omap_plane plane, int hinc, int vinc)
 {
 	u32 val;
 	const struct dispc_reg fir_reg[] = { DISPC_VID_FIR(0),
-				      DISPC_VID_FIR(1) };
+				      DISPC_VID_FIR(1),
+				      DISPC_VID3_WB_FIR(0) };
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
@@ -1133,11 +1203,15 @@ static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
 	const struct dispc_reg ac0_reg[] = { DISPC_VID_ACCU0(0),
-				      DISPC_VID_ACCU0(1) };
+					DISPC_VID_ACCU0(1),
+					DISPC_VID3_WB_ACCU0(0) };
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
+	if (cpu_is_omap44xx())
+		val = FLD_VAL(vaccu, 26, 16) | FLD_VAL(haccu, 10, 0);
+	else
+		val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
 	dispc_write_reg(ac0_reg[plane-1], val);
 }
 
@@ -1145,11 +1219,15 @@ static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
 	const struct dispc_reg ac1_reg[] = { DISPC_VID_ACCU1(0),
-				      DISPC_VID_ACCU1(1) };
+					DISPC_VID_ACCU1(1),
+					DISPC_VID3_WB_ACCU1(0) };
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
+	if (cpu_is_omap44xx())
+		val = FLD_VAL(vaccu, 26, 16) | FLD_VAL(haccu, 10, 0);
+	else
+		val = FLD_VAL(vaccu, 25, 16) | FLD_VAL(haccu, 9, 0);
 	dispc_write_reg(ac1_reg[plane-1], val);
 }
 
@@ -2563,6 +2641,21 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_VID_ACCU0(1));
 	DUMPREG(DISPC_VID_ACCU1(1));
 
+	if (cpu_is_omap44xx()) {
+		DUMPREG(DISPC_VID3_WB_BA0(0));
+		DUMPREG(DISPC_VID3_WB_BA1(0));
+		DUMPREG(DISPC_VID3_POSITION);
+		DUMPREG(DISPC_VID3_WB_SIZE(0));
+		DUMPREG(DISPC_VID3_WB_ATTRIBUTES(0));
+		DUMPREG(DISPC_VID3_WB_BUF_THRESHOLD(0));
+		DUMPREG(DISPC_VID3_WB_BUF_SIZE_STATUS(0));
+		DUMPREG(DISPC_VID3_WB_ROW_INC(0));
+		DUMPREG(DISPC_VID3_WB_PIXEL_INC(0));
+		DUMPREG(DISPC_VID3_WB_FIR(0));
+		DUMPREG(DISPC_VID3_WB_PICTURE_SIZE(0));
+		DUMPREG(DISPC_VID3_WB_ACCU0(0));
+		DUMPREG(DISPC_VID3_WB_ACCU1(0));
+	}
 	DUMPREG(DISPC_VID_FIR_COEF_H(0, 0));
 	DUMPREG(DISPC_VID_FIR_COEF_H(0, 1));
 	DUMPREG(DISPC_VID_FIR_COEF_H(0, 2));
@@ -2623,8 +2716,41 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_VID_FIR_COEF_V(1, 6));
 	DUMPREG(DISPC_VID_FIR_COEF_V(1, 7));
 
+	if (cpu_is_omap44xx()) {
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 0));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 1));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 2));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 3));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 4));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 5));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 6));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_H(0, 7));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 0));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 1));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 2));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 3));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 4));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 5));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 6));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_HV(0, 7));
+		DUMPREG(DISPC_VID3_WB_CONV_COEF(0, 0));
+		DUMPREG(DISPC_VID3_WB_CONV_COEF(0, 1));
+		DUMPREG(DISPC_VID3_WB_CONV_COEF(0, 2));
+		DUMPREG(DISPC_VID3_WB_CONV_COEF(0, 3));
+		DUMPREG(DISPC_VID3_WB_CONV_COEF(0, 4));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 0));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 1));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 2));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 3));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 4));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 5));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 6));
+		DUMPREG(DISPC_VID3_WB_FIR_COEF_V(0, 7));
+	}
 	DUMPREG(DISPC_VID_PRELOAD(0));
 	DUMPREG(DISPC_VID_PRELOAD(1));
+	if (cpu_is_omap44xx())
+		DUMPREG(DISPC_VID3_PRELOAD);
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 #undef DUMPREG
-- 
1.5.4.7

