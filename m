From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAP: DSS2: Clean up DISPC overlay register definitions
Date: Fri,  6 May 2011 11:45:49 +0530
Message-ID: <1304662551-23832-2-git-send-email-archit@ti.com>
References: <1304662551-23832-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab1EFGLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 02:11:08 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p466B7Hh012396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 6 May 2011 01:11:07 -0500
In-Reply-To: <1304662551-23832-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Move all DISPC register definitions to a new header dispc.h. There are
separate register offset definitions for GFX, VID1 and VID2 pipeline share
register definitions by using an argument. The introduction of VID3 pipeline
on OMAP4 will not let us use the above method since VID3 pipe register offsets
don't map with VID1 and VID2 offsets.

Represent overlay registers as DISPC_OVL_XXXX(plane), where the plane argument
tells the overlay. Register offsets are calculated as:

DISPC_OVL_XXXX(plane) = DISPC_OVL_BASE(plane) + DISPC_XXXX_OFFSET(plane)

Idea suggested by Tomi Valkeinen.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  884 +++++++++++++++++----------------------
 drivers/video/omap2/dss/dispc.h |  386 +++++++++++++++++
 2 files changed, 771 insertions(+), 499 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dispc.h

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 92a1172..127cc32 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -41,95 +41,11 @@
 
 #include "dss.h"
 #include "dss_features.h"
+#include "dispc.h"
 
 /* DISPC */
 #define DISPC_SZ_REGS			SZ_4K
 
-struct dispc_reg { u16 idx; };
-
-#define DISPC_REG(idx)			((const struct dispc_reg) { idx })
-
-/*
- * DISPC common registers and
- * DISPC channel registers , ch = 0 for LCD, ch = 1 for
- * DIGIT, and ch = 2 for LCD2
- */
-#define DISPC_REVISION			DISPC_REG(0x0000)
-#define DISPC_SYSCONFIG			DISPC_REG(0x0010)
-#define DISPC_SYSSTATUS			DISPC_REG(0x0014)
-#define DISPC_IRQSTATUS			DISPC_REG(0x0018)
-#define DISPC_IRQENABLE			DISPC_REG(0x001C)
-#define DISPC_CONTROL			DISPC_REG(0x0040)
-#define DISPC_CONTROL2			DISPC_REG(0x0238)
-#define DISPC_CONFIG			DISPC_REG(0x0044)
-#define DISPC_CONFIG2			DISPC_REG(0x0620)
-#define DISPC_CAPABLE			DISPC_REG(0x0048)
-#define DISPC_DEFAULT_COLOR(ch)		DISPC_REG(ch == 0 ? 0x004C : \
-					(ch == 1 ? 0x0050 : 0x03AC))
-#define DISPC_TRANS_COLOR(ch)		DISPC_REG(ch == 0 ? 0x0054 : \
-					(ch == 1 ? 0x0058 : 0x03B0))
-#define DISPC_LINE_STATUS		DISPC_REG(0x005C)
-#define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
-#define DISPC_TIMING_H(ch)		DISPC_REG(ch != 2 ? 0x0064 : 0x0400)
-#define DISPC_TIMING_V(ch)		DISPC_REG(ch != 2 ? 0x0068 : 0x0404)
-#define DISPC_POL_FREQ(ch)		DISPC_REG(ch != 2 ? 0x006C : 0x0408)
-#define DISPC_DIVISORo(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
-#define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
-#define DISPC_SIZE_DIG			DISPC_REG(0x0078)
-#define DISPC_SIZE_LCD(ch)		DISPC_REG(ch != 2 ? 0x007C : 0x03CC)
-
-/* DISPC GFX plane */
-#define DISPC_GFX_BA0			DISPC_REG(0x0080)
-#define DISPC_GFX_BA1			DISPC_REG(0x0084)
-#define DISPC_GFX_POSITION		DISPC_REG(0x0088)
-#define DISPC_GFX_SIZE			DISPC_REG(0x008C)
-#define DISPC_GFX_ATTRIBUTES		DISPC_REG(0x00A0)
-#define DISPC_GFX_FIFO_THRESHOLD	DISPC_REG(0x00A4)
-#define DISPC_GFX_FIFO_SIZE_STATUS	DISPC_REG(0x00A8)
-#define DISPC_GFX_ROW_INC		DISPC_REG(0x00AC)
-#define DISPC_GFX_PIXEL_INC		DISPC_REG(0x00B0)
-#define DISPC_GFX_WINDOW_SKIP		DISPC_REG(0x00B4)
-#define DISPC_GFX_TABLE_BA		DISPC_REG(0x00B8)
-
-#define DISPC_DATA_CYCLE1(ch)		DISPC_REG(ch != 2 ? 0x01D4 : 0x03C0)
-#define DISPC_DATA_CYCLE2(ch)		DISPC_REG(ch != 2 ? 0x01D8 : 0x03C4)
-#define DISPC_DATA_CYCLE3(ch)		DISPC_REG(ch != 2 ? 0x01DC : 0x03C8)
-#define DISPC_CPR_COEF_R(ch)		DISPC_REG(ch != 2 ? 0x0220 : 0x03BC)
-#define DISPC_CPR_COEF_G(ch)		DISPC_REG(ch != 2 ? 0x0224 : 0x03B8)
-#define DISPC_CPR_COEF_B(ch)		DISPC_REG(ch != 2 ? 0x0228 : 0x03B4)
-
-#define DISPC_GFX_PRELOAD		DISPC_REG(0x022C)
-
-/* DISPC Video plane, n = 0 for VID1 and n = 1 for VID2 */
-#define DISPC_VID_REG(n, idx)		DISPC_REG(0x00BC + (n)*0x90 + idx)
-
-#define DISPC_VID_BA0(n)		DISPC_VID_REG(n, 0x0000)
-#define DISPC_VID_BA1(n)		DISPC_VID_REG(n, 0x0004)
-#define DISPC_VID_POSITION(n)		DISPC_VID_REG(n, 0x0008)
-#define DISPC_VID_SIZE(n)		DISPC_VID_REG(n, 0x000C)
-#define DISPC_VID_ATTRIBUTES(n)		DISPC_VID_REG(n, 0x0010)
-#define DISPC_VID_FIFO_THRESHOLD(n)	DISPC_VID_REG(n, 0x0014)
-#define DISPC_VID_FIFO_SIZE_STATUS(n)	DISPC_VID_REG(n, 0x0018)
-#define DISPC_VID_ROW_INC(n)		DISPC_VID_REG(n, 0x001C)
-#define DISPC_VID_PIXEL_INC(n)		DISPC_VID_REG(n, 0x0020)
-#define DISPC_VID_FIR(n)		DISPC_VID_REG(n, 0x0024)
-#define DISPC_VID_PICTURE_SIZE(n)	DISPC_VID_REG(n, 0x0028)
-#define DISPC_VID_ACCU0(n)		DISPC_VID_REG(n, 0x002C)
-#define DISPC_VID_ACCU1(n)		DISPC_VID_REG(n, 0x0030)
-
-/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
-#define DISPC_VID_FIR_COEF_H(n, i)	DISPC_REG(0x00F0 + (n)*0x90 + (i)*0x8)
-/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
-#define DISPC_VID_FIR_COEF_HV(n, i)	DISPC_REG(0x00F4 + (n)*0x90 + (i)*0x8)
-/* coef index i = {0, 1, 2, 3, 4} */
-#define DISPC_VID_CONV_COEF(n, i)	DISPC_REG(0x0130 + (n)*0x90 + (i)*0x4)
-/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
-#define DISPC_VID_FIR_COEF_V(n, i)	DISPC_REG(0x01E0 + (n)*0x20 + (i)*0x4)
-
-#define DISPC_VID_PRELOAD(n)		DISPC_REG(0x230 + (n)*0x04)
-
-#define DISPC_DIVISOR			DISPC_REG(0x0804)
-
 #define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
 					 DISPC_IRQ_OCP_ERR | \
 					 DISPC_IRQ_VID1_FIFO_UNDERFLOW | \
