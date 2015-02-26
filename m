From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/15] OMAPDSS: DISPC: fix div by zero issue in overlay scaling
Date: Thu, 26 Feb 2015 14:49:03 +0200
Message-ID: <1424954949-12801-9-git-send-email-tomi.valkeinen@ti.com>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60617 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbbBZMto (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 07:49:44 -0500
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm doesn't always configure the overlays correctly, causing the
overlay setup functions to be called with zero timings. This leads to
division by zero error.

This happens, for example, when a HDMI cable is not connected, but a
user tries to setup a plane with scaling.

Fixing omapdrm is a big job, so for now let's check for the bad timings
in DISPC and return an error.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 8805266a52f4..1123111d3940 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2322,6 +2322,11 @@ static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 	if (width == out_width && height == out_height)
 		return 0;
 
+	if (pclk == 0 || mgr_timings->pixelclock == 0) {
+		DSSERR("cannot calculate scaling settings: pclk is zero\n");
+		return -EINVAL;
+	}
+
 	if ((caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
 		return -EINVAL;
 
-- 
2.3.0

