From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 12/28] OMAP: DSS2: Add new FEAT definitions for features missing from OMAP2
Date: Thu,  9 Jun 2011 16:56:34 +0300
Message-ID: <1307627810-3768-13-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42538 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758081Ab1FIN5a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:30 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP2 doesn't have CPR, PRELOAD nor FIR_COEF_V registers. Add new
feature definitions for those, and check the feature before accessing
those registers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |  145 ++++++++++++++++++++------------
 drivers/video/omap2/dss/dss_features.c |   12 ++-
 drivers/video/omap2/dss/dss_features.h |    3 +
 drivers/video/omap2/dss/overlay.c      |    3 +
 4 files changed, 105 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a9eebd8..ee2052f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -159,7 +159,8 @@ void dispc_save_context(void)
 	SR(TIMING_V(OMAP_DSS_CHANNEL_LCD));
 	SR(POL_FREQ(OMAP_DSS_CHANNEL_LCD));
 	SR(DIVISORo(OMAP_DSS_CHANNEL_LCD));
-	SR(GLOBAL_ALPHA);
+	if (dss_has_feature(FEAT_GLOBAL_ALPHA))
+		SR(GLOBAL_ALPHA);
 	SR(SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
 	SR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
@@ -189,20 +190,25 @@ void dispc_save_context(void)
 	SR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
 	SR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
 
-	SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
-	SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
-	SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
+	if (dss_has_feature(FEAT_CPR)) {
+		SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
+		SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
+		SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
+	}
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
-		SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
-		SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+		if (dss_has_feature(FEAT_CPR)) {
+			SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
+			SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
+			SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+		}
 
 		SR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
 		SR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
 		SR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 	}
 
-	SR(OVL_PRELOAD(OMAP_DSS_GFX));
+	if (dss_has_feature(FEAT_PRELOAD))
+		SR(OVL_PRELOAD(OMAP_DSS_GFX));
 
 	/* VID1 */
 	SR(OVL_BA0(OMAP_DSS_VIDEO1));
@@ -227,8 +233,10 @@ void dispc_save_context(void)
 	for (i = 0; i < 5; i++)
 		SR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, i));
 
-	for (i = 0; i < 8; i++)
-		SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
+	if (dss_has_feature(FEAT_FIR_COEF_V)) {
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
+	}
 
 	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
 		SR(OVL_BA0_UV(OMAP_DSS_VIDEO1));
@@ -249,7 +257,8 @@ void dispc_save_context(void)
 	if (dss_has_feature(FEAT_ATTR2))
 		SR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
 
-	SR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
+	if (dss_has_feature(FEAT_PRELOAD))
+		SR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
 
 	/* VID2 */
 	SR(OVL_BA0(OMAP_DSS_VIDEO2));
@@ -274,8 +283,10 @@ void dispc_save_context(void)
 	for (i = 0; i < 5; i++)
 		SR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, i));
 
-	for (i = 0; i < 8; i++)
-		SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
+	if (dss_has_feature(FEAT_FIR_COEF_V)) {
+		for (i = 0; i < 8; i++)
+			SR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
+	}
 
 	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
 		SR(OVL_BA0_UV(OMAP_DSS_VIDEO2));
@@ -296,7 +307,8 @@ void dispc_save_context(void)
 	if (dss_has_feature(FEAT_ATTR2))
 		SR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
 
-	SR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
+	if (dss_has_feature(FEAT_PRELOAD))
+		SR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		SR(DIVISOR);
@@ -318,7 +330,8 @@ void dispc_restore_context(void)
 	RR(TIMING_V(OMAP_DSS_CHANNEL_LCD));
 	RR(POL_FREQ(OMAP_DSS_CHANNEL_LCD));
 	RR(DIVISORo(OMAP_DSS_CHANNEL_LCD));