@@ -167,10 +83,6 @@ struct dispc_v_coef {
 #define REG_FLD_MOD(idx, val, start, end)				\
 	dispc_write_reg(idx, FLD_MOD(dispc_read_reg(idx), val, start, end))
 
-static const struct dispc_reg dispc_reg_att[] = { DISPC_GFX_ATTRIBUTES,
-	DISPC_VID_ATTRIBUTES(0),
-	DISPC_VID_ATTRIBUTES(1) };
-
 struct dispc_irq_stats {
 	unsigned long last_reset;
 	unsigned irq_count;
@@ -248,16 +160,16 @@ void dispc_save_context(void)
 		SR(CONFIG2);
 	}
 
-	SR(GFX_BA0);
-	SR(GFX_BA1);
-	SR(GFX_POSITION);
-	SR(GFX_SIZE);
-	SR(GFX_ATTRIBUTES);
-	SR(GFX_FIFO_THRESHOLD);
-	SR(GFX_ROW_INC);
-	SR(GFX_PIXEL_INC);
-	SR(GFX_WINDOW_SKIP);
-	SR(GFX_TABLE_BA);
+	SR(OVL_BA0(OMAP_DSS_GFX));
+	SR(OVL_BA1(OMAP_DSS_GFX));
+	SR(OVL_POSITION(OMAP_DSS_GFX));
+	SR(OVL_SIZE(OMAP_DSS_GFX));
+	SR(OVL_ATTRIBUTES(OMAP_DSS_GFX));
+	SR(OVL_FIFO_THRESHOLD(OMAP_DSS_GFX));
+	SR(OVL_ROW_INC(OMAP_DSS_GFX));
+	SR(OVL_PIXEL_INC(OMAP_DSS_GFX));
+	SR(OVL_WINDOW_SKIP(OMAP_DSS_GFX));
+	SR(OVL_TABLE_BA(OMAP_DSS_GFX));
 
 	SR(DATA_CYCLE1(0));
 	SR(DATA_CYCLE2(0));
@@ -276,105 +188,105 @@ void dispc_save_context(void)
 		SR(DATA_CYCLE3(2));
 	}
 
-	SR(GFX_PRELOAD);
+	SR(OVL_PRELOAD(OMAP_DSS_GFX));
 
 	/* VID1 */
-	SR(VID_BA0(0));
-	SR(VID_BA1(0));
-	SR(VID_POSITION(0));
-	SR(VID_SIZE(0));
-	SR(VID_ATTRIBUTES(0));
-	SR(VID_FIFO_THRESHOLD(0));
-	SR(VID_ROW_INC(0));
-	SR(VID_PIXEL_INC(0));
-	SR(VID_FIR(0));
-	SR(VID_PICTURE_SIZE(0));
-	SR(VID_ACCU0(0));
-	SR(VID_ACCU1(0));
-
-	SR(VID_FIR_COEF_H(0, 0));
-	SR(VID_FIR_COEF_H(0, 1));
-	SR(VID_FIR_COEF_H(0, 2));
-	SR(VID_FIR_COEF_H(0, 3));
-	SR(VID_FIR_COEF_H(0, 4));
-	SR(VID_FIR_COEF_H(0, 5));
-	SR(VID_FIR_COEF_H(0, 6));
-	SR(VID_FIR_COEF_H(0, 7));
-
-	SR(VID_FIR_COEF_HV(0, 0));
-	SR(VID_FIR_COEF_HV(0, 1));
-	SR(VID_FIR_COEF_HV(0, 2));
-	SR(VID_FIR_COEF_HV(0, 3));
-	SR(VID_FIR_COEF_HV(0, 4));
-	SR(VID_FIR_COEF_HV(0, 5));
-	SR(VID_FIR_COEF_HV(0, 6));
-	SR(VID_FIR_COEF_HV(0, 7));
-
-	SR(VID_CONV_COEF(0, 0));
-	SR(VID_CONV_COEF(0, 1));
-	SR(VID_CONV_COEF(0, 2));
-	SR(VID_CONV_COEF(0, 3));
-	SR(VID_CONV_COEF(0, 4));
-
-	SR(VID_FIR_COEF_V(0, 0));
-	SR(VID_FIR_COEF_V(0, 1));
-	SR(VID_FIR_COEF_V(0, 2));
-	SR(VID_FIR_COEF_V(0, 3));
-	SR(VID_FIR_COEF_V(0, 4));
-	SR(VID_FIR_COEF_V(0, 5));
-	SR(VID_FIR_COEF_V(0, 6));
-	SR(VID_FIR_COEF_V(0, 7));
-
-	SR(VID_PRELOAD(0));
+	SR(OVL_BA0(OMAP_DSS_VIDEO1));
+	SR(OVL_BA1(OMAP_DSS_VIDEO1));
+	SR(OVL_POSITION(OMAP_DSS_VIDEO1));
+	SR(OVL_SIZE(OMAP_DSS_VIDEO1));
+	SR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO1));
+	SR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO1));
+	SR(OVL_ROW_INC(OMAP_DSS_VIDEO1));
+	SR(OVL_PIXEL_INC(OMAP_DSS_VIDEO1));
+	SR(OVL_FIR(OMAP_DSS_VIDEO1));
+	SR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO1));
+	SR(OVL_ACCU0(OMAP_DSS_VIDEO1));
+	SR(OVL_ACCU1(OMAP_DSS_VIDEO1));
+
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 0));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 1));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 2));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 3));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 4));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 5));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 6));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 7));
+
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 0));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 1));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 2));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 3));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 4));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 5));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 6));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 7));
+
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 0));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 1));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 2));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 3));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 4));
+
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 0));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 1));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 2));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 3));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 4));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 5));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 6));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 7));
+
+	SR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
 
 	/* VID2 */
