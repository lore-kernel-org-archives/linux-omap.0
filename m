From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH] OMAP3630:DSS: Updating MAX divider value
Date: Sun, 25 Apr 2010 16:42:00 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2B95@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53812 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab0DYLKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Apr 2010 07:10:43 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


In DPLL4 M3, M4, M5 and M6 field width has been increased by 1 bit in 3630.
So the max divider value that can be achived will be 32 and not 16.
In 3630 the functional clock is x1 of DPLL4 and not x2 .Hence multiplier 2
is removed.

Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
---
 drivers/video/omap2/dss/dss.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 5434418..e78b67d 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -34,8 +34,12 @@
 #include "dss.h"
 
 #define DSS_BASE			0x48050000
-
 #define DSS_SZ_REGS			SZ_512
+#if defined(CONFIG_MACH_OMAP_ZOOM3) || defined(CONFIG_MACH_OMAP_3630SDP)
+#define FCK_MAX_DIV			32
+#else
+#define FCK_MAX_DIV			16
+#endif
 
 struct dss_reg {
 	u16 idx;
@@ -223,7 +227,13 @@ void dss_dump_clocks(struct seq_file *s)
 
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
@@ -293,7 +303,7 @@ int dss_calc_clock_rates(struct dss_clock_info *cinfo)
 {
 	unsigned long prate;
 
-	if (cinfo->fck_div > 16 || cinfo->fck_div == 0)
+	if (cinfo->fck_div > FCK_MAX_DIV || cinfo->fck_div == 0)
 		return -EINVAL;
 
 	prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
@@ -329,7 +339,10 @@ int dss_get_clock_div(struct dss_clock_info *cinfo)
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
@@ -402,10 +415,13 @@ retry:
 
 		goto found;
 	} else if (cpu_is_omap34xx()) {
-		for (fck_div = 16; fck_div > 0; --fck_div) {
+		for (fck_div = FCK_MAX_DIV; fck_div > 0; --fck_div) {
 			struct dispc_clock_info cur_dispc;
 
-			fck = prate / fck_div * 2;
+			if (cpu_is_omap3630())
+				fck = prate / fck_div;
+			else
+				fck = prate / fck_div * 2;
 
 			if (fck > DISPC_MAX_FCK)
 				continue;
-- 
1.5.6.3


Regards,
Kishore Y
