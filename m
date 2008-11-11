From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 09/59] omap: namespace cleanup to arch/arm/mach-omap1/clock.c
Date: Wed, 12 Nov 2008 00:56:28 +0200
Message-ID: <1226444238-14614-10-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56971 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYKKW6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:58:38 -0500
In-Reply-To: <1226444238-14614-9-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/clock.c |   54 +++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 997cfda..77a0ebe 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -50,7 +50,7 @@ static void omap1_uart_recalc(struct clk * clk)
 
 static void omap1_sossi_recalc(struct clk *clk)
 {
-	u32 div = omap_readl(MOD_CONF_CTRL_1);
+	u32 div = __raw_readl(MOD_CONF_CTRL_1);
 
 	div = (div >> 17) & 0x7;
 	div++;
@@ -87,7 +87,7 @@ static int omap1_clk_enable_uart_functional(struct clk *clk)
 	if (ret == 0) {
 		/* Set smart idle acknowledgement mode */
 		uclk = (struct uart_clk *)clk;
-		omap_writeb((omap_readb(uclk->sysc_addr) & ~0x10) | 8,
+		__raw_writeb((__raw_readb(uclk->sysc_addr) & ~0x10) | 8,
 			    uclk->sysc_addr);
 	}
 
@@ -100,7 +100,7 @@ static void omap1_clk_disable_uart_functional(struct clk *clk)
 
 	/* Set force idle acknowledgement mode */
 	uclk = (struct uart_clk *)clk;
-	omap_writeb((omap_readb(uclk->sysc_addr) & ~0x18), uclk->sysc_addr);
+	__raw_writeb((__raw_readb(uclk->sysc_addr) & ~0x18), uclk->sysc_addr);
 
 	omap1_clk_disable_generic(clk);
 }
@@ -220,7 +220,7 @@ static void omap1_ckctl_recalc(struct clk * clk)
 	int dsor;
 
 	/* Calculate divisor encoded as 2-bit exponent */
-	dsor = 1 << (3 & (omap_readw(ARM_CKCTL) >> clk->rate_offset));
+	dsor = 1 << (3 & (__raw_readw(ARM_CKCTL) >> clk->rate_offset));
 
 	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
@@ -239,7 +239,7 @@ static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
 	 * The clock control bits are in DSP domain,
 	 * so api_ck is needed for access.
 	 * Note that DSP_CKCTL virt addr = phys addr, so
-	 * we must use __raw_readw() instead of omap_readw().
+	 * we must use __raw_readw() instead of __raw_readw().
 	 */
 	omap1_clk_enable(&api_ck.clk);
 	dsor = 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
@@ -417,10 +417,10 @@ static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
 	if (div < 0 || div > 7)
 		return -EINVAL;
 
-	l = omap_readl(MOD_CONF_CTRL_1);
+	l = __raw_readl(MOD_CONF_CTRL_1);
 	l &= ~(7 << 17);
 	l |= div << 17;
-	omap_writel(l, MOD_CONF_CTRL_1);
+	__raw_writel(l, MOD_CONF_CTRL_1);
 
 	clk->rate = p_rate / (div + 1);
 	if (unlikely(clk->flags & RATE_PROPAGATES))
@@ -574,11 +574,11 @@ static int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 		if (dsor_exp < 0)
 			return dsor_exp;
 
-		regval = omap_readw(ARM_CKCTL);
+		regval = __raw_readw(ARM_CKCTL);
 		regval &= ~(3 << clk->rate_offset);
 		regval |= dsor_exp << clk->rate_offset;
 		regval = verify_ckctl_value(regval);
-		omap_writew(regval, ARM_CKCTL);
+		__raw_writew(regval, ARM_CKCTL);
 		clk->rate = clk->parent->rate / (1 << dsor_exp);
 		ret = 0;
 	}
@@ -655,14 +655,14 @@ int __init omap1_clk_init(void)
 	/* Resets some clocks that may be left on from bootloader,
 	 * but leaves serial clocks on.
  	 */
