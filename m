From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 20/86] [ARM] omap: convert OMAP3 to use clkdev
Date: Thu, 12 Mar 2009 11:27:30 -0700
Message-ID: <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbZCLSae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:34 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:32 -0700 (PDT)
In-Reply-To: <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.c         |  268 +++++++++++++++--
 arch/arm/mach-omap2/clock34xx.h         |  513 +++++--------------------------
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/include/mach/clock.h |    5 +-
 4 files changed, 331 insertions(+), 456 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 52698fb..2c22750 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -30,6 +30,7 @@
 #include <mach/clock.h>
 #include <mach/sram.h>
 #include <asm/div64.h>
+#include <asm/clkdev.h>
 
 #include "memory.h"
 #include "clock.h"
@@ -42,6 +43,240 @@ static const struct clkops clkops_noncore_dpll_ops;
 
 #include "clock34xx.h"
 
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
+#define CK_343X		(1 << 0)
+#define CK_3430ES1	(1 << 1)
+#define CK_3430ES2	(1 << 2)
+
+static struct omap_clk omap34xx_clks[] = {
+	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X),
+	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X),
+	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X),
+	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
+	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
+	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X),
+	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
+	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_343X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_343X),
+	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_343X),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_343X),
+	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_343X),
+	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_343X),
+	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_343X),
+	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
+	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_343X),
+	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_343X),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_343X),
+	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_343X),
+	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
+	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_343X),
+	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
+	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_343X),
+	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_343X),
+	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
+	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_343X),
+	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_343X),
+	CLK(NULL,	"virt_omap_54m_fck", &virt_omap_54m_fck, CK_343X),
+	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_343X),
+	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_343X),
+	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_343X),
+	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
+	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X),
+	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
+	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
+	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
+	CLK(NULL,	"omap_120m_fck", &omap_120m_fck, CK_3430ES2),
+	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_343X),
+	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_343X),
+	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_343X),
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_343X),
+	CLK(NULL,	"arm_fck",	&arm_fck,	CK_343X),
+	CLK(NULL,	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
+	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
+	CLK(NULL,	"l3_ick",	&l3_ick,	CK_343X),
+	CLK(NULL,	"l4_ick",	&l4_ick,	CK_343X),
+	CLK(NULL,	"rm_ick",	&rm_ick,	CK_343X),
+	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck,	CK_3430ES1),
+	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck,	CK_3430ES1),
+	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
+	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
+	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
+	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2),
+	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2),
+	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_343X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_343X),
+	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2),
+	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2),
+	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2),
+	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_343X),
+	CLK("mmci-omap-hs.2",	"mmchs_fck",	&mmchs3_fck,	CK_3430ES2),
+	CLK("mmci-omap-hs.1",	"mmchs_fck",	&mmchs2_fck,	CK_343X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
+	CLK("mmci-omap-hs.0",	"mmchs_fck",	&mmchs1_fck,	CK_343X),
+	CLK("i2c_omap.3", "i2c_fck",	&i2c3_fck,	CK_343X),
+	CLK("i2c_omap.2", "i2c_fck",	&i2c2_fck,	CK_343X),
+	CLK("i2c_omap.1", "i2c_fck",	&i2c1_fck,	CK_343X),
+	CLK("omap-mcbsp.5", "mcbsp_fck", &mcbsp5_fck,	CK_343X),
+	CLK("omap-mcbsp.1", "mcbsp_fck", &mcbsp1_fck,	CK_343X),
+	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
+	CLK("omap2_mcspi.4", "mcspi_fck", &mcspi4_fck,	CK_343X),
+	CLK("omap2_mcspi.3", "mcspi_fck", &mcspi3_fck,	CK_343X),
+	CLK("omap2_mcspi.2", "mcspi_fck", &mcspi2_fck,	CK_343X),
+	CLK("omap2_mcspi.1", "mcspi_fck", &mcspi1_fck,	CK_343X),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_343X),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_343X),
+	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
+	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_343X),
+	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_343X),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck,	CK_343X),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck,	CK_343X),
+	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
+	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick,	CK_343X),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
+	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
+	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_343X),
+	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2),
+	CLK("mmci-omap-hs.2",	"mmchs_ick",	&mmchs3_ick,	CK_3430ES2),
+	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
+	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
+	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_343X),
+	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
+	CLK("mmci-omap-hs.1",	"mmchs_ick",	&mmchs2_ick,	CK_343X),
+	CLK("mmci-omap-hs.0",	"mmchs_ick",	&mmchs1_ick,	CK_343X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
+	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_343X),
+	CLK("omap2_mcspi.4", "mcspi_ick", &mcspi4_ick,	CK_343X),
+	CLK("omap2_mcspi.3", "mcspi_ick", &mcspi3_ick,	CK_343X),
+	CLK("omap2_mcspi.2", "mcspi_ick", &mcspi2_ick,	CK_343X),
+	CLK("omap2_mcspi.1", "mcspi_ick", &mcspi1_ick,	CK_343X),
+	CLK("i2c_omap.3", "i2c_ick",	&i2c3_ick,	CK_343X),
+	CLK("i2c_omap.2", "i2c_ick",	&i2c2_ick,	CK_343X),
+	CLK("i2c_omap.1", "i2c_ick",	&i2c1_ick,	CK_343X),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_343X),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_343X),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_343X),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_343X),
+	CLK("omap-mcbsp.5", "mcbsp_ick", &mcbsp5_ick,	CK_343X),
+	CLK("omap-mcbsp.1", "mcbsp_ick", &mcbsp1_ick,	CK_343X),
+	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
+	CLK(NULL,	"ssi_ick",	&ssi_ick,	CK_343X),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
+	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
+	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
+	CLK(NULL,	"rng_ick",	&rng_ick,	CK_343X),
+	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
+	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
+	CLK(NULL,	"dss1_alwon_fck", &dss1_alwon_fck, CK_343X),
+	CLK(NULL,	"dss_tv_fck",	&dss_tv_fck,	CK_343X),
+	CLK(NULL,	"dss_96m_fck",	&dss_96m_fck,	CK_343X),
+	CLK(NULL,	"dss2_alwon_fck", &dss2_alwon_fck, CK_343X),
+	CLK(NULL,	"dss_ick",	&dss_ick,	CK_343X),
+	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
+	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
+	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
+	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
+	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2),
+	CLK(NULL,	"usbhost_sar_fck", &usbhost_sar_fck, CK_3430ES2),
+	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
+	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
+	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
+	CLK(NULL,	"wdt2_fck",	&wdt2_fck,	CK_343X),
+	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
+	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
+	CLK(NULL,	"wdt2_ick",	&wdt2_ick,	CK_343X),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
+	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
+	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_343X),
+	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_343X),
+	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_343X),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_343X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_343X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_343X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_343X),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_343X),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_343X),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_343X),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_343X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_343X),
+	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_343X),
+	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_343X),
+	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_343X),
+	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
+	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
+	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
+	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
+	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
+	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
+	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
+	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_343X),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_343X),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_343X),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_343X),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_343X),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_343X),
+	CLK("omap-mcbsp.2", "mcbsp_ick", &mcbsp2_ick,	CK_343X),
+	CLK("omap-mcbsp.3", "mcbsp_ick", &mcbsp3_ick,	CK_343X),
+	CLK("omap-mcbsp.4", "mcbsp_ick", &mcbsp4_ick,	CK_343X),
+	CLK("omap-mcbsp.2", "mcbsp_fck", &mcbsp2_fck,	CK_343X),
+	CLK("omap-mcbsp.3", "mcbsp_fck", &mcbsp3_fck,	CK_343X),
+	CLK("omap-mcbsp.4", "mcbsp_fck", &mcbsp4_fck,	CK_343X),
+	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_343X),
+	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
+	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
+	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_343X),
+	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_343X),
+	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_343X),
+	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_343X),
+	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
+	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
+	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
+	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
+};
+
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
 #define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
