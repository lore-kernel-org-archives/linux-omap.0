From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAP: DSS2: Fix: Return correct lcd clock source for OMAP2/3
Date: Fri, 15 Apr 2011 11:11:09 +0300
Message-ID: <1302855071-5510-4-git-send-email-tomi.valkeinen@ti.com>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55356 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750857Ab1DOILc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 04:11:32 -0400
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

dss.lcd_clk_source is set to the default value DSS_CLK_SRC_FCK at dss_init.
For OMAP2 and OMAP3, the dss.lcd_clk_source should always be the same as
dss.dispc_clk_source. The function dss_get_lcd_clk_source() always returns the
default value DSS_CLK_SRC_FCK for OMAP2/3. This leads to wrong clock dumps when
dispc_clk_source is not DSS_CLK_SRC_FCK.

Correct this function to always return dss.dispc_clk_source for OMAP2/3.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 3f1fee6..c3b48a0 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -385,8 +385,14 @@ enum dss_clk_source dss_get_dsi_clk_source(void)
 
 enum dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 {
-	int ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
-	return dss.lcd_clk_source[ix];
+	if (dss_has_feature(FEAT_LCD_CLK_SRC)) {
+		int ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
+		return dss.lcd_clk_source[ix];
+	} else {
+		/* LCD_CLK source is the same as DISPC_FCLK source for
+		 * OMAP2 and OMAP3 */
+		return dss.dispc_clk_source;
+	}
 }
 
 /* calculate clock rates using dividers in cinfo */
-- 
1.7.1

