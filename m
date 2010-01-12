From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] AM35xx: Clock table updates for AM3505/17
Date: Mon, 11 Jan 2010 17:46:26 -0700
Message-ID: <20100112004624.24684.52801.stgit@localhost.localdomain>
References: <20100112004326.24684.91321.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55138 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0ALAra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:47:30 -0500
In-Reply-To: <20100112004326.24684.91321.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

AM3505/17 though a OMAP3530 derivative have the following
main differences

	- Removal of the following OMAP3 modules
		- IVA
		- ISP/CAM
		- Modem and D2D components (MAD2D, SAD2D)
		- USIM
		- SSI
		- Mailboxes
		- USB OTG
		- ICR
		- MSPRO
		- SmartReflex
	- SDRC replaced with EMIF4 Controller in the SDRC subsystem
	  thus adding support for DDR2 memory devices
	- Addition of the following new modules
		- Ethernet MAC (CPGMAC)
		- CAN Controller (HECC)
		- New USB OTG Controller with integrated Phy
		- Video Processing Front End (VPFE)
		- Additional UART (UART4)
	- All security accelerators disabled on GP devices and not to
	  be accessed or configured

This patch defines CPU flags for AM3505/17 and update the clock table.
Clock support for new modules will be added by subsequent patches.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
[paul@pwsan.com: updated for 2.6.34 clock layout]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |  353 +++++++++++++++++-----------------
 1 files changed, 180 insertions(+), 173 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 59b0903..409d445 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -2992,139 +2992,140 @@ static struct clk wdt1_fck = {
  * clkdev
  */
 
-static struct omap_clk omap34xx_clks[] = {
-	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X),
-	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X),
-	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X),
-	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
-	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_343X),
-	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_343X),
-	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_343X),
-	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_343X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_343X),
-	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_343X),
-	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_343X),
-	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_343X),
-	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_343X),
-	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_343X),
-	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_343X),
+/* XXX At some point we should rename this file to clock3xxx_data.c */
+static struct omap_clk omap3xxx_clks[] = {
+	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
+	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
+	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_3XXX),
+	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_3XXX),
+	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_3XXX),
+	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_3XXX),
+	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
+	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_3XXX),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
+	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_3XXX),
+	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
+	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_3XXX),
 	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_343X),
 	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_343X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_343X),
-	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
-	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
-	CLK("etb",	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
-	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_343X),
-	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_343X),
-	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_343X),
-	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_343X),
-	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_343X),
-	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_343X),
-	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_343X),
-	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_343X),
-	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
-	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X),
-	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
-	CLK("etb",	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
-	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
-	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
-	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_343X),
-	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_343X),
-	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_343X),
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_343X),
-	CLK(NULL,	"arm_fck",	&arm_fck,	CK_343X),
-	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
+	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_3XXX),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_3XXX),
+	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_3XXX),
+	CLK("etb",	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_3XXX),
+	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_3XXX),
+	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_3XXX),
+	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_3XXX),
+	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_3XXX),
+	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_3XXX),
+	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_3XXX),
+	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_3XXX),
+	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_3XXX),
+	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_3XXX),
+	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_3XXX),
+	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX),
+	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_3XXX),
+	CLK("etb",	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_3XXX),
+	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_3XXX),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_3XXX),
+	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_3XXX),
+	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_3XXX),
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_3XXX),
+	CLK(NULL,	"arm_fck",	&arm_fck,	CK_3XXX),
+	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_3XXX),
 	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
 	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
-	CLK(NULL,	"l3_ick",	&l3_ick,	CK_343X),
-	CLK(NULL,	"l4_ick",	&l4_ick,	CK_343X),
-	CLK(NULL,	"rm_ick",	&rm_ick,	CK_343X),
+	CLK(NULL,	"l3_ick",	&l3_ick,	CK_3XXX),
+	CLK(NULL,	"l4_ick",	&l4_ick,	CK_3XXX),
+	CLK(NULL,	"rm_ick",	&rm_ick,	CK_3XXX),
 	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck,	CK_3430ES1),
 	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck,	CK_3430ES1),
 	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
-	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2),
-	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2),
+	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2 | CK_3517),
+	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2 | CK_3517),
 	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
 	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
 	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
 	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_343X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_343X),