-	SR(VID_BA0(1));
-	SR(VID_BA1(1));
-	SR(VID_POSITION(1));
-	SR(VID_SIZE(1));
-	SR(VID_ATTRIBUTES(1));
-	SR(VID_FIFO_THRESHOLD(1));
-	SR(VID_ROW_INC(1));
-	SR(VID_PIXEL_INC(1));
-	SR(VID_FIR(1));
-	SR(VID_PICTURE_SIZE(1));
-	SR(VID_ACCU0(1));
-	SR(VID_ACCU1(1));
-
-	SR(VID_FIR_COEF_H(1, 0));
-	SR(VID_FIR_COEF_H(1, 1));
-	SR(VID_FIR_COEF_H(1, 2));
-	SR(VID_FIR_COEF_H(1, 3));
-	SR(VID_FIR_COEF_H(1, 4));
-	SR(VID_FIR_COEF_H(1, 5));
-	SR(VID_FIR_COEF_H(1, 6));
-	SR(VID_FIR_COEF_H(1, 7));
-
-	SR(VID_FIR_COEF_HV(1, 0));
-	SR(VID_FIR_COEF_HV(1, 1));
-	SR(VID_FIR_COEF_HV(1, 2));
-	SR(VID_FIR_COEF_HV(1, 3));
-	SR(VID_FIR_COEF_HV(1, 4));
-	SR(VID_FIR_COEF_HV(1, 5));
-	SR(VID_FIR_COEF_HV(1, 6));
-	SR(VID_FIR_COEF_HV(1, 7));
-
-	SR(VID_CONV_COEF(1, 0));
-	SR(VID_CONV_COEF(1, 1));
-	SR(VID_CONV_COEF(1, 2));
-	SR(VID_CONV_COEF(1, 3));
-	SR(VID_CONV_COEF(1, 4));
-
-	SR(VID_FIR_COEF_V(1, 0));
-	SR(VID_FIR_COEF_V(1, 1));
-	SR(VID_FIR_COEF_V(1, 2));
-	SR(VID_FIR_COEF_V(1, 3));
-	SR(VID_FIR_COEF_V(1, 4));
-	SR(VID_FIR_COEF_V(1, 5));
-	SR(VID_FIR_COEF_V(1, 6));
-	SR(VID_FIR_COEF_V(1, 7));
-
-	SR(VID_PRELOAD(1));
+	SR(OVL_BA0(OMAP_DSS_VIDEO2));
+	SR(OVL_BA1(OMAP_DSS_VIDEO2));
+	SR(OVL_POSITION(OMAP_DSS_VIDEO2));
+	SR(OVL_SIZE(OMAP_DSS_VIDEO2));
+	SR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO2));
+	SR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO2));
+	SR(OVL_ROW_INC(OMAP_DSS_VIDEO2));
+	SR(OVL_PIXEL_INC(OMAP_DSS_VIDEO2));
+	SR(OVL_FIR(OMAP_DSS_VIDEO2));
+	SR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO2));
+	SR(OVL_ACCU0(OMAP_DSS_VIDEO2));
+	SR(OVL_ACCU1(OMAP_DSS_VIDEO2));
+
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 0));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 1));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 2));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 3));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 4));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 5));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 6));
+	SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 7));
+
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 0));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 1));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 2));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 3));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 4));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 5));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 6));
+	SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 7));
+
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 0));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 1));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 2));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 3));
+	SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 4));
+
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 0));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 1));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 2));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 3));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 4));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 5));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 6));
+	SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 7));
+
+	SR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		SR(DIVISOR);
@@ -409,16 +321,17 @@ void dispc_restore_context(void)
 		RR(CONFIG2);
 	}
 
-	RR(GFX_BA0);
-	RR(GFX_BA1);
-	RR(GFX_POSITION);
-	RR(GFX_SIZE);
-	RR(GFX_ATTRIBUTES);
-	RR(GFX_FIFO_THRESHOLD);
-	RR(GFX_ROW_INC);
-	RR(GFX_PIXEL_INC);
-	RR(GFX_WINDOW_SKIP);
-	RR(GFX_TABLE_BA);
+	RR(OVL_BA0(OMAP_DSS_GFX));
+	RR(OVL_BA1(OMAP_DSS_GFX));
+	RR(OVL_POSITION(OMAP_DSS_GFX));
+	RR(OVL_SIZE(OMAP_DSS_GFX));
+	RR(OVL_ATTRIBUTES(OMAP_DSS_GFX));
+	RR(OVL_FIFO_THRESHOLD(OMAP_DSS_GFX));
+	RR(OVL_ROW_INC(OMAP_DSS_GFX));
+	RR(OVL_PIXEL_INC(OMAP_DSS_GFX));
+	RR(OVL_WINDOW_SKIP(OMAP_DSS_GFX));
+	RR(OVL_TABLE_BA(OMAP_DSS_GFX));
+
 
 	RR(DATA_CYCLE1(0));
 	RR(DATA_CYCLE2(0));
@@ -437,105 +350,105 @@ void dispc_restore_context(void)
 		RR(CPR_COEF_R(2));
 	}
 
-	RR(GFX_PRELOAD);
+	RR(OVL_PRELOAD(OMAP_DSS_GFX));
 
 	/* VID1 */
