From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/5] OMAP: DSS2: DISPC: dispc_save_context() and dispc_restore_context() cleanup
Date: Fri, 5 Aug 2011 13:12:50 +0530
Message-ID: <1312530172-24095-4-git-send-email-archit@ti.com>
References: <1312530172-24095-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45191 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926Ab1HEHe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 03:34:26 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p757YQZ6022887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:26 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p757YQCf011170
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:26 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p757YQDk027001
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:26 -0500 (CDT)
In-Reply-To: <1312530172-24095-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Iterate over manager and overlay id's to shorten dispc_save_context() and
dispc_restore_context().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  408 ++++++++++++---------------------------
 1 files changed, 128 insertions(+), 280 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index bdd24a2..2fd16ac 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -171,172 +171,97 @@ static int dispc_get_ctx_loss_count(void)
 
 static void dispc_save_context(void)
 {
-	int i;
+	int i, j;
 
 	DSSDBG("dispc_save_context\n");
 
 	SR(IRQENABLE);
 	SR(CONTROL);
 	SR(CONFIG);
-	SR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD));
-	SR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_DIGIT));
-	SR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD));
-	SR(TRANS_COLOR(OMAP_DSS_CHANNEL_DIGIT));
 	SR(LINE_NUMBER);
-	SR(TIMING_H(OMAP_DSS_CHANNEL_LCD));
-	SR(TIMING_V(OMAP_DSS_CHANNEL_LCD));
-	SR(POL_FREQ(OMAP_DSS_CHANNEL_LCD));
-	SR(DIVISORo(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_GLOBAL_ALPHA))
 		SR(GLOBAL_ALPHA);
-	SR(SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
-	SR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		SR(CONTROL2);
-		SR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD2));
-		SR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD2));
-		SR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD2));
-		SR(TIMING_H(OMAP_DSS_CHANNEL_LCD2));
-		SR(TIMING_V(OMAP_DSS_CHANNEL_LCD2));
-		SR(POL_FREQ(OMAP_DSS_CHANNEL_LCD2));
-		SR(DIVISORo(OMAP_DSS_CHANNEL_LCD2));
 		SR(CONFIG2);
 	}
 
-	SR(OVL_BA0(OMAP_DSS_GFX));
-	SR(OVL_BA1(OMAP_DSS_GFX));
-	SR(OVL_POSITION(OMAP_DSS_GFX));
-	SR(OVL_SIZE(OMAP_DSS_GFX));
-	SR(OVL_ATTRIBUTES(OMAP_DSS_GFX));
-	SR(OVL_FIFO_THRESHOLD(OMAP_DSS_GFX));
-	SR(OVL_ROW_INC(OMAP_DSS_GFX));
-	SR(OVL_PIXEL_INC(OMAP_DSS_GFX));
-	SR(OVL_WINDOW_SKIP(OMAP_DSS_GFX));
-	SR(OVL_TABLE_BA(OMAP_DSS_GFX));
+	for (i = 0; i < dss_feat_get_num_mgrs(); i++) {
+		SR(DEFAULT_COLOR(i));
+		SR(TRANS_COLOR(i));
+		SR(SIZE_MGR(i));
+		if (i == OMAP_DSS_CHANNEL_DIGIT)
+			continue;
+		SR(TIMING_H(i));
+		SR(TIMING_V(i));
+		SR(POL_FREQ(i));
+		SR(DIVISORo(i));
 
-	SR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD));
-	SR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
-	SR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
+		SR(DATA_CYCLE1(i));
+		SR(DATA_CYCLE2(i));
+		SR(DATA_CYCLE3(i));
 
-	if (dss_has_feature(FEAT_CPR)) {
-		SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
-		SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
-		SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
-	}
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		if (dss_has_feature(FEAT_CPR)) {
-			SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
-			SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
-			SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+			SR(CPR_COEF_R(i));
+			SR(CPR_COEF_G(i));
+			SR(CPR_COEF_B(i));
 		}
