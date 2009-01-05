From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 07/23] OMAP clock: drop RATE_FIXED
Date: Sun, 04 Jan 2009 19:34:51 -0700
Message-ID: <20090105023450.12661.94041.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42882 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbZAEDWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:45 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

The RATE_FIXED flag currently has no useful purpose.  Fixed rate clocks
should simply not implement the recalc, set_rate, set_parent, and round_rate
function pointers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c             |    3 ---
 arch/arm/mach-omap1/clock.h             |   31 +++++++++++++++----------------
 arch/arm/mach-omap2/clock.c             |    4 ----
 arch/arm/mach-omap2/clock24xx.h         |    8 ++++----
 arch/arm/mach-omap2/clock34xx.h         |   19 +++++++++----------
 arch/arm/plat-omap/include/mach/clock.h |    2 +-
 6 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index f3cf6f8..af48050 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -570,9 +570,6 @@ static long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	int dsor_exp;
 
-	if (clk->flags & RATE_FIXED)
-		return clk->rate;
-
 	if (clk->flags & RATE_CKCTL) {
 		dsor_exp = calc_dsor_exp(clk, rate);
 		if (dsor_exp < 0)
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index d9f34d3..564f4bc 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -554,8 +554,8 @@ static struct uart_clk uart1_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
-				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+		.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT |
+				  CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 29,
 		.enable		= &omap1_clk_enable_uart_functional,
@@ -602,8 +602,8 @@ static struct uart_clk uart3_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
-				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+		.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT |
+				  CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 31,
 		.enable		= &omap1_clk_enable_uart_functional,
@@ -617,7 +617,7 @@ static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
+			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
 	.enable_bit	= USB_MCLK_EN_BIT,
 	.enable		= &omap1_clk_enable_generic,
@@ -629,7 +629,7 @@ static struct clk usb_hhc_ck1510 = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  RATE_FIXED | ENABLE_REG_32BIT,
+			  ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
 	.enable		= &omap1_clk_enable_generic,
@@ -641,8 +641,7 @@ static struct clk usb_hhc_ck16xx = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-	.flags		= CLOCK_IN_OMAP16XX |
-			  RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
 	.enable_bit	= 8 /* UHOST_EN */,
 	.enable		= &omap1_clk_enable_generic,
@@ -653,7 +652,7 @@ static struct clk usb_dc_ck = {
 	.name		= "usb_dc_ck",
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
+	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 4,
 	.enable		= &omap1_clk_enable_generic,
@@ -664,9 +663,9 @@ static struct clk mclk_1510 = {
 	.name		= "mclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
- 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
- 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
- 	.enable_bit	= 6,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 6,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -688,7 +687,7 @@ static struct clk bclk_1510 = {
 	.name		= "bclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
+	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
 };
@@ -712,7 +711,7 @@ static struct clk mmc1_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT |
+			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
 			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 23,
@@ -726,8 +725,8 @@ static struct clk mmc2_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX |
-			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= CLOCK_IN_OMAP16XX | ENABLE_REG_32BIT |
+			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 20,
 	.enable		= &omap1_clk_enable_generic,
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4d04e9f..31b5c9d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -644,10 +644,6 @@ long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
 	if (clk->round_rate != NULL)
 		return clk->round_rate(clk, rate);
 
-	if (clk->flags & RATE_FIXED)
-		printk(KERN_ERR "clock: generic omap2_clk_round_rate called "
-		       "on fixed-rate clock %s\n", clk->name);
-
 	return clk->rate;
 }
 
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 88ba9cf..824413d 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -628,7 +628,7 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED,
+				ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -656,7 +656,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED,
+				ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -703,7 +703,7 @@ static struct clk apll96_ck = {
 	.prcm_mod	= PLL_MOD,
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ENABLE_ON_INIT,
+				ENABLE_ON_INIT,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
@@ -717,7 +717,7 @@ static struct clk apll54_ck = {
 	.prcm_mod	= PLL_MOD,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ENABLE_ON_INIT,
+				ENABLE_ON_INIT,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_CLKEN,
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 2fde89e..179ea17 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -66,14 +66,14 @@ static struct clk dpll2_fck;
 static struct clk omap_32k_fck = {
 	.name		= "omap_32k_fck",
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -81,42 +81,42 @@ static struct clk secure_32k_fck = {
 static struct clk virt_12m_ck = {
 	.name		= "virt_12m_ck",
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_13m_ck = {
 	.name		= "virt_13m_ck",
 	.rate		= 13000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
 	.rate		= 16800000,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP3430ES2 | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
 	.rate		= 19200000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_26m_ck = {
 	.name		= "virt_26m_ck",
 	.rate		= 26000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.rate		= 38400000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 };
 
@@ -170,8 +170,7 @@ static struct clk osc_sys_ck = {
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED |
-				ALWAYS_ENABLED,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index f01f59d..4b90531 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -153,7 +153,7 @@ void omap_clk_del_child(struct clk *clk, struct clk *clk2);
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
-#define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
+
 
 #define VIRTUAL_CLOCK		(1 << 3)	/* Composite clock from table */
 #define ALWAYS_ENABLED		(1 << 4)	/* Clock cannot be disabled */


