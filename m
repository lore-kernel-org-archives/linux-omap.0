From: Archit Taneja <archit@ti.com>
Subject: [RFC][PATCH 7/8] OMAP: DSS2: Context Save and Restore of DISPC registers for Secondary LCD
Date: Thu,  1 Jul 2010 16:01:24 +0530
Message-ID: <1277980285-20996-8-git-send-email-archit@ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
 <1277980285-20996-2-git-send-email-archit@ti.com>
 <1277980285-20996-3-git-send-email-archit@ti.com>
 <1277980285-20996-4-git-send-email-archit@ti.com>
 <1277980285-20996-5-git-send-email-archit@ti.com>
 <1277980285-20996-6-git-send-email-archit@ti.com>
 <1277980285-20996-7-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44402 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755008Ab0GAKcH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:32:07 -0400
In-Reply-To: <1277980285-20996-7-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, Mayuresh Janorkar <mayur@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

Context Save and Restore of DISPC registers for Secondary LCD

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   48 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3dcd3fe..ca90593
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -237,6 +237,17 @@ void dispc_save_context(void)
 	SR(SIZE_DIG);
 	SR(SIZE_LCD);
 
+	if (cpu_is_omap44xx()) {
+		SR(CONTROL2);
+		SR(DEFAULT_COLOR2);
+		SR(TRANS_COLOR2);
+		SR(SIZE_LCD2);
+		SR(TIMING_H2);
+		SR(TIMING_V2);
+		SR(POL_FREQ2);
+		SR(DIVISOR2);
+		SR(CONFIG2);
+	}
 	SR(GFX_BA0);
 	SR(GFX_BA1);
 	SR(GFX_POSITION);
@@ -256,6 +267,15 @@ void dispc_save_context(void)
 	SR(CPR_COEF_G);
 	SR(CPR_COEF_B);
 
+	if (cpu_is_omap44xx()) {
+		SR(CPR2_COEF_B);
+		SR(CPR2_COEF_G);
+		SR(CPR2_COEF_R);
+
+		SR(DATA2_CYCLE1);
+		SR(DATA2_CYCLE2);
+		SR(DATA2_CYCLE3);
+	}
 	SR(GFX_PRELOAD);
 
 	/* VID1 */
@@ -376,6 +396,22 @@ void dispc_restore_context(void)
 	RR(SIZE_DIG);
 	RR(SIZE_LCD);
 
+	if (cpu_is_omap44xx()) {
+		RR(DEFAULT_COLOR2);
+		RR(TRANS_COLOR2);
+		RR(CPR2_COEF_B);
+		RR(CPR2_COEF_G);
+		RR(CPR2_COEF_R);
+		RR(DATA2_CYCLE1);
+		RR(DATA2_CYCLE2);
+		RR(DATA2_CYCLE3);
+		RR(SIZE_LCD2);
+		RR(TIMING_H2);
+		RR(TIMING_V2);
+		RR(POL_FREQ2);
+		RR(DIVISOR2);
+		RR(CONFIG2);
+	}
 	RR(GFX_BA0);
 	RR(GFX_BA1);
 	RR(GFX_POSITION);
@@ -395,6 +431,15 @@ void dispc_restore_context(void)
 	RR(CPR_COEF_G);
 	RR(CPR_COEF_B);
 
+	if (cpu_is_omap44xx()) {
+		RR(CPR2_COEF_B);
+		RR(CPR2_COEF_G);
+		RR(CPR2_COEF_R);
+
+		RR(DATA2_CYCLE1);
+		RR(DATA2_CYCLE2);
+		RR(DATA2_CYCLE3);
+	}
 	RR(GFX_PRELOAD);
 
 	/* VID1 */
@@ -497,7 +542,8 @@ void dispc_restore_context(void)
 
 	/* enable last, because LCD & DIGIT enable are here */
 	RR(CONTROL);
-
+	if (cpu_is_omap44xx())
+		RR(CONTROL2);
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 
-- 
1.6.3.3

