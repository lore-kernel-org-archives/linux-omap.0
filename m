From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/11] OMAPDSS: DISPC: check if scaling setup failed
Date: Wed, 17 Jun 2015 15:54:31 +0300
Message-ID: <1434545675-477-8-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40740 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426AbbFQMy7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:54:59 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC's scaling code seems to presume that decimation always
succeeds, and so we always do find a suitable downscaling setup.
However, this is not the case, and the algorithm can fail.

When that happens, the code just proceeds with wrong results, causing
issues later.

Add the necessary checks to bail out if the scaling algorithm failed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 2db1c986e989..0bdb587cb48c 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2279,6 +2279,11 @@ static int dispc_ovl_calc_scaling_24xx(unsigned long pclk, unsigned long lclk,
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
+	if (error) {
+		DSSERR("failed to find scaling settings\n");
+		return -EINVAL;
+	}
+
 	if (in_width > maxsinglelinewidth) {
 		DSSERR("Cannot scale max input width exceeded");
 		return -EINVAL;
@@ -2356,6 +2361,11 @@ again:
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
+	if (error) {
+		DSSERR("failed to find scaling settings\n");
+		return -EINVAL;
+	}
+
 	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, in_width,
 				in_height, out_width, out_height, *five_taps)) {
 			DSSERR("horizontal timing too tight\n");
-- 
2.1.4

