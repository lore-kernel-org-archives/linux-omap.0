From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAP: DSS2: DSI: Fix DSI PLL power bug
Date: Fri, 15 Apr 2011 11:11:10 +0300
Message-ID: <1302855071-5510-5-git-send-email-tomi.valkeinen@ti.com>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38992 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794Ab1DOILe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 04:11:34 -0400
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP3630 has a HW bug causing DSI PLL power command POWER_ON_DIV (0x3)
to not work properly. The bug prevents us from enabling DSI PLL power
only to HS divider block.

This patch adds a dss feature for the bug and converts POWER_ON_DIV
requests to POWER_ON_ALL (0x2).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |    5 +++++
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/dss_features.h |    2 ++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1464ac4..cbd9ca4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1059,6 +1059,11 @@ static int dsi_pll_power(enum dsi_pll_power_state state)
 {
 	int t = 0;
 
+	/* DSI-PLL power command 0x3 is not working */
+	if (dss_has_feature(FEAT_DSI_PLL_PWR_BUG) &&
+			state == DSI_PLL_POWER_ON_DIV)
+		state = DSI_PLL_POWER_ON_ALL;
+
 	REG_FLD_MOD(DSI_CLK_CTRL, state, 31, 30);	/* PLL_PWR_CMD */
 
 	/* PLL_PWR_STATUS */
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index aa16222..8c50e18 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -271,7 +271,7 @@ static struct omap_dss_features omap3630_dss_features = {
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
 		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
 		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
-		FEAT_RESIZECONF,
+		FEAT_RESIZECONF | FEAT_DSI_PLL_PWR_BUG,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 12e9c4e..37922ce 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -40,6 +40,8 @@ enum dss_feat_id {
 	/* Independent core clk divider */
 	FEAT_CORE_CLK_DIV	= 1 << 11,
 	FEAT_LCD_CLK_SRC	= 1 << 12,
+	/* DSI-PLL power command 0x3 is not working */
+	FEAT_DSI_PLL_PWR_BUG	= 1 << 13,
 };
 
 /* DSS register field id */
-- 
1.7.1