-	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
+	__raw_writel(0x3 << 29, MOD_CONF_CTRL_0);
 #endif
 
 	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
-	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
-	omap_writew(reg, SOFT_REQ_REG);
+	reg = __raw_readw(SOFT_REQ_REG) & (1 << 4);
+	__raw_writew(reg, SOFT_REQ_REG);
 	if (!cpu_is_omap15xx())
-		omap_writew(0, SOFT_REQ_REG2);
+		__raw_writew(0, SOFT_REQ_REG2);
 
 	clk_init(&omap1_clk_functions);
 
@@ -705,18 +705,18 @@ int __init omap1_clk_init(void)
 #endif
 
 	printk("Clocks: ARM_SYSST: 0x%04x DPLL_CTL: 0x%04x ARM_CKCTL: 0x%04x\n",
-	       omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
-	       omap_readw(ARM_CKCTL));
+	       __raw_readw(ARM_SYSST), __raw_readw(DPLL_CTL),
+	       __raw_readw(ARM_CKCTL));
 
 	/* We want to be in syncronous scalable mode */
-	omap_writew(0x1000, ARM_SYSST);
+	__raw_writew(0x1000, ARM_SYSST);
 
 #ifdef CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER
 	/* Use values set by bootloader. Determine PLL rate and recalculate
 	 * dependent clocks as if kernel had changed PLL or divisors.
 	 */
 	{
-		unsigned pll_ctl_val = omap_readw(DPLL_CTL);
+		unsigned pll_ctl_val = __raw_readw(DPLL_CTL);
 
 		ck_dpll1.rate = ck_ref.rate; /* Base xtal rate */
 		if (pll_ctl_val & 0x10) {
@@ -744,8 +744,8 @@ int __init omap1_clk_init(void)
 	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
 		printk(KERN_ERR "System frequencies not set. Check your config.\n");
 		/* Guess sane values (60MHz) */
-		omap_writew(0x2290, DPLL_CTL);
-		omap_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
+		__raw_writew(0x2290, DPLL_CTL);
+		__raw_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
 		ck_dpll1.rate = 60000000;
 		propagate_rate(&ck_dpll1);
 	}
@@ -760,33 +760,33 @@ int __init omap1_clk_init(void)
 
 #if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
 	/* Select slicer output as OMAP input clock */
-	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
+	__raw_writew(__raw_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
 #endif
 
 	/* Amstrad Delta wants BCLK high when inactive */
 	if (machine_is_ams_delta())
-		omap_writel(omap_readl(ULPD_CLOCK_CTRL) |
+		__raw_writel(__raw_readl(ULPD_CLOCK_CTRL) |
 				(1 << SDW_MCLK_INV_BIT),
 				ULPD_CLOCK_CTRL);
 
 	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
 	/* (on 730, bit 13 must not be cleared) */
 	if (cpu_is_omap730())
-		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
+		__raw_writew(__raw_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
 	else
-		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
+		__raw_writew(__raw_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
 
 	/* Put DSP/MPUI into reset until needed */
-	omap_writew(0, ARM_RSTCT1);
-	omap_writew(1, ARM_RSTCT2);
-	omap_writew(0x400, ARM_IDLECT1);
+	__raw_writew(0, ARM_RSTCT1);
+	__raw_writew(1, ARM_RSTCT2);
+	__raw_writew(0x400, ARM_IDLECT1);
 
 	/*
 	 * According to OMAP5910 Erratum SYS_DMA_1, bit DMACK_REQ (bit 8)
 	 * of the ARM_IDLECT2 register must be set to zero. The power-on
 	 * default value of this bit is one.
 	 */
-	omap_writew(0x0000, ARM_IDLECT2);	/* Turn LCD clock off also */
+	__raw_writew(0x0000, ARM_IDLECT2);	/* Turn LCD clock off also */
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
-- 
1.6.0.2.307.gc427

