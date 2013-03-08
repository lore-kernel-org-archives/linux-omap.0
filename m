From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/14] OMAPDSS: DISPC: store core clk rate
Date: Fri, 8 Mar 2013 13:52:36 +0200
Message-ID: <1362743569-10289-2-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33547 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933764Ab3CHLxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:15 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Store dispc core clock rate so that it's available for calculations even
if the HW is disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 05ff2b9..f564955 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -97,6 +97,8 @@ static struct {
 
 	int irq;
 
+	unsigned long core_clk_rate;
+
 	u32 fifo_size[DISPC_MAX_NR_FIFOS];
 	/* maps which plane is using a fifo. fifo-id -> plane-id */
 	int fifo_assignment[DISPC_MAX_NR_FIFOS];
@@ -2951,6 +2953,10 @@ static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 
 	dispc_write_reg(DISPC_DIVISORo(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
+
+	if (dss_has_feature(FEAT_CORE_CLK_DIV) == false &&
+			channel == OMAP_DSS_CHANNEL_LCD)
+		dispc.core_clk_rate = dispc_fclk_rate() / lck_div;
 }
 
 static void dispc_mgr_get_lcd_divisor(enum omap_channel channel, int *lck_div,
@@ -3056,15 +3062,7 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 
 unsigned long dispc_core_clk_rate(void)
 {
-	int lcd;
-	unsigned long fclk = dispc_fclk_rate();
-
-	if (dss_has_feature(FEAT_CORE_CLK_DIV))
-		lcd = REG_GET(DISPC_DIVISOR, 23, 16);
-	else
-		lcd = REG_GET(DISPC_DIVISORo(OMAP_DSS_CHANNEL_LCD), 23, 16);
-
-	return fclk / lcd;
+	return dispc.core_clk_rate;
 }
 
 static unsigned long dispc_plane_pclk_rate(enum omap_plane plane)
@@ -3451,6 +3449,8 @@ static void _omap_dispc_initial_config(void)
 		l = FLD_MOD(l, 1, 0, 0);
 		l = FLD_MOD(l, 1, 23, 16);
 		dispc_write_reg(DISPC_DIVISOR, l);
+
+		dispc.core_clk_rate = dispc_fclk_rate();
 	}
 
 	/* FUNCGATED */
-- 
1.7.10.4