-	RR(VID_BA0(0));
-	RR(VID_BA1(0));
-	RR(VID_POSITION(0));
-	RR(VID_SIZE(0));
-	RR(VID_ATTRIBUTES(0));
-	RR(VID_FIFO_THRESHOLD(0));
-	RR(VID_ROW_INC(0));
-	RR(VID_PIXEL_INC(0));
-	RR(VID_FIR(0));
-	RR(VID_PICTURE_SIZE(0));
-	RR(VID_ACCU0(0));
-	RR(VID_ACCU1(0));
-
-	RR(VID_FIR_COEF_H(0, 0));
-	RR(VID_FIR_COEF_H(0, 1));
-	RR(VID_FIR_COEF_H(0, 2));
-	RR(VID_FIR_COEF_H(0, 3));
-	RR(VID_FIR_COEF_H(0, 4));
-	RR(VID_FIR_COEF_H(0, 5));
-	RR(VID_FIR_COEF_H(0, 6));
-	RR(VID_FIR_COEF_H(0, 7));
-
-	RR(VID_FIR_COEF_HV(0, 0));
-	RR(VID_FIR_COEF_HV(0, 1));
-	RR(VID_FIR_COEF_HV(0, 2));
-	RR(VID_FIR_COEF_HV(0, 3));
-	RR(VID_FIR_COEF_HV(0, 4));
-	RR(VID_FIR_COEF_HV(0, 5));
-	RR(VID_FIR_COEF_HV(0, 6));
-	RR(VID_FIR_COEF_HV(0, 7));
-
-	RR(VID_CONV_COEF(0, 0));
-	RR(VID_CONV_COEF(0, 1));
-	RR(VID_CONV_COEF(0, 2));
-	RR(VID_CONV_COEF(0, 3));
-	RR(VID_CONV_COEF(0, 4));
-
-	RR(VID_FIR_COEF_V(0, 0));
-	RR(VID_FIR_COEF_V(0, 1));
-	RR(VID_FIR_COEF_V(0, 2));
-	RR(VID_FIR_COEF_V(0, 3));
-	RR(VID_FIR_COEF_V(0, 4));
-	RR(VID_FIR_COEF_V(0, 5));
-	RR(VID_FIR_COEF_V(0, 6));
-	RR(VID_FIR_COEF_V(0, 7));
-
-	RR(VID_PRELOAD(0));
+	RR(OVL_BA0(OMAP_DSS_VIDEO1));
+	RR(OVL_BA1(OMAP_DSS_VIDEO1));
+	RR(OVL_POSITION(OMAP_DSS_VIDEO1));
+	RR(OVL_SIZE(OMAP_DSS_VIDEO1));
+	RR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO1));
+	RR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO1));
+	RR(OVL_ROW_INC(OMAP_DSS_VIDEO1));
+	RR(OVL_PIXEL_INC(OMAP_DSS_VIDEO1));
+	RR(OVL_FIR(OMAP_DSS_VIDEO1));
+	RR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO1));
+	RR(OVL_ACCU0(OMAP_DSS_VIDEO1));
+	RR(OVL_ACCU1(OMAP_DSS_VIDEO1));
+
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 0));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 1));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 2));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 3));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 4));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 5));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 6));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 7));
+
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 0));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 1));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 2));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 3));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 4));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 5));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 6));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 7));
+
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 0));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 1));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 2));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 3));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, 4));
+
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 0));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 1));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 2));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 3));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 4));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 5));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 6));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 7));
+
+	RR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
 
 	/* VID2 */
-	RR(VID_BA0(1));
-	RR(VID_BA1(1));
-	RR(VID_POSITION(1));
-	RR(VID_SIZE(1));
-	RR(VID_ATTRIBUTES(1));
-	RR(VID_FIFO_THRESHOLD(1));
-	RR(VID_ROW_INC(1));
-	RR(VID_PIXEL_INC(1));
-	RR(VID_FIR(1));
-	RR(VID_PICTURE_SIZE(1));
-	RR(VID_ACCU0(1));
-	RR(VID_ACCU1(1));
-
-	RR(VID_FIR_COEF_H(1, 0));
-	RR(VID_FIR_COEF_H(1, 1));
-	RR(VID_FIR_COEF_H(1, 2));
-	RR(VID_FIR_COEF_H(1, 3));
-	RR(VID_FIR_COEF_H(1, 4));
-	RR(VID_FIR_COEF_H(1, 5));
-	RR(VID_FIR_COEF_H(1, 6));
-	RR(VID_FIR_COEF_H(1, 7));
-
-	RR(VID_FIR_COEF_HV(1, 0));
-	RR(VID_FIR_COEF_HV(1, 1));
-	RR(VID_FIR_COEF_HV(1, 2));
-	RR(VID_FIR_COEF_HV(1, 3));
-	RR(VID_FIR_COEF_HV(1, 4));
-	RR(VID_FIR_COEF_HV(1, 5));
-	RR(VID_FIR_COEF_HV(1, 6));
-	RR(VID_FIR_COEF_HV(1, 7));
-
-	RR(VID_CONV_COEF(1, 0));
-	RR(VID_CONV_COEF(1, 1));
-	RR(VID_CONV_COEF(1, 2));
-	RR(VID_CONV_COEF(1, 3));
-	RR(VID_CONV_COEF(1, 4));
-
-	RR(VID_FIR_COEF_V(1, 0));
-	RR(VID_FIR_COEF_V(1, 1));
-	RR(VID_FIR_COEF_V(1, 2));
-	RR(VID_FIR_COEF_V(1, 3));
-	RR(VID_FIR_COEF_V(1, 4));
-	RR(VID_FIR_COEF_V(1, 5));
-	RR(VID_FIR_COEF_V(1, 6));
-	RR(VID_FIR_COEF_V(1, 7));
-
-	RR(VID_PRELOAD(1));
+	RR(OVL_BA0(OMAP_DSS_VIDEO2));
+	RR(OVL_BA1(OMAP_DSS_VIDEO2));
+	RR(OVL_POSITION(OMAP_DSS_VIDEO2));
+	RR(OVL_SIZE(OMAP_DSS_VIDEO2));
+	RR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO2));
+	RR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO2));
+	RR(OVL_ROW_INC(OMAP_DSS_VIDEO2));
+	RR(OVL_PIXEL_INC(OMAP_DSS_VIDEO2));
+	RR(OVL_FIR(OMAP_DSS_VIDEO2));
+	RR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO2));
+	RR(OVL_ACCU0(OMAP_DSS_VIDEO2));
+	RR(OVL_ACCU1(OMAP_DSS_VIDEO2));
+
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 0));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 1));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 2));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 3));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 4));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 5));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 6));
+	RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 7));
+
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 0));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 1));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 2));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 3));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 4));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 5));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 6));
+	RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 7));
+
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 0));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 1));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 2));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 3));
+	RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, 4));
+
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 0));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 1));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 2));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 3));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 4));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 5));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 6));
+	RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 7));
+
+	RR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		RR(DIVISOR);
@@ -632,23 +545,17 @@ end:
 
 static void _dispc_write_firh_reg(enum omap_plane plane, int reg, u32 value)
 {
-	BUG_ON(plane == OMAP_DSS_GFX);
-
-	dispc_write_reg(DISPC_VID_FIR_COEF_H(plane-1, reg), value);
+	dispc_write_reg(DISPC_OVL_FIR_COEF_H(plane, reg), value);
 }
 
 static void _dispc_write_firhv_reg(enum omap_plane plane, int reg, u32 value)
 {
-	BUG_ON(plane == OMAP_DSS_GFX);
-
-	dispc_write_reg(DISPC_VID_FIR_COEF_HV(plane-1, reg), value);
+	dispc_write_reg(DISPC_OVL_FIR_COEF_HV(plane, reg), value);
 }
 
 static void _dispc_write_firv_reg(enum omap_plane plane, int reg, u32 value)
 {
-	BUG_ON(plane == OMAP_DSS_GFX);
-
-	dispc_write_reg(DISPC_VID_FIR_COEF_V(plane-1, reg), value);
+	dispc_write_reg(DISPC_OVL_FIR_COEF_V(plane, reg), value);
 }
 
 static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
@@ -779,72 +686,73 @@ static void _dispc_setup_color_conv_coef(void)
 
 	ct = &ctbl_bt601_5;
 
