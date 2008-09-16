From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] OMAP2/3 clock: encode target IDLEST bits and clean
	omap2_clk_wait_ready()
Date: Tue, 16 Sep 2008 08:58:34 -0600
Message-ID: <20080916145833.1470.57607.stgit@localhost.localdomain>
References: <20080916145747.1470.51591.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47789 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbYIPPPL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 11:15:11 -0400
In-Reply-To: <20080916145747.1470.51591.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

For each OMAP module that has a target IDLEST bit, add the appropriate
bits to the clock tree on both the module interface clock and the appropriate
functional clock.  Add a new clock bit, "WAIT_READY", that indicates that
the clock code must wait for the clock's module to come out of idle after
both the target functional clock and interface clocks are enabled.  Fix
some clock flag comments while there to indicate that clocks marked
as "3430ES2" clocks also are valid for later 3430 revisions.

Several OMAP3xxx clocks must be split into platform-specific variants,
since some early silicon revisions do not have target idle state bits
available. DSS, HSOTGUSB, and SSI clocks are affected.  In the future, it
would be ideal to #ifdef out those clocks for kernels that don't need to
run on 3430ES1 chips to save memory.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h         |  194 +++++++++-----
 arch/arm/mach-omap2/clock34xx.h         |  437 ++++++++++++++++++++++---------
 arch/arm/mach-omap2/cm-regbits-24xx.h   |    1 
 arch/arm/plat-omap/include/mach/clock.h |    8 -
 4 files changed, 448 insertions(+), 192 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index f52b3f0..13aa25d 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1232,10 +1232,11 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.parent		= &core_l3_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP | CONFIG_PARTICIPANT,
