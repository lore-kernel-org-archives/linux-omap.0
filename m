From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAPDSS: DISPC: Fix calc_scaling_44xx() bugs for writeback pipeline
Date: Wed, 7 Nov 2012 11:45:02 +0530
Message-ID: <1352268905-31093-2-git-send-email-archit@ti.com>
References: <1352268905-31093-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51700 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2KGGPa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 01:15:30 -0500
In-Reply-To: <1352268905-31093-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dispc_ovl_calc_scaling_44xx() doesn't work correctly for writeback. There are
two issues with it:

- the function tries to calculate pixel clock for the input plane using
  dispc_plane_pclk_rate(), calling this with writeback as input plane results in
  a BUG(), this function shouldn't be called for writeback at all. Fix this by
  calculating pixel clock only when we are not in mem to mem mode.

- the maximum input_width is the product of the downscale ratio supported and
  the and the given output_width. This was calculated incorrectly by dividing
  output_width with maxdownscale. Fix this.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 05def42..f19cd37 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2264,14 +2264,16 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 	u16 in_height = DIV_ROUND_UP(height, *decim_y);
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 
-	if (mem_to_mem)
-		in_width_max = DIV_ROUND_UP(out_width, maxdownscale);
-	else
+	if (mem_to_mem) {
+		in_width_max = out_width * maxdownscale;
+	} else {
+		unsigned long pclk = dispc_plane_pclk_rate(plane);
+
 		in_width_max = dispc_core_clk_rate() /
 					DIV_ROUND_UP(pclk, out_width);
+	}
 
 	*decim_x = DIV_ROUND_UP(width, in_width_max);
 
-- 
1.7.9.5

