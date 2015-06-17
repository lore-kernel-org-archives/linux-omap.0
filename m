From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/11] OMAPDSS: DISPC: fix check_horiz_timing_omap3 args
Date: Wed, 17 Jun 2015 15:54:27 +0300
Message-ID: <1434545675-477-4-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56641 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbbFQMyy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:54:54 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

After calculating the required decimation for scaling, the dispc driver
checks once more if the resulting configuration is valid by calling
check_horiz_timing_omap3().

Earlier calls to this function have correctly used in_width and
in_height as parameters, but the last call uses width and height. This
causes the driver to possibly reject scaling that would work.

This patch fixes the parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index db60aa98f661..cc61513afdb4 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2338,8 +2338,8 @@ again:
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
-	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, width,
-				height, out_width, out_height, *five_taps)) {
+	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, in_width,
+				in_height, out_width, out_height, *five_taps)) {
 			DSSERR("horizontal timing too tight\n");
 			return -EINVAL;
 	}
-- 
2.1.4

