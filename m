From: Archit Taneja <archit@ti.com>
Subject: [RFC][PATCH 4/8] OMAP: DSS2: OMAP4 Secondary LCD Channel DISPC Registers
Date: Thu,  1 Jul 2010 16:01:21 +0530
Message-ID: <1277980285-20996-5-git-send-email-archit@ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
 <1277980285-20996-2-git-send-email-archit@ti.com>
 <1277980285-20996-3-git-send-email-archit@ti.com>
 <1277980285-20996-4-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34578 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755008Ab0GAKbx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:31:53 -0400
In-Reply-To: <1277980285-20996-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, "Semwal, Sumit" <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Semwal, Sumit <sumit.semwal@ti.com>

Introduce OMAP4 DISPC base address and Secondary LCD Channel registers, use them
in register dumps.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   42 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5ecdc00..08b36d6
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -41,9 +41,13 @@
 #include "dss.h"
 
 /* DISPC */
+#ifdef CONFIG_ARCH_OMAP4
+#define DISPC_BASE			0x58001000
+#define DISPC_SZ_REGS			SZ_16K
+#else
 #define DISPC_BASE			0x48050400
-
 #define DISPC_SZ_REGS			SZ_1K
+#endif
 
 struct dispc_reg { u16 idx; };
 
@@ -68,6 +72,7 @@ struct dispc_reg { u16 idx; };
 #define DISPC_TIMING_V			DISPC_REG(0x0068)
 #define DISPC_POL_FREQ			DISPC_REG(0x006C)
 #define DISPC_DIVISOR			DISPC_REG(0x0070)
+#define DISPC_DIVISOR1			DISPC_REG(0x0804)
 #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
 #define DISPC_SIZE_DIG			DISPC_REG(0x0078)
 #define DISPC_SIZE_LCD			DISPC_REG(0x007C)
@@ -131,6 +136,23 @@ struct dispc_reg { u16 idx; };
 					 DISPC_IRQ_SYNC_LOST | \
 					 DISPC_IRQ_SYNC_LOST_DIGIT)
 
+/* OMAP4 new global registers */
+#define DISPC_CONTROL2		DISPC_REG(0x0238)
+#define DISPC_DEFAULT_COLOR2		DISPC_REG(0x03AC)
+#define DISPC_TRANS_COLOR2		DISPC_REG(0x03B0)
+#define DISPC_CPR2_COEF_B		DISPC_REG(0x03B4)
+#define DISPC_CPR2_COEF_G		DISPC_REG(0x03B8)
+#define DISPC_CPR2_COEF_R		DISPC_REG(0x03BC)
+#define DISPC_DATA2_CYCLE1		DISPC_REG(0x03C0)
+#define DISPC_DATA2_CYCLE2		DISPC_REG(0x03C4)
+#define DISPC_DATA2_CYCLE3		DISPC_REG(0x03C8)
+#define DISPC_SIZE_LCD2		DISPC_REG(0x03CC)
+#define DISPC_TIMING_H2		DISPC_REG(0x0400)
+#define DISPC_TIMING_V2		DISPC_REG(0x0404)
+#define DISPC_POL_FREQ2		DISPC_REG(0x0408)
+#define DISPC_DIVISOR2		DISPC_REG(0x040C)
+#define DISPC_CONFIG2		DISPC_REG(0x0620)
+
 #define DISPC_MAX_NR_ISRS		8
 
 struct omap_dispc_isr_data {
@@ -2361,6 +2383,24 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_SIZE_DIG);
 	DUMPREG(DISPC_SIZE_LCD);
 
+	/* OMAP4 LCD2 channel registers*/
+	if (cpu_is_omap44xx()) {
+		DUMPREG(DISPC_CONTROL2);
+		DUMPREG(DISPC_DEFAULT_COLOR2);
+		DUMPREG(DISPC_TRANS_COLOR2);
+		DUMPREG(DISPC_CPR2_COEF_B);
+		DUMPREG(DISPC_CPR2_COEF_G);
+		DUMPREG(DISPC_CPR2_COEF_R);
+		DUMPREG(DISPC_DATA2_CYCLE1);
+		DUMPREG(DISPC_DATA2_CYCLE2);
+		DUMPREG(DISPC_DATA2_CYCLE3);
+		DUMPREG(DISPC_SIZE_LCD2);
+		DUMPREG(DISPC_TIMING_H2);
+		DUMPREG(DISPC_TIMING_V2);
+		DUMPREG(DISPC_POL_FREQ2);
+		DUMPREG(DISPC_DIVISOR2);
+		DUMPREG(DISPC_CONFIG2);
+	}
 	DUMPREG(DISPC_GFX_BA0);
 	DUMPREG(DISPC_GFX_BA1);
 	DUMPREG(DISPC_GFX_POSITION);
-- 
1.6.3.3

