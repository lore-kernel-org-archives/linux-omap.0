From: Archit Taneja <archit@ti.com>
Subject: [PATCH 5/5] OMAP: DSS2: Context Save and Restore of Video3 pipeline registers
Date: Mon, 19 Jul 2010 17:25:44 +0530
Message-ID: <1279540544-12682-6-git-send-email-archit@ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
 <1279540544-12682-5-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35631 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760621Ab0GSL4M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 07:56:12 -0400
In-Reply-To: <1279540544-12682-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Mayuresh Janorkar <mayur@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

Context Save and Restore of Video3 pipeline registers.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  104 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8cda961..5a6c10e
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -397,6 +397,58 @@ void dispc_save_context(void)
 	SR(VID_FIR_COEF_V(1, 7));
 
 	SR(VID_PRELOAD(1));
+
+	/* VID3 */
+	if (cpu_is_omap44xx()) {
+		SR(VID3_WB_BA0(0));
+		SR(VID3_WB_BA1(0));
+		SR(VID3_POSITION);
+		SR(VID3_WB_SIZE(0));
+		SR(VID3_WB_ATTRIBUTES(0));
+		SR(VID3_WB_BUF_THRESHOLD(0));
+		SR(VID3_WB_BUF_SIZE_STATUS(0));
+		SR(VID3_WB_ROW_INC(0));
+		SR(VID3_WB_PIXEL_INC(0));
+		SR(VID3_WB_FIR(0));
+		SR(VID3_WB_PICTURE_SIZE(0));
+		SR(VID3_WB_ACCU0(0));
+		SR(VID3_WB_ACCU1(0));
+
+		SR(VID3_WB_FIR_COEF_H(0, 0));
+		SR(VID3_WB_FIR_COEF_H(0, 1));
+		SR(VID3_WB_FIR_COEF_H(0, 2));
+		SR(VID3_WB_FIR_COEF_H(0, 3));
+		SR(VID3_WB_FIR_COEF_H(0, 4));
+		SR(VID3_WB_FIR_COEF_H(0, 5));
+		SR(VID3_WB_FIR_COEF_H(0, 6));
+		SR(VID3_WB_FIR_COEF_H(0, 7));
+
+		SR(VID3_WB_FIR_COEF_HV(0, 0));
+		SR(VID3_WB_FIR_COEF_HV(0, 1));
+		SR(VID3_WB_FIR_COEF_HV(0, 2));
+		SR(VID3_WB_FIR_COEF_HV(0, 3));
+		SR(VID3_WB_FIR_COEF_HV(0, 4));
+		SR(VID3_WB_FIR_COEF_HV(0, 5));
+		SR(VID3_WB_FIR_COEF_HV(0, 6));
+		SR(VID3_WB_FIR_COEF_HV(0, 7));
+
+		SR(VID3_WB_CONV_COEF(0, 0));
+		SR(VID3_WB_CONV_COEF(0, 1));
+		SR(VID3_WB_CONV_COEF(0, 2));
+		SR(VID3_WB_CONV_COEF(0, 3));
+		SR(VID3_WB_CONV_COEF(0, 4));
+
+		SR(VID3_WB_FIR_COEF_V(0, 0));
+		SR(VID3_WB_FIR_COEF_V(0, 1));
+		SR(VID3_WB_FIR_COEF_V(0, 2));
+		SR(VID3_WB_FIR_COEF_V(0, 3));
+		SR(VID3_WB_FIR_COEF_V(0, 4));
+		SR(VID3_WB_FIR_COEF_V(0, 5));
+		SR(VID3_WB_FIR_COEF_V(0, 6));
+		SR(VID3_WB_FIR_COEF_V(0, 7));
+
+		SR(VID3_PRELOAD);
+	}
 }
 
 void dispc_restore_context(void)
@@ -553,6 +605,58 @@ void dispc_restore_context(void)
 
 	RR(VID_PRELOAD(1));
 
+	/* VID3 */
+	if (cpu_is_omap44xx()) {
+		SR(VID3_WB_BA0(0));
+		SR(VID3_WB_BA1(0));
+		SR(VID3_POSITION);
+		SR(VID3_WB_SIZE(0));
+		SR(VID3_WB_ATTRIBUTES(0));
+		SR(VID3_WB_BUF_THRESHOLD(0));
+		SR(VID3_WB_BUF_SIZE_STATUS(0));
+		SR(VID3_WB_ROW_INC(0));
+		SR(VID3_WB_PIXEL_INC(0));
+		SR(VID3_WB_FIR(0));
+		SR(VID3_WB_PICTURE_SIZE(0));
+		SR(VID3_WB_ACCU0(0));
+		SR(VID3_WB_ACCU1(0));
+
+		SR(VID3_WB_FIR_COEF_H(0, 0));
+		SR(VID3_WB_FIR_COEF_H(0, 1));
+		SR(VID3_WB_FIR_COEF_H(0, 2));
+		SR(VID3_WB_FIR_COEF_H(0, 3));
+		SR(VID3_WB_FIR_COEF_H(0, 4));
+		SR(VID3_WB_FIR_COEF_H(0, 5));
+		SR(VID3_WB_FIR_COEF_H(0, 6));
+		SR(VID3_WB_FIR_COEF_H(0, 7));
+
+		SR(VID3_WB_FIR_COEF_HV(0, 0));
+		SR(VID3_WB_FIR_COEF_HV(0, 1));
+		SR(VID3_WB_FIR_COEF_HV(0, 2));
+		SR(VID3_WB_FIR_COEF_HV(0, 3));
+		SR(VID3_WB_FIR_COEF_HV(0, 4));
+		SR(VID3_WB_FIR_COEF_HV(0, 5));
+		SR(VID3_WB_FIR_COEF_HV(0, 6));
+		SR(VID3_WB_FIR_COEF_HV(0, 7));
+
+		SR(VID3_WB_CONV_COEF(0, 0));
+		SR(VID3_WB_CONV_COEF(0, 1));
+		SR(VID3_WB_CONV_COEF(0, 2));
+		SR(VID3_WB_CONV_COEF(0, 3));
+		SR(VID3_WB_CONV_COEF(0, 4));
+
+		SR(VID3_WB_FIR_COEF_V(0, 0));
+		SR(VID3_WB_FIR_COEF_V(0, 1));
+		SR(VID3_WB_FIR_COEF_V(0, 2));
+		SR(VID3_WB_FIR_COEF_V(0, 3));
+		SR(VID3_WB_FIR_COEF_V(0, 4));
+		SR(VID3_WB_FIR_COEF_V(0, 5));
+		SR(VID3_WB_FIR_COEF_V(0, 6));
+		SR(VID3_WB_FIR_COEF_V(0, 7));
+
+		SR(VID3_PRELOAD);
+	}
+
 	/* enable last, because LCD & DIGIT enable are here */
 	RR(CONTROL(0));
 	if (cpu_is_omap44xx())
-- 
1.5.4.7

