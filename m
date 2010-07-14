From: Archit Taneja <archit@ti.com>
Subject: [RFC v2][PATCH 6/7] OMAP: DSS2: Context Save & Restore of DISPC registers for secondary LCD
Date: Wed, 14 Jul 2010 12:02:46 +0530
Message-ID: <1279089167-14057-7-git-send-email-archit@ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
 <1279089167-14057-3-git-send-email-archit@ti.com>
 <1279089167-14057-4-git-send-email-archit@ti.com>
 <1279089167-14057-5-git-send-email-archit@ti.com>
 <1279089167-14057-6-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab0GNGdX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 02:33:23 -0400
In-Reply-To: <1279089167-14057-6-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Mayuresh Janorkar <mayur@ti.com>, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

Context Save and Restore of DISPC registers for Secondary LCD

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index c7811b4..9f83f7e 
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -230,6 +230,17 @@ void dispc_save_context(void)
 	SR(SIZE_DIG);
 	SR(SIZE_LCD(0));
 
+	if (cpu_is_omap44xx()) {
+		SR(CONTROL(2));
+		SR(DEFAULT_COLOR(2));
+		SR(TRANS_COLOR(2));
+		SR(SIZE_LCD(2));
+		SR(TIMING_H(2));
+		SR(TIMING_V(2));
+		SR(POL_FREQ(2));
+		SR(DIVISOR(2));
+		SR(CONFIG(2));
+	}
 	SR(GFX_BA0);
 	SR(GFX_BA1);
 	SR(GFX_POSITION);
@@ -249,6 +260,15 @@ void dispc_save_context(void)
 	SR(CPR_COEF_G(0));
 	SR(CPR_COEF_B(0));
 
+	if (cpu_is_omap44xx()) {
+		SR(CPR_COEF_B(2));
+		SR(CPR_COEF_G(2));
+		SR(CPR_COEF_R(2));
+
+		SR(DATA_CYCLE1(2));
+		SR(DATA_CYCLE2(2));
+		SR(DATA_CYCLE3(2));
+	}
 	SR(GFX_PRELOAD);
 
 	/* VID1 */
@@ -369,6 +389,22 @@ void dispc_restore_context(void)
 	RR(SIZE_DIG);
 	RR(SIZE_LCD(0));
 
+	if (cpu_is_omap44xx()) {
+		RR(DEFAULT_COLOR(2));
+		RR(TRANS_COLOR(2));
+		RR(CPR_COEF_B(2));
+		RR(CPR_COEF_G(2));
+		RR(CPR_COEF_R(2));
+		RR(DATA_CYCLE1(2));
+		RR(DATA_CYCLE2(2));
+		RR(DATA_CYCLE3(2));
+		RR(SIZE_LCD(2));
+		RR(TIMING_H(2));
+		RR(TIMING_V(2));
+		RR(POL_FREQ(2));
+		RR(DIVISOR(2));
+		RR(CONFIG(2));
+	}
 	RR(GFX_BA0);
 	RR(GFX_BA1);
 	RR(GFX_POSITION);
@@ -490,7 +526,8 @@ void dispc_restore_context(void)
 
 	/* enable last, because LCD & DIGIT enable are here */
 	RR(CONTROL(0));
-
+	if (cpu_is_omap44xx())
+		RR(CONTROL(2));
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 
-- 
1.6.3.3