-	dispc_write_reg(DISPC_VID_CONV_COEF(0, 0), CVAL(ct->rcr, ct->ry));
-	dispc_write_reg(DISPC_VID_CONV_COEF(0, 1), CVAL(ct->gy,	 ct->rcb));
-	dispc_write_reg(DISPC_VID_CONV_COEF(0, 2), CVAL(ct->gcb, ct->gcr));
-	dispc_write_reg(DISPC_VID_CONV_COEF(0, 3), CVAL(ct->bcr, ct->by));
-	dispc_write_reg(DISPC_VID_CONV_COEF(0, 4), CVAL(0,       ct->bcb));
-
-	dispc_write_reg(DISPC_VID_CONV_COEF(1, 0), CVAL(ct->rcr, ct->ry));
-	dispc_write_reg(DISPC_VID_CONV_COEF(1, 1), CVAL(ct->gy,	 ct->rcb));
-	dispc_write_reg(DISPC_VID_CONV_COEF(1, 2), CVAL(ct->gcb, ct->gcr));
-	dispc_write_reg(DISPC_VID_CONV_COEF(1, 3), CVAL(ct->bcr, ct->by));
-	dispc_write_reg(DISPC_VID_CONV_COEF(1, 4), CVAL(0,       ct->bcb));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 0),
+		CVAL(ct->rcr, ct->ry));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 1),
+		CVAL(ct->gy,  ct->rcb));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 2),
+		CVAL(ct->gcb, ct->gcr));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 3),
+		CVAL(ct->bcr, ct->by));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 4),
+		CVAL(0, ct->bcb));
+
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 0),
+		CVAL(ct->rcr, ct->ry));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 1),
+		CVAL(ct->gy, ct->rcb));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 2),
+		CVAL(ct->gcb, ct->gcr));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 3),
+		CVAL(ct->bcr, ct->by));
+	dispc_write_reg(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 4),
+		CVAL(0, ct->bcb));
 
 #undef CVAL
 
-	REG_FLD_MOD(DISPC_VID_ATTRIBUTES(0), ct->full_range, 11, 11);
-	REG_FLD_MOD(DISPC_VID_ATTRIBUTES(1), ct->full_range, 11, 11);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(OMAP_DSS_VIDEO1),
+		ct->full_range, 11, 11);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(OMAP_DSS_VIDEO2),
+		ct->full_range, 11, 11);
 }
 
 
 static void _dispc_set_plane_ba0(enum omap_plane plane, u32 paddr)
 {
-	const struct dispc_reg ba0_reg[] = { DISPC_GFX_BA0,
-		DISPC_VID_BA0(0),
-		DISPC_VID_BA0(1) };
-
-	dispc_write_reg(ba0_reg[plane], paddr);
+	dispc_write_reg(DISPC_OVL_BA0(plane), paddr);
 }
 
 static void _dispc_set_plane_ba1(enum omap_plane plane, u32 paddr)
 {
-	const struct dispc_reg ba1_reg[] = { DISPC_GFX_BA1,
-				      DISPC_VID_BA1(0),
-				      DISPC_VID_BA1(1) };
-
-	dispc_write_reg(ba1_reg[plane], paddr);
+	dispc_write_reg(DISPC_OVL_BA1(plane), paddr);
 }
 
 static void _dispc_set_plane_pos(enum omap_plane plane, int x, int y)
 {
-	const struct dispc_reg pos_reg[] = { DISPC_GFX_POSITION,
-				      DISPC_VID_POSITION(0),
-				      DISPC_VID_POSITION(1) };
-
 	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
-	dispc_write_reg(pos_reg[plane], val);
+
+	dispc_write_reg(DISPC_OVL_POSITION(plane), val);
 }
 
 static void _dispc_set_pic_size(enum omap_plane plane, int width, int height)
 {
-	const struct dispc_reg siz_reg[] = { DISPC_GFX_SIZE,
-				      DISPC_VID_PICTURE_SIZE(0),
-				      DISPC_VID_PICTURE_SIZE(1) };
 	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	dispc_write_reg(siz_reg[plane], val);
+
+	if (plane == OMAP_DSS_GFX)
+		dispc_write_reg(DISPC_OVL_SIZE(plane), val);
+	else
+		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
 }
 
 static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
 {
 	u32 val;
-	const struct dispc_reg vsi_reg[] = { DISPC_VID_SIZE(0),
-				      DISPC_VID_SIZE(1) };
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	dispc_write_reg(vsi_reg[plane-1], val);
+
+	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
 static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
@@ -856,7 +764,7 @@ static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 		plane == OMAP_DSS_VIDEO1)
 		return;
 
-	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 28, 28);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 28, 28);
 }
 
 static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
@@ -876,20 +784,12 @@ static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 
 static void _dispc_set_pix_inc(enum omap_plane plane, s32 inc)
 {
-	const struct dispc_reg ri_reg[] = { DISPC_GFX_PIXEL_INC,
-				     DISPC_VID_PIXEL_INC(0),
-				     DISPC_VID_PIXEL_INC(1) };
-
-	dispc_write_reg(ri_reg[plane], inc);
+	dispc_write_reg(DISPC_OVL_PIXEL_INC(plane), inc);
 }
 
 static void _dispc_set_row_inc(enum omap_plane plane, s32 inc)
 {
-	const struct dispc_reg ri_reg[] = { DISPC_GFX_ROW_INC,
-				     DISPC_VID_ROW_INC(0),
-				     DISPC_VID_ROW_INC(1) };
-
-	dispc_write_reg(ri_reg[plane], inc);
+	dispc_write_reg(DISPC_OVL_ROW_INC(plane), inc);
 }
 
 static void _dispc_set_color_mode(enum omap_plane plane,
@@ -930,7 +830,7 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 		BUG(); break;
 	}
 
-	REG_FLD_MOD(dispc_reg_att[plane], m, 4, 1);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
 static void _dispc_set_channel_out(enum omap_plane plane,
@@ -953,7 +853,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 		return;
 	}
 
-	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		switch (channel) {
 		case OMAP_DSS_CHANNEL_LCD:
@@ -977,7 +877,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 	} else {
 		val = FLD_MOD(val, channel, shift, shift);
 	}
-	dispc_write_reg(dispc_reg_att[plane], val);
+	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
 void dispc_set_burst_size(enum omap_plane plane,
@@ -1001,9 +901,9 @@ void dispc_set_burst_size(enum omap_plane plane,
 		return;
 	}
 
-	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 	val = FLD_MOD(val, burst_size, shift+1, shift);
-	dispc_write_reg(dispc_reg_att[plane], val);
+	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 
 	enable_clocks(0);
 }
