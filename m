From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 12/13] OMAP clock: drop RATE_FIXED clock flag
Date: Mon, 15 Feb 2010 18:02:10 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002151800270.28188@utopia.booyaka.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain> <20100211181809.795.84359.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40653 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338Ab0BPBCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:02:10 -0500
In-Reply-To: <20100211181809.795.84359.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>


The RATE_FIXED clock flag is pointless.  In the OMAP1 clock code, it
simply causes the omap1_clk_round_rate() function to return the
current rate of the clock.  omap1_clk_round_rate(), however, should
never be called for a fixed-rate clock, since none of these clocks
have a .round_rate function pointer set in their struct clk records.
Similarly, in the OMAP2+ clock code, the RATE_FIXED flag just causes
the clock code to emit a warning if the OMAP clock maintainer was
foolish enough to add a .round_rate function pointer to a fixed-rate
clock.  "Doctor, it hurts when I pretend that a fixed-rate clock is
rate-changeable."  "Then don't pretend that a fixed-rate clock is
rate-changeable."  It has no functional value.  This patch drops the
RATE_FIXED clock flag, removing it from all clocks that are so marked.

This second version of the patch also drops the flag from the OMAP3 
clocks - an oversight in the first revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap1/clock.c             |    5 +----
 arch/arm/mach-omap1/clock_data.c        |   25 +++++++++----------------
 arch/arm/mach-omap2/clkt_clksel.c       |    4 ----
 arch/arm/mach-omap2/clock2420_data.c    |    7 ++-----
 arch/arm/mach-omap2/clock2430_data.c    |    7 ++-----
 arch/arm/mach-omap2/clock3xxx_data.c    |   11 -----------
 arch/arm/plat-omap/include/plat/clock.h |   13 ++++++-------
 7 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 3e052f6..0ba044d 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mach-omap1/clock.c
  *
- *  Copyright (C) 2004 - 2005, 2009 Nokia corporation
+ *  Copyright (C) 2004 - 2005, 2009-2010 Nokia Corporation
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *
  *  Modified to use omap shared clock framework by
@@ -571,9 +571,6 @@ const struct clkops clkops_uart = {
 
 long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	if (clk->flags & RATE_FIXED)
-		return clk->rate;
-
 	if (clk->round_rate != NULL)
 		return clk->round_rate(clk, rate);
 
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index cea91cd..8b1d14d 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mach-omap1/clock_data.c
  *
- *  Copyright (C) 2004 - 2005, 2009 Nokia corporation
+ *  Copyright (C) 2004 - 2005, 2009-2010 Nokia Corporation
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
  *
@@ -31,7 +31,6 @@
 static struct clk dummy_ck = {
 	.name	= "dummy",
 	.ops	= &clkops_dummy,
-	.flags	= RATE_FIXED,
 };
 
 static struct clk ck_ref = {
@@ -389,8 +388,7 @@ static struct uart_clk uart1_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
-				  CLOCK_NO_IDLE_PARENT,
+		.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 29,
 	},
@@ -430,8 +428,7 @@ static struct uart_clk uart3_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
-				  CLOCK_NO_IDLE_PARENT,
+		.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 31,
 	},
@@ -443,7 +440,7 @@ static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
 	.enable_bit	= USB_MCLK_EN_BIT,
 };
@@ -453,7 +450,7 @@ static struct clk usb_hhc_ck1510 = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
 };
@@ -464,7 +461,7 @@ static struct clk usb_hhc_ck16xx = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
 	.enable_bit	= 8 /* UHOST_EN */,
 };
@@ -474,7 +471,6 @@ static struct clk usb_dc_ck = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
-	.flags		= RATE_FIXED,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 4,
 };
@@ -484,7 +480,6 @@ static struct clk usb_dc_ck7xx = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
-	.flags		= RATE_FIXED,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 8,
 };
@@ -494,7 +489,6 @@ static struct clk mclk_1510 = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= RATE_FIXED,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 6,
 };
@@ -515,7 +509,6 @@ static struct clk bclk_1510 = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk bclk_16xx = {
@@ -535,7 +528,7 @@ static struct clk mmc1_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 23,
 };
@@ -546,7 +539,7 @@ static struct clk mmc2_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 20,
 };
@@ -557,7 +550,7 @@ static struct clk mmc3_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 12,
 };
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index ade19f6..e50812d 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -258,10 +258,6 @@ long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
 	if (clk->round_rate)
 		return clk->round_rate(clk, rate);
 
