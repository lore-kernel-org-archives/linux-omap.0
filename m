From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 2/4] OMAP3: Clock Type change for OMAP3 Clocks
Date: Fri, 20 Nov 2009 20:58:55 +0530
Message-ID: <1258730937-1962-3-git-send-email-vishwanath.bs@ti.com>
References: <1258730937-1962-1-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-2-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbZKTP17 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 10:27:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKFS2KW012811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 09:28:05 -0600
In-Reply-To: <1258730937-1962-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, vishwanath.bs@ti.com

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock.h             |   15 +-
 arch/arm/mach-omap2/clock34xx.c         |  370 +++++++++++++++---------------
 arch/arm/mach-omap2/clock34xx.h         |  158 +++++++-------
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 4 files changed, 274 insertions(+), 271 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 43b6bed..8ceefcc 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -79,20 +79,23 @@ extern u8 cpu_mask;
 
 /* clksel_rate data common to 24xx/343x */
 static const struct clksel_rate gpt_32k_rates[] = {
-	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_3XXX |
+							DEFAULT_RATE },
 	 { .div = 0 }
 };
 
 static const struct clksel_rate gpt_sys_rates[] = {
-	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_3XXX |
+							DEFAULT_RATE },
 	 { .div = 0 }
 };
 
 static const struct clksel_rate gfx_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_3XXX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_3XXX |
+							DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 832ed0b..167f075 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -94,69 +94,69 @@ struct omap_clk {
 		},			\
 	}
 
-#define CK_343X		(1 << 0)
+#define CK_3XXX		(1 << 0)
 #define CK_3430ES1	(1 << 1)
 #define CK_3430ES2	(1 << 2)
 
 static struct omap_clk omap34xx_clks[] = {
-	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_343X),
-	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_343X),
-	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_343X),
+	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
+	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
+	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_3XXX),
 	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2),
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
-	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_343X),
-	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_343X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_343X),
-	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_343X),
-	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_343X),
-	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_343X),
-	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_343X),
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
-	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
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
+	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_3XXX),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_3XXX),
+	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_3XXX),
+	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_3XXX),
+	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_3XXX),
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
+	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_3XXX),
 	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
 	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2),
-	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_343X),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_343X),
-	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_343X),
-	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_343X),
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_343X),
-	CLK(NULL,	"arm_fck",	&arm_fck,	CK_343X),
-	CLK(NULL,	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_343X),
-	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
-	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
-	CLK(NULL,	"l3_ick",	&l3_ick,	CK_343X),
-	CLK(NULL,	"l4_ick",	&l4_ick,	CK_343X),
-	CLK(NULL,	"rm_ick",	&rm_ick,	CK_343X),
+	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_3XXX),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_3XXX),
+	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_3XXX),
+	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_3XXX),
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_3XXX),
+	CLK(NULL,	"arm_fck",	&arm_fck,	CK_3XXX),
+	CLK(NULL,	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_3XXX),
+	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_3XXX),
+	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_3XXX),
+	CLK(NULL,	"l3_ick",	&l3_ick,	CK_3XXX),
+	CLK(NULL,	"l4_ick",	&l4_ick,	CK_3XXX),
+	CLK(NULL,	"rm_ick",	&rm_ick,	CK_3XXX),
 	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck,	CK_3430ES1),
 	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck,	CK_3430ES1),
 	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
@@ -165,159 +165,159 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2),
 	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2),
 	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
-	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
-	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
-	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_343X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_343X),
+	CLK(NULL,	"modem_fck",	&modem_fck,	CK_3XXX),
+	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_3XXX),
+	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_3XXX),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2),
-	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_343X),
+	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2),
-	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_343X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
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
+	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_3XXX),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_3XXX),
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
-	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
-	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_343X),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_3XXX),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_3XXX),
+	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_3XXX),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_3XXX),
+	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2),
 	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2),