+				DELAYED_APP | CONFIG_PARTICIPANT | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_USB_SHIFT,
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
@@ -1305,11 +1306,12 @@ static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.parent		= &core_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY |
 				DELAYED_APP,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= OMAP24XX_CM_FCLKEN2,
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_SSI_SHIFT,
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
@@ -1327,9 +1329,10 @@ static struct clk ssi_l4_ick = {
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
 	.clkdm		= { .name = "core_l4_clkdm" },
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_SSI_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1572,10 +1575,11 @@ static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= WKUP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1600,10 +1604,11 @@ static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1626,10 +1631,11 @@ static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1652,10 +1658,11 @@ static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1678,10 +1685,11 @@ static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1704,10 +1712,11 @@ static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT6_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1730,10 +1739,11 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1756,10 +1766,11 @@ static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT8_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1782,10 +1793,11 @@ static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT9_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1808,10 +1820,11 @@ static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT10_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1834,10 +1847,11 @@ static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT11_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1860,10 +1874,11 @@ static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPT12_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1887,10 +1902,11 @@ static struct clk mcbsp1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MCBSP1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1911,10 +1927,11 @@ static struct clk mcbsp2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MCBSP2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1935,10 +1952,11 @@ static struct clk mcbsp3_ick = {
 	.id		= 3,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MCBSP3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1959,10 +1977,11 @@ static struct clk mcbsp4_ick = {
 	.id		= 4,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MCBSP4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1983,10 +2002,11 @@ static struct clk mcbsp5_ick = {
 	.id		= 5,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MCBSP5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2008,9 +2028,10 @@ static struct clk mcspi1_ick = {
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
 	.clkdm		= { .name = "core_l4_clkdm" },
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2031,10 +2052,11 @@ static struct clk mcspi2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2055,10 +2077,11 @@ static struct clk mcspi3_ick = {
 	.id		= 3,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2078,10 +2101,11 @@ static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_UART1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2100,10 +2124,11 @@ static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_UART2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2122,10 +2147,11 @@ static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_UART3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2144,10 +2170,11 @@ static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= WKUP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2155,10 +2182,11 @@ static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.prcm_mod	= WKUP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2167,10 +2195,11 @@ static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= WKUP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2179,10 +2208,11 @@ static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.prcm_mod	= WKUP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2191,10 +2221,11 @@ static struct clk sync_32k_ick = {
 	.parent		= &l4_ck,
 	.prcm_mod	= WKUP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ENABLE_ON_INIT,
+				ENABLE_ON_INIT | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_32KSYNC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2207,6 +2238,7 @@ static struct clk wdt1_ick = {
 	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_WDT1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2219,6 +2251,7 @@ static struct clk omapctrl_ick = {
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_OMAPCTRL_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2226,10 +2259,11 @@ static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= WKUP_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
+	.idlest_bit	= OMAP2430_ST_ICR_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2264,10 +2298,11 @@ static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MAILBOXES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2275,10 +2310,11 @@ static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_WDT4_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2297,10 +2333,11 @@ static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.idlest_bit	= OMAP2420_ST_WDT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2308,10 +2345,11 @@ static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.parent		= &func_32k_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.enable_bit	= OMAP2420_ST_WDT3_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2319,10 +2357,11 @@ static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MSPRO_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2330,10 +2369,11 @@ static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.parent		= &func_96m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_MSPRO_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2341,10 +2381,11 @@ static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.idlest_bit	= OMAP2420_ST_MMC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2352,10 +2393,11 @@ static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.parent		= &func_96m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.idlest_bit	= OMAP2420_ST_MMC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2363,10 +2405,11 @@ static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_FAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2374,10 +2417,11 @@ static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.parent		= &func_12m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_FAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2385,10 +2429,11 @@ static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.idlest_bit	= OMAP2420_ST_EAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2396,10 +2441,11 @@ static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.parent		= &func_96m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.idlest_bit	= OMAP2420_ST_EAC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2407,10 +2453,11 @@ static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_HDQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2418,10 +2465,11 @@ static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.parent		= &func_12m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_HDQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2430,10 +2478,11 @@ static struct clk i2c2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.idlest_bit	= OMAP2420_ST_I2C2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2442,10 +2491,11 @@ static struct clk i2c2_fck = {
 	.id		= 2,
 	.parent		= &func_12m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.idlest_bit	= OMAP2420_ST_I2C2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2466,10 +2516,11 @@ static struct clk i2c1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.idlest_bit	= OMAP2420_ST_I2C1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2478,10 +2529,11 @@ static struct clk i2c1_fck = {
 	.id		= 1,
 	.parent		= &func_12m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.idlest_bit	= OMAP2420_ST_I2C1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2526,10 +2578,11 @@ static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.idlest_bit	= OMAP2420_ST_VLYNQ_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2562,10 +2615,11 @@ static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.idlest_bit	= OMAP2420_ST_VLYNQ_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
@@ -2579,10 +2633,11 @@ static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY | ENABLE_ON_INIT,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN3,
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
+	.idlest_bit	= OMAP2430_ST_SDRC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2590,10 +2645,11 @@ static struct clk des_ick = {
 	.name		= "des_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= OMAP24XX_CM_ICLKEN4,
 	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_DES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2601,10 +2657,11 @@ static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= OMAP24XX_CM_ICLKEN4,
 	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_SHA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2612,10 +2669,11 @@ static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= OMAP24XX_CM_ICLKEN4,
 	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_RNG_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2623,10 +2681,11 @@ static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= OMAP24XX_CM_ICLKEN4,
 	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_AES_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2634,10 +2693,11 @@ static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= OMAP24XX_CM_ICLKEN4,
 	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_PKA_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2645,10 +2705,11 @@ static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.parent		= &func_48m_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= OMAP24XX_CM_FCLKEN2,
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
+	.idlest_bit	= OMAP24XX_ST_USB_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2656,10 +2717,11 @@ static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.parent		= &core_l3_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
+	.idlest_bit	= OMAP2430_ST_USBHS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2668,10 +2730,11 @@ static struct clk mmchs1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MMCHS1_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2692,10 +2755,11 @@ static struct clk mmchs2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2715,10 +2779,11 @@ static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
+	.idlest_bit	= OMAP2430_ST_GPIO5_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2737,10 +2802,11 @@ static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP243X,
+	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
+	.idlest_bit	= OMAP2430_ST_MDM_INTC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index cacd59f..78f1295 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1330,10 +1330,11 @@ static struct clk gpt10_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT10_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT10_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1345,10 +1346,11 @@ static struct clk gpt11_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT11_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT11_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1359,7 +1361,8 @@ static struct clk cpefuse_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= OMAP3430ES2_CM_FCLKEN3,
 	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_CPEFUSE_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "cm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1381,7 +1384,8 @@ static struct clk usbtll_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= OMAP3430ES2_CM_FCLKEN3,
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_USBTLL_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1404,7 +1408,8 @@ static struct clk mmchs3_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_MMC3_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1416,7 +1421,8 @@ static struct clk mmchs2_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MMC2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1427,7 +1433,8 @@ static struct clk mspro_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MSPRO_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1439,7 +1446,8 @@ static struct clk mmchs1_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MMC1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1451,7 +1459,8 @@ static struct clk i2c3_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_I2C3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1463,7 +1472,8 @@ static struct clk i2c2_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_I2C2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1475,7 +1485,8 @@ static struct clk i2c1_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_I2C1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1520,7 +1531,8 @@ static struct clk mcbsp5_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1545,7 +1557,8 @@ static struct clk mcbsp1_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1568,7 +1581,8 @@ static struct clk mcspi4_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1580,7 +1594,8 @@ static struct clk mcspi3_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1592,7 +1607,8 @@ static struct clk mcspi2_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1604,7 +1620,8 @@ static struct clk mcspi1_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1615,7 +1632,8 @@ static struct clk uart2_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_UART2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1626,18 +1644,21 @@ static struct clk uart1_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_UART1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
+/* XXX doublecheck: is this idle or standby? */
 static struct clk fshostusb_fck = {
 	.name		= "fshostusb_fck",
 	.parent		= &core_48m_fck,
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
+	.idlest_bit	= OMAP3430ES1_ST_FSHOSTUSB_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES1 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1659,7 +1680,8 @@ static struct clk hdq_fck = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_FCLKEN1,
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_HDQ_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1681,7 +1703,7 @@ static const struct clksel ssi_ssr_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk ssi_ssr_fck = {
+static struct clk ssi_ssr_fck_3430es1 = {
 	.name		= "ssi_ssr_fck",
 	.init		= &omap2_init_clksel_parent,
 	.prcm_mod	= CORE_MOD,
@@ -1690,16 +1712,41 @@ static struct clk ssi_ssr_fck = {
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk ssi_sst_fck = {
+static struct clk ssi_ssr_fck_3430es2 = {
+	.name		= "ssi_ssr_fck",
+	.init		= &omap2_init_clksel_parent,
+	.prcm_mod	= CORE_MOD,
+	.enable_reg	= CM_FCLKEN1,
+	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
+	.idlest_bit	= OMAP3430ES2_ST_SSI_IDLE_SHIFT,
+	.clksel_reg	= CM_CLKSEL,
+	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
+	.clksel		= ssi_ssr_clksel,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES | WAIT_READY,
+	.clkdm		= { .name = "core_l4_clkdm" },
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* It's unfortunate that we need to duplicate this clock. */
+static struct clk ssi_sst_fck_3430es1 = {
 	.name		= "ssi_sst_fck",
-	.parent		= &ssi_ssr_fck,
+	.parent		= &ssi_ssr_fck_3430es1,
 	.fixed_div	= 2,
-	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP3430ES1 | PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l4_clkdm" },
+	.recalc		= &omap2_fixed_divisor_recalc,
+};
+
+static struct clk ssi_sst_fck_3430es2 = {
+	.name		= "ssi_sst_fck",
+	.parent		= &ssi_ssr_fck_3430es2,
+	.fixed_div	= 2,
+	.flags		= CLOCK_IN_OMAP3430ES2 | PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
@@ -1721,13 +1768,25 @@ static struct clk core_l3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk hsotgusb_ick = {
+static struct clk hsotgusb_ick_3430es1 = {
 	.name		= "hsotgusb_ick",
 	.parent		= &core_l3_ick,
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "core_l3_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hsotgusb_ick_3430es2 = {
+	.name		= "hsotgusb_ick",
+	.parent		= &core_l3_ick,
+	.prcm_mod	= CORE_MOD,
+	.enable_reg	= CM_ICLKEN1,
+	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
+	.idlest_bit	= OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1738,7 +1797,8 @@ static struct clk sdrc_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.idlest_bit	= OMAP3430_ST_SDRC_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1769,7 +1829,8 @@ static struct clk pka_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_PKA_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1791,7 +1852,8 @@ static struct clk usbtll_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN3,
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_USBTLL_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1803,7 +1865,8 @@ static struct clk mmchs3_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_MMC3_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1815,7 +1878,8 @@ static struct clk icr_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_ICR_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1826,7 +1890,8 @@ static struct clk aes2_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_AES2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1837,7 +1902,8 @@ static struct clk sha12_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_SHA12_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1848,7 +1914,8 @@ static struct clk des2_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_DES2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1860,7 +1927,8 @@ static struct clk mmchs2_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MMC2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1872,7 +1940,8 @@ static struct clk mmchs1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MMC1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1883,7 +1952,8 @@ static struct clk mspro_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MSPRO_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1894,7 +1964,8 @@ static struct clk hdq_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_HDQ_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1906,7 +1977,8 @@ static struct clk mcspi4_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1918,7 +1990,8 @@ static struct clk mcspi3_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1930,7 +2003,8 @@ static struct clk mcspi2_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1942,7 +2016,8 @@ static struct clk mcspi1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCSPI1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1954,7 +2029,8 @@ static struct clk i2c3_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_I2C3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1966,7 +2042,8 @@ static struct clk i2c2_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_I2C2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1978,7 +2055,8 @@ static struct clk i2c1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_I2C1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -1989,7 +2067,8 @@ static struct clk uart2_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_UART2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2000,7 +2079,8 @@ static struct clk uart1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_UART1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2011,7 +2091,8 @@ static struct clk gpt11_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT11_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2022,7 +2103,8 @@ static struct clk gpt10_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT10_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2034,7 +2116,8 @@ static struct clk mcbsp5_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2046,7 +2129,8 @@ static struct clk mcbsp1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2057,7 +2141,8 @@ static struct clk fac_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430ES1_EN_FAC_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
+	.idlest_bit	= OMAP3430ES1_ST_FAC_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES1 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2068,7 +2153,8 @@ static struct clk mailboxes_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MAILBOXES_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2079,7 +2165,8 @@ static struct clk omapctrl_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.idlest_bit	= OMAP3430_ST_OMAPCTRL_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2095,20 +2182,33 @@ static struct clk ssi_l4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ssi_ick = {
+static struct clk ssi_ick_3430es1 = {
 	.name		= "ssi_ick",
 	.parent		= &ssi_l4_ick,
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
-/* REVISIT: Technically the TRM claims that this is CORE_CLK based,
- * but l4_ick makes more sense to me */
+static struct clk ssi_ick_3430es2 = {
+	.name		= "ssi_ick",
+	.parent		= &ssi_l4_ick,
+	.prcm_mod	= CORE_MOD,
+	.enable_reg	= CM_ICLKEN1,
+	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
+	.idlest_bit	= OMAP3430ES2_ST_SSI_IDLE_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
+	.clkdm		= { .name = "core_l4_clkdm" },
+	.recalc		= &followparent_recalc,
+};
 
+/*
+ * REVISIT: Technically the TRM claims that this is CORE_CLK based,
+ * but l4_ick makes more sense to me
+ */
 static const struct clksel usb_l4_clksel[] = {
 	{ .parent = &l4_ick, .rates = div2_rates },
 	{ .parent = NULL },
@@ -2121,10 +2221,11 @@ static struct clk usb_l4_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN1,
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
+	.idlest_bit	= OMAP3430ES1_ST_FSHOSTUSB_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
 	.clksel		= usb_l4_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1,
+	.flags		= CLOCK_IN_OMAP3430ES1 | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2148,7 +2249,8 @@ static struct clk aes1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_AES1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2159,7 +2261,8 @@ static struct clk rng_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_RNG_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2170,7 +2273,8 @@ static struct clk sha11_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_SHA11_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2181,13 +2285,14 @@ static struct clk des1_ick = {
 	.prcm_mod	= CORE_MOD,
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_DES1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
 /* DSS */
-static struct clk dss1_alwon_fck = {
+static struct clk dss1_alwon_fck_3430es1 = {
 	.name		= "dss1_alwon_fck",
 	.parent		= &dpll4_m4x2_ck,
 	.init		= &omap2_init_clksel_parent,
@@ -2199,6 +2304,19 @@ static struct clk dss1_alwon_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk dss1_alwon_fck_3430es2 = {
+	.name		= "dss1_alwon_fck",
+	.parent		= &dpll4_m4x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.prcm_mod	= OMAP3430_DSS_MOD,
+	.enable_reg	= CM_FCLKEN,
+	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
+	.idlest_bit	= OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
+	.clkdm		= { .name = "dss_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
 	.parent		= &omap_54m_fck,
@@ -2232,14 +2350,27 @@ static struct clk dss2_alwon_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk dss_ick = {
+static struct clk dss_ick_3430es1 = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
 	.parent		= &l4_ick,
 	.prcm_mod	= OMAP3430_DSS_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "dss_clkdm" },
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_ick_3430es2 = {
+	/* Handles both L3 and L4 clocks */
+	.name		= "dss_ick",
+	.parent		= &l4_ick,
+	.prcm_mod	= OMAP3430_DSS_MOD,
+	.enable_reg	= CM_ICLKEN,
+	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
+	.idlest_bit	= OMAP3430ES2_ST_DSS_IDLE_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "dss_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2299,7 +2430,8 @@ static struct clk usbhost_48m_fck = {
 	.prcm_mod	= OMAP3430ES2_USBHOST_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_USBHOST_IDLE_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "usbhost_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2311,7 +2443,8 @@ static struct clk usbhost_ick = {
 	.prcm_mod	= OMAP3430ES2_USBHOST_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
+	.idlest_bit	= OMAP3430ES2_ST_USBHOST_IDLE_SHIFT,
+	.flags		= CLOCK_IN_OMAP3430ES2 | WAIT_READY,
 	.clkdm		= { .name = "usbhost_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2363,10 +2496,11 @@ static struct clk gpt1_fck = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT1_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT1_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2385,7 +2519,8 @@ static struct clk gpio1_fck = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2396,7 +2531,8 @@ static struct clk wdt2_fck = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_WDT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2428,7 +2564,8 @@ static struct clk wdt2_ick = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_WDT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2439,7 +2576,8 @@ static struct clk wdt1_ick = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_WDT1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2450,7 +2588,8 @@ static struct clk gpio1_ick = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2461,7 +2600,8 @@ static struct clk omap_32ksync_ick = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_32KSYNC_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2472,7 +2612,8 @@ static struct clk gpt12_ick = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT12_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2483,7 +2624,8 @@ static struct clk gpt1_ick = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2516,7 +2658,8 @@ static struct clk uart3_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_UART3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2527,10 +2670,11 @@ static struct clk gpt2_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT2_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT2_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2541,10 +2685,11 @@ static struct clk gpt3_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT3_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT3_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2555,10 +2700,11 @@ static struct clk gpt4_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT4_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT4_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2569,10 +2715,11 @@ static struct clk gpt5_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT5_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT5_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2583,10 +2730,11 @@ static struct clk gpt6_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT6_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT6_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2597,10 +2745,11 @@ static struct clk gpt7_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT7_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT7_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2611,10 +2760,11 @@ static struct clk gpt8_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT8_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT8_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2625,10 +2775,11 @@ static struct clk gpt9_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
+	.idlest_bit	= OMAP3430_ST_GPT9_SHIFT,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP3430_CLKSEL_GPT9_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2647,7 +2798,8 @@ static struct clk gpio6_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO6_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2658,7 +2810,8 @@ static struct clk gpio5_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2669,7 +2822,8 @@ static struct clk gpio4_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2680,7 +2834,8 @@ static struct clk gpio3_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2691,7 +2846,8 @@ static struct clk gpio2_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2702,7 +2858,8 @@ static struct clk wdt3_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_WDT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2722,7 +2879,8 @@ static struct clk gpio6_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO6_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2733,7 +2891,8 @@ static struct clk gpio5_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2744,7 +2903,8 @@ static struct clk gpio4_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2755,7 +2915,8 @@ static struct clk gpio3_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2766,7 +2927,8 @@ static struct clk gpio2_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPIO2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2777,7 +2939,8 @@ static struct clk wdt3_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_WDT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2788,7 +2951,8 @@ static struct clk uart3_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_UART3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2799,7 +2963,8 @@ static struct clk gpt9_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT9_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2810,7 +2975,8 @@ static struct clk gpt8_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT8_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2821,7 +2987,8 @@ static struct clk gpt7_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT7_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2832,7 +2999,8 @@ static struct clk gpt6_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT6_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2843,7 +3011,8 @@ static struct clk gpt5_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2854,7 +3023,8 @@ static struct clk gpt4_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2865,7 +3035,8 @@ static struct clk gpt3_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2876,7 +3047,8 @@ static struct clk gpt2_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_GPT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2888,7 +3060,8 @@ static struct clk mcbsp2_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2900,7 +3073,8 @@ static struct clk mcbsp3_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2912,7 +3086,8 @@ static struct clk mcbsp4_ick = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -2943,7 +3118,8 @@ static struct clk mcbsp2_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2968,7 +3144,8 @@ static struct clk mcbsp3_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2993,7 +3170,8 @@ static struct clk mcbsp4_fck = {
 	.prcm_mod	= OMAP3430_PER_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
+	.idlest_bit	= OMAP3430_ST_MCBSP4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | WAIT_READY,
 	.clkdm		= { .name = "per_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3158,7 +3336,8 @@ static struct clk sr1_fck = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.idlest_bit	= OMAP3430_ST_SR1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -3170,7 +3349,8 @@ static struct clk sr2_fck = {
 	.prcm_mod	= WKUP_MOD,
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.idlest_bit	= OMAP3430_ST_SR2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -3185,11 +3365,12 @@ static struct clk sr_l4_ick = {
 
 /* SECURE_32K_FCK clocks */
 
-/* XXX This clock no longer exists in 3430 TRM rev F */
+/* XXX Make sure idlest_bit/wait_ready with no enable_bit works */
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &secure_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.idlest_bit	= OMAP3430_ST_GPT12_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED | WAIT_READY,
 	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
@@ -3296,10 +3477,13 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&fshostusb_fck,
 	&core_12m_fck,
 	&hdq_fck,
-	&ssi_ssr_fck,
-	&ssi_sst_fck,
+	&ssi_ssr_fck_3430es1,
+	&ssi_ssr_fck_3430es2,
+	&ssi_sst_fck_3430es1,
+	&ssi_sst_fck_3430es2,
 	&core_l3_ick,
-	&hsotgusb_ick,
+	&hsotgusb_ick_3430es1,
+	&hsotgusb_ick_3430es2,
 	&sdrc_ick,
 	&gpmc_fck,
 	&security_l3_ick,
@@ -3332,18 +3516,21 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&mailboxes_ick,
 	&omapctrl_ick,
 	&ssi_l4_ick,
-	&ssi_ick,
+	&ssi_ick_3430es1,
+	&ssi_ick_3430es2,
 	&usb_l4_ick,
 	&security_l4_ick2,
 	&aes1_ick,
 	&rng_ick,
 	&sha11_ick,
 	&des1_ick,
-	&dss1_alwon_fck,
+	&dss1_alwon_fck_3430es1,
+	&dss1_alwon_fck_3430es2,
 	&dss_tv_fck,
 	&dss_96m_fck,
 	&dss2_alwon_fck,
-	&dss_ick,
+	&dss_ick_3430es1,
+	&dss_ick_3430es2,
 	&cam_mclk,
 	&cam_ick,
 	&csi2_96m_fck,
diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
index 297a2fe..a9a0df5 100644
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -147,6 +147,7 @@
 
 /* CM_IDLEST3_CORE */
 /* 2430 only */
+#define OMAP2430_ST_SDRC_SHIFT				2
 #define OMAP2430_ST_SDRC_MASK				(1 << 2)
 
 /* CM_IDLEST4_CORE */
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index f73423d..d5f24b1 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -69,6 +69,7 @@ struct clk {
 	u16			enable_reg;
 	__u8			enable_bit;
 	__s8			usecount;
+	u8			idlest_bit;
 	void			(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
 	long			(*round_rate)(struct clk *, unsigned long);
@@ -142,7 +143,8 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 12)	/* 0 enables, 1 disables */
-/* bits 13-20 are currently free */
+#define WAIT_READY		(1 << 13)	/* wait for dev to leave idle */
+/* bits 14-20 are currently free */
 #define CLOCK_IN_OMAP310	(1 << 21)
 #define CLOCK_IN_OMAP730	(1 << 22)
 #define CLOCK_IN_OMAP1510	(1 << 23)
@@ -152,14 +154,14 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #define CLOCK_IN_OMAP343X	(1 << 27)	/* clocks common to all 343X */
 #define PARENT_CONTROLS_CLOCK	(1 << 28)
 #define CLOCK_IN_OMAP3430ES1	(1 << 29)	/* 3430ES1 clocks only */
-#define CLOCK_IN_OMAP3430ES2	(1 << 30)	/* 3430ES2 clocks only */
+#define CLOCK_IN_OMAP3430ES2	(1 << 30)	/* 3430ES2+ clocks only */
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)
 #define RATE_IN_242X		(1 << 1)
 #define RATE_IN_243X		(1 << 2)
 #define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
-#define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
+#define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2+ rates only */
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 


