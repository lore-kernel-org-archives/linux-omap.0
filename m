From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/7] OMAPDSS: add dedicated fck PLL support
Date: Mon, 18 Nov 2013 14:39:04 +0200
Message-ID: <1384778344-8226-8-git-send-email-tomi.valkeinen@ti.com>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53879 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab3KRMj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:39:26 -0500
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch adds support for SoCs that have a dedicated DSS PLL used for
DSS function clock.

If there is no dss parent clock defined, it is presumed that the
functionl clock rate can be set (almost) freely. The code calculates the
highest allowed fck rate, which when divided with some integer gives the
required pck.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 08c58eb..9a145da 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -446,12 +446,20 @@ bool dss_div_calc(unsigned long pck, unsigned long fck_min,
 	unsigned long prate;
 	unsigned m;
 
+	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+
 	if (dss.parent_clk == NULL) {
-		fck = clk_get_rate(dss.dss_clk);
+		unsigned pckd;
+
+		pckd = fck_hw_max / pck;
+
+		fck = pck * pckd;
+
+		fck = clk_round_rate(dss.dss_clk, fck);
+
 		return func(fck, data);
 	}
 
-	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 	fckd_hw_max = dss.feat->fck_div_max;
 
 	m = dss.feat->dss_fck_multiplier;
@@ -503,16 +511,17 @@ static int dss_setup_default_clock(void)
 	unsigned fck_div;
 	int r;
 
-	if (dss.parent_clk == NULL)
-		return 0;
-
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	prate = clk_get_rate(dss.parent_clk);
+	if (dss.parent_clk == NULL) {
+		fck = clk_round_rate(dss.dss_clk, max_dss_fck);
+	} else {
+		prate = clk_get_rate(dss.parent_clk);
 
-	fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
-			max_dss_fck);
-	fck = prate / fck_div * dss.feat->dss_fck_multiplier;
+		fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
+				max_dss_fck);
+		fck = prate / fck_div * dss.feat->dss_fck_multiplier;
+	}
 
 	r = dss_set_fck_rate(fck);
 	if (r)
-- 
1.8.3.2

