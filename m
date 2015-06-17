From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/11] OMAPDSS: DISPC: do only y decimation on OMAP3
Date: Wed, 17 Jun 2015 15:54:32 +0300
Message-ID: <1434545675-477-9-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40744 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbbFQMzB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:55:01 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The current driver does both x and y decimation on OMAP3 DSS. Testing
shows that x decimation rarely works, leading to underflows.

The exact reason for this is unclear, as the underflows seem to happen
even with low pixel clock rates, and I would presume that if the DSS can
manage a display with 140MHz pixel clock, it could manage x decimation
with factor 2 with a low pixel clock (~30MHz).

So it is possible that there is a problem somewhere else, in memory
management, or DSS DMA, or similar. I have not found anything that would
help this.

So, to fix the downscaling scaling, this patch removes x decimation for
OMAP3. This will limit some of the more demanding downscaling scenarios,
but one could argue that using DSS to downscale such a large amount is
insane in the first place, as the produced image is rather bad quality.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 0bdb587cb48c..646d94a71a79 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2300,7 +2300,6 @@ static int dispc_ovl_calc_scaling_34xx(unsigned long pclk, unsigned long lclk,
 {
 	int error;
 	u16 in_width, in_height;
-	int min_factor = min(*decim_x, *decim_y);
 	const int maxsinglelinewidth =
 			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 
@@ -2349,16 +2348,8 @@ again:
 			}
 		}
 
-		if (error) {
-			if (*decim_x == *decim_y) {
-				*decim_x = min_factor;
-				++*decim_y;
-			} else {
-				swap(*decim_x, *decim_y);
-				if (*decim_x < *decim_y)
-					++*decim_x;
-			}
-		}
+		if (error)
+			++*decim_y;
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
 	if (error) {
-- 
2.1.4

