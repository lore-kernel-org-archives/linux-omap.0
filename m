From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 19/23] OMAP3630: DSS2: Updating MAX divider value
Date: Tue, 18 May 2010 15:35:10 +0300
Message-ID: <1274186114-26951-20-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62555 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757557Ab0ERMgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:31 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Kishore Y <kishore.y@ti.com>, Sudeep Basavaraj <sudeep.basavaraj@ti.com>, Mukund Mittal <mmittal@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Kishore Y <kishore.y@ti.com>

In DPLL4 M3, M4, M5 and M6 field width has been increased by 1 bit in 3630.
So the max divider value that can be achived will be 32 and not 16.
In 3630 the functional clock is x1 of DPLL4 and not x2. Hence multiplier 2
is removed.

Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dss.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 5434418..24b1825 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -223,7 +223,13 @@ void dss_dump_clocks(struct seq_file *s)
 
 	seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
 
-	seq_printf(s, "dss1_alwon_fclk = %lu / %lu * 2 = %lu\n",
+	if (cpu_is_omap3630())
+		seq_printf(s, "dss1_alwon_fclk = %lu / %lu  = %lu\n",
+			dpll4_ck_rate,
+			dpll4_ck_rate / dpll4_m4_ck_rate,
+			dss_clk_get_rate(DSS_CLK_FCK1));
+	else
+		seq_printf(s, "dss1_alwon_fclk = %lu / %lu * 2 = %lu\n",
 			dpll4_ck_rate,
 			dpll4_ck_rate / dpll4_m4_ck_rate,
 			dss_clk_get_rate(DSS_CLK_FCK1));
@@ -293,7 +299,8 @@ int dss_calc_clock_rates(struct dss_clock_info *cinfo)
 {
 	unsigned long prate;
 
-	if (cinfo->fck_div > 16 || cinfo->fck_div == 0)
+	if (cinfo->fck_div > (cpu_is_omap3630() ? 32 : 16) ||
+						cinfo->fck_div == 0)
 		return -EINVAL;
 
 	prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
@@ -329,7 +336,10 @@ int dss_get_clock_div(struct dss_clock_info *cinfo)
 	if (cpu_is_omap34xx()) {
 		unsigned long prate;
 		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
-		cinfo->fck_div = prate / (cinfo->fck / 2);
+		if (cpu_is_omap3630())
+			cinfo->fck_div = prate / (cinfo->fck);
+		else
+			cinfo->fck_div = prate / (cinfo->fck / 2);
 	} else {
 		cinfo->fck_div = 0;
 	}
@@ -402,10 +412,14 @@ retry:
 
 		goto found;
 	} else if (cpu_is_omap34xx()) {
-		for (fck_div = 16; fck_div > 0; --fck_div) {
+		for (fck_div = (cpu_is_omap3630() ? 32 : 16);
+					fck_div > 0; --fck_div) {
 			struct dispc_clock_info cur_dispc;
 
-			fck = prate / fck_div * 2;
+			if (cpu_is_omap3630())
+				fck = prate / fck_div;
+			else
+				fck = prate / fck_div * 2;
 
 			if (fck > DISPC_MAX_FCK)
 				continue;
-- 
1.7.0.4

