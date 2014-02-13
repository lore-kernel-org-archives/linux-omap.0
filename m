From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/8] OMAPDSS: fix rounding when calculating fclk rate
Date: Thu, 13 Feb 2014 12:04:06 +0200
Message-ID: <1392285846-13199-9-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60620 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbaBMKFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 05:05:03 -0500
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

"clk: divider: fix rate calculation for fractional rates" patch (and
similar for TI specific divider) fixes the clk-divider's rounding. This
patch updates the DSS driver to round the rates accordingly.

This fixes the DSS's warnings about clock rate mismatch, and also fixes
the wrong fclk rate being set.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 9a145da35ad3..efe7c308341d 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -471,7 +471,7 @@ bool dss_div_calc(unsigned long pck, unsigned long fck_min,
 	fckd_stop = max(DIV_ROUND_UP(prate * m, fck_hw_max), 1ul);
 
 	for (fckd = fckd_start; fckd >= fckd_stop; --fckd) {
-		fck = prate / fckd * m;
+		fck = DIV_ROUND_UP(prate, fckd) * m;
 
 		if (func(fck, data))
 			return true;
@@ -520,7 +520,7 @@ static int dss_setup_default_clock(void)
 
 		fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
 				max_dss_fck);
-		fck = prate / fck_div * dss.feat->dss_fck_multiplier;
+		fck = DIV_ROUND_UP(prate, fck_div) * dss.feat->dss_fck_multiplier;
 	}
 
 	r = dss_set_fck_rate(fck);
-- 
1.8.3.2