@@ -1028,9 +928,9 @@ static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	val = dispc_read_reg(dispc_reg_att[plane]);
+	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 	val = FLD_MOD(val, enable, 9, 9);
-	dispc_write_reg(dispc_reg_att[plane], val);
+	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
 void dispc_enable_replication(enum omap_plane plane, bool enable)
@@ -1043,7 +943,7 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
 		bit = 10;
 
 	enable_clocks(1);
-	REG_FLD_MOD(dispc_reg_att[plane], enable, bit, bit);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, bit, bit);
 	enable_clocks(0);
 }
 
@@ -1069,9 +969,6 @@ void dispc_set_digit_size(u16 width, u16 height)
 
 static void dispc_read_plane_fifo_sizes(void)
 {
-	const struct dispc_reg fsz_reg[] = { DISPC_GFX_FIFO_SIZE_STATUS,
-				      DISPC_VID_FIFO_SIZE_STATUS(0),
-				      DISPC_VID_FIFO_SIZE_STATUS(1) };
 	u32 size;
 	int plane;
 	u8 start, end;
@@ -1081,7 +978,8 @@ static void dispc_read_plane_fifo_sizes(void)
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
 	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
-		size = FLD_GET(dispc_read_reg(fsz_reg[plane]), start, end);
+		size = FLD_GET(dispc_read_reg(DISPC_OVL_FIFO_SIZE_STATUS(plane)),
+			start, end);
 		dispc.fifo_size[plane] = size;
 	}
 
@@ -1095,23 +993,22 @@ u32 dispc_get_plane_fifo_size(enum omap_plane plane)
 
 void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 {
-	const struct dispc_reg ftrs_reg[] = { DISPC_GFX_FIFO_THRESHOLD,
-				       DISPC_VID_FIFO_THRESHOLD(0),
-				       DISPC_VID_FIFO_THRESHOLD(1) };
 	u8 hi_start, hi_end, lo_start, lo_end;
 
+	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
+	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
+
 	enable_clocks(1);
 
 	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
 			plane,
-			REG_GET(ftrs_reg[plane], 11, 0),
-			REG_GET(ftrs_reg[plane], 27, 16),
+			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
+				lo_start, lo_end),
+			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
+				hi_start, hi_end),
 			low, high);
 
-	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
-	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
-
-	dispc_write_reg(ftrs_reg[plane],
+	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
 			FLD_VAL(high, hi_start, hi_end) |
 			FLD_VAL(low, lo_start, lo_end));
 
@@ -1131,55 +1028,43 @@ void dispc_enable_fifomerge(bool enable)
 static void _dispc_set_fir(enum omap_plane plane, int hinc, int vinc)
 {
 	u32 val;
-	const struct dispc_reg fir_reg[] = { DISPC_VID_FIR(0),
-				      DISPC_VID_FIR(1) };
 	u8 hinc_start, hinc_end, vinc_start, vinc_end;
 
-	BUG_ON(plane == OMAP_DSS_GFX);
-
 	dss_feat_get_reg_field(FEAT_REG_FIRHINC, &hinc_start, &hinc_end);
 	dss_feat_get_reg_field(FEAT_REG_FIRVINC, &vinc_start, &vinc_end);
 
 	val = FLD_VAL(vinc, vinc_start, vinc_end) |
 			FLD_VAL(hinc, hinc_start, hinc_end);
 
-	dispc_write_reg(fir_reg[plane-1], val);
+	dispc_write_reg(DISPC_OVL_FIR(plane), val);
 }
 
 static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
-	const struct dispc_reg ac0_reg[] = { DISPC_VID_ACCU0(0),
-				      DISPC_VID_ACCU0(1) };
 	u8 hor_start, hor_end, vert_start, vert_end;
 
-	BUG_ON(plane == OMAP_DSS_GFX);
-
 	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
 	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
 
 	val = FLD_VAL(vaccu, vert_start, vert_end) |
 			FLD_VAL(haccu, hor_start, hor_end);
 
-	dispc_write_reg(ac0_reg[plane-1], val);
+	dispc_write_reg(DISPC_OVL_ACCU0(plane), val);
 }
 
 static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
-	const struct dispc_reg ac1_reg[] = { DISPC_VID_ACCU1(0),
-				      DISPC_VID_ACCU1(1) };
 	u8 hor_start, hor_end, vert_start, vert_end;
 
-	BUG_ON(plane == OMAP_DSS_GFX);
-
 	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
 	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
 
 	val = FLD_VAL(vaccu, vert_start, vert_end) |
 			FLD_VAL(haccu, hor_start, hor_end);
 
-	dispc_write_reg(ac1_reg[plane-1], val);
+	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
 }
 
 
