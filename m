From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/20] OMAPDSS: DISPC: fix dispc_mgr_lclk_rate for DIGIT output
Date: Wed, 24 Oct 2012 12:28:55 +0300
Message-ID: <1351070951-18616-5-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47948 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003Ab2JXJ3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 05:29:32 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_lclk_rate() cannot currently be called with DIGIT channel
parameter, even if dispc_ovl_lclk_rate() can. Fix this by making
dispc_mgr_lclk_rate() handle DIGIT channel also.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   49 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 817d671..198e321 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3167,28 +3167,32 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISORo(channel));
+	if (dss_mgr_is_lcd(channel)) {
+		l = dispc_read_reg(DISPC_DIVISORo(channel));
 
-	lcd = FLD_GET(l, 23, 16);
+		lcd = FLD_GET(l, 23, 16);
 
-	switch (dss_get_lcd_clk_source(channel)) {
-	case OMAP_DSS_CLK_SRC_FCK:
-		r = clk_get_rate(dispc.dss_clk);
-		break;
-	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
-		dsidev = dsi_get_dsidev_from_id(0);
-		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
-		break;
-	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
-		dsidev = dsi_get_dsidev_from_id(1);
-		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
-		break;
-	default:
-		BUG();
-		return 0;
-	}
+		switch (dss_get_lcd_clk_source(channel)) {
+		case OMAP_DSS_CLK_SRC_FCK:
+			r = clk_get_rate(dispc.dss_clk);
+			break;
+		case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
+			dsidev = dsi_get_dsidev_from_id(0);
+			r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+			break;
+		case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
+			dsidev = dsi_get_dsidev_from_id(1);
+			r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+			break;
+		default:
+			BUG();
+			return 0;
+		}
 
-	return r / lcd;
+		return r / lcd;
+	} else {
+		return dispc_fclk_rate();
+	}
 }
 
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
@@ -3247,12 +3251,9 @@ static unsigned long dispc_plane_lclk_rate(enum omap_plane plane)
 {
 	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
 
-	if (dss_mgr_is_lcd(channel))
-		return dispc_mgr_lclk_rate(channel);
-	else
-		return dispc_fclk_rate();
-
+	return dispc_mgr_lclk_rate(channel);
 }
+
 static void dispc_dump_clocks_channel(struct seq_file *s, enum omap_channel channel)
 {
 	int lcd, pcd;
-- 
1.7.9.5