-	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
-	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_343X),
-	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_343X),
-	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
-	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_343X),
-	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_343X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
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
+	CLK(NULL,	"icr_ick",	&icr_ick,	CK_3XXX),
+	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_3XXX),
+	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_3XXX),
+	CLK(NULL,	"des2_ick",	&des2_ick,	CK_3XXX),
+	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_3XXX),
+	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_3XXX),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_3XXX),
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
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_343X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_3XXX),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_3XXX),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_3XXX),
 	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
 	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2),
 	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
-	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
-	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
-	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
-	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
+	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_3XXX),
+	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_3XXX),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_3XXX),
+	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_3XXX),
+	CLK(NULL,	"des1_ick",	&des1_ick,	CK_3XXX),
 	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
 	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2),
-	CLK("omapfb",	"tv_fck",	&dss_tv_fck,	CK_343X),
-	CLK("omapfb",	"video_fck",	&dss_96m_fck,	CK_343X),
-	CLK("omapfb",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
+	CLK("omapfb",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
+	CLK("omapfb",	"video_fck",	&dss_96m_fck,	CK_3XXX),
+	CLK("omapfb",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
 	CLK("omapfb",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
 	CLK("omapfb",	"ick",		&dss_ick_3430es2,	CK_3430ES2),
-	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
-	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
+	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_3XXX),
+	CLK(NULL,	"cam_ick",	&cam_ick,	CK_3XXX),
+	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_3XXX),
 	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
-	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
-	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
-	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
-	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
+	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
+	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
+	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_3XXX),
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
-	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_343X),
-	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_343X),
-	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_343X),
-	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_343X),
-	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_343X),
-	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_343X),
-	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_343X),
-	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
-	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
-	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
-	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
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
+	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_3XXX),
+	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_3XXX),
+	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_3XXX),
+	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_3XXX),
+	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
+	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
+	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_3XXX),
+	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_3XXX),
+	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_3XXX),
+	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
+	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
 };
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
@@ -1202,8 +1202,8 @@ int __init omap2_clk_init(void)
 	u32 cpu_clkflg;
 
 	if (cpu_is_omap34xx()) {
-		cpu_mask = RATE_IN_343X;
-		cpu_clkflg = CK_343X;
+		cpu_mask = RATE_IN_3XXX;
+		cpu_clkflg = CK_3XXX;
 
 		/*
 		 * Update this if there are further clock changes between ES2
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a1b3de7..813a83e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -120,12 +120,12 @@ static struct clk virt_38_4m_ck = {
 };
 
 static const struct clksel_rate osc_sys_12m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_13m_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -135,17 +135,17 @@ static const struct clksel_rate osc_sys_16_8m_rates[] = {
 };
 
 static const struct clksel_rate osc_sys_19_2m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_26m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate osc_sys_38_4m_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 4, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -174,8 +174,8 @@ static struct clk osc_sys_ck = {
 };
 
 static const struct clksel_rate div2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -224,22 +224,22 @@ static struct clk sys_clkout1 = {
 /* CM CLOCKS */
 
 static const struct clksel_rate div16_dpll_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 5, .val = 5, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 7, .val = 7, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
-	{ .div = 9, .val = 9, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 10, .flags = RATE_IN_343X },
-	{ .div = 11, .val = 11, .flags = RATE_IN_343X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_343X },
-	{ .div = 13, .val = 13, .flags = RATE_IN_343X },
-	{ .div = 14, .val = 14, .flags = RATE_IN_343X },
-	{ .div = 15, .val = 15, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3XXX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_3XXX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_3XXX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_3XXX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_3XXX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_3XXX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_3XXX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -425,8 +425,8 @@ static struct clk dpll3_x2_ck = {
 };
 
 static const struct clksel_rate div31_dpll3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2 },
 	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2 },
 	{ .div = 5, .val = 5, .flags = RATE_IN_3430ES2 },
