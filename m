From: Amber Jain <amber@ti.com>
Subject: [PATCH 4/5] OMAP: DSS2: Adds new registers for NV12 support
Date: Thu, 19 May 2011 11:01:29 +0530
Message-ID: <1305783090-21214-5-git-send-email-amber@ti.com>
References: <1305783090-21214-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39830 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab1ESFbr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 01:31:47 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4J5Vlaq022984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 00:31:47 -0500
In-Reply-To: <1305783090-21214-1-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

Adds new register definitions and simple helper functions to configure them.
Added these new registers to save/restore and DUMPREG fumction.
Also adds two new features FEAT_HANDLE_UV_SEPARATE and FEAT_ATTR2.

Signed-off-by: Amber Jain <amber@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |  160 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dispc.h        |  147 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 +
 4 files changed, 310 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 19b0b50..48717a9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -217,6 +217,25 @@ void dispc_save_context(void)
 	for (i = 0; i < 8; i++)
 		SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
 
+	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+		SR(OVL_BA0_UV(OMAP_DSS_VIDEO1));
+		SR(OVL_BA1_UV(OMAP_DSS_VIDEO1));
+		SR(OVL_FIR2(OMAP_DSS_VIDEO1));
+		SR(OVL_ACCU2_0(OMAP_DSS_VIDEO1));
+		SR(OVL_ACCU2_1(OMAP_DSS_VIDEO1));
+
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO1, i));
+
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO1, i));
+
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO1, i));
+	}
+	if (dss_has_feature(FEAT_ATTR2))
+		SR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
+
 	SR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
 
 	/* VID2 */
@@ -245,6 +264,25 @@ void dispc_save_context(void)
 	for (i = 0; i < 8; i++)
 		SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
 
+	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+		SR(OVL_BA0_UV(OMAP_DSS_VIDEO2));
+		SR(OVL_BA1_UV(OMAP_DSS_VIDEO2));
+		SR(OVL_FIR2(OMAP_DSS_VIDEO2));
+		SR(OVL_ACCU2_0(OMAP_DSS_VIDEO2));
+		SR(OVL_ACCU2_1(OMAP_DSS_VIDEO2));
+
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO2, i));
+
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO2, i));
+
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO2, i));
+	}
+	if (dss_has_feature(FEAT_ATTR2))
+		SR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
+
 	SR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
@@ -338,6 +376,25 @@ void dispc_restore_context(void)
 	for (i = 0; i < 8; i++)
 		RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
 
+	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+		RR(OVL_BA0_UV(OMAP_DSS_VIDEO1));
+		RR(OVL_BA1_UV(OMAP_DSS_VIDEO1));
+		RR(OVL_FIR2(OMAP_DSS_VIDEO1));
+		RR(OVL_ACCU2_0(OMAP_DSS_VIDEO1));
+		RR(OVL_ACCU2_1(OMAP_DSS_VIDEO1));
+
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO1, i));
+
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO1, i));
+
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO1, i));
+	}
+	if (dss_has_feature(FEAT_ATTR2))
+		RR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
+
 	RR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
 
 	/* VID2 */
@@ -366,6 +423,25 @@ void dispc_restore_context(void)
 	for (i = 0; i < 8; i++)
 		RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
 
+	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+		RR(OVL_BA0_UV(OMAP_DSS_VIDEO2));
+		RR(OVL_BA1_UV(OMAP_DSS_VIDEO2));
+		RR(OVL_FIR2(OMAP_DSS_VIDEO2));
+		RR(OVL_ACCU2_0(OMAP_DSS_VIDEO2));
+		RR(OVL_ACCU2_1(OMAP_DSS_VIDEO2));
+
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO2, i));
+
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO2, i));
+
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO2, i));
+	}
+	if (dss_has_feature(FEAT_ATTR2))
+		RR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
+
 	RR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
@@ -476,6 +552,27 @@ static void _dispc_write_firv_reg(enum omap_plane plane, int reg, u32 value)
 	dispc_write_reg(DISPC_OVL_FIR_COEF_V(plane, reg), value);
 }
 
+static void _dispc_write_firh2_reg(enum omap_plane plane, int reg, u32 value)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	dispc_write_reg(DISPC_OVL_FIR_COEF_H2(plane, reg), value);
+}
+
+static void _dispc_write_firhv2_reg(enum omap_plane plane, int reg, u32 value)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	dispc_write_reg(DISPC_OVL_FIR_COEF_HV2(plane, reg), value);
+}
+
+static void _dispc_write_firv2_reg(enum omap_plane plane, int reg, u32 value)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	dispc_write_reg(DISPC_OVL_FIR_COEF_V2(plane, reg), value);
+}
+
 static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 		int vscaleup, int five_taps)
 {
@@ -645,6 +742,16 @@ static void _dispc_set_plane_ba1(enum omap_plane plane, u32 paddr)
 	dispc_write_reg(DISPC_OVL_BA1(plane), paddr);
 }
 