-
-		SR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
-		SR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
-		SR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 	}
 
-	if (dss_has_feature(FEAT_PRELOAD))
-		SR(OVL_PRELOAD(OMAP_DSS_GFX));
-
-	/* VID1 */
-	SR(OVL_BA0(OMAP_DSS_VIDEO1));
-	SR(OVL_BA1(OMAP_DSS_VIDEO1));
-	SR(OVL_POSITION(OMAP_DSS_VIDEO1));
-	SR(OVL_SIZE(OMAP_DSS_VIDEO1));
-	SR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO1));
-	SR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO1));
-	SR(OVL_ROW_INC(OMAP_DSS_VIDEO1));
-	SR(OVL_PIXEL_INC(OMAP_DSS_VIDEO1));
-	SR(OVL_FIR(OMAP_DSS_VIDEO1));
-	SR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO1));
-	SR(OVL_ACCU0(OMAP_DSS_VIDEO1));
-	SR(OVL_ACCU1(OMAP_DSS_VIDEO1));
-
-	for (i = 0; i < 8; i++)
-		SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, i));
-
-	for (i = 0; i < 8; i++)
-		SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, i));
-
-	for (i = 0; i < 5; i++)
-		SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, i));
-
-	if (dss_has_feature(FEAT_FIR_COEF_V)) {
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
-	}
-
-	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
-		SR(OVL_BA0_UV(OMAP_DSS_VIDEO1));
-		SR(OVL_BA1_UV(OMAP_DSS_VIDEO1));
-		SR(OVL_FIR2(OMAP_DSS_VIDEO1));
-		SR(OVL_ACCU2_0(OMAP_DSS_VIDEO1));
-		SR(OVL_ACCU2_1(OMAP_DSS_VIDEO1));
-
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO1, i));
-
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO1, i));
-
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO1, i));
-	}
-	if (dss_has_feature(FEAT_ATTR2))
-		SR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
-
-	if (dss_has_feature(FEAT_PRELOAD))
-		SR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
-
-	/* VID2 */
-	SR(OVL_BA0(OMAP_DSS_VIDEO2));
-	SR(OVL_BA1(OMAP_DSS_VIDEO2));
-	SR(OVL_POSITION(OMAP_DSS_VIDEO2));
-	SR(OVL_SIZE(OMAP_DSS_VIDEO2));
-	SR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO2));
-	SR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO2));
-	SR(OVL_ROW_INC(OMAP_DSS_VIDEO2));
-	SR(OVL_PIXEL_INC(OMAP_DSS_VIDEO2));
-	SR(OVL_FIR(OMAP_DSS_VIDEO2));
-	SR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO2));
-	SR(OVL_ACCU0(OMAP_DSS_VIDEO2));
-	SR(OVL_ACCU1(OMAP_DSS_VIDEO2));
+	for (i = 0; i < dss_feat_get_num_ovls(); i++) {
+		SR(OVL_BA0(i));
+		SR(OVL_BA1(i));
+		SR(OVL_POSITION(i));
+		SR(OVL_SIZE(i));
+		SR(OVL_ATTRIBUTES(i));
+		SR(OVL_FIFO_THRESHOLD(i));
+		SR(OVL_ROW_INC(i));
+		SR(OVL_PIXEL_INC(i));
+		if (dss_has_feature(FEAT_PRELOAD))
+			SR(OVL_PRELOAD(i));
+		if (i == OMAP_DSS_GFX) {
+			SR(OVL_WINDOW_SKIP(i));
+			SR(OVL_TABLE_BA(i));
+			continue;
+		}
+		SR(OVL_FIR(i));
+		SR(OVL_PICTURE_SIZE(i));
+		SR(OVL_ACCU0(i));
+		SR(OVL_ACCU1(i));
 
-	for (i = 0; i < 8; i++)
-		SR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, i));
+		for (j = 0; j < 8; j++)
+			SR(OVL_FIR_COEF_H(i, j));
 
