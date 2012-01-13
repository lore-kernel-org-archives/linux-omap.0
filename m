From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/6] OMAPDSS: FEAT: Add FIFO_MERGE feature
Date: Fri, 13 Jan 2012 13:46:28 +0200
Message-ID: <1326455193-19716-2-git-send-email-tomi.valkeinen@ti.com>
References: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40037 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936Ab2AMLqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 06:46:44 -0500
In-Reply-To: <1326455193-19716-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add feature flag for fifo merge. OMAP2 doesn't contain fifo merge, later
OMAPs do.

dispc_enable_fifomerge() checks for the flag when called, and gives a
WARN if fifo merge is being enabled when it is not supported.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |    5 +++++
 drivers/video/omap2/dss/dss_features.c |    9 +++++----
 drivers/video/omap2/dss/dss_features.h |    1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a5ec7f3..d711518 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1054,6 +1054,11 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 
 void dispc_enable_fifomerge(bool enable)
 {
+	if (!dss_has_feature(FEAT_FIFO_MERGE)) {
+		WARN_ON(enable);
+		return;
+	}
+
 	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
 	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
 }
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index afcb593..c2456c5 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -370,7 +370,7 @@ static const struct omap_dss_features omap3430_dss_features = {
 		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
 		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC |
 		FEAT_VENC_REQUIRES_TV_DAC_CLK | FEAT_CPR | FEAT_PRELOAD |
-		FEAT_FIR_COEF_V | FEAT_ALPHA_FIXED_ZORDER,
+		FEAT_FIR_COEF_V | FEAT_ALPHA_FIXED_ZORDER | FEAT_FIFO_MERGE,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -394,7 +394,7 @@ static const struct omap_dss_features omap3630_dss_features = {
 		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
 		FEAT_RESIZECONF | FEAT_DSI_PLL_PWR_BUG |
 		FEAT_DSI_PLL_FREQSEL | FEAT_CPR | FEAT_PRELOAD |
-		FEAT_FIR_COEF_V | FEAT_ALPHA_FIXED_ZORDER,
+		FEAT_FIR_COEF_V | FEAT_ALPHA_FIXED_ZORDER | FEAT_FIFO_MERGE,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -419,7 +419,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
 		FEAT_DSI_GNQ | FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 |
 		FEAT_CPR | FEAT_PRELOAD | FEAT_FIR_COEF_V |
-		FEAT_ALPHA_FREE_ZORDER,
+		FEAT_ALPHA_FREE_ZORDER | FEAT_FIFO_MERGE,
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
@@ -443,7 +443,8 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
 		FEAT_DSI_GNQ | FEAT_HDMI_CTS_SWMODE |
 		FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 | FEAT_CPR |
-		FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER,
+		FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER |
+		FEAT_FIFO_MERGE,
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index cd833bb..50caee9 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -58,6 +58,7 @@ enum dss_feat_id {
 	FEAT_FIR_COEF_V			= 1 << 25,
 	FEAT_ALPHA_FIXED_ZORDER		= 1 << 26,
 	FEAT_ALPHA_FREE_ZORDER		= 1 << 27,
+	FEAT_FIFO_MERGE			= 1 << 28,
 };
 
 /* DSS register field id */
-- 
1.7.4.1

