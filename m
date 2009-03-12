From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 19/86] [ARM] omap: convert OMAP2 to use clkdev
Date: Thu, 12 Mar 2009 11:27:29 -0700
Message-ID: <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbZCLSaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:20 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:18 -0700 (PDT)
In-Reply-To: <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c         |  197 ++++++++++++++++--
 arch/arm/mach-omap2/clock24xx.h         |  353 +++----------------------------
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/include/mach/clock.h |    4 +-
 4 files changed, 218 insertions(+), 337 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 3a0a1b8..36093ea 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -31,6 +31,7 @@
 #include <mach/clock.h>
 #include <mach/sram.h>
 #include <asm/div64.h>
+#include <asm/clkdev.h>
 
 #include "memory.h"
 #include "clock.h"
@@ -44,6 +45,177 @@ static const struct clkops clkops_fixed;
 
 #include "clock24xx.h"
 
+struct omap_clk {
+	u32		cpu;
+	struct clk_lookup lk;
+};
+
+#define CLK(dev, con, ck, cp) 		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+#define CK_243X	(1 << 0)
+#define CK_242X	(1 << 1)
+
+static struct omap_clk omap24xx_clks[] = {
+	/* external root sources */
+	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X | CK_242X),
+	/* internal analog sources */
+	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X | CK_242X),
+	/* internal prcm root sources */
+	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X | CK_242X),
+	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X | CK_242X),
+	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
+	CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
+	/* mpu domain clocks */
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X | CK_242X),
+	/* dsp domain clocks */
+	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_243X | CK_242X),
+	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
+	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick,	CK_243X),
+	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
+	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
+	/* GFX domain clocks */
+	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X | CK_242X),
+	/* Modem domain clocks */
+	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
+	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
+	/* DSS domain clocks */
+	CLK(NULL,	"dss_ick",	&dss_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_243X | CK_242X),
+	/* L3 domain clocks */
+	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
+	/* L4 domain clocks */
+	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
+	/* virtual meta-group clock */
+	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X | CK_242X),
+	/* general l4 interface ck, multi-parent functional clk */
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.1", "mcbsp_ick", &mcbsp1_ick,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.1", "mcbsp_fck", &mcbsp1_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.2", "mcbsp_ick", &mcbsp2_ick,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.2", "mcbsp_fck", &mcbsp2_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.3", "mcbsp_ick", &mcbsp3_ick,	CK_243X),
+	CLK("omap-mcbsp.3", "mcbsp_fck", &mcbsp3_fck,	CK_243X),
+	CLK("omap-mcbsp.4", "mcbsp_ick", &mcbsp4_ick,	CK_243X),
+	CLK("omap-mcbsp.4", "mcbsp_fck", &mcbsp4_fck,	CK_243X),
+	CLK("omap-mcbsp.5", "mcbsp_ick", &mcbsp5_ick,	CK_243X),
+	CLK("omap-mcbsp.5", "mcbsp_fck", &mcbsp5_fck,	CK_243X),
+	CLK("omap2_mcspi.1", "mcspi_ick", &mcspi1_ick,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.1", "mcspi_fck", &mcspi1_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.2", "mcspi_ick", &mcspi2_ick,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.2", "mcspi_fck", &mcspi2_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.3", "mcspi_ick", &mcspi3_ick,	CK_243X),
+	CLK("omap2_mcspi.3", "mcspi_fck", &mcspi3_fck,	CK_243X),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"mpu_wdt_ick",	&mpu_wdt_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
+	CLK(NULL,	"cam_fck",	&cam_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"cam_ick",	&cam_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"mmc_ick",	&mmc_ick,	CK_242X),
+	CLK(NULL,	"mmc_fck",	&mmc_fck,	CK_242X),
+	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
+	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
+	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_243X | CK_242X),
+	CLK("i2c_omap.1", "i2c_ick",	&i2c1_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.1", "i2c_fck",	&i2c1_fck,	CK_242X),
+	CLK("i2c_omap.1", "i2c_fck",	&i2chs1_fck,	CK_243X),
+	CLK("i2c_omap.2", "i2c_ick",	&i2c2_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.2", "i2c_fck",	&i2c2_fck,	CK_242X),
+	CLK("i2c_omap.2", "i2c_fck",	&i2chs2_fck,	CK_243X),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
+	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
+	CLK(NULL,	"des_ick",	&des_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"sha_ick",	&sha_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"rng_ick",	&rng_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"usbhs_ick",	&usbhs_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "mmchs_ick",	&mmchs1_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "mmchs_fck",	&mmchs1_fck,	CK_243X),
+	CLK("mmci-omap-hs.1", "mmchs_ick",	&mmchs2_ick,	CK_243X),
+	CLK("mmci-omap-hs.1", "mmchs_fck",	&mmchs2_fck,	CK_243X),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
+	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
+	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
+	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
+};
+
 /* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
 #define EN_APLL_STOPPED			0
 #define EN_APLL_LOCKED			3
@@ -487,8 +659,8 @@ arch_initcall(omap2_clk_arch_init);
 int __init omap2_clk_init(void)
 {
 	struct prcm_config *prcm;
-	struct clk **clkp;
-	u32 clkrate;
+	struct omap_clk *c;
+	u32 clkrate, cpu_mask;
 
 	if (cpu_is_omap242x())
 		cpu_mask = RATE_IN_242X;
@@ -502,21 +674,18 @@ int __init omap2_clk_init(void)
 	omap2_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
-	for (clkp = onchip_24xx_clks;
-	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
-	     clkp++) {
+	cpu_mask = 0;
+	if (cpu_is_omap2420())
+		cpu_mask |= CK_242X;
+	if (cpu_is_omap2430())
+		cpu_mask |= CK_243X;
 
-		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {
-			clk_register(*clkp);
-			continue;
+	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+		if (c->cpu & cpu_mask) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
 		}
 
-		if ((*clkp)->flags & CLOCK_IN_OMAP243X && cpu_is_omap2430()) {
-			clk_register(*clkp);
-			continue;
-		}
-	}
-
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index e07dcba..b244247 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -621,8 +621,7 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.ops		= &clkops_null,
 	.rate		= 32000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -630,8 +629,7 @@ static struct clk func_32k_ck = {
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
 	.ops		= &clkops_oscck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_osc_clk_recalc,
 };
@@ -641,8 +639,7 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.ops		= &clkops_null,
 	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_sys_clk_recalc,
 };
@@ -651,8 +648,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.ops		= &clkops_null,
 	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 };
 
@@ -683,8 +679,7 @@ static struct clk dpll_ck = {
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,		/* Can be func_32k also */
 	.dpll_data	= &dpll_dd,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_dpllcore_recalc,
 	.set_rate	= &omap2_reprogram_dpllcore,
@@ -695,8 +690,7 @@ static struct clk apll96_ck = {
 	.ops		= &clkops_fixed,
 	.parent		= &sys_ck,
 	.rate		= 96000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+	.flags		= RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
@@ -707,8 +701,7 @@ static struct clk apll54_ck = {
 	.ops		= &clkops_fixed,
 	.parent		= &sys_ck,
 	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+	.flags		= RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
@@ -740,8 +733,7 @@ static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -754,8 +746,7 @@ static struct clk core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll_ck,		/* can also be 32k */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -782,8 +773,7 @@ static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -816,8 +806,7 @@ static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
@@ -833,8 +822,7 @@ static struct clk func_12m_ck = {
 	.ops		= &clkops_null,
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
@@ -844,7 +832,6 @@ static struct clk wdt1_osc_ck = {
 	.name		= "ck_wdt1_osc",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -888,8 +875,7 @@ static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
@@ -920,7 +906,6 @@ static struct clk sys_clkout = {
 	.name		= "sys_clkout",
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout_src,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
@@ -935,7 +920,7 @@ static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
@@ -958,7 +943,6 @@ static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout2_src,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "wkup_clkdm",
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
@@ -972,7 +956,6 @@ static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
@@ -1008,9 +991,7 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
@@ -1052,8 +1033,7 @@ static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clkdm_name	= "dsp_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1083,8 +1063,7 @@ static struct clk dsp_irate_ick = {
 	.name		= "dsp_irate_ick",
 	.ops		= &clkops_null,
 	.parent		= &dsp_fck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
-				CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
@@ -1098,7 +1077,7 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
-	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
@@ -1108,7 +1087,7 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
-	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
@@ -1122,8 +1101,7 @@ static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
-				RATE_PROPAGATES | DELAYED_APP,
+	.flags		= CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
 	.clkdm_name	= "iva1_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -1140,7 +1118,6 @@ static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &iva1_ifck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "iva1_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
@@ -1187,9 +1164,7 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
@@ -1217,8 +1192,7 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -1252,8 +1226,7 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP | RATE_PROPAGATES,
+	.flags		= DELAYED_APP | RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
@@ -1291,8 +1264,7 @@ static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
@@ -1328,7 +1300,6 @@ static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
@@ -1344,7 +1315,6 @@ static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
@@ -1360,7 +1330,6 @@ static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
@@ -1391,7 +1360,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
 	.clkdm_name	= "mdm_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
@@ -1407,7 +1376,6 @@ static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "mdm_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
@@ -1453,7 +1421,6 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ck,	/* really both l3 and l4 */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
@@ -1464,8 +1431,7 @@ static struct clk dss1_fck = {
 	.name		= "dss1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_ck,		/* Core or sys */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
@@ -1498,8 +1464,7 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
@@ -1514,7 +1479,6 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
@@ -1543,7 +1507,6 @@ static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
@@ -1554,7 +1517,6 @@ static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
@@ -1571,7 +1533,6 @@ static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
@@ -1582,7 +1543,6 @@ static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
@@ -1597,7 +1557,6 @@ static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
@@ -1608,7 +1567,6 @@ static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
@@ -1623,7 +1581,6 @@ static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
@@ -1634,7 +1591,6 @@ static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
@@ -1649,7 +1605,6 @@ static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
@@ -1660,7 +1615,6 @@ static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
@@ -1675,7 +1629,6 @@ static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
@@ -1686,7 +1639,6 @@ static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
@@ -1701,7 +1653,6 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1711,7 +1662,6 @@ static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
@@ -1726,7 +1676,6 @@ static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
@@ -1737,7 +1686,6 @@ static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
@@ -1752,7 +1700,6 @@ static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
@@ -1763,7 +1710,6 @@ static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
@@ -1778,7 +1724,6 @@ static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
@@ -1789,7 +1734,6 @@ static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
@@ -1804,7 +1748,6 @@ static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
@@ -1815,7 +1758,6 @@ static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
@@ -1830,7 +1772,6 @@ static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
@@ -1841,7 +1782,6 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
@@ -1857,7 +1797,6 @@ static struct clk mcbsp1_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
@@ -1869,7 +1808,6 @@ static struct clk mcbsp1_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
@@ -1881,7 +1819,6 @@ static struct clk mcbsp2_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
@@ -1893,7 +1830,6 @@ static struct clk mcbsp2_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
@@ -1905,7 +1841,6 @@ static struct clk mcbsp3_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
@@ -1917,7 +1852,6 @@ static struct clk mcbsp3_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
@@ -1929,7 +1863,6 @@ static struct clk mcbsp4_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
@@ -1941,7 +1874,6 @@ static struct clk mcbsp4_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
@@ -1953,7 +1885,6 @@ static struct clk mcbsp5_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
@@ -1965,7 +1896,6 @@ static struct clk mcbsp5_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
@@ -1978,7 +1908,6 @@ static struct clk mcspi1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1989,7 +1918,6 @@ static struct clk mcspi1_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
@@ -2001,7 +1929,6 @@ static struct clk mcspi2_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
@@ -2013,7 +1940,6 @@ static struct clk mcspi2_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
@@ -2025,7 +1951,6 @@ static struct clk mcspi3_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
@@ -2037,7 +1962,6 @@ static struct clk mcspi3_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
@@ -2048,7 +1972,6 @@ static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
@@ -2059,7 +1982,6 @@ static struct clk uart1_fck = {
 	.name		= "uart1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
@@ -2070,7 +1992,6 @@ static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
@@ -2081,7 +2002,6 @@ static struct clk uart2_fck = {
 	.name		= "uart2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
@@ -2092,7 +2012,6 @@ static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
@@ -2103,7 +2022,6 @@ static struct clk uart3_fck = {
 	.name		= "uart3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
@@ -2114,7 +2032,6 @@ static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
@@ -2125,7 +2042,6 @@ static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
@@ -2136,7 +2052,6 @@ static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
@@ -2147,7 +2062,6 @@ static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
@@ -2158,8 +2072,7 @@ static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
@@ -2170,7 +2083,6 @@ static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
@@ -2181,8 +2093,7 @@ static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
@@ -2193,7 +2104,6 @@ static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
@@ -2204,7 +2114,6 @@ static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
@@ -2220,7 +2129,6 @@ static struct clk cam_fck = {
 	.name		= "cam_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
@@ -2231,7 +2139,6 @@ static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
@@ -2242,7 +2149,6 @@ static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
@@ -2253,7 +2159,6 @@ static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
@@ -2264,7 +2169,6 @@ static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
@@ -2275,7 +2179,6 @@ static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
@@ -2286,7 +2189,6 @@ static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
@@ -2297,7 +2199,6 @@ static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
@@ -2308,7 +2209,6 @@ static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
@@ -2319,7 +2219,6 @@ static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
@@ -2330,7 +2229,6 @@ static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
@@ -2341,7 +2239,6 @@ static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
@@ -2352,7 +2249,6 @@ static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
@@ -2363,7 +2259,6 @@ static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
@@ -2374,7 +2269,6 @@ static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
@@ -2385,7 +2279,6 @@ static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
@@ -2397,7 +2290,6 @@ static struct clk i2c2_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
@@ -2409,7 +2301,6 @@ static struct clk i2c2_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
@@ -2421,7 +2312,6 @@ static struct clk i2chs2_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
@@ -2433,7 +2323,6 @@ static struct clk i2c1_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
@@ -2445,7 +2334,6 @@ static struct clk i2c1_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
@@ -2457,7 +2345,6 @@ static struct clk i2chs1_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
@@ -2468,8 +2355,7 @@ static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2478,7 +2364,6 @@ static struct clk sdma_fck = {
 	.name		= "sdma_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2487,7 +2372,6 @@ static struct clk sdma_ick = {
 	.name		= "sdma_ick",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2496,7 +2380,6 @@ static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
@@ -2532,7 +2415,7 @@ static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
@@ -2549,7 +2432,7 @@ static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
@@ -2560,7 +2443,6 @@ static struct clk des_ick = {
 	.name		= "des_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
@@ -2571,7 +2453,6 @@ static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
@@ -2582,7 +2463,6 @@ static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
@@ -2593,7 +2473,6 @@ static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
@@ -2604,7 +2483,6 @@ static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
 	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
@@ -2615,7 +2493,6 @@ static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -2626,7 +2503,6 @@ static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
@@ -2637,7 +2513,6 @@ static struct clk mmchs1_ick = {
 	.name		= "mmchs_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
@@ -2648,7 +2523,6 @@ static struct clk mmchs1_fck = {
 	.name		= "mmchs_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
@@ -2660,7 +2534,6 @@ static struct clk mmchs2_ick = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
@@ -2672,7 +2545,6 @@ static struct clk mmchs2_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2682,7 +2554,6 @@ static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
@@ -2693,7 +2564,6 @@ static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
@@ -2704,7 +2574,6 @@ static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
@@ -2715,7 +2584,6 @@ static struct clk mmchsdb1_fck = {
 	.name		= "mmchsdb_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
@@ -2727,7 +2595,6 @@ static struct clk mmchsdb2_fck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
@@ -2751,166 +2618,12 @@ static struct clk mmchsdb2_fck = {
 static struct clk virt_prcm_set = {
 	.name		= "virt_prcm_set",
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP,
+	.flags		= DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
 	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
 	.round_rate	= &omap2_round_to_table_rate,
 };
 
-static struct clk *onchip_24xx_clks[] __initdata = {
-	/* external root sources */
-	&func_32k_ck,
-	&osc_ck,
-	&sys_ck,
-	&alt_ck,
-	/* internal analog sources */
-	&dpll_ck,
-	&apll96_ck,
-	&apll54_ck,
-	/* internal prcm root sources */
-	&func_54m_ck,
-	&core_ck,
-	&func_96m_ck,
-	&func_48m_ck,
-	&func_12m_ck,
-	&wdt1_osc_ck,
-	&sys_clkout_src,
-	&sys_clkout,
-	&sys_clkout2_src,
-	&sys_clkout2,
-	&emul_ck,
-	/* mpu domain clocks */
-	&mpu_ck,
-	/* dsp domain clocks */
-	&dsp_fck,
-	&dsp_irate_ick,
-	&dsp_ick,		/* 242x */
-	&iva2_1_ick,		/* 243x */
-	&iva1_ifck,		/* 242x */
-	&iva1_mpu_int_ifck,	/* 242x */
-	/* GFX domain clocks */
-	&gfx_3d_fck,
-	&gfx_2d_fck,
-	&gfx_ick,
-	/* Modem domain clocks */
-	&mdm_ick,
-	&mdm_osc_ck,
-	/* DSS domain clocks */
-	&dss_ick,
-	&dss1_fck,
-	&dss2_fck,
-	&dss_54m_fck,
-	/* L3 domain clocks */
-	&core_l3_ck,
-	&ssi_ssr_sst_fck,
-	&usb_l4_ick,
-	/* L4 domain clocks */
-	&l4_ck,			/* used as both core_l4 and wu_l4 */
-	/* virtual meta-group clock */
-	&virt_prcm_set,
-	/* general l4 interface ck, multi-parent functional clk */
-	&gpt1_ick,
-	&gpt1_fck,
-	&gpt2_ick,
-	&gpt2_fck,
-	&gpt3_ick,
-	&gpt3_fck,
-	&gpt4_ick,
-	&gpt4_fck,
-	&gpt5_ick,
-	&gpt5_fck,
-	&gpt6_ick,
-	&gpt6_fck,
-	&gpt7_ick,
-	&gpt7_fck,
-	&gpt8_ick,
-	&gpt8_fck,
-	&gpt9_ick,
-	&gpt9_fck,
-	&gpt10_ick,
-	&gpt10_fck,
-	&gpt11_ick,
-	&gpt11_fck,
-	&gpt12_ick,
-	&gpt12_fck,
-	&mcbsp1_ick,
-	&mcbsp1_fck,
-	&mcbsp2_ick,
-	&mcbsp2_fck,
-	&mcbsp3_ick,
-	&mcbsp3_fck,
-	&mcbsp4_ick,
-	&mcbsp4_fck,
-	&mcbsp5_ick,
-	&mcbsp5_fck,
-	&mcspi1_ick,
-	&mcspi1_fck,
-	&mcspi2_ick,
-	&mcspi2_fck,
-	&mcspi3_ick,
-	&mcspi3_fck,
-	&uart1_ick,
-	&uart1_fck,
-	&uart2_ick,
-	&uart2_fck,
-	&uart3_ick,
-	&uart3_fck,
-	&gpios_ick,
-	&gpios_fck,
-	&mpu_wdt_ick,
-	&mpu_wdt_fck,
-	&sync_32k_ick,
-	&wdt1_ick,
-	&omapctrl_ick,
-	&icr_ick,
-	&cam_fck,
-	&cam_ick,
-	&mailboxes_ick,
-	&wdt4_ick,
-	&wdt4_fck,
-	&wdt3_ick,
-	&wdt3_fck,
-	&mspro_ick,
-	&mspro_fck,
-	&mmc_ick,
-	&mmc_fck,
-	&fac_ick,
-	&fac_fck,
-	&eac_ick,
-	&eac_fck,
-	&hdq_ick,
-	&hdq_fck,
-	&i2c1_ick,
-	&i2c1_fck,
-	&i2chs1_fck,
-	&i2c2_ick,
-	&i2c2_fck,
-	&i2chs2_fck,
-	&gpmc_fck,
-	&sdma_fck,
-	&sdma_ick,
-	&vlynq_ick,
-	&vlynq_fck,
-	&sdrc_ick,
-	&des_ick,
-	&sha_ick,
-	&rng_ick,
-	&aes_ick,
-	&pka_ick,
-	&usb_fck,
-	&usbhs_ick,
-	&mmchs1_ick,
-	&mmchs1_fck,
-	&mmchs2_ick,
-	&mmchs2_fck,
-	&gpio5_ick,
-	&gpio5_fck,
-	&mdm_intc_ick,
-	&mmchsdb1_fck,
-	&mmchsdb2_fck,
-};
-
 #endif
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index fc7b683..9037213 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -16,6 +16,7 @@ config ARCH_OMAP1
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	select CPU_V6
+	select COMMON_CLKDEV
 
 config ARCH_OMAP3
 	bool "TI OMAP3"
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 2af4bc2..214dc46 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -136,9 +136,7 @@ extern const struct clkops clkops_null;
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
-/* bits 13-24 are currently free */
-#define CLOCK_IN_OMAP242X	(1 << 25)
-#define CLOCK_IN_OMAP243X	(1 << 26)
+/* bits 13-26 are currently free */
 #define CLOCK_IN_OMAP343X	(1 << 27)	/* clocks common to all 343X */
 #define CLOCK_IN_OMAP3430ES1	(1 << 29)	/* 3430ES1 clocks only */
 #define CLOCK_IN_OMAP3430ES2	(1 << 30)	/* 3430ES2 clocks only */
-- 
1.6.1.2