-	for (i = 0; i < 8; i++)
-		SR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, i));
+		for (j = 0; j < 8; j++)
+			SR(OVL_FIR_COEF_HV(i, j));
 
-	for (i = 0; i < 5; i++)
-		SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, i));
+		for (j = 0; j < 5; j++)
+			SR(OVL_CONV_COEF(i, j));
 
-	if (dss_has_feature(FEAT_FIR_COEF_V)) {
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
-	}
+		if (dss_has_feature(FEAT_FIR_COEF_V)) {
+			for (j = 0; j < 8; j++)
+				SR(OVL_FIR_COEF_V(i, j));
+		}
 
-	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
-		SR(OVL_BA0_UV(OMAP_DSS_VIDEO2));
-		SR(OVL_BA1_UV(OMAP_DSS_VIDEO2));
-		SR(OVL_FIR2(OMAP_DSS_VIDEO2));
-		SR(OVL_ACCU2_0(OMAP_DSS_VIDEO2));
-		SR(OVL_ACCU2_1(OMAP_DSS_VIDEO2));
+		if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+			SR(OVL_BA0_UV(i));
+			SR(OVL_BA1_UV(i));
+			SR(OVL_FIR2(i));
+			SR(OVL_ACCU2_0(i));
+			SR(OVL_ACCU2_1(i));
 
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO2, i));
+			for (j = 0; j < 8; j++)
+				SR(OVL_FIR_COEF_H2(i, j));
 
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO2, i));
+			for (j = 0; j < 8; j++)
+				SR(OVL_FIR_COEF_HV2(i, j));
 
-		for (i = 0; i < 8; i++)
-			SR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO2, i));
+			for (j = 0; j < 8; j++)
+				SR(OVL_FIR_COEF_V2(i, j));
+		}
+		if (dss_has_feature(FEAT_ATTR2))
+			SR(OVL_ATTRIBUTES2(i));
 	}
-	if (dss_has_feature(FEAT_ATTR2))
-		SR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
-
-	if (dss_has_feature(FEAT_PRELOAD))
-		SR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		SR(DIVISOR);
@@ -349,7 +274,7 @@ static void dispc_save_context(void)
 
 static void dispc_restore_context(void)
 {
-	int i, ctx;
+	int i, j, ctx;
 
 	DSSDBG("dispc_restore_context\n");
 
@@ -367,165 +292,88 @@ static void dispc_restore_context(void)
 	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
 	RR(CONFIG);
-	RR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD));
-	RR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_DIGIT));
-	RR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD));
-	RR(TRANS_COLOR(OMAP_DSS_CHANNEL_DIGIT));
 	RR(LINE_NUMBER);
-	RR(TIMING_H(OMAP_DSS_CHANNEL_LCD));
-	RR(TIMING_V(OMAP_DSS_CHANNEL_LCD));
-	RR(POL_FREQ(OMAP_DSS_CHANNEL_LCD));
-	RR(DIVISORo(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_GLOBAL_ALPHA))
 		RR(GLOBAL_ALPHA);
-	RR(SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
-	RR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		RR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD2));
-		RR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD2));
-		RR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD2));
-		RR(TIMING_H(OMAP_DSS_CHANNEL_LCD2));
-		RR(TIMING_V(OMAP_DSS_CHANNEL_LCD2));
-		RR(POL_FREQ(OMAP_DSS_CHANNEL_LCD2));
-		RR(DIVISORo(OMAP_DSS_CHANNEL_LCD2));
+	if (dss_has_feature(FEAT_MGR_LCD2))
 		RR(CONFIG2);
-	}
-
-	RR(OVL_BA0(OMAP_DSS_GFX));
-	RR(OVL_BA1(OMAP_DSS_GFX));
-	RR(OVL_POSITION(OMAP_DSS_GFX));
-	RR(OVL_SIZE(OMAP_DSS_GFX));
-	RR(OVL_ATTRIBUTES(OMAP_DSS_GFX));
-	RR(OVL_FIFO_THRESHOLD(OMAP_DSS_GFX));
-	RR(OVL_ROW_INC(OMAP_DSS_GFX));
-	RR(OVL_PIXEL_INC(OMAP_DSS_GFX));
-	RR(OVL_WINDOW_SKIP(OMAP_DSS_GFX));
-	RR(OVL_TABLE_BA(OMAP_DSS_GFX));
 