@@ -634,12 +634,12 @@ static struct clk cm_96m_fck = {
 };
 
 static const struct clksel_rate omap_96m_dpll_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_96m_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -687,12 +687,12 @@ static struct clk dpll4_m3x2_ck = {
 };
 
 static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_54m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -713,12 +713,12 @@ static struct clk omap_54m_fck = {
 };
 
 static const struct clksel_rate omap_48m_cm96m_rates[] = {
-	{ .div = 2, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate omap_48m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -890,22 +890,22 @@ static struct clk dpll5_m2_ck = {
 /* CM EXTERNAL CLOCK OUTPUTS */
 
 static const struct clksel_rate clkout2_src_core_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_96m_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate clkout2_src_54m_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -931,11 +931,11 @@ static struct clk clkout2_src_ck = {
 };
 
 static const struct clksel_rate sys_clkout2_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -966,9 +966,9 @@ static struct clk corex2_fck = {
 /* DPLL power domain clock controls */
 
 static const struct clksel_rate div4_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -1002,8 +1002,8 @@ static struct clk mpu_ck = {
 
 /* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu_ck */
 static const struct clksel_rate arm_fck_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -1175,14 +1175,14 @@ static struct clk gfx_cg2_ck = {
 /* SGX power domain - 3430ES2 only */
 
 static const struct clksel_rate sgx_core_rates[] = {
-	{ .div = 3, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 4, .val = 1, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 3, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 4, .val = 1, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 2, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate sgx_96m_rates[] = {
-	{ .div = 1,  .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1,  .val = 3, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 },
 };
 
@@ -1408,12 +1408,12 @@ static struct clk i2c1_fck = {
  * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
  */
 static const struct clksel_rate common_mcbsp_96m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
 static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
@@ -1550,12 +1550,12 @@ static struct clk hdq_fck = {
 /* DPLL3-derived clock */
 
 static const struct clksel_rate ssi_ssr_corex2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3XXX },
 	{ .div = 0 }
 };
 
@@ -2200,18 +2200,18 @@ static struct clk usbhost_ick = {
 /* WKUP */
 
 static const struct clksel_rate usim_96m_rates[] = {
-	{ .div = 2,  .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 4,  .val = 4, .flags = RATE_IN_343X },
-	{ .div = 8,  .val = 5, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 2,  .val = 3, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 4,  .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 8,  .val = 5, .flags = RATE_IN_3XXX },
+	{ .div = 10, .val = 6, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate usim_120m_rates[] = {
-	{ .div = 4,  .val = 7,	.flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 8,  .val = 8,	.flags = RATE_IN_343X },
-	{ .div = 16, .val = 9,	.flags = RATE_IN_343X },
-	{ .div = 20, .val = 10, .flags = RATE_IN_343X },
+	{ .div = 4,  .val = 7,	.flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 8,  .val = 8,	.flags = RATE_IN_3XXX },
+	{ .div = 16, .val = 9,	.flags = RATE_IN_3XXX },
+	{ .div = 20, .val = 10, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -2804,22 +2804,22 @@ static struct clk mcbsp4_fck = {
 /* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 */
 
 static const struct clksel_rate emu_src_sys_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_per_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 2, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 },
 };
 
 static const struct clksel_rate emu_src_mpu_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 1, .val = 3, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 0 },
 };
 
@@ -2848,10 +2848,10 @@ static struct clk emu_src_ck = {
 };
 
 static const struct clksel_rate pclk_emu_rates[] = {
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -2872,9 +2872,9 @@ static struct clk pclk_fck = {
 };
 
 static const struct clksel_rate pclkx2_emu_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
@@ -2922,9 +2922,9 @@ static struct clk traceclk_src_fck = {
 };
 
 static const struct clksel_rate traceclk_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
 };
 
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 66648d4..359ccb4 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -157,7 +157,7 @@ extern const struct clkops clkops_null;
 #define DEFAULT_RATE		(1 << 0)
 #define RATE_IN_242X		(1 << 1)
 #define RATE_IN_243X		(1 << 2)
-#define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
+#define RATE_IN_3XXX		(1 << 3)	/* rates common to all 343X */
 #define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
-- 
1.5.6.3

