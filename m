From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 08/11] OMAP2/3 clock: convert omap2_wait_clock_ready() to
	use clk.prcm_mod
Date: Thu, 18 Sep 2008 11:47:15 -0600
Message-ID: <20080918174712.7146.55539.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55118 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbYIRRsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:09 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert omap2_wait_clock_ready() to use clk.prcm_mod rather than a
void __iomem *.  This removes some cruft from clock24xx.c and sets
up further cruft removal in a subsequent patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c     |   13 ++++++++-----
 arch/arm/mach-omap2/clock.h     |    3 ++-
 arch/arm/mach-omap2/clock24xx.c |   10 +---------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6433679..b2478b7 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -255,14 +255,16 @@ void omap2_fixed_divisor_recalc(struct clk *clk)
 
 /**
  * omap2_wait_clock_ready - wait for clock to enable
- * @reg: physical address of clock IDLEST register
+ * @prcm_mod: CM submodule offset from CM_BASE (e.g., "MPU_MOD")
+ * @reg_index: offset of CM register address from prcm_mod
  * @mask: value to mask against to determine if the clock is active
  * @name: name of the clock (for printk)
  *
  * Returns 1 if the clock enabled in time, or 0 if it failed to enable
  * in roughly MAX_CLOCK_ENABLE_WAIT microseconds.
  */
-int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
+int omap2_wait_clock_ready(s16 prcm_mod, u16 reg_index, u32 mask,
+			   const char *name)
 {
 	int i = 0, ena = 0;
 
@@ -276,7 +278,7 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 		ena = 0;
 
 	/* Wait for lock */
-	while (((__raw_readl(reg) & mask) != ena) &&
+	while (((cm_read_mod_reg(prcm_mod, reg_index) & mask) != ena) &&
 	       (i++ < MAX_CLOCK_ENABLE_WAIT)) {
 		udelay(1);
 	}
@@ -287,7 +289,6 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 		printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
 		       name, MAX_CLOCK_ENABLE_WAIT);
 
-
 	return (i < MAX_CLOCK_ENABLE_WAIT) ? 1 : 0;
 };
 
@@ -389,7 +390,9 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	idlest_reg = other_reg & ~PRCM_REGTYPE_MASK;
 	idlest_reg |= CM_IDLEST_REGTYPE;
 
-	omap2_wait_clock_ready((void __iomem *)idlest_reg, idlest_bit,
+	idlest_reg &= 0xff; /* convert to PRCM register index */
+
+	omap2_wait_clock_ready(clk->prcm_mod, idlest_reg, idlest_bit,
 			       clk->name);
 }
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 3fa2e26..bcb0c03 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -48,7 +48,8 @@ void omap2_fixed_divisor_recalc(struct clk *clk);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
-int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
+int omap2_wait_clock_ready(s16 prcm_mod, u16 idlest_reg, u32 cval,
+			   const char *name);
 void omap2_clk_prepare_for_reboot(void);
 
 extern u8 cpu_mask;
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index ddb6429..a97d89d 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -93,7 +93,6 @@ static void omap2_disable_osc_ck(struct clk *clk)
 static int omap2_clk_fixed_enable(struct clk *clk)
 {
 	u32 cval, apll_mask;
-	void __iomem *idlest;
 
 	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
 
@@ -111,14 +110,7 @@ static int omap2_clk_fixed_enable(struct clk *clk)
 	else if (clk == &apll54_ck)
 		cval = OMAP24XX_ST_54M_APLL;
 
-	if (cpu_is_omap242x())
-		idlest = (__force void __iomem *)OMAP2420_CM_REGADDR(PLL_MOD,
-								CM_IDLEST);
-	else
-		idlest = (__force void __iomem *)OMAP2430_CM_REGADDR(PLL_MOD,
-								CM_IDLEST);
-
-	omap2_wait_clock_ready(idlest, cval, clk->name);
+	omap2_wait_clock_ready(PLL_MOD, CM_IDLEST, cval, clk->name);
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()


