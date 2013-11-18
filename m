From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/7] OMAPDSS: simplify dss clk dump
Date: Mon, 18 Nov 2013 14:39:00 +0200
Message-ID: <1384778344-8226-4-git-send-email-tomi.valkeinen@ti.com>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45008 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab3KRMjU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:39:20 -0500
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Simplify dss_dump_clocks() so that it doesn't make any presumptions
about the DSS fclks nature.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index c37d934..3dea532 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -264,8 +264,6 @@ const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 
 void dss_dump_clocks(struct seq_file *s)
 {
-	unsigned long dpll4_ck_rate;
-	unsigned long dpll4_m4_ck_rate;
 	const char *fclk_name, *fclk_real_name;
 	unsigned long fclk_rate;
 
@@ -278,21 +276,9 @@ void dss_dump_clocks(struct seq_file *s)
 	fclk_real_name = dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_FCK);
 	fclk_rate = clk_get_rate(dss.dss_clk);
 
-	if (dss.dpll4_m4_ck) {
-		dpll4_ck_rate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
-		dpll4_m4_ck_rate = clk_get_rate(dss.dpll4_m4_ck);
-
-		seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
-
-		seq_printf(s, "%s (%s) = %lu / %lu * %d  = %lu\n",
-				fclk_name, fclk_real_name, dpll4_ck_rate,
-				dpll4_ck_rate / dpll4_m4_ck_rate,
-				dss.feat->dss_fck_multiplier, fclk_rate);
-	} else {
-		seq_printf(s, "%s (%s) = %lu\n",
-				fclk_name, fclk_real_name,
-				fclk_rate);
-	}
+	seq_printf(s, "%s (%s) = %lu\n",
+			fclk_name, fclk_real_name,
+			fclk_rate);
 
 	dss_runtime_put();
 }
-- 
1.8.3.2

