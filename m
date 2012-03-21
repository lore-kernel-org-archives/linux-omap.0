From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Date: Wed, 21 Mar 2012 15:22:10 +0530
Message-ID: <1332323530-9088-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46562 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758095Ab2CUJwQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:52:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
divisor LCD.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d8a1672..1fdac73 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1761,6 +1761,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	const int max_decim_limit = 16;
 	unsigned long fclk = 0;
+	unsigned long dispc_core_clk = dispc_mgr_lclk_rate(channel);
 	int decim_x, decim_y, error, min_factor;
 	u16 in_width, in_height, in_width_max = 0;
 
@@ -1803,7 +1804,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 			fclk = calc_fclk(channel, in_width, in_height,
 					out_width, out_height);
 			error = (in_width > maxsinglelinewidth || !fclk ||
-				fclk > dispc_fclk_rate());
+				fclk > dispc_core_clk);
 			if (error) {
 				if (decim_x == decim_y) {
 					decim_x = min_factor;
@@ -1841,7 +1842,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 					out_width, out_height);
 			error = (error || in_width > maxsinglelinewidth * 2 ||
 				(in_width > maxsinglelinewidth && *five_taps) ||
-				!fclk || fclk > dispc_fclk_rate());
+				!fclk || fclk > dispc_core_clk);
 			if (error) {
 				if (decim_x == decim_y) {
 					decim_x = min_factor;
@@ -1873,7 +1874,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		}
 	} else {
 		in_height = DIV_ROUND_UP(height, decim_y);
-		in_width_max = dispc_fclk_rate() /
+		in_width_max = dispc_core_clk /
 				DIV_ROUND_UP(dispc_mgr_pclk_rate(channel),
 						out_width);
 		decim_x = DIV_ROUND_UP(width, in_width_max);
@@ -1894,13 +1895,13 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	}
 
 	DSSDBG("required fclk rate = %lu Hz\n", fclk);
-	DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
+	DSSDBG("current fclk rate = %lu Hz\n", dispc_core_clk);
 
-	if (!fclk || fclk > dispc_fclk_rate()) {
+	if (!fclk || fclk > dispc_core_clk) {
 		DSSERR("failed to set up scaling, "
 			"required fclk rate = %lu Hz, "
 			"current fclk rate = %lu Hz\n",
-			fclk, dispc_fclk_rate());
+			fclk, dispc_core_clk);
 		return -EINVAL;
 	}
 
-- 
1.7.1