-	if (clk->flags & RATE_FIXED)
-		printk(KERN_ERR "clock: generic omap2_clk_round_rate called "
-		       "on fixed-rate clock %s\n", clk->name);
-
 	return clk->rate;
 }
 
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index bef647a..f2122d7 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -55,7 +55,6 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32000,
-	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -63,7 +62,6 @@ static struct clk secure_32k_ck = {
 	.name		= "secure_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -88,7 +86,6 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.ops		= &clkops_null,
 	.rate		= 54000000,
-	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -134,7 +131,7 @@ static struct clk apll96_ck = {
 	.ops		= &clkops_apll96,
 	.parent		= &sys_ck,
 	.rate		= 96000000,
-	.flags		= RATE_FIXED | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
@@ -145,7 +142,7 @@ static struct clk apll54_ck = {
 	.ops		= &clkops_apll54,
 	.parent		= &sys_ck,
 	.rate		= 54000000,
-	.flags		= RATE_FIXED | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index b389584..0438b6e 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -55,7 +55,6 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32000,
-	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -63,7 +62,6 @@ static struct clk secure_32k_ck = {
 	.name		= "secure_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -88,7 +86,6 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.ops		= &clkops_null,
 	.rate		= 54000000,
-	.flags		= RATE_FIXED,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -134,7 +131,7 @@ static struct clk apll96_ck = {
 	.ops		= &clkops_apll96,
 	.parent		= &sys_ck,
 	.rate		= 96000000,
-	.flags		= RATE_FIXED | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
@@ -145,7 +142,7 @@ static struct clk apll54_ck = {
 	.ops		= &clkops_apll54,
 	.parent		= &sys_ck,
 	.rate		= 54000000,
-	.flags		= RATE_FIXED | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f237902..fd83230 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -64,14 +64,12 @@ static struct clk omap_32k_fck = {
 	.name		= "omap_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= RATE_FIXED,
 };
 
 /* Virtual source clocks for osc_sys_ck */
@@ -79,42 +77,36 @@ static struct clk virt_12m_ck = {
 	.name		= "virt_12m_ck",
 	.ops		= &clkops_null,
 	.rate		= 12000000,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_13m_ck = {
 	.name		= "virt_13m_ck",
 	.ops		= &clkops_null,
 	.rate		= 13000000,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
 	.ops		= &clkops_null,
 	.rate		= 16800000,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
 	.ops		= &clkops_null,
 	.rate		= 19200000,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_26m_ck = {
 	.name		= "virt_26m_ck",
 	.ops		= &clkops_null,
 	.rate		= 26000000,
-	.flags		= RATE_FIXED,
 };
 
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.ops		= &clkops_null,
 	.rate		= 38400000,
-	.flags		= RATE_FIXED,
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
@@ -167,7 +159,6 @@ static struct clk osc_sys_ck = {
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
-	.flags		= RATE_FIXED,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -3168,7 +3159,6 @@ static struct clk emac_ick = {
 static struct clk rmii_ck = {
 	.name		= "rmii_ck",
 	.ops		= &clkops_null,
-	.flags		= RATE_FIXED,
 	.rate		= 50000000,
 };
 
@@ -3224,7 +3214,6 @@ static struct clk vpfe_ick = {
 static struct clk pclk_ck = {
 	.name		= "pclk_ck",
 	.ops		= &clkops_null,
-	.flags		= RATE_FIXED,
 	.rate		= 27000000,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 9ce9323..dcfdcd6 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -188,13 +188,12 @@ extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
 extern const struct clkops clkops_null;
 
 /* Clock flags */
-#define RATE_FIXED		(1 << 0)	/* Fixed clock rate */
-#define ENABLE_REG_32BIT	(1 << 1)	/* Use 32-bit access */
-#define CLOCK_IDLE_CONTROL	(1 << 2)
-#define CLOCK_NO_IDLE_PARENT	(1 << 3)
-#define ENABLE_ON_INIT		(1 << 4)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 5)	/* 0 enables, 1 disables */
-#define ALWAYS_ENABLED		(1 << 6)
+#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 1)
+#define CLOCK_NO_IDLE_PARENT	(1 << 2)
+#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define ALWAYS_ENABLED		(1 << 5)
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)
-- 
1.6.6.GIT