-	RR(GLOBAL_ALPHA);
+	if (dss_has_feature(FEAT_GLOBAL_ALPHA))
+		RR(GLOBAL_ALPHA);
 	RR(SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
 	RR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
@@ -348,20 +361,25 @@ void dispc_restore_context(void)
 	RR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
 	RR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
 
-	RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
-	RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
-	RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
+	if (dss_has_feature(FEAT_CPR)) {
+		RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
+		RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
+		RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
+	}
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		RR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
 		RR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
 		RR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 
-		RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
-		RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
-		RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+		if (dss_has_feature(FEAT_CPR)) {
+			RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
+			RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
+			RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+		}
 	}
 
-	RR(OVL_PRELOAD(OMAP_DSS_GFX));
+	if (dss_has_feature(FEAT_PRELOAD))
+		RR(OVL_PRELOAD(OMAP_DSS_GFX));
 
 	/* VID1 */
 	RR(OVL_BA0(OMAP_DSS_VIDEO1));
@@ -386,8 +404,10 @@ void dispc_restore_context(void)
 	for (i = 0; i < 5; i++)
 		RR(OVL_CONV_COEF(OMAP_DSS_VIDEO1, i));
 
-	for (i = 0; i < 8; i++)
-		RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
+	if (dss_has_feature(FEAT_FIR_COEF_V)) {
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, i));
+	}
 
 	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
 		RR(OVL_BA0_UV(OMAP_DSS_VIDEO1));
@@ -408,7 +428,8 @@ void dispc_restore_context(void)
 	if (dss_has_feature(FEAT_ATTR2))
 		RR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO1));
 
-	RR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
+	if (dss_has_feature(FEAT_PRELOAD))
+		RR(OVL_PRELOAD(OMAP_DSS_VIDEO1));
 
 	/* VID2 */
 	RR(OVL_BA0(OMAP_DSS_VIDEO2));
@@ -433,8 +454,10 @@ void dispc_restore_context(void)
 	for (i = 0; i < 5; i++)
 		RR(OVL_CONV_COEF(OMAP_DSS_VIDEO2, i));
 
-	for (i = 0; i < 8; i++)
-		RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
+	if (dss_has_feature(FEAT_FIR_COEF_V)) {
+		for (i = 0; i < 8; i++)
+			RR(OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, i));
+	}
 
 	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
 		RR(OVL_BA0_UV(OMAP_DSS_VIDEO2));
@@ -455,7 +478,8 @@ void dispc_restore_context(void)
 	if (dss_has_feature(FEAT_ATTR2))
 		RR(OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
 
-	RR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
+	if (dss_has_feature(FEAT_PRELOAD))
+		RR(OVL_PRELOAD(OMAP_DSS_VIDEO2));
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		RR(DIVISOR);
@@ -2650,7 +2674,8 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_TIMING_V(OMAP_DSS_CHANNEL_LCD));
 	DUMPREG(DISPC_POL_FREQ(OMAP_DSS_CHANNEL_LCD));
 	DUMPREG(DISPC_DIVISORo(OMAP_DSS_CHANNEL_LCD));
-	DUMPREG(DISPC_GLOBAL_ALPHA);
+	if (dss_has_feature(FEAT_GLOBAL_ALPHA))
+		DUMPREG(DISPC_GLOBAL_ALPHA);
 	DUMPREG(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
 	DUMPREG(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
@@ -2681,20 +2706,25 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
 	DUMPREG(DISPC_DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
 
-	DUMPREG(DISPC_CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
-	DUMPREG(DISPC_CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
-	DUMPREG(DISPC_CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
+	if (dss_has_feature(FEAT_CPR)) {
+		DUMPREG(DISPC_CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
+		DUMPREG(DISPC_CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
+		DUMPREG(DISPC_CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
+	}
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		DUMPREG(DISPC_DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
 		DUMPREG(DISPC_DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
 		DUMPREG(DISPC_DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 
-		DUMPREG(DISPC_CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
-		DUMPREG(DISPC_CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
-		DUMPREG(DISPC_CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
+		if (dss_has_feature(FEAT_CPR)) {
+			DUMPREG(DISPC_CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+			DUMPREG(DISPC_CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
+			DUMPREG(DISPC_CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
+		}
 	}
 
-	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_GFX));
+	if (dss_has_feature(FEAT_PRELOAD))
+		DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_GFX));
 
 	DUMPREG(DISPC_OVL_BA0(OMAP_DSS_VIDEO1));
 	DUMPREG(DISPC_OVL_BA1(OMAP_DSS_VIDEO1));
@@ -2745,14 +2775,16 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 2));
 	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 3));
 	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO1, 4));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 0));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 1));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 2));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 3));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 4));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 5));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 6));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 7));