@@ -453,26 +688,13 @@ arch_initcall(omap2_clk_arch_init);
 int __init omap2_clk_init(void)
 {
 	/* struct prcm_config *prcm; */
-	struct clk **clkp;
+	struct omap_clk *c;
 	/* u32 clkrate; */
 	u32 cpu_clkflg;
 
-	/* REVISIT: Ultimately this will be used for multiboot */
-#if 0
-	if (cpu_is_omap242x()) {
-		cpu_mask = RATE_IN_242X;
-		cpu_clkflg = CLOCK_IN_OMAP242X;
-		clkp = onchip_24xx_clks;
-	} else if (cpu_is_omap2430()) {
-		cpu_mask = RATE_IN_243X;
-		cpu_clkflg = CLOCK_IN_OMAP243X;
-		clkp = onchip_24xx_clks;
-	}
-#endif
 	if (cpu_is_omap34xx()) {
 		cpu_mask = RATE_IN_343X;
-		cpu_clkflg = CLOCK_IN_OMAP343X;
-		clkp = onchip_34xx_clks;
+		cpu_clkflg = CK_343X;
 
 		/*
 		 * Update this if there are further clock changes between ES2
@@ -480,23 +702,21 @@ int __init omap2_clk_init(void)
 		 */
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
-			cpu_clkflg |= CLOCK_IN_OMAP3430ES1;
+			cpu_clkflg |= CK_3430ES1;
 		} else {
 			cpu_mask |= RATE_IN_3430ES2;
-			cpu_clkflg |= CLOCK_IN_OMAP3430ES2;
+			cpu_clkflg |= CK_3430ES2;
 		}
 	}
 
 	clk_init(&omap2_clk_functions);
 
