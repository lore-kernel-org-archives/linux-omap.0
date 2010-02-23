From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/11] OMAP4: clock: Add dummy clock nodes for interface clocks
Date: Mon, 22 Feb 2010 21:50:58 -0700
Message-ID: <20100223045056.18888.65308.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60278 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0BWE5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:40 -0500
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4 platform the iclk control is completly under hardware control
and no software control is available.

This difference w.r.t previous OMAP's needs all the common driver
accross OMAP's , cpu_is_xxxx() checks. To avoid poulluting the
drivers dummy clock nodes are created (The autogeneration
script has been updated accordingly).

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: made OMAP1 dummy_ck common and edited patch to reuse that]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c             |   14 ------------
 arch/arm/mach-omap1/clock_data.c        |    6 -----
 arch/arm/mach-omap2/clock.h             |    1 +
 arch/arm/mach-omap2/clock44xx_data.c    |   35 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/clock.c              |   10 +++++++++
 arch/arm/plat-omap/include/plat/clock.h |    2 ++
 6 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 0ba044d..e0aec10 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -38,20 +38,6 @@ struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
  * Omap1 specific clock functions
  *-------------------------------------------------------------------------*/
 
-static int clk_omap1_dummy_enable(struct clk *clk)
-{
-	return 0;
-}
-
-static void clk_omap1_dummy_disable(struct clk *clk)
-{
-}
-
-const struct clkops clkops_dummy = {
-	.enable		= clk_omap1_dummy_enable,
-	.disable	= clk_omap1_dummy_disable,
-};
-
 unsigned long omap1_uart_recalc(struct clk *clk)
 {
 	unsigned int val = __raw_readl(clk->enable_reg);
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 8b1d14d..aa8558a 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -27,12 +27,6 @@
  * Omap1 clocks
  *-------------------------------------------------------------------------*/
 
-/* XXX is this necessary? */
-static struct clk dummy_ck = {
-	.name	= "dummy",
-	.ops	= &clkops_dummy,
-};
-
 static struct clk ck_ref = {
 	.name		= "ck_ref",
 	.ops		= &clkops_null,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 49ad473..816d932 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -101,6 +101,7 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 extern u8 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
+extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index c0825cf..28b1079 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2645,6 +2645,41 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
 	CLK(NULL,	"utmi_p1_gfclk_ck",		&utmi_p1_gfclk_ck,	CK_443X),
 	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
+	CLK(NULL,	"gpio1_dbck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpio2_dbck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpio3_dbck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpio4_dbck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpio5_dbck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpio6_dbck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt3_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt4_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt5_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt6_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt7_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt8_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_443X),
+	CLK("i2c_omap.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("i2c_omap.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("i2c_omap.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("i2c_omap.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcbsp.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcspi.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcspi.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcspi.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap-mcspi.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
+	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
+	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 6cc13e7..5261a09 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -357,6 +357,16 @@ const struct clkops clkops_null = {
 	.disable	= clkll_disable_null,
 };
 
+/*
+ * Dummy clock
+ *
+ * Used for clock aliases that are needed on some OMAPs, but not others
+ */
+struct clk dummy_ck = {
+	.name	= "dummy",
+	.ops	= &clkops_null,
+};
+
 #ifdef CONFIG_CPU_FREQ
 void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 6a32ac1..2e2e4c5 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -188,6 +188,8 @@ extern struct clk *omap_clk_get_by_name(const char *name);
 
 extern const struct clkops clkops_null;
 
+extern struct clk dummy_ck;
+
 /* Clock flags */
 #define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 1)