-	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2),
-	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2),
-	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2),
-	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_343X),
-	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2),
-	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_343X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
+	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
+	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_3XXX),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
-	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_343X),
-	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_343X),
-	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_343X),
-	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_343X),
-	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_343X),
-	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_343X),
-	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_343X),
-	CLK("omap2_mcspi.4", "fck",	&mcspi4_fck,	CK_343X),
-	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_343X),
-	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_343X),
-	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_343X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_343X),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_343X),
+	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_3XXX),
+	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_3XXX),
+	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_3XXX),
+	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_3XXX),
+	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_3XXX),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_3XXX),
+	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_3XXX),
+	CLK("omap2_mcspi.4", "fck",	&mcspi4_fck,	CK_3XXX),
+	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_3XXX),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_3XXX),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_3XXX),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_3XXX),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_3XXX),
 	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
-	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_343X),
-	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_343X),
+	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_3XXX),
+	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_3XXX),
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2),
-	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_343X),
+	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_3XXX),
 	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
 	CLK("musb_hdrc",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2),
-	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_343X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_343X),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_3XXX),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_3XXX),
 	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
-	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_343X),
-	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2),
-	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2),
+	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
+	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2 | CK_AM35XX),
+	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
 	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
 	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_343X),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
-	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_343X),
-	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_343X),
+	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_3XXX),
+	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_3XXX),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_343X),
-	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_343X),
-	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_343X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_343X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_343X),
-	CLK("i2c_omap.3", "ick",	&i2c3_ick,	CK_343X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_343X),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_343X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_343X),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_343X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_343X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_343X),
-	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_343X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_343X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_3XXX),
+	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_3XXX),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_3XXX),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_3XXX),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_3XXX),
+	CLK("i2c_omap.3", "ick",	&i2c3_ick,	CK_3XXX),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_3XXX),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_3XXX),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_3XXX),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_3XXX),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_3XXX),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_3XXX),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_3XXX),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_3XXX),
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_3XXX),
 	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
 	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
 	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2),
@@ -3135,83 +3136,83 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
 	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2),
-	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_343X),
-	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_343X),
-	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
+	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
+	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
+	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
+	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
 	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2),
+	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
-	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
-	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
-	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2),
+	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
-	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
-	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
-	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
+	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
+	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
 	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
-	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
-	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_343X),
-	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_343X),
-	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_343X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_343X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_343X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_343X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_343X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_343X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_343X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_343X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_343X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_343X),
-	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_343X),
-	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_343X),
-	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_343X),
-	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
-	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
-	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
-	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
-	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
-	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
-	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
-	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_343X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_343X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_343X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_343X),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_343X),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_343X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_343X),
-	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_343X),
-	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_343X),
-	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_343X),
-	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_343X),
-	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_343X),
-	CLK("etb",	"emu_src_ck",	&emu_src_ck,	CK_343X),
-	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
-	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
-	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_343X),
-	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_343X),
-	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_343X),
+	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
+	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
+	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
+	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
+	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_3XXX),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_3XXX),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_3XXX),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
+	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
+	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
+	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
+	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_3XXX),
+	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_3XXX),
+	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_3XXX),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_3XXX),
+	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_3XXX),
+	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_3XXX),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_3XXX),
+	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_3XXX),
+	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_3XXX),
+	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_3XXX),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_3XXX),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_3XXX),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_3XXX),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_3XXX),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_3XXX),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_3XXX),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_3XXX),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_3XXX),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_3XXX),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_3XXX),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_3XXX),
+	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_3XXX),
+	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_3XXX),
+	CLK("etb",	"emu_src_ck",	&emu_src_ck,	CK_3XXX),
+	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_3XXX),
+	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_3XXX),
+	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_3XXX),
+	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
+	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
 	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_343X),
 	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
-	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
-	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
+	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
+	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
 };
 
 
@@ -3222,7 +3223,13 @@ int __init omap2_clk_init(void)
 	/* u32 clkrate; */
 	u32 cpu_clkflg = CK_3XXX;
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap3517()) {
+		cpu_mask = RATE_IN_343X | RATE_IN_3430ES2;
+		cpu_clkflg |= CK_3517;
+	} else if (cpu_is_omap3505()) {
+		cpu_mask = RATE_IN_343X | RATE_IN_3430ES2;
+		cpu_clkflg |= CK_3505;
+	} else if (cpu_is_omap34xx()) {
 		cpu_mask = RATE_IN_343X;
 		cpu_clkflg |= CK_343X;
 
@@ -3241,10 +3248,10 @@ int __init omap2_clk_init(void)
 
 	clk_init(&omap2_clk_functions);
 
-	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
+	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks); c++)
 		clk_preinit(c->lk.clk);
 
-	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
+	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks); c++)
 		if (c->cpu & cpu_clkflg) {
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);