+	for (i = 0; i < dss_feat_get_num_mgrs(); i++) {
+		RR(DEFAULT_COLOR(i));
+		RR(TRANS_COLOR(i));
+		RR(SIZE_MGR(i));
+		if (i == OMAP_DSS_CHANNEL_DIGIT)
+			continue;
+		RR(TIMING_H(i));
+		RR(TIMING_V(i));
+		RR(POL_FREQ(i));
+		RR(DIVISORo(i));
 
-	RR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD));
-	RR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
-	RR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
-
-	if (dss_has_feature(FEAT_CPR)) {
-		RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
-		RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
-		RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
-	}
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		RR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
-		RR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
-		RR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
+		RR(DATA_CYCLE1(i));
+		RR(DATA_CYCLE2(i));
+		RR(DATA_CYCLE3(i));
 
 		if (dss_has_feature(FEAT_CPR)) {
-			RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
-			RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
-			RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+			RR(CPR_COEF_R(i));
+			RR(CPR_COEF_G(i));
+			RR(CPR_COEF_B(i));
 		}
 	}
 
-	if (dss_has_feature(FEAT_PRELOAD))
-		RR(OVL_PRELOAD(OMAP_DSS_GFX));
-
-	/* VID1 */
-	RR(OVL_BA0(OMAP_DSS_VIDEO1));
-	RR(OVL_BA1(OMAP_DSS_VIDEO1));
-	RR(OVL_POSITION(OMAP_DSS_VIDEO1));
-	RR(OVL_SIZE(OMAP_DSS_VIDEO1));
-	RR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO1));
-	RR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO1));
-	RR(OVL_ROW_INC(OMAP_DSS_VIDEO1));
-	RR(OVL_PIXEL_INC(OMAP_DSS_VIDEO1));
-	RR(OVL_FIR(OMAP_DSS_VIDEO1));
-	RR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO1));
-	RR(OVL_ACCU0(OMAP_DSS_VIDEO1));
-	RR(OVL_ACCU1(OMAP_DSS_VIDEO1));
-
-	for (i = 0; i < 8; i++)
-		RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO1, i));
-
-	for (i = 0; i < 8; i++)
-		RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO1, i));
-
-	for (i = 0; i < 5; i++)
-		RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, i));
-
-	if (dss_has_feature(FEAT_FIR_COEF_V)) {
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
-	}
-
-	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
-		RR(OVL_BA0_UV(OMAP_DSS_VIDEO1));
-		RR(OVL_BA1_UV(OMAP_DSS_VIDEO1));
-		RR(OVL_FIR2(OMAP_DSS_VIDEO1));
-		RR(OVL_ACCU2_0(OMAP_DSS_VIDEO1));
-		RR(OVL_ACCU2_1(OMAP_DSS_VIDEO1));
-
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO1, i));
-
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO1, i));
-
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO1, i));
-	}
-	if (dss_has_feature(FEAT_ATTR2))
-		RR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
-
-	if (dss_has_feature(FEAT_PRELOAD))
-		RR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
-
-	/* VID2 */
-	RR(OVL_BA0(OMAP_DSS_VIDEO2));
-	RR(OVL_BA1(OMAP_DSS_VIDEO2));
-	RR(OVL_POSITION(OMAP_DSS_VIDEO2));
-	RR(OVL_SIZE(OMAP_DSS_VIDEO2));
-	RR(OVL_ATTRIBUTES(OMAP_DSS_VIDEO2));
-	RR(OVL_FIFO_THRESHOLD(OMAP_DSS_VIDEO2));
-	RR(OVL_ROW_INC(OMAP_DSS_VIDEO2));
-	RR(OVL_PIXEL_INC(OMAP_DSS_VIDEO2));
-	RR(OVL_FIR(OMAP_DSS_VIDEO2));
-	RR(OVL_PICTURE_SIZE(OMAP_DSS_VIDEO2));
-	RR(OVL_ACCU0(OMAP_DSS_VIDEO2));
-	RR(OVL_ACCU1(OMAP_DSS_VIDEO2));
+	for (i = 0; i < dss_feat_get_num_ovls(); i++) {
+		RR(OVL_BA0(i));
+		RR(OVL_BA1(i));
+		RR(OVL_POSITION(i));
+		RR(OVL_SIZE(i));
+		RR(OVL_ATTRIBUTES(i));
+		RR(OVL_FIFO_THRESHOLD(i));
+		RR(OVL_ROW_INC(i));
+		RR(OVL_PIXEL_INC(i));
+		if (dss_has_feature(FEAT_PRELOAD))
+			RR(OVL_PRELOAD(i));
+		if (i == OMAP_DSS_GFX) {
+			RR(OVL_WINDOW_SKIP(i));
+			RR(OVL_TABLE_BA(i));
+			continue;
+		}
+		RR(OVL_FIR(i));
+		RR(OVL_PICTURE_SIZE(i));
+		RR(OVL_ACCU0(i));
+		RR(OVL_ACCU1(i));
 
-	for (i = 0; i < 8; i++)
-		RR(OVL_FIR_COEF_H(OMAP_DSS_VIDEO2, i));
+		for (j = 0; j < 8; j++)
+			RR(OVL_FIR_COEF_H(i, j));
 
-	for (i = 0; i < 8; i++)
-		RR(OVL_FIR_COEF_HV(OMAP_DSS_VIDEO2, i));
+		for (j = 0; j < 8; j++)
+			RR(OVL_FIR_COEF_HV(i, j));
 
-	for (i = 0; i < 5; i++)
-		RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, i));
+		for (j = 0; j < 5; j++)
+			RR(OVL_CONV_COEF(i, j));
 