@@ -1215,7 +1100,7 @@ static void _dispc_set_scaling(enum omap_plane plane,
 
 	_dispc_set_fir(plane, fir_hinc, fir_vinc);
 
-	l = dispc_read_reg(dispc_reg_att[plane]);
+	l = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 
 	/* RESIZEENABLE and VERTICALTAPS */
 	l &= ~((0x3 << 5) | (0x1 << 21));
@@ -1236,7 +1121,7 @@ static void _dispc_set_scaling(enum omap_plane plane,
 		l |= five_taps ? (1 << 22) : 0;
 	}
 
-	dispc_write_reg(dispc_reg_att[plane], l);
+	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), l);
 
 	/*
 	 * field 0 = even field = bottom field
@@ -1302,9 +1187,10 @@ static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 			row_repeat = false;
 	}
 
-	REG_FLD_MOD(dispc_reg_att[plane], vidrot, 13, 12);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), vidrot, 13, 12);
 	if (dss_has_feature(FEAT_ROWREPEATENABLE))
-		REG_FLD_MOD(dispc_reg_att[plane], row_repeat ? 1 : 0, 18, 18);
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane),
+			row_repeat ? 1 : 0, 18, 18);
 }
 
 static int color_mode_to_bpp(enum omap_color_mode color_mode)
@@ -1806,7 +1692,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 
 static void _dispc_enable_plane(enum omap_plane plane, bool enable)
 {
-	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 0, 0);
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 0, 0);
 }
 
 static void dispc_disable_isr(void *data, u32 mask)
@@ -2528,7 +2414,7 @@ void dispc_dump_irqs(struct seq_file *s)
 
 void dispc_dump_regs(struct seq_file *s)
 {
-#define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dispc_read_reg(r))
+#define DUMPREG(r) seq_printf(s, "%-50s %08x\n", #r, dispc_read_reg(r))
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
@@ -2565,17 +2451,17 @@ void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(DISPC_SIZE_LCD(2));
 	}
 
-	DUMPREG(DISPC_GFX_BA0);
-	DUMPREG(DISPC_GFX_BA1);
-	DUMPREG(DISPC_GFX_POSITION);
-	DUMPREG(DISPC_GFX_SIZE);
-	DUMPREG(DISPC_GFX_ATTRIBUTES);
-	DUMPREG(DISPC_GFX_FIFO_THRESHOLD);
-	DUMPREG(DISPC_GFX_FIFO_SIZE_STATUS);
-	DUMPREG(DISPC_GFX_ROW_INC);
-	DUMPREG(DISPC_GFX_PIXEL_INC);
-	DUMPREG(DISPC_GFX_WINDOW_SKIP);
-	DUMPREG(DISPC_GFX_TABLE_BA);
+	DUMPREG(DISPC_OVL_BA0(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_BA1(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_POSITION(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_SIZE(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_ATTRIBUTES(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_FIFO_THRESHOLD(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_FIFO_SIZE_STATUS(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_ROW_INC(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_PIXEL_INC(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_WINDOW_SKIP(OMAP_DSS_GFX));
+	DUMPREG(DISPC_OVL_TABLE_BA(OMAP_DSS_GFX));
 
 	DUMPREG(DISPC_DATA_CYCLE1(0));
 	DUMPREG(DISPC_DATA_CYCLE2(0));
@@ -2594,98 +2480,98 @@ void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(DISPC_CPR_COEF_B(2));
 	}
 
-	DUMPREG(DISPC_GFX_PRELOAD);
-
-	DUMPREG(DISPC_VID_BA0(0));
-	DUMPREG(DISPC_VID_BA1(0));
-	DUMPREG(DISPC_VID_POSITION(0));
-	DUMPREG(DISPC_VID_SIZE(0));
-	DUMPREG(DISPC_VID_ATTRIBUTES(0));
-	DUMPREG(DISPC_VID_FIFO_THRESHOLD(0));
-	DUMPREG(DISPC_VID_FIFO_SIZE_STATUS(0));
-	DUMPREG(DISPC_VID_ROW_INC(0));
-	DUMPREG(DISPC_VID_PIXEL_INC(0));
-	DUMPREG(DISPC_VID_FIR(0));
-	DUMPREG(DISPC_VID_PICTURE_SIZE(0));
-	DUMPREG(DISPC_VID_ACCU0(0));
-	DUMPREG(DISPC_VID_ACCU1(0));
-
-	DUMPREG(DISPC_VID_BA0(1));
-	DUMPREG(DISPC_VID_BA1(1));
-	DUMPREG(DISPC_VID_POSITION(1));
-	DUMPREG(DISPC_VID_SIZE(1));
-	DUMPREG(DISPC_VID_ATTRIBUTES(1));
-	DUMPREG(DISPC_VID_FIFO_THRESHOLD(1));
-	DUMPREG(DISPC_VID_FIFO_SIZE_STATUS(1));
-	DUMPREG(DISPC_VID_ROW_INC(1));
-	DUMPREG(DISPC_VID_PIXEL_INC(1));
-	DUMPREG(DISPC_VID_FIR(1));
-	DUMPREG(DISPC_VID_PICTURE_SIZE(1));
-	DUMPREG(DISPC_VID_ACCU0(1));
-	DUMPREG(DISPC_VID_ACCU1(1));
-
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 0));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 1));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 2));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 3));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 5));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 6));
-	DUMPREG(DISPC_VID_FIR_COEF_H(0, 7));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 0));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 1));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 2));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 3));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 5));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 6));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(0, 7));
-	DUMPREG(DISPC_VID_CONV_COEF(0, 0));
-	DUMPREG(DISPC_VID_CONV_COEF(0, 1));
-	DUMPREG(DISPC_VID_CONV_COEF(0, 2));
-	DUMPREG(DISPC_VID_CONV_COEF(0, 3));
-	DUMPREG(DISPC_VID_CONV_COEF(0, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 0));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 1));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 2));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 3));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 5));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 6));
-	DUMPREG(DISPC_VID_FIR_COEF_V(0, 7));
-
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 0));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 1));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 2));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 3));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 5));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 6));
-	DUMPREG(DISPC_VID_FIR_COEF_H(1, 7));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 0));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 1));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 2));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 3));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 5));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 6));
-	DUMPREG(DISPC_VID_FIR_COEF_HV(1, 7));
-	DUMPREG(DISPC_VID_CONV_COEF(1, 0));
-	DUMPREG(DISPC_VID_CONV_COEF(1, 1));
-	DUMPREG(DISPC_VID_CONV_COEF(1, 2));
-	DUMPREG(DISPC_VID_CONV_COEF(1, 3));
-	DUMPREG(DISPC_VID_CONV_COEF(1, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 0));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 1));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 2));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 3));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 4));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 5));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 6));
-	DUMPREG(DISPC_VID_FIR_COEF_V(1, 7));
-
-	DUMPREG(DISPC_VID_PRELOAD(0));
-	DUMPREG(DISPC_VID_PRELOAD(1));
+	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_GFX));
+
+	DUMPREG(DISPC_OVL_BA0(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_BA1(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_POSITION(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_SIZE(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_ATTRIBUTES(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_FIFO_SIZE_STATUS(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_ROW_INC(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_PIXEL_INC(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_FIR(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_PICTURE_SIZE(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_ACCU0(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_ACCU1(OMAP_DSS_VIDEO1));
+
+	DUMPREG(DISPC_OVL_BA0(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_BA1(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_POSITION(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_SIZE(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_ATTRIBUTES(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_FIFO_SIZE_STATUS(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_ROW_INC(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_PIXEL_INC(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_FIR(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_PICTURE_SIZE(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_ACCU0(OMAP_DSS_VIDEO2));
+	DUMPREG(DISPC_OVL_ACCU1(OMAP_DSS_VIDEO2));
+
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 0));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 1));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 2));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 3));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 5));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 6));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, 7));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 0));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 1));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 2));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 3));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 5));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 6));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, 7));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 0));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 1));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 2));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 3));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 0));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 1));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 2));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 3));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 5));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 6));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 7));
+
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 0));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 1));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 2));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 3));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 5));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 6));
+	DUMPREG(DISPC_OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, 7));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 0));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 1));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 2));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 3));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 5));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 6));
+	DUMPREG(DISPC_OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, 7));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 0));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 1));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 2));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 3));
+	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 0));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 1));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 2));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 3));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 4));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 5));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 6));
+	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 7));
+
+	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO1));
+	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
new file mode 100644
index 0000000..f22346b
--- /dev/null
+++ b/drivers/video/omap2/dss/dispc.h
@@ -0,0 +1,386 @@
+/*
+ * linux/drivers/video/omap2/dss/dispc.h
+ *
+ * Copyright (C) 2011 Texas Instruments
+ * Author: Archit Taneja <archit@ti.com>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __OMAP2_DISPC_REG_H
+#define __OMAP2_DISPC_REG_H
+
+struct dispc_reg { u16 idx; };
+
+#define DISPC_REG(idx)			((const struct dispc_reg) { idx })
+
+/*
+ * DISPC common registers and
+ * DISPC channel registers , ch = 0 for LCD, ch = 1 for
+ * DIGIT, and ch = 2 for LCD2
+ */
+#define DISPC_REVISION			DISPC_REG(0x0000)
+#define DISPC_SYSCONFIG			DISPC_REG(0x0010)
+#define DISPC_SYSSTATUS			DISPC_REG(0x0014)
+#define DISPC_IRQSTATUS			DISPC_REG(0x0018)
+#define DISPC_IRQENABLE			DISPC_REG(0x001C)
+#define DISPC_CONTROL			DISPC_REG(0x0040)
+#define DISPC_CONTROL2			DISPC_REG(0x0238)
+#define DISPC_CONFIG			DISPC_REG(0x0044)
+#define DISPC_CONFIG2			DISPC_REG(0x0620)
+#define DISPC_CAPABLE			DISPC_REG(0x0048)
+#define DISPC_DEFAULT_COLOR(ch)		DISPC_REG(ch == 0 ? 0x004C : \
+					(ch == 1 ? 0x0050 : 0x03AC))
+#define DISPC_TRANS_COLOR(ch)		DISPC_REG(ch == 0 ? 0x0054 : \
+					(ch == 1 ? 0x0058 : 0x03B0))
+#define DISPC_LINE_STATUS		DISPC_REG(0x005C)
+#define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
+#define DISPC_TIMING_H(ch)		DISPC_REG(ch != 2 ? 0x0064 : 0x0400)
+#define DISPC_TIMING_V(ch)		DISPC_REG(ch != 2 ? 0x0068 : 0x0404)
+#define DISPC_POL_FREQ(ch)		DISPC_REG(ch != 2 ? 0x006C : 0x0408)
+#define DISPC_DIVISORo(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
+#define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
+#define DISPC_SIZE_DIG			DISPC_REG(0x0078)
+#define DISPC_SIZE_LCD(ch)		DISPC_REG(ch != 2 ? 0x007C : 0x03CC)
+
+#define DISPC_DATA_CYCLE1(ch)		DISPC_REG(ch != 2 ? 0x01D4 : 0x03C0)
+#define DISPC_DATA_CYCLE2(ch)		DISPC_REG(ch != 2 ? 0x01D8 : 0x03C4)
+#define DISPC_DATA_CYCLE3(ch)		DISPC_REG(ch != 2 ? 0x01DC : 0x03C8)
+#define DISPC_CPR_COEF_R(ch)		DISPC_REG(ch != 2 ? 0x0220 : 0x03BC)
+#define DISPC_CPR_COEF_G(ch)		DISPC_REG(ch != 2 ? 0x0224 : 0x03B8)
+#define DISPC_CPR_COEF_B(ch)		DISPC_REG(ch != 2 ? 0x0228 : 0x03B4)
+
+#define DISPC_DIVISOR			DISPC_REG(0x0804)
+
+/* DISPC overlay registers */
+#define DISPC_OVL_BA0(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_BA0_OFFSET(n))
+#define DISPC_OVL_BA1(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_BA1_OFFSET(n))
+#define DISPC_OVL_POSITION(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_POS_OFFSET(n))
+#define DISPC_OVL_SIZE(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_SIZE_OFFSET(n))
+#define DISPC_OVL_ATTRIBUTES(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_ATTR_OFFSET(n))
+#define DISPC_OVL_FIFO_THRESHOLD(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_FIFO_THRESH_OFFSET(n))
+#define DISPC_OVL_FIFO_SIZE_STATUS(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_FIFO_SIZE_STATUS_OFFSET(n))
+#define DISPC_OVL_ROW_INC(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_ROW_INC_OFFSET(n))
+#define DISPC_OVL_PIXEL_INC(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_PIX_INC_OFFSET(n))
+#define DISPC_OVL_WINDOW_SKIP(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_WINDOW_SKIP_OFFSET(n))
+#define DISPC_OVL_TABLE_BA(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_TABLE_BA_OFFSET(n))
+#define DISPC_OVL_FIR(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_OFFSET(n))
+#define DISPC_OVL_PICTURE_SIZE(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_PIC_SIZE_OFFSET(n))
+#define DISPC_OVL_ACCU0(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_ACCU0_OFFSET(n))
+#define DISPC_OVL_ACCU1(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_ACCU1_OFFSET(n))
+#define DISPC_OVL_FIR_COEF_H(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_COEF_H_OFFSET(n, i))
+#define DISPC_OVL_FIR_COEF_HV(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_COEF_HV_OFFSET(n, i))
+#define DISPC_OVL_CONV_COEF(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_CONV_COEF_OFFSET(n, i))
+#define DISPC_OVL_FIR_COEF_V(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_FIR_COEF_V_OFFSET(n, i))
+#define DISPC_OVL_PRELOAD(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+					DISPC_PRELOAD_OFFSET(n))
+
+/* DISPC overlay register base addresses */
+static inline u16 DISPC_OVL_BASE(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0080;
+	case OMAP_DSS_VIDEO1:
+		return 0x00BC;
+	case OMAP_DSS_VIDEO2:
+		return 0x014C;
+	default:
+		BUG();
+	}
+}
+
+/* DISPC overlay register offsets */
+static inline u16 DISPC_BA0_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0000;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_BA1_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0004;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_POS_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0008;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_SIZE_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x000C;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_ATTR_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0020;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0010;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_FIFO_THRESH_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0024;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0014;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_FIFO_SIZE_STATUS_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0028;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0018;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_ROW_INC_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x002C;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x001C;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_PIX_INC_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0030;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0020;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_WINDOW_SKIP_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0034;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		BUG();
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_TABLE_BA_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0038;
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		BUG();
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0024;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0028;
+	default:
+		BUG();
+	}
+}
+
+
+static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x002C;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0030;
+	default:
+		BUG();
+	}
+}
+
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0034 + i * 0x8;
+	default:
+		BUG();
+	}
+}
+
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0038 + i * 0x8;
+	default:
+		BUG();
+	}
+}
+
+/* coef index i = {0, 1, 2, 3, 4,} */
+static inline u16 DISPC_CONV_COEF_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+	case OMAP_DSS_VIDEO2:
+		return 0x0074 + i * 0x4;
+	default:
+		BUG();
+	}
+}
+
+/* coef index i = {0, 1, 2, 3, 4, 5, 6, 7} */
+static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		BUG();
+	case OMAP_DSS_VIDEO1:
+		return 0x0124 + i * 0x4;
+	case OMAP_DSS_VIDEO2:
+		return 0x00B4 + i * 0x4;
+	default:
+		BUG();
+	}
+}
+
+static inline u16 DISPC_PRELOAD_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x01AC;
+	case OMAP_DSS_VIDEO1:
+		return 0x0174;
+	case OMAP_DSS_VIDEO2:
+		return 0x00E8;
+	default:
+		BUG();
+	}
+}
+#endif
-- 
1.7.1

