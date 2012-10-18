From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 2/2] ARM: OMAP4: clock: use omap4_clks_register API
Date: Thu, 18 Oct 2012 19:38:17 +0300
Message-ID: <1350578297-22572-3-git-send-email-grygorii.strashko@ti.com>
References: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39898 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693Ab2JRQiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 12:38:50 -0400
In-Reply-To: <1350578297-22572-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grygorii Strashko <grygorii.strashko@ti.com>

Remove OMAP443x and OMAP446x specific clocks from omap44xx_clks
array and add corresponding set of clocks per each SoC:
 - struct omap_clk omap44xx_clks[]; - common clocks set for all OMAP4
 - struct omap_clk omap443x_clks[]; - specific clocks set for OMAP443x
 - struct omap_clk omap446x_clks[]; - specific clocks set for OMAP446x
   and don't rely on platform specific flags any more.

Use omap4_clks_register() API to register and init OMAP4 set of
clocks.

With this change, we can now safely remove CK_443X/CK_446X etc macro
usage. It has not been done in this patch, but if the approach is OK,
then, it is possible to do the same.

One additional benefit seen is that the match logic can entirely be
skipped.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   40 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 6efc30c..4060c9c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3145,10 +3145,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_443X),
 	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
 	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
-	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
-	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
 	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
-	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
@@ -3346,19 +3343,27 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK(NULL,	NULL,		NULL,			CK_443X),
+};
+
+static struct omap_clk omap443x_clks[] = {
+	CLK(NULL,	"bandgap_fclk",		&bandgap_fclk,		CK_443X),
+	CLK(NULL,	NULL,		NULL,			CK_443X),
+};
+
+
+static struct omap_clk omap446x_clks[] = {
+	CLK(NULL,	"div_ts_ck",		&div_ts_ck,		CK_446X),
+	CLK(NULL,	"bandgap_ts_fclk",	&bandgap_ts_fclk,	CK_446X),
+	CLK(NULL,	NULL,		NULL,		CK_446X),
 };
 
 int __init omap4xxx_clk_init(void)
 {
-	struct omap_clk *c;
-	u32 cpu_clkflg;
-
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
-		cpu_clkflg = CK_443X;
 	} else if (cpu_is_omap446x() || cpu_is_omap447x()) {
 		cpu_mask = RATE_IN_4460 | RATE_IN_4430;
-		cpu_clkflg = CK_446X | CK_443X;
 
 		if (cpu_is_omap447x())
 			pr_warn("WARNING: OMAP4470 clock data incomplete!\n");
@@ -3375,17 +3380,14 @@ int __init omap4xxx_clk_init(void)
 	 * omap2_clk_disable_clkdm_control();
 	 */
 
-	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
-									  c++)
-		clk_preinit(c->lk.clk);
-
-	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
-									  c++)
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			clk_register(c->lk.clk);
-			omap2_init_clk_clkdm(c->lk.clk);
-		}
+	omap2_clks_register(omap44xx_clks);
+
+	if (cpu_is_omap443x())
+		omap2_clks_register(omap443x_clks);
+	else if (cpu_is_omap446x() || cpu_is_omap447x())
+		omap2_clks_register(omap446x_clks);
+	else
+		return 0;
 
 	/* Disable autoidle on all clocks; let the PM code enable it later */
 	omap_clk_disable_autoidle_all();
-- 
1.7.9.5