-	if (dss_has_feature(FEAT_FIR_COEF_V)) {
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
-	}
+		if (dss_has_feature(FEAT_FIR_COEF_V)) {
+			for (j = 0; j < 8; j++)
+				RR(OVL_FIR_COEF_V(i, j));
+		}
 
-	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
-		RR(OVL_BA0_UV(OMAP_DSS_VIDEO2));
-		RR(OVL_BA1_UV(OMAP_DSS_VIDEO2));
-		RR(OVL_FIR2(OMAP_DSS_VIDEO2));
-		RR(OVL_ACCU2_0(OMAP_DSS_VIDEO2));
-		RR(OVL_ACCU2_1(OMAP_DSS_VIDEO2));
+		if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
+			RR(OVL_BA0_UV(i));
+			RR(OVL_BA1_UV(i));
+			RR(OVL_FIR2(i));
+			RR(OVL_ACCU2_0(i));
+			RR(OVL_ACCU2_1(i));
 
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_H2(OMAP_DSS_VIDEO2, i));
+			for (j = 0; j < 8; j++)
+				RR(OVL_FIR_COEF_H2(i, j));
 
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_HV2(OMAP_DSS_VIDEO2, i));
+			for (j = 0; j < 8; j++)
+				RR(OVL_FIR_COEF_HV2(i, j));
 
-		for (i = 0; i < 8; i++)
-			RR(OVL_FIR_COEF_V2(OMAP_DSS_VIDEO2, i));
+			for (j = 0; j < 8; j++)
+				RR(OVL_FIR_COEF_V2(i, j));
+		}
+		if (dss_has_feature(FEAT_ATTR2))
+			RR(OVL_ATTRIBUTES2(i));
 	}
-	if (dss_has_feature(FEAT_ATTR2))
-		RR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
-
-	if (dss_has_feature(FEAT_PRELOAD))
-		RR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		RR(DIVISOR);
-- 
1.7.1

