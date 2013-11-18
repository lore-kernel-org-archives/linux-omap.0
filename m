From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/7] OMAPDSS: fix omap2 dss fck handling
Date: Mon, 18 Nov 2013 14:38:58 +0200
Message-ID: <1384778344-8226-2-git-send-email-tomi.valkeinen@ti.com>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab3KRMjR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:39:17 -0500
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The driver considers OMAP2 DSS's functional clock as a fixed clock.
However, it can be changed, but the possible dividers are not continuous
which is why it was just handled as a fixed clock.

As a partial fix, this patch changes the code to handle the continous
part of the dividers, from 1 to 6. This let's us handle the OMAP2 fck
the same way as fcks on other OMAPs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bd01608..e59577a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -484,11 +484,6 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 	unsigned m;
 
 	if (dss.dpll4_m4_ck == NULL) {
-		/*
-		 * TODO: dss1_fclk can be changed on OMAP2, but the available
-		 * dividers are not continuous. We just use the pre-set rate for
-		 * now.
-		 */
 		fck = clk_get_rate(dss.dss_clk);
 		fckd = 1;
 		return func(fckd, fck, data);
@@ -761,9 +756,13 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #endif
 
 static const struct dss_features omap24xx_dss_feats __initconst = {
-	.fck_div_max		=	16,
+	/*
+	 * fck div max is really 16, but the divider range has gaps. The range
+	 * from 1 to 6 has no gaps, so let's use that as a max.
+	 */
+	.fck_div_max		=	6,
 	.dss_fck_multiplier	=	2,
-	.clk_name		=	NULL,
+	.clk_name		=	"dss1_fck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
-- 
1.8.3.2