-	for (clkp = onchip_34xx_clks;
-	     clkp < onchip_34xx_clks + ARRAY_SIZE(onchip_34xx_clks);
-	     clkp++) {
-		if ((*clkp)->flags & cpu_clkflg) {
-			clk_register(*clkp);
-			omap2_init_clk_clkdm(*clkp);
+	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
+		if (c->cpu & cpu_clkflg) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+			omap2_init_clk_clkdm(c->lk.clk);
 		}
-	}
 
 	/* REVISIT: Not yet ready for OMAP3 */
 #if 0
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index dcacec8..6bd8c6d 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -57,14 +57,14 @@ static struct clk omap_32k_fck = {
 	.name		= "omap_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static struct clk secure_32k_fck = {
 	.name		= "secure_32k_fck",
 	.ops		= &clkops_null,
 	.rate		= 32768,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 /* Virtual source clocks for osc_sys_ck */
@@ -72,42 +72,42 @@ static struct clk virt_12m_ck = {
 	.name		= "virt_12m_ck",
 	.ops		= &clkops_null,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static struct clk virt_13m_ck = {
 	.name		= "virt_13m_ck",
 	.ops		= &clkops_null,
 	.rate		= 13000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static struct clk virt_16_8m_ck = {
 	.name		= "virt_16_8m_ck",
 	.ops		= &clkops_null,
 	.rate		= 16800000,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static struct clk virt_19_2m_ck = {
 	.name		= "virt_19_2m_ck",
 	.ops		= &clkops_null,
 	.rate		= 19200000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static struct clk virt_26m_ck = {
 	.name		= "virt_26m_ck",
 	.ops		= &clkops_null,
 	.rate		= 26000000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static struct clk virt_38_4m_ck = {
 	.name		= "virt_38_4m_ck",
 	.ops		= &clkops_null,
 	.rate		= 38400000,
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
@@ -160,7 +160,7 @@ static struct clk osc_sys_ck = {
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
-	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES,
+	.flags		= RATE_FIXED | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -185,21 +185,21 @@ static struct clk sys_ck = {
 	.clksel_reg	= OMAP3430_PRM_CLKSRC_CTRL,
 	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
 	.clksel		= sys_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk sys_altclk = {
 	.name		= "sys_altclk",
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 };
 
 /* Optional external clock input for some McBSPs */
 static struct clk mcbsp_clks = {
 	.name		= "mcbsp_clks",
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 };
 
 /* PRM EXTERNAL CLOCK OUTPUT */
@@ -210,7 +210,6 @@ static struct clk sys_clkout1 = {
 	.parent		= &osc_sys_ck,
 	.enable_reg	= OMAP3430_PRM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -275,7 +274,7 @@ static struct clk dpll1_ck = {
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll1_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -288,7 +287,7 @@ static struct clk dpll1_x2_ck = {
 	.name		= "dpll1_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll1_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -310,7 +309,7 @@ static struct clk dpll1_x2m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll1_x2m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -343,7 +342,7 @@ static struct clk dpll2_ck = {
 	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll2_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -366,7 +365,7 @@ static struct clk dpll2_m2_ck = {
 					  OMAP3430_CM_CLKSEL2_PLL),
 	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div16_dpll2_m2x2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -396,7 +395,7 @@ static struct clk dpll3_ck = {
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll3_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -409,7 +408,7 @@ static struct clk dpll3_x2_ck = {
 	.name		= "dpll3_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -466,7 +465,7 @@ static struct clk dpll3_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.clksel		= div31_dpll3m2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -483,7 +482,7 @@ static struct clk core_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= core_ck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -500,7 +499,7 @@ static struct clk dpll3_m2x2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= dpll3_m2x2_ck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -519,7 +518,7 @@ static struct clk dpll3_m3_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -530,7 +529,7 @@ static struct clk dpll3_m3x2_ck = {
 	.parent		= &dpll3_m3_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -548,7 +547,7 @@ static struct clk emu_core_alwon_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		= emu_core_alwon_ck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -579,7 +578,7 @@ static struct clk dpll4_ck = {
 	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll4_dd,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -593,7 +592,7 @@ static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -611,7 +610,7 @@ static struct clk dpll4_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
 	.clksel_mask	= OMAP3430_DIV_96M_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -622,7 +621,7 @@ static struct clk dpll4_m2x2_ck = {
 	.parent		= &dpll4_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -640,7 +639,7 @@ static struct clk omap_96m_alwon_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= omap_96m_alwon_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -648,7 +647,7 @@ static struct clk omap_96m_fck = {
 	.name		= "omap_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -666,7 +665,7 @@ static struct clk cm_96m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= cm_96m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -679,7 +678,7 @@ static struct clk dpll4_m3_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -691,7 +690,7 @@ static struct clk dpll4_m3x2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -709,7 +708,7 @@ static struct clk virt_omap_54m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= virt_omap_54m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -736,7 +735,7 @@ static struct clk omap_54m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_54M,
 	.clksel		= omap_54m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -763,7 +762,7 @@ static struct clk omap_48m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_SOURCE_48M,
 	.clksel		= omap_48m_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -772,7 +771,7 @@ static struct clk omap_12m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.fixed_div	= 4,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -785,7 +784,7 @@ static struct clk dpll4_m4_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -796,7 +795,7 @@ static struct clk dpll4_m4x2_ck = {
 	.parent		= &dpll4_m4_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -809,7 +808,7 @@ static struct clk dpll4_m5_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -820,7 +819,7 @@ static struct clk dpll4_m5x2_ck = {
 	.parent		= &dpll4_m5_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -833,7 +832,7 @@ static struct clk dpll4_m6_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
 	.clksel		= div16_dpll4_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -845,7 +844,7 @@ static struct clk dpll4_m6x2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.flags		= RATE_PROPAGATES | INVERT_ENABLE,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
@@ -853,7 +852,7 @@ static struct clk emu_per_alwon_ck = {
 	.name		= "emu_per_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &dpll4_m6x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -885,7 +884,7 @@ static struct clk dpll5_ck = {
 	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll5_dd,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -903,7 +902,7 @@ static struct clk dpll5_m2_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
 	.clksel		= div16_dpll5_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -921,7 +920,7 @@ static struct clk omap_120m_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
 	.clksel_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
 	.clksel		= omap_120m_fck_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -964,7 +963,7 @@ static struct clk clkout2_src_ck = {
 	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -989,7 +988,6 @@ static struct clk sys_clkout2 = {
 	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -999,7 +997,7 @@ static struct clk corex2_fck = {
 	.name		= "corex2_fck",
 	.ops		= &clkops_null,
 	.parent		= &dpll3_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1022,7 +1020,7 @@ static struct clk dpll1_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1046,7 +1044,7 @@ static struct clk mpu_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= mpu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1071,7 +1069,7 @@ static struct clk arm_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
 	.clksel		= arm_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1085,7 +1083,7 @@ static struct clk emu_mpu_alwon_ck = {
 	.name		= "emu_mpu_alwon_ck",
 	.ops		= &clkops_null,
 	.parent		= &mpu_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1097,7 +1095,7 @@ static struct clk dpll2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1125,7 +1123,7 @@ static struct clk iva2_ck = {
 					  OMAP3430_CM_IDLEST_PLL),
 	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.clksel		= iva2_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "iva2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1140,7 +1138,7 @@ static struct clk l3_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
 	.clksel		= div2_core_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1158,7 +1156,7 @@ static struct clk l4_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
 	.clksel		= div2_l3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 
@@ -1177,7 +1175,6 @@ static struct clk rm_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_RM_MASK,
 	.clksel		= div2_l4_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1198,7 +1195,6 @@ static struct clk gfx_l3_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1210,7 +1206,7 @@ static struct clk gfx_l3_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1219,7 +1215,6 @@ static struct clk gfx_l3_ick = {
 	.name		= "gfx_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &gfx_l3_ck,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1231,7 +1226,6 @@ static struct clk gfx_cg1_ck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_2D_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1243,7 +1237,6 @@ static struct clk gfx_cg2_ck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_3D_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1277,7 +1270,6 @@ static struct clk sgx_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430ES2_CLKSEL_SGX_MASK,
 	.clksel		= sgx_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "sgx_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1289,7 +1281,6 @@ static struct clk sgx_ick = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "sgx_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1303,7 +1294,6 @@ static struct clk d2d_26m_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_D2D_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm_name	= "d2d_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1324,7 +1314,6 @@ static struct clk gpt10_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT10_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1339,7 +1328,6 @@ static struct clk gpt11_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT11_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1350,7 +1338,6 @@ static struct clk cpefuse_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1360,7 +1347,6 @@ static struct clk ts_fck = {
 	.parent		= &omap_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1370,7 +1356,6 @@ static struct clk usbtll_fck = {
 	.parent		= &omap_120m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1380,7 +1365,7 @@ static struct clk core_96m_fck = {
 	.name		= "core_96m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1392,7 +1377,6 @@ static struct clk mmchs3_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1404,7 +1388,6 @@ static struct clk mmchs2_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1415,7 +1398,6 @@ static struct clk mspro_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1426,7 +1408,6 @@ static struct clk mmchs1_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1438,7 +1419,6 @@ static struct clk i2c3_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1450,7 +1430,6 @@ static struct clk i2c2_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1462,7 +1441,6 @@ static struct clk i2c1_fck = {
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1497,7 +1475,6 @@ static struct clk mcbsp5_fck = {
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1512,7 +1489,6 @@ static struct clk mcbsp1_fck = {
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1523,7 +1499,7 @@ static struct clk core_48m_fck = {
 	.name		= "core_48m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1535,7 +1511,6 @@ static struct clk mcspi4_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1546,7 +1521,6 @@ static struct clk mcspi3_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1557,7 +1531,6 @@ static struct clk mcspi2_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1568,7 +1541,6 @@ static struct clk mcspi1_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1578,7 +1550,6 @@ static struct clk uart2_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1588,7 +1559,6 @@ static struct clk uart1_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1598,7 +1568,6 @@ static struct clk fshostusb_fck = {
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1608,7 +1577,7 @@ static struct clk core_12m_fck = {
 	.name		= "core_12m_fck",
 	.ops		= &clkops_null,
 	.parent		= &omap_12m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1619,7 +1588,6 @@ static struct clk hdq_fck = {
 	.parent		= &core_12m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1649,7 +1617,7 @@ static struct clk ssi_ssr_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -1659,7 +1627,6 @@ static struct clk ssi_sst_fck = {
 	.ops		= &clkops_null,
 	.parent		= &ssi_ssr_fck,
 	.fixed_div	= 2,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -1676,7 +1643,7 @@ static struct clk core_l3_ick = {
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1687,7 +1654,6 @@ static struct clk hsotgusb_ick = {
 	.parent		= &core_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1698,7 +1664,7 @@ static struct clk sdrc_ick = {
 	.parent		= &core_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1707,7 +1673,7 @@ static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT, /* huh? */
+	.flags		= ENABLE_ON_INIT, /* huh? */
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1718,7 +1684,7 @@ static struct clk security_l3_ick = {
 	.name		= "security_l3_ick",
 	.ops		= &clkops_null,
 	.parent		= &l3_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1728,7 +1694,6 @@ static struct clk pka_ick = {
 	.parent		= &security_l3_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1739,7 +1704,7 @@ static struct clk core_l4_ick = {
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1750,7 +1715,6 @@ static struct clk usbtll_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1762,7 +1726,6 @@ static struct clk mmchs3_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1774,7 +1737,6 @@ static struct clk icr_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1785,7 +1747,6 @@ static struct clk aes2_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1796,7 +1757,6 @@ static struct clk sha12_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1807,7 +1767,6 @@ static struct clk des2_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1819,7 +1778,6 @@ static struct clk mmchs2_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1830,7 +1788,6 @@ static struct clk mmchs1_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1841,7 +1798,6 @@ static struct clk mspro_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1852,7 +1808,6 @@ static struct clk hdq_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1864,7 +1819,6 @@ static struct clk mcspi4_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1876,7 +1830,6 @@ static struct clk mcspi3_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1888,7 +1841,6 @@ static struct clk mcspi2_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1900,7 +1852,6 @@ static struct clk mcspi1_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1912,7 +1863,6 @@ static struct clk i2c3_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1924,7 +1874,6 @@ static struct clk i2c2_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1936,7 +1885,6 @@ static struct clk i2c1_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1947,7 +1895,6 @@ static struct clk uart2_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1958,7 +1905,6 @@ static struct clk uart1_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1969,7 +1915,6 @@ static struct clk gpt11_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1980,7 +1925,6 @@ static struct clk gpt10_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -1992,7 +1936,6 @@ static struct clk mcbsp5_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2004,7 +1947,6 @@ static struct clk mcbsp1_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2015,7 +1957,6 @@ static struct clk fac_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FAC_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2026,7 +1967,6 @@ static struct clk mailboxes_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2037,7 +1977,7 @@ static struct clk omapctrl_ick = {
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.flags		= ENABLE_ON_INIT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2047,7 +1987,7 @@ static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2058,7 +1998,6 @@ static struct clk ssi_ick = {
 	.parent		= &ssi_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2081,7 +2020,6 @@ static struct clk usb_l4_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
 	.clksel		= usb_l4_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES1,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2093,7 +2031,7 @@ static struct clk security_l4_ick2 = {
 	.name		= "security_l4_ick2",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2103,7 +2041,6 @@ static struct clk aes1_ick = {
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2113,7 +2050,6 @@ static struct clk rng_ick = {
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2123,7 +2059,6 @@ static struct clk sha11_ick = {
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2133,7 +2068,6 @@ static struct clk des1_ick = {
 	.parent		= &security_l4_ick2,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2154,7 +2088,6 @@ static struct clk dss1_alwon_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= dss1_alwon_fck_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "dss_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2166,7 +2099,6 @@ static struct clk dss_tv_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2178,7 +2110,6 @@ static struct clk dss_96m_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2190,7 +2121,6 @@ static struct clk dss2_alwon_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2203,7 +2133,6 @@ static struct clk dss_ick = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2226,7 +2155,6 @@ static struct clk cam_mclk = {
 	.clksel		= cam_mclk_clksel,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "cam_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2239,7 +2167,6 @@ static struct clk cam_ick = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "cam_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2253,7 +2180,6 @@ static struct clk usbhost_120m_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2265,7 +2191,6 @@ static struct clk usbhost_48m_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2278,7 +2203,6 @@ static struct clk usbhost_ick = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2290,7 +2214,6 @@ static struct clk usbhost_sar_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
 	.enable_bit	= OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2330,7 +2253,6 @@ static struct clk usim_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430ES2_CLKSEL_USIMOCP_MASK,
 	.clksel		= usim_clksel,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2344,7 +2266,6 @@ static struct clk gpt1_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT1_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2354,7 +2275,7 @@ static struct clk wkup_32k_fck = {
 	.ops		= &clkops_null,
 	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2365,7 +2286,6 @@ static struct clk gpio1_dbck = {
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2376,7 +2296,6 @@ static struct clk wdt2_fck = {
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2385,7 +2304,7 @@ static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &sys_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2398,7 +2317,6 @@ static struct clk usim_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2409,7 +2327,6 @@ static struct clk wdt2_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2420,7 +2337,6 @@ static struct clk wdt1_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2431,7 +2347,6 @@ static struct clk gpio1_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2442,7 +2357,6 @@ static struct clk omap_32ksync_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2454,7 +2368,6 @@ static struct clk gpt12_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2465,7 +2378,6 @@ static struct clk gpt1_ick = {
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2479,7 +2391,7 @@ static struct clk per_96m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_96m_alwon_fck,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2489,7 +2401,7 @@ static struct clk per_48m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.init		= &omap2_init_clk_clkdm,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2500,7 +2412,6 @@ static struct clk uart3_fck = {
 	.parent		= &per_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2514,7 +2425,6 @@ static struct clk gpt2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT2_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2528,7 +2438,6 @@ static struct clk gpt3_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT3_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2542,7 +2451,6 @@ static struct clk gpt4_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT4_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2556,7 +2464,6 @@ static struct clk gpt5_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT5_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2570,7 +2477,6 @@ static struct clk gpt6_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT6_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2584,7 +2490,6 @@ static struct clk gpt7_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT7_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2598,7 +2503,6 @@ static struct clk gpt8_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT8_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2612,7 +2516,6 @@ static struct clk gpt9_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430_CLKSEL_GPT9_MASK,
 	.clksel		= omap343x_gpt_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2622,7 +2525,7 @@ static struct clk per_32k_alwon_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_32k_fck,
 	.clkdm_name	= "per_clkdm",
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2632,7 +2535,6 @@ static struct clk gpio6_dbck = {
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2643,7 +2545,6 @@ static struct clk gpio5_dbck = {
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2654,7 +2555,6 @@ static struct clk gpio4_dbck = {
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2665,7 +2565,6 @@ static struct clk gpio3_dbck = {
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2676,7 +2575,6 @@ static struct clk gpio2_dbck = {
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2687,7 +2585,6 @@ static struct clk wdt3_fck = {
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2696,7 +2593,7 @@ static struct clk per_l4_ick = {
 	.name		= "per_l4_ick",
 	.ops		= &clkops_null,
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2707,7 +2604,6 @@ static struct clk gpio6_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2718,7 +2614,6 @@ static struct clk gpio5_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2729,7 +2624,6 @@ static struct clk gpio4_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2740,7 +2634,6 @@ static struct clk gpio3_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2751,7 +2644,6 @@ static struct clk gpio2_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2762,7 +2654,6 @@ static struct clk wdt3_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2773,7 +2664,6 @@ static struct clk uart3_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2784,7 +2674,6 @@ static struct clk gpt9_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2795,7 +2684,6 @@ static struct clk gpt8_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2806,7 +2694,6 @@ static struct clk gpt7_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2817,7 +2704,6 @@ static struct clk gpt6_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2828,7 +2714,6 @@ static struct clk gpt5_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2839,7 +2724,6 @@ static struct clk gpt4_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2850,7 +2734,6 @@ static struct clk gpt3_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2861,7 +2744,6 @@ static struct clk gpt2_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2873,7 +2755,6 @@ static struct clk mcbsp2_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2885,7 +2766,6 @@ static struct clk mcbsp3_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2897,7 +2777,6 @@ static struct clk mcbsp4_ick = {
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -2918,7 +2797,6 @@ static struct clk mcbsp2_fck = {
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2933,7 +2811,6 @@ static struct clk mcbsp3_fck = {
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2948,7 +2825,6 @@ static struct clk mcbsp4_fck = {
 	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -2997,7 +2873,7 @@ static struct clk emu_src_ck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3022,7 +2898,7 @@ static struct clk pclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3046,7 +2922,7 @@ static struct clk pclkx2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3063,7 +2939,7 @@ static struct clk atclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3075,7 +2951,7 @@ static struct clk traceclk_src_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3099,7 +2975,6 @@ static struct clk traceclk_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
 	.clksel		= traceclk_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
@@ -3113,7 +2988,7 @@ static struct clk sr1_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -3124,7 +2999,7 @@ static struct clk sr2_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -3132,7 +3007,6 @@ static struct clk sr_l4_ick = {
 	.name		= "sr_l4_ick",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ick,
-	.flags		= CLOCK_IN_OMAP343X,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -3144,7 +3018,6 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
 };
 
@@ -3152,223 +3025,7 @@ static struct clk wdt1_fck = {
 	.name		= "wdt1_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
-	.flags		= CLOCK_IN_OMAP343X,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk *onchip_34xx_clks[] __initdata = {
-	&omap_32k_fck,
-	&virt_12m_ck,
-	&virt_13m_ck,
-	&virt_16_8m_ck,
-	&virt_19_2m_ck,
-	&virt_26m_ck,
-	&virt_38_4m_ck,
-	&osc_sys_ck,
-	&sys_ck,
-	&sys_altclk,
-	&mcbsp_clks,
-	&sys_clkout1,
-	&dpll1_ck,
-	&dpll1_x2_ck,
-	&dpll1_x2m2_ck,
-	&dpll2_ck,
-	&dpll2_m2_ck,
-	&dpll3_ck,
-	&core_ck,
-	&dpll3_x2_ck,
-	&dpll3_m2_ck,
-	&dpll3_m2x2_ck,
-	&dpll3_m3_ck,
-	&dpll3_m3x2_ck,
-	&emu_core_alwon_ck,
-	&dpll4_ck,
-	&dpll4_x2_ck,
-	&omap_96m_alwon_fck,
-	&omap_96m_fck,
-	&cm_96m_fck,
-	&virt_omap_54m_fck,
-	&omap_54m_fck,
-	&omap_48m_fck,
-	&omap_12m_fck,
-	&dpll4_m2_ck,
-	&dpll4_m2x2_ck,
-	&dpll4_m3_ck,
-	&dpll4_m3x2_ck,
-	&dpll4_m4_ck,
-	&dpll4_m4x2_ck,
-	&dpll4_m5_ck,
-	&dpll4_m5x2_ck,
-	&dpll4_m6_ck,
-	&dpll4_m6x2_ck,
-	&emu_per_alwon_ck,
-	&dpll5_ck,
-	&dpll5_m2_ck,
-	&omap_120m_fck,
-	&clkout2_src_ck,
-	&sys_clkout2,
-	&corex2_fck,
-	&dpll1_fck,
-	&mpu_ck,
-	&arm_fck,
-	&emu_mpu_alwon_ck,
-	&dpll2_fck,
-	&iva2_ck,
-	&l3_ick,
-	&l4_ick,
-	&rm_ick,
-	&gfx_l3_ck,
-	&gfx_l3_fck,
-	&gfx_l3_ick,
-	&gfx_cg1_ck,
-	&gfx_cg2_ck,
-	&sgx_fck,
-	&sgx_ick,
-	&d2d_26m_fck,
-	&gpt10_fck,
-	&gpt11_fck,
-	&cpefuse_fck,
-	&ts_fck,
-	&usbtll_fck,
-	&core_96m_fck,
-	&mmchs3_fck,
-	&mmchs2_fck,
-	&mspro_fck,
-	&mmchs1_fck,
-	&i2c3_fck,
-	&i2c2_fck,
-	&i2c1_fck,
-	&mcbsp5_fck,
-	&mcbsp1_fck,
-	&core_48m_fck,
-	&mcspi4_fck,
-	&mcspi3_fck,
-	&mcspi2_fck,
-	&mcspi1_fck,
-	&uart2_fck,
-	&uart1_fck,
-	&fshostusb_fck,
-	&core_12m_fck,
-	&hdq_fck,
-	&ssi_ssr_fck,
-	&ssi_sst_fck,
-	&core_l3_ick,
-	&hsotgusb_ick,
-	&sdrc_ick,
-	&gpmc_fck,
-	&security_l3_ick,
-	&pka_ick,
-	&core_l4_ick,
-	&usbtll_ick,
-	&mmchs3_ick,
-	&icr_ick,
-	&aes2_ick,
-	&sha12_ick,
-	&des2_ick,
-	&mmchs2_ick,
-	&mmchs1_ick,
-	&mspro_ick,
-	&hdq_ick,
-	&mcspi4_ick,
-	&mcspi3_ick,
-	&mcspi2_ick,
-	&mcspi1_ick,
-	&i2c3_ick,
-	&i2c2_ick,
-	&i2c1_ick,
-	&uart2_ick,
-	&uart1_ick,
-	&gpt11_ick,
-	&gpt10_ick,
-	&mcbsp5_ick,
-	&mcbsp1_ick,
-	&fac_ick,
-	&mailboxes_ick,
-	&omapctrl_ick,
-	&ssi_l4_ick,
-	&ssi_ick,
-	&usb_l4_ick,
-	&security_l4_ick2,
-	&aes1_ick,
-	&rng_ick,
-	&sha11_ick,
-	&des1_ick,
-	&dss1_alwon_fck,
-	&dss_tv_fck,
-	&dss_96m_fck,
-	&dss2_alwon_fck,
-	&dss_ick,
-	&cam_mclk,
-	&cam_ick,
-	&usbhost_120m_fck,
-	&usbhost_48m_fck,
-	&usbhost_ick,
-	&usbhost_sar_fck,
-	&usim_fck,
-	&gpt1_fck,
-	&wkup_32k_fck,
-	&gpio1_dbck,
-	&wdt2_fck,
-	&wkup_l4_ick,
-	&usim_ick,
-	&wdt2_ick,
-	&wdt1_ick,
-	&gpio1_ick,
-	&omap_32ksync_ick,
-	&gpt12_ick,
-	&gpt1_ick,
-	&per_96m_fck,
-	&per_48m_fck,
-	&uart3_fck,
-	&gpt2_fck,
-	&gpt3_fck,
-	&gpt4_fck,
-	&gpt5_fck,
-	&gpt6_fck,
-	&gpt7_fck,
-	&gpt8_fck,
-	&gpt9_fck,
-	&per_32k_alwon_fck,
-	&gpio6_dbck,
-	&gpio5_dbck,
-	&gpio4_dbck,
-	&gpio3_dbck,
-	&gpio2_dbck,
-	&wdt3_fck,
-	&per_l4_ick,
-	&gpio6_ick,
-	&gpio5_ick,
-	&gpio4_ick,
-	&gpio3_ick,
-	&gpio2_ick,
-	&wdt3_ick,
-	&uart3_ick,
-	&gpt9_ick,
-	&gpt8_ick,
-	&gpt7_ick,
-	&gpt6_ick,
-	&gpt5_ick,
-	&gpt4_ick,
-	&gpt3_ick,
-	&gpt2_ick,
-	&mcbsp2_ick,
-	&mcbsp3_ick,
-	&mcbsp4_ick,
-	&mcbsp2_fck,
-	&mcbsp3_fck,
-	&mcbsp4_fck,
-	&emu_src_ck,
-	&pclk_fck,
-	&pclkx2_fck,
-	&atclk_fck,
-	&traceclk_src_fck,
-	&traceclk_fck,
-	&sr1_fck,
-	&sr2_fck,
-	&sr_l4_ick,
-	&secure_32k_fck,
-	&gpt12_fck,
-	&wdt1_fck,
+	.recalc		= &followparent_recalc,
 };
 
 #endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 9037213..e25e1ac 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -21,6 +21,7 @@ config ARCH_OMAP2
 config ARCH_OMAP3
 	bool "TI OMAP3"
 	select CPU_V7
+	select COMMON_CLKDEV
 
 endchoice
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 214dc46..3895ba7 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -136,10 +136,7 @@ extern const struct clkops clkops_null;
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
-/* bits 13-26 are currently free */
-#define CLOCK_IN_OMAP343X	(1 << 27)	/* clocks common to all 343X */
-#define CLOCK_IN_OMAP3430ES1	(1 << 29)	/* 3430ES1 clocks only */
-#define CLOCK_IN_OMAP3430ES2	(1 << 30)	/* 3430ES2 clocks only */
+/* bits 13-31 are currently free */
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)
-- 
1.6.1.2

