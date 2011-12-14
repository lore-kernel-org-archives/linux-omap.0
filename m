From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 3/6] HACK: omap: clk: add mpu_periphclk clk node
Date: Tue, 13 Dec 2011 20:31:25 -0800
Message-ID: <1323837088-2469-4-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52988 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754338Ab1LNEem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:34:42 -0500
Received: by mail-yw0-f44.google.com with SMTP id j72so972121yhj.3
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:34:42 -0800 (PST)
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

From: Mike Turquette <mturquette@linaro.org>

The ARM periphclk drives various peripherals for the MPU including the
TWD and local timers.  This patch creates the missing clk tree data to
represent this relationship:

 dpll_mpu_ck
      |
dpll_mpu_m2_ck (divide by 1)
      |
   mpu_clk (divide by 1)
      |
 mpu_periphclk (divide by 2)

This patch is based on Santosh Shilimkar's original version:
http://article.gmane.org/gmane.linux.ports.arm.omap/64936

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   37 +++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 33249b3..6c6d0fb 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1035,7 +1035,7 @@ static const struct clksel dpll_mpu_m2_div[] = {
 
 static const struct clk_hw_ops dpll_mpu_m2_ck_ops = {
 	.recalc_rate	= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
+	.round_rate	= &omap2_passthrough_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
 	.get_parent	= &omap2_get_parent_fixed,
 };
@@ -1043,6 +1043,7 @@ static const struct clk_hw_ops dpll_mpu_m2_ck_ops = {
 static struct clk_hw_omap dpll_mpu_m2_ck_hw = {
 	.clk = {
 		.name		= "dpll_mpu_m2_ck",
+		.flags		= CLK_PARENT_SET_RATE,
 		.ops		= &dpll_mpu_m2_ck_ops,
 	},
 	.fixed_parent	= &dpll_mpu_ck_hw.clk,
@@ -1053,6 +1054,38 @@ static struct clk_hw_omap dpll_mpu_m2_ck_hw = {
 	.deny_idle	= &omap4_dpllmx_deny_gatectrl,
 };
 
+static const struct clk_hw_ops mpu_clk_ops = {
+	.recalc_rate	= &omap_fixed_divisor_recalc,
+	.round_rate	= &omap2_passthrough_round_rate,
+	.get_parent	= &omap2_get_parent_fixed,
+};
+
+static struct clk_hw_omap mpu_clk_hw = {
+	.clk = {
+		.name		= "mpu_clk",
+		.flags		= CLK_PARENT_SET_RATE,
+		.ops		= &mpu_clk_ops,
+	},
+	.fixed_parent	= &dpll_mpu_m2_ck_hw.clk,
+	.fixed_div	= 1,
+};
+
+static const struct clk_hw_ops mpu_periphclk_ops = {
+	.recalc_rate	= &omap_fixed_divisor_recalc,
+	.round_rate	= &omap2_passthrough_round_rate,
+	.get_parent	= &omap2_get_parent_fixed,
+};
+
+static struct clk_hw_omap mpu_periphclk_hw = {
+	.clk = {
+		.name		= "mpu_periphclk",
+		.flags		= CLK_PARENT_SET_RATE,
+		.ops		= &mpu_periphclk_ops,
+	},
+	.fixed_parent	= &mpu_clk_hw.clk,
+	.fixed_div	= 2,
+};
+
 static const struct clk_hw_ops per_hs_clk_div_ck_ops = {
 	.recalc_rate	= &omap_fixed_divisor_recalc,
 	.get_parent	= &omap2_get_parent_fixed,
@@ -4071,6 +4104,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck_hw.clk,	CK_443X),
 	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck_hw.clk,	CK_443X),
 	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck_hw.clk,	CK_443X),
+	CLK(NULL,	"mpu_clk",			&mpu_clk_hw.clk,	CK_443X),
+	CLK("smp_twd",	NULL,				&mpu_periphclk_hw.clk,	CK_443X),
 	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck_hw.clk,	CK_443X),
 	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck_hw.clk,	CK_443X),
 	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck_hw.clk,	CK_443X),
-- 
1.7.5.4