+static void _dispc_set_plane_ba0_uv(enum omap_plane plane, u32 paddr)
+{
+	dispc_write_reg(DISPC_OVL_BA0_UV(plane), paddr);
+}
+
+static void _dispc_set_plane_ba1_uv(enum omap_plane plane, u32 paddr)
+{
+	dispc_write_reg(DISPC_OVL_BA1_UV(plane), paddr);
+}
+
 static void _dispc_set_plane_pos(enum omap_plane plane, int x, int y)
 {
 	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
@@ -1025,6 +1132,21 @@ static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
 }
 
+static void _dispc_set_vid_accu2_0(enum omap_plane plane, int haccu, int vaccu)
+{
+	u32 val;
+
+	val = FLD_VAL(vaccu, 26, 16) | FLD_VAL(haccu, 10, 0);
+	dispc_write_reg(DISPC_OVL_ACCU2_0(plane), val);
+}
+
+static void _dispc_set_vid_accu2_1(enum omap_plane plane, int haccu, int vaccu)
+{
+	u32 val;
+
+	val = FLD_VAL(vaccu, 26, 16) | FLD_VAL(haccu, 10, 0);
+	dispc_write_reg(DISPC_OVL_ACCU2_1(plane), val);
+}
 
 static void _dispc_set_scaling(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
@@ -2479,6 +2601,25 @@ void dispc_dump_regs(struct seq_file *s)
 	for (i = 0; i < 8; i++)
 		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
 
+	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+		DUMPREG(DISPC_OVL_BA0_UV(OMAP_DSS_VIDEO1));
+		DUMPREG(DISPC_OVL_BA1_UV(OMAP_DSS_VIDEO1));
+		DUMPREG(DISPC_OVL_FIR2(OMAP_DSS_VIDEO1));
+		DUMPREG(DISPC_OVL_ACCU2_0(OMAP_DSS_VIDEO1));
+		DUMPREG(DISPC_OVL_ACCU2_1(OMAP_DSS_VIDEO1));
+
+		for (i = 0; i < 8; i++)
+			DUMPREG(DISPC_OVL_FIR_COEF_H2(OMAP_DSS_VIDEO1, i));
+
+		for (i = 0; i < 8; i++)
+			DUMPREG(DISPC_OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO1, i));
+
+		for (i = 0; i < 8; i++)
+			DUMPREG(DISPC_OVL_FIR_COEF_V2(OMAP_DSS_VIDEO1, i));
+	}
+	if (dss_has_feature(FEAT_ATTR2))
+		DUMPREG(DISPC_OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
+
 	for (i = 0; i < 8; i++)
 		DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, i));
 
@@ -2491,6 +2632,25 @@ void dispc_dump_regs(struct seq_file *s)
 	for (i = 0; i < 8; i++)
 		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
 
+	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+		DUMPREG(DISPC_OVL_BA0_UV(OMAP_DSS_VIDEO2));
+		DUMPREG(DISPC_OVL_BA1_UV(OMAP_DSS_VIDEO2));
+		DUMPREG(DISPC_OVL_FIR2(OMAP_DSS_VIDEO2));
+		DUMPREG(DISPC_OVL_ACCU2_0(OMAP_DSS_VIDEO2));
+		DUMPREG(DISPC_OVL_ACCU2_1(OMAP_DSS_VIDEO2));
+
+		for (i = 0; i < 8; i++)
+			DUMPREG(DISPC_OVL_FIR_COEF_H2(OMAP_DSS_VIDEO2, i));
+
+		for (i = 0; i < 8; i++)
+			DUMPREG(DISPC_OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO2, i));
+
+		for (i = 0; i < 8; i++)
+			DUMPREG(DISPC_OVL_FIR_COEF_V2(OMAP_DSS_VIDEO2, i));
+	}
+	if (dss_has_feature(FEAT_ATTR2))
+		DUMPREG(DISPC_OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
+
 	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO1));
 	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index d45f010..6c9ee0a 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -42,12 +42,18 @@
 					DISPC_BA0_OFFSET(n))
 #define DISPC_OVL_BA1(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_BA1_OFFSET(n))
+#define DISPC_OVL_BA0_UV(n)		(DISPC_OVL_BASE(n) + \
+					DISPC_BA0_UV_OFFSET(n))
+#define DISPC_OVL_BA1_UV(n)		(DISPC_OVL_BASE(n) + \
+					DISPC_BA1_UV_OFFSET(n))
 #define DISPC_OVL_POSITION(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_POS_OFFSET(n))
 #define DISPC_OVL_SIZE(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_SIZE_OFFSET(n))
 #define DISPC_OVL_ATTRIBUTES(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ATTR_OFFSET(n))
+#define DISPC_OVL_ATTRIBUTES2(n)	(DISPC_OVL_BASE(n) + \
+					DISPC_ATTR2_OFFSET(n))
 #define DISPC_OVL_FIFO_THRESHOLD(n)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIFO_THRESH_OFFSET(n))
 #define DISPC_OVL_FIFO_SIZE_STATUS(n)	(DISPC_OVL_BASE(n) + \
@@ -62,20 +68,32 @@
 					DISPC_TABLE_BA_OFFSET(n))
 #define DISPC_OVL_FIR(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_OFFSET(n))