+	if (dss_has_feature(FEAT_FIR_COEF_V)) {
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 0));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 1));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 2));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 3));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 4));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 5));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 6));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO1, 7));
+	}
 
 	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
 		DUMPREG(DISPC_OVL_BA0_UV(OMAP_DSS_VIDEO1));
@@ -2813,14 +2845,17 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 2));
 	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 3));
 	DUMPREG(DISPC_OVL_CONV_COEF(OMAP_DSS_VIDEO2, 4));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 0));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 1));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 2));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 3));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 4));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 5));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 6));
-	DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 7));
+
+	if (dss_has_feature(FEAT_FIR_COEF_V)) {
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 0));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 1));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 2));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 3));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 4));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 5));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 6));
+		DUMPREG(DISPC_OVL_FIR_COEF_V(OMAP_DSS_VIDEO2, 7));
+	}
 
 	if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
 		DUMPREG(DISPC_OVL_BA0_UV(OMAP_DSS_VIDEO2));
@@ -2859,8 +2894,10 @@ void dispc_dump_regs(struct seq_file *s)
 	if (dss_has_feature(FEAT_ATTR2))
 		DUMPREG(DISPC_OVL_ATTRIBUTES2(OMAP_DSS_VIDEO2));
 
-	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO1));
-	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO2));
+	if (dss_has_feature(FEAT_PRELOAD)) {
+		DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO1));
+		DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_VIDEO2));
+	}
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index a588380..bd420f9 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -287,7 +287,8 @@ static const struct omap_dss_features omap3430_dss_features = {
 		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
 		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
 		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC |
-		FEAT_VENC_REQUIRES_TV_DAC_CLK,
+		FEAT_VENC_REQUIRES_TV_DAC_CLK | FEAT_CPR | FEAT_PRELOAD |
+		FEAT_FIR_COEF_V,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -307,7 +308,8 @@ static const struct omap_dss_features omap3630_dss_features = {
 		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
 		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
 		FEAT_RESIZECONF | FEAT_DSI_PLL_PWR_BUG |
-		FEAT_DSI_PLL_FREQSEL,
+		FEAT_DSI_PLL_FREQSEL | FEAT_CPR | FEAT_PRELOAD |
+		FEAT_FIR_COEF_V,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -328,7 +330,8 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
-		FEAT_DSI_GNQ | FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2,
+		FEAT_DSI_GNQ | FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 |
+		FEAT_CPR | FEAT_PRELOAD | FEAT_FIR_COEF_V,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
@@ -349,7 +352,8 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
 		FEAT_DSI_GNQ | FEAT_HDMI_CTS_SWMODE |
-		FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2,
+		FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 | FEAT_CPR |
+		FEAT_PRELOAD | FEAT_FIR_COEF_V,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 3058e24..5be8103 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -52,6 +52,9 @@ enum dss_feat_id {
 	FEAT_HANDLE_UV_SEPARATE         = 1 << 20,
 	FEAT_ATTR2                      = 1 << 21,
 	FEAT_VENC_REQUIRES_TV_DAC_CLK	= 1 << 22,
+	FEAT_CPR			= 1 << 23,
+	FEAT_PRELOAD			= 1 << 24,
+	FEAT_FIR_COEF_V			= 1 << 25,
 };
 
 /* DSS register field id */
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 0f08025..cfbfc57 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -238,6 +238,9 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 	u8 alpha;
 	struct omap_overlay_info info;
 
+	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
+		return -ENODEV;
+
 	r = kstrtou8(buf, 0, &alpha);
 	if (r)
 		return r;
-- 
1.7.4.1

