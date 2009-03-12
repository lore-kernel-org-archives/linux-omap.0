From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 03/86] [ARM] omap: provide a NULL clock operations structure
Date: Thu, 12 Mar 2009 11:27:13 -0700
Message-ID: <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbZCLS3A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:00 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:28:58 -0700 (PDT)
In-Reply-To: <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

... and use it for clocks which are ALWAYS_ENABLED.  These clocks
use a non-NULL enable_reg pointer for other purposes (such as
selecting clock rates.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |    3 -
 arch/arm/mach-omap1/clock.h             |   78 +++++++++++++---------------
 arch/arm/mach-omap2/clock.c             |    4 +-
 arch/arm/mach-omap2/clock24xx.h         |   31 ++++++++---
 arch/arm/mach-omap2/clock34xx.h         |   85 ++++++++++++++++++------------
 arch/arm/plat-omap/clock.c              |   23 ++++++++-
 arch/arm/plat-omap/include/mach/clock.h |    4 +-
 7 files changed, 135 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 25ef04d..ff40810 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -515,9 +515,6 @@ static int omap1_clk_enable_generic(struct clk *clk)
 	__u16 regval16;
 	__u32 regval32;
 
-	if (clk->flags & ALWAYS_ENABLED)
-		return 0;
-
 	if (unlikely(clk->enable_reg == NULL)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 5b93a2a..8673832 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -144,18 +144,18 @@ static struct mpu_rate rate_table[] = {
 
 static struct clk ck_ref = {
 	.name		= "ck_ref",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310,
 };
 
 static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_PROPAGATES | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_PROPAGATES,
 };
 
 static struct arm_idlect1_clk ck_dpll1out = {
@@ -186,11 +186,10 @@ static struct clk sossi_ck = {
 
 static struct clk arm_ck = {
 	.name		= "arm_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES |
-			  ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 };
@@ -265,9 +264,9 @@ static struct arm_idlect1_clk armwdt_ck = {
 
 static struct clk arminth_ck16xx = {
 	.name		= "arminth_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &arm_ck,
-	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 	/* Note: On 16xx the frequency can be divided by 2 by programming
 	 * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
@@ -290,10 +289,10 @@ static struct clk dsp_ck = {
 
 static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL | ALWAYS_ENABLED,
+			  RATE_CKCTL,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 };
@@ -337,12 +336,12 @@ static struct clk dsptim_ck = {
 static struct arm_idlect1_clk tc_ck = {
 	.clk = {
 		.name		= "tc_ck",
-		.ops		= &clkops_generic,
+		.ops		= &clkops_null,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
 				  RATE_CKCTL | RATE_PROPAGATES |
-				  ALWAYS_ENABLED | CLOCK_IDLE_CONTROL,
+				  CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
 	},
@@ -351,10 +350,9 @@ static struct arm_idlect1_clk tc_ck = {
 
 static struct clk arminth_ck1510 = {
 	.name		= "arminth_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.recalc		= &followparent_recalc,
 	/* Note: On 1510 the frequency follows TC_CK
 	 *
@@ -365,10 +363,9 @@ static struct clk arminth_ck1510 = {
 static struct clk tipb_ck = {
 	/* No-idle controlled by "tc_ck" */
 	.name		= "tipb_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.recalc		= &followparent_recalc,
 };
 
@@ -406,18 +403,18 @@ static struct clk tc2_ck = {
 static struct clk dma_ck = {
 	/* No-idle controlled by "tc_ck" */
 	.name		= "dma_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310,
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk dma_lcdfree_ck = {
 	.name		= "dma_lcdfree_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 };
 
@@ -451,17 +448,17 @@ static struct arm_idlect1_clk lb_ck = {
 
 static struct clk rhea1_ck = {
 	.name		= "rhea1_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk rhea2_ck = {
 	.name		= "rhea2_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 };
 
@@ -493,13 +490,12 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 
 static struct clk uart1_1510 = {
 	.name		= "uart1_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
-			  CLOCK_NO_IDLE_PARENT,
+			  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -523,13 +519,13 @@ static struct uart_clk uart1_16xx = {
 
 static struct clk uart2_ck = {
 	.name		= "uart2_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
-			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
+			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -538,13 +534,12 @@ static struct clk uart2_ck = {
 
 static struct clk uart3_1510 = {
 	.name		= "uart3_ck",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
-			  CLOCK_NO_IDLE_PARENT,
+			  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -680,9 +675,9 @@ static struct clk mmc2_ck = {
 
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+			  CLOCK_IN_OMAP310,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
@@ -694,9 +689,9 @@ remains active during MPU idle whenever this is enabled */
 static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
-	.ops		= &clkops_generic,
+	.ops		= &clkops_null,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_NO_IDLE_PARENT | ALWAYS_ENABLED,
+			  CLOCK_NO_IDLE_PARENT,
 	.parent		= &armxor_ck.clk,
 	.recalc		= &followparent_recalc,
 };
@@ -704,9 +699,8 @@ static struct clk i2c_fck = {
 static struct clk i2c_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
-	.ops		= &clkops_generic,
-	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
-			  ALWAYS_ENABLED,
+	.ops		= &clkops_null,
+	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT,
 	.parent		= &armper_ck.clk,
 	.recalc		= &followparent_recalc,
 };
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d3213f5..fa99c0b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -271,7 +271,7 @@ int _omap2_clk_enable(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
+	if (clk->flags & PARENT_CONTROLS_CLOCK)
 		return 0;
 
 	if (clk->ops && clk->ops->enable)
@@ -301,7 +301,7 @@ void _omap2_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
-	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
+	if (clk->flags & PARENT_CONTROLS_CLOCK)
 		return;
 
 	if (clk->ops && clk->ops->disable) {
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 2aa0b5e..d486937 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -619,9 +619,10 @@ static struct prcm_config rate_table[] = {
 /* Base external input clocks */
 static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
+	.ops		= &clkops_null,
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+				RATE_FIXED | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &propagate_rate,
 };
@@ -639,18 +640,20 @@ static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 /* Without modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
+	.ops		= &clkops_null,
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | RATE_PROPAGATES,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_sys_clk_recalc,
 };
 
 static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
+	.ops		= &clkops_null,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+				RATE_FIXED | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &propagate_rate,
 };
@@ -679,10 +682,11 @@ static struct dpll_data dpll_dd = {
  */
 static struct clk dpll_ck = {
 	.name		= "dpll_ck",
+	.ops		= &clkops_null,
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | ALWAYS_ENABLED,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_dpllcore_recalc,
 	.set_rate	= &omap2_reprogram_dpllcore,
@@ -751,9 +755,10 @@ static struct clk func_54m_ck = {
 
 static struct clk core_ck = {
 	.name		= "core_ck",
+	.ops		= &clkops_null,
 	.parent		= &dpll_ck,		/* can also be 32k */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | RATE_PROPAGATES,
+				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -837,6 +842,7 @@ static struct clk func_12m_ck = {
 /* Secure timer, only available in secure mode */
 static struct clk wdt1_osc_ck = {
 	.name		= "ck_wdt1_osc",
+	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.recalc		= &followparent_recalc,
@@ -996,9 +1002,10 @@ static const struct clksel mpu_clksel[] = {
 
 static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
+	.ops		= &clkops_null,
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP |
+				DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
@@ -1168,9 +1175,10 @@ static const struct clksel core_l3_clksel[] = {
 
 static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
+	.ops		= &clkops_null,
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP |
+				DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1231,9 +1239,10 @@ static const struct clksel l4_clksel[] = {
 
 static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
+	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
+				DELAYED_APP | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
@@ -2359,6 +2368,7 @@ static struct clk i2chs1_fck = {
 
 static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
+	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ENABLE_ON_INIT,
@@ -2368,6 +2378,7 @@ static struct clk gpmc_fck = {
 
 static struct clk sdma_fck = {
 	.name		= "sdma_fck",
+	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2376,6 +2387,7 @@ static struct clk sdma_fck = {
 
 static struct clk sdma_ick = {
 	.name		= "sdma_ick",
+	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
@@ -2621,8 +2633,9 @@ static struct clk mmchsdb2_fck = {
  */
 static struct clk virt_prcm_set = {
 	.name		= "virt_prcm_set",
+	.ops		= &clkops_null,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP,
+				DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
 	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 8b188fb..b56fd28 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -55,66 +55,66 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk);
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
 static struct clk omap_32k_fck = {
 	.name		= "omap_32k_fck",
+	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
+	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 /* Virtual source clocks for osc_sys_ck */
 static struct clk virt_12m_ck = {
 	.name		= "virt_12m_ck",
+	.ops		= &clkops_null,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_13m_ck = {
 	.name		= "virt_13m_ck",
+	.ops		= &clkops_null,
 	.rate		= 13000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
+	.ops		= &clkops_null,
 	.rate		= 16800000,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
+	.ops		= &clkops_null,
 	.rate		= 19200000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_26m_ck = {
 	.name		= "virt_26m_ck",
+	.ops		= &clkops_null,
 	.rate		= 26000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
+	.ops		= &clkops_null,
 	.rate		= 38400000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
@@ -162,13 +162,13 @@ static const struct clksel osc_sys_clksel[] = {
 /* 12, 13, 16.8, 19.2, 26, or 38.4 MHz */
 static struct clk osc_sys_ck = {
 	.name		= "osc_sys_ck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP3430_PRM_CLKSEL,
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -187,25 +187,28 @@ static const struct clksel sys_clksel[] = {
 /* Feeds DPLLs - divided first by PRM_CLKSRC_CTRL.SYSCLKDIV? */
 static struct clk sys_ck = {
 	.name		= "sys_ck",
+	.ops		= &clkops_null,
 	.parent		= &osc_sys_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP3430_PRM_CLKSRC_CTRL,
 	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
 	.clksel		= sys_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk sys_altclk = {
 	.name		= "sys_altclk",
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.ops		= &clkops_null,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
 /* Optional external clock input for some McBSPs */
 static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.ops		= &clkops_null,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &propagate_rate,
 };
 
@@ -278,9 +281,10 @@ static struct dpll_data dpll1_dd = {
 
 static struct clk dpll1_ck = {
 	.name		= "dpll1_ck",
+	.ops		= &clkops_null,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -398,9 +402,10 @@ static struct dpll_data dpll3_dd = {
 
 static struct clk dpll3_ck = {
 	.name		= "dpll3_ck",
+	.ops		= &clkops_null,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll3_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -2266,9 +2271,10 @@ static struct clk gpt1_fck = {
 
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2295,8 +2301,9 @@ static struct clk wdt2_fck = {
 
 static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
+	.ops		= &clkops_null,
 	.parent		= &sys_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2514,9 +2521,10 @@ static struct clk gpt9_fck = {
 
 static struct clk per_32k_alwon_fck = {
 	.name		= "per_32k_alwon_fck",
+	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
 	.clkdm_name	= "per_clkdm",
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2859,11 +2867,12 @@ static const struct clksel emu_src_clksel[] = {
  */
 static struct clk emu_src_ck = {
 	.name		= "emu_src_ck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2883,11 +2892,12 @@ static const struct clksel pclk_emu_clksel[] = {
 
 static struct clk pclk_fck = {
 	.name		= "pclk_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2906,11 +2916,12 @@ static const struct clksel pclkx2_emu_clksel[] = {
 
 static struct clk pclkx2_fck = {
 	.name		= "pclkx2_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2922,22 +2933,24 @@ static const struct clksel atclk_emu_clksel[] = {
 
 static struct clk atclk_fck = {
 	.name		= "atclk_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk traceclk_src_fck = {
 	.name		= "traceclk_src_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2956,11 +2969,12 @@ static const struct clksel traceclk_clksel[] = {
 
 static struct clk traceclk_fck = {
 	.name		= "traceclk_fck",
+	.ops		= &clkops_null,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
 	.clksel		= traceclk_clksel,
-	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2989,6 +3003,7 @@ static struct clk sr2_fck = {
 
 static struct clk sr_l4_ick = {
 	.name		= "sr_l4_ick",
+	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -3000,15 +3015,17 @@ static struct clk sr_l4_ick = {
 /* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
+	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt1_fck = {
 	.name		= "wdt1_fck",
+	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index be6aab9..529c4a9 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -358,6 +358,23 @@ void clk_enable_init_clocks(void)
 }
 EXPORT_SYMBOL(clk_enable_init_clocks);
 
+/*
+ * Low level helpers
+ */
+static int clkll_enable_null(struct clk *clk)
+{
+	return 0;
+}
+
+static void clkll_disable_null(struct clk *clk)
+{
+}
+
+const struct clkops clkops_null = {
+	.enable		= clkll_enable_null,
+	.disable	= clkll_disable_null,
+};
+
 #ifdef CONFIG_CPU_FREQ
 void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
@@ -383,8 +400,10 @@ static int __init clk_disable_unused(void)
 	unsigned long flags;
 
 	list_for_each_entry(ck, &clocks, node) {
-		if (ck->usecount > 0 || (ck->flags & ALWAYS_ENABLED) ||
-			ck->enable_reg == 0)
+		if (ck->ops == &clkops_null)
+			continue;
+
+		if (ck->usecount > 0 || ck->enable_reg == 0)
 			continue;
 
 		spin_lock_irqsave(&clockfw_lock, flags);
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 4fe5084..c1e4844 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -125,11 +125,13 @@ extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 
+extern const struct clkops clkops_null;
+
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
 #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
 #define RATE_PROPAGATES		(1 << 2)	/* Program children too */
-#define ALWAYS_ENABLED		(1 << 4)	/* Clock cannot be disabled */
+/* bits 3-4 are free */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
 #define VIRTUAL_IO_ADDRESS	(1 << 6)	/* Clock in virtual address */
 #define CLOCK_IDLE_CONTROL	(1 << 7)
-- 
1.6.1.2