+#define DISPC_OVL_FIR2(n)		(DISPC_OVL_BASE(n) + \
+					DISPC_FIR2_OFFSET(n))
 #define DISPC_OVL_PICTURE_SIZE(n)	(DISPC_OVL_BASE(n) + \
 					DISPC_PIC_SIZE_OFFSET(n))
 #define DISPC_OVL_ACCU0(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ACCU0_OFFSET(n))
 #define DISPC_OVL_ACCU1(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ACCU1_OFFSET(n))
+#define DISPC_OVL_ACCU2_0(n)		(DISPC_OVL_BASE(n) + \
+					DISPC_ACCU2_0_OFFSET(n))
+#define DISPC_OVL_ACCU2_1(n)		(DISPC_OVL_BASE(n) + \
+					DISPC_ACCU2_1_OFFSET(n))
 #define DISPC_OVL_FIR_COEF_H(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_COEF_H_OFFSET(n, i))
 #define DISPC_OVL_FIR_COEF_HV(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_COEF_HV_OFFSET(n, i))
+#define DISPC_OVL_FIR_COEF_H2(n, i)	(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_COEF_H2_OFFSET(n, i))
+#define DISPC_OVL_FIR_COEF_HV2(n, i)	(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_COEF_HV2_OFFSET(n, i))
 #define DISPC_OVL_CONV_COEF(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_CONV_COEF_OFFSET(n, i))
 #define DISPC_OVL_FIR_COEF_V(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_COEF_V_OFFSET(n, i))
+#define DISPC_OVL_FIR_COEF_V2(n, i)	(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_COEF_V2_OFFSET(n, i))
 #define DISPC_OVL_PRELOAD(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_PRELOAD_OFFSET(n))
 
@@ -303,6 +321,34 @@ static inline u16 DISPC_BA1_OFFSET(enum omap_plane plane)
 	}
 }
 
+static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0544;
+	case OMAP_DSS_VIDEO2:
+		return 0x04BC;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0548;
+	case OMAP_DSS_VIDEO2:
+		return 0x04C0;
+	default:
+		BUG();
+	}
+}
+
 static inline u16 DISPC_POS_OFFSET(enum omap_plane plane)
 {
 	switch (plane) {
@@ -340,6 +386,20 @@ static inline u16 DISPC_ATTR_OFFSET(enum omap_plane plane)
 	}
 }
 
+static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0568;
+	case OMAP_DSS_VIDEO2:
+		return 0x04DC;
+	default:
+		BUG();
+	}
+}
+
 static inline u16 DISPC_FIFO_THRESH_OFFSET(enum omap_plane plane)
 {
 	switch (plane) {
@@ -431,6 +491,20 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
 	}
 }
 
+static inline u16 DISPC_FIR2_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0580;
+	case OMAP_DSS_VIDEO2:
+		return 0x055C;
+	default:
+		BUG();
+	}
+}
+
 static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
 {
 	switch (plane) {
@@ -458,6 +532,20 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
 	}
 }
 
+static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0584;
+	case OMAP_DSS_VIDEO2:
+		return 0x0560;
+	default:
+		BUG();
+	}
+}
+
 static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 {
 	switch (plane) {
@@ -471,6 +559,20 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 	}
 }
 
+static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0588;
+	case OMAP_DSS_VIDEO2:
+		return 0x0564;
+	default:
+		BUG();
+	}
+}
+
 /* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
 static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 {
@@ -486,6 +588,21 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 }
 
 /* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x058C + i * 0x8;
+	case OMAP_DSS_VIDEO2:
+		return 0x0568 + i * 0x8;
+	default:
+		BUG();
+	}
+}
+
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
 static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 {
 	switch (plane) {
@@ -499,6 +616,21 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 	}
 }
 
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0590 + i * 8;
+	case OMAP_DSS_VIDEO2:
+		return 0x056C + i * 0x8;
+	default:
+		BUG();
+	}
+}
+
 /* coef index i = {0, 1, 2, 3, 4,} */
 static inline u16 DISPC_CONV_COEF_OFFSET(enum omap_plane plane, u16 i)
 {
@@ -528,6 +660,21 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
 	}
 }
 
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x05CC + i * 0x4;
+	case OMAP_DSS_VIDEO2:
+		return 0x05A8 + i * 0x4;
+	default:
+		BUG();
+	}
+}
+
 static inline u16 DISPC_PRELOAD_OFFSET(enum omap_plane plane)
 {
 	switch (plane) {
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 915f700..8e37d6a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -326,7 +326,7 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
-		FEAT_DSI_GNQ,
+		FEAT_DSI_GNQ | FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index ff2cf33..895b390 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -48,6 +48,8 @@ enum dss_feat_id {
 	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
 	FEAT_DSI_REVERSE_TXCLKESC	= 1 << 17,
 	FEAT_DSI_GNQ			= 1 << 18,
+	FEAT_HANDLE_UV_SEPARATE		= 1 << 18,
+	FEAT_ATTR2			= 1 << 19,
 };
 
 /* DSS register field id */
-- 
1.7.1

