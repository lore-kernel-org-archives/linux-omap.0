From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: clocks: Pass static parent pointers to common clock core
Date: Thu, 14 Mar 2013 18:06:58 +0530
Message-ID: <1363264618-5071-3-git-send-email-rnayak@ti.com>
References: <1363264618-5071-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab3CNMkX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 08:40:23 -0400
In-Reply-To: <1363264618-5071-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, Rajendra Nayak <rnayak@ti.com>

OMAP clock inits happen quite early, even before the slab is available.
As part of the clock init, the common clock core tries to cache parent
pointers (if not passed by the caller registering the clock) which
fails in case of OMAP since the slab isn't initied.
Without CONFIG_DEBUG_SLAB enabled, this just results in the common clock core
retrying the caching attempt at some point later.
However with CONFIG_DEBUG_SLAB enabled this results in a BUG() as reported
in the link below by Tony..
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85932.html

Fix this by passing static parent pointers to the common clock core
while registering clocks.

Reported-by: Piotr Haber <phaber@broadcom.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cclock2420_data.c |   56 +++++++-
 arch/arm/mach-omap2/cclock2430_data.c |   56 +++++++-
 arch/arm/mach-omap2/cclock33xx_data.c |   74 ++++++++---
 arch/arm/mach-omap2/cclock3xxx_data.c |   79 +++++++++--
 arch/arm/mach-omap2/cclock44xx_data.c |  236 ++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/clock.h           |   15 ++-
 6 files changed, 436 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 4b89559..727a6dd 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -296,6 +296,10 @@ static const char *dsp_fck_parents[] = {
 	"core_ck",
 };
 
+static struct clk *dsp_fck_parents_ptr[] = {
+	&core_ck,
+};
+
 static const struct clk_ops dsp_fck_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
@@ -322,6 +326,10 @@ static const char *dsp_ick_parents[] = {
 	"dsp_fck",
 };
 
+static struct clk *dsp_ick_parents_ptr[] = {
+	&dsp_fck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(dsp_ick, "dsp_clkdm", dsp_ick_clksel,
 			 OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 			 OMAP24XX_CLKSEL_DSP_IF_MASK,
@@ -358,6 +366,10 @@ static const char *dss1_fck_parents[] = {
 	"sys_ck", "core_ck",
 };
 
+static struct clk *dss1_fck_parents_ptr[] = {
+	&sys_ck, &core_ck,
+};
+
 static struct clk dss1_fck;
 
 static const struct clk_ops dss1_fck_ops = {
@@ -407,6 +419,10 @@ static const char *func_48m_ck_parents[] = {
 	"apll96_ck", "alt_ck",
 };
 
+static struct clk *func_48m_ck_parents_ptr[] = {
+	&apll96_ck, &alt_ck,
+};
+
 static struct clk func_48m_ck;
 
 static const struct clk_ops func_48m_ck_ops = {
@@ -428,7 +444,7 @@ static struct clk_hw_omap func_48m_ck_hw = {
 	.clkdm_name	= "wkup_clkdm",
 };
 
-DEFINE_STRUCT_CLK(func_48m_ck, func_48m_ck_parents, func_48m_ck_ops);
+DEFINE_STRUCT_CLK_MUX(func_48m_ck, func_48m_ck_parents, func_48m_ck_ops);
 
 static const struct clksel dss2_fck_clksel[] = {
 	{ .parent = &sys_ck, .rates = dss2_fck_sys_rates },
@@ -440,6 +456,10 @@ static const char *dss2_fck_parents[] = {
 	"sys_ck", "func_48m_ck",
 };
 
+static struct clk *dss2_fck_parents_ptr[] = {
+	&sys_ck, &func_48m_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(dss2_fck, "dss_clkdm", dss2_fck_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 			 OMAP24XX_CLKSEL_DSS2_MASK,
@@ -451,7 +471,11 @@ static const char *func_54m_ck_parents[] = {
 	"apll54_ck", "alt_ck",
 };
 
-DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parents, NULL, 0x0,
+static struct clk *func_54m_ck_parents_ptr[] = {
+	&apll54_ck, &alt_ck,
+};
+
+DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parents, func_54m_ck_parents_ptr, 0x0,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP24XX_54M_SOURCE_SHIFT, OMAP24XX_54M_SOURCE_WIDTH,
 	       0x0, NULL);
@@ -572,6 +596,10 @@ static const char *gfx_2d_fck_parents[] = {
 	"core_l3_ck",
 };
 
+static struct clk *gfx_2d_fck_parents_ptr[] = {
+	&core_l3_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(gfx_2d_fck, "gfx_clkdm", gfx_fck_clksel,
 			 OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 			 OMAP_CLKSEL_GFX_MASK,
@@ -671,6 +699,10 @@ static const char *gpt10_fck_parents[] = {
 	"func_32k_ck", "sys_ck", "alt_ck",
 };
 
+static struct clk  *gpt10_fck_parents_ptr[] = {
+	&func_32k_ck, &sys_ck, &alt_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(gpt10_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 			 OMAP24XX_CLKSEL_GPT10_MASK,
@@ -1088,6 +1120,10 @@ static const char *mcbsp1_fck_parents[] = {
 	"func_96m_ck", "mcbsp_clks",
 };
 
+static struct clk *mcbsp1_fck_parents_ptr[] = {
+	&func_96m_ck, &mcbsp_clks,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP242X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 			 OMAP2_MCBSP1_CLKS_MASK,
@@ -1403,6 +1439,10 @@ static const char *ssi_ssr_sst_fck_parents[] = {
 	"core_ck",
 };
 
+static struct clk *ssi_ssr_sst_fck_parents_ptr[] = {
+	&core_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(ssi_ssr_sst_fck, "core_l3_clkdm",
 			 ssi_ssr_sst_fck_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1458,6 +1498,10 @@ static const char *sys_clkout_src_parents[] = {
 	"core_ck", "sys_ck", "func_96m_ck", "func_54m_ck",
 };
 
+static struct clk *sys_clkout_src_parents_ptr[] = {
+	&core_ck, &sys_ck, &func_96m_ck, &func_54m_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(sys_clkout_src, "wkup_clkdm", common_clkout_src_clksel,
 			 OMAP2420_PRCM_CLKOUT_CTRL, OMAP24XX_CLKOUT_SOURCE_MASK,
 			 OMAP2420_PRCM_CLKOUT_CTRL, OMAP24XX_CLKOUT_EN_SHIFT,
@@ -1591,6 +1635,10 @@ static const char *usb_l4_ick_parents[] = {
 	"core_l3_ck",
 };
 
+static struct clk *usb_l4_ick_parents_ptr[] = {
+	&core_l3_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(usb_l4_ick, "core_l4_clkdm", usb_l4_ick_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 			 OMAP24XX_CLKSEL_USB_MASK,
@@ -1642,6 +1690,10 @@ static const char *vlynq_fck_parents[] = {
 	"func_96m_ck", "core_ck",
 };
 
+static struct clk *vlynq_fck_parents_ptr[] = {
+	&func_96m_ck, &core_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(vlynq_fck, "core_l3_clkdm", vlynq_fck_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 			 OMAP2420_CLKSEL_VLYNQ_MASK,
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index 0da6e31..d5c909c 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -226,7 +226,11 @@ static const char *func_96m_ck_parents[] = {
 	"apll96_ck", "alt_ck",
 };
 
-DEFINE_CLK_MUX(func_96m_ck, func_96m_ck_parents, NULL, 0x0,
+static struct clk *func_96m_ck_parents_ptr[] = {
+	&apll96_ck, &alt_ck,
+};
+
+DEFINE_CLK_MUX(func_96m_ck, func_96m_ck_parents, func_96m_ck_parents_ptr, 0x0,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1), OMAP2430_96M_SOURCE_SHIFT,
 	       OMAP2430_96M_SOURCE_WIDTH, 0x0, NULL);
 
@@ -292,6 +296,10 @@ static const char *dsp_fck_parents[] = {
 	"core_ck",
 };
 
+static struct clk *dsp_fck_parents_ptr[] = {
+	&core_ck,
+};
+
 static struct clk dsp_fck;
 
 static const struct clk_ops dsp_fck_ops = {
@@ -340,6 +348,10 @@ static const char *dss1_fck_parents[] = {
 	"sys_ck", "core_ck",
 };
 
+static struct clk *dss1_fck_parents_ptr[] = {
+	&sys_ck, &core_ck,
+};
+
 static const struct clk_ops dss1_fck_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
@@ -420,6 +432,10 @@ static const char *dss2_fck_parents[] = {
 	"sys_ck", "func_48m_ck",
 };
 
+static struct clk *dss2_fck_parents_ptr[] = {
+	&sys_ck, &func_48m_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(dss2_fck, "dss_clkdm", dss2_fck_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 			 OMAP24XX_CLKSEL_DSS2_MASK,
@@ -431,7 +447,11 @@ static const char *func_54m_ck_parents[] = {
 	"apll54_ck", "alt_ck",
 };
 
-DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parents, NULL, 0x0,
+static struct clk *func_54m_ck_parents_ptr[] = {
+	&apll54_ck, &alt_ck,
+};
+
+DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parents, func_54m_ck_parents_ptr, 0x0,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP24XX_54M_SOURCE_SHIFT, OMAP24XX_54M_SOURCE_WIDTH, 0x0, NULL);
 
@@ -523,6 +543,10 @@ static const char *gfx_2d_fck_parents[] = {
 	"core_l3_ck",
 };
 
+static struct clk *gfx_2d_fck_parents_ptr[] = {
+	&core_l3_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(gfx_2d_fck, "gfx_clkdm", gfx_fck_clksel,
 			 OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 			 OMAP_CLKSEL_GFX_MASK,
@@ -650,6 +674,10 @@ static const char *gpt10_fck_parents[] = {
 	"func_32k_ck", "sys_ck", "alt_ck",
 };
 
+static struct clk *gpt10_fck_parents_ptr[] = {
+	&func_32k_ck, &sys_ck, &alt_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(gpt10_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 			 OMAP24XX_CLKSEL_GPT10_MASK,
@@ -1023,6 +1051,10 @@ static const char *iva2_1_ick_parents[] = {
 	"dsp_fck",
 };
 
+static struct clk *iva2_1_ick_parents_ptr[] = {
+	&dsp_fck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(iva2_1_ick, "dsp_clkdm", dsp_ick_clksel,
 			 OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 			 OMAP24XX_CLKSEL_DSP_IF_MASK,
@@ -1064,6 +1096,10 @@ static const char *mcbsp1_fck_parents[] = {
 	"func_96m_ck", "mcbsp_clks",
 };
 
+static struct clk *mcbsp1_fck_parents_ptr[] = {
+	&func_96m_ck, &mcbsp_clks,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP243X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 			 OMAP2_MCBSP1_CLKS_MASK,
@@ -1274,6 +1310,10 @@ static const char *mdm_ick_parents[] = {
 	"core_ck",
 };
 
+static struct clk *mdm_ick_parents_ptr[] = {
+	&core_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(mdm_ick, "mdm_clkdm", mdm_ick_clksel,
 			 OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
 			 OMAP2430_CLKSEL_MDM_MASK,
@@ -1578,6 +1618,10 @@ static const char *ssi_ssr_sst_fck_parents[] = {
 	"core_ck",
 };
 
+static struct clk *ssi_ssr_sst_fck_parents_ptr[] = {
+	&core_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(ssi_ssr_sst_fck, "core_l3_clkdm",
 			 ssi_ssr_sst_fck_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
@@ -1633,6 +1677,10 @@ static const char *sys_clkout_src_parents[] = {
 	"core_ck", "sys_ck", "func_96m_ck", "func_54m_ck",
 };
 
+static struct clk *sys_clkout_src_parents_ptr[] = {
+	&core_ck, &sys_ck, &func_96m_ck, &func_54m_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(sys_clkout_src, "wkup_clkdm", common_clkout_src_clksel,
 			 OMAP2430_PRCM_CLKOUT_CTRL, OMAP24XX_CLKOUT_SOURCE_MASK,
 			 OMAP2430_PRCM_CLKOUT_CTRL, OMAP24XX_CLKOUT_EN_SHIFT,
@@ -1756,6 +1804,10 @@ static const char *usb_l4_ick_parents[] = {
 	"core_l3_ck",
 };
 
+static struct clk *usb_l4_ick_parents_ptr[] = {
+	&core_l3_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(usb_l4_ick, "core_l4_clkdm", usb_l4_ick_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 			 OMAP24XX_CLKSEL_USB_MASK,
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 476b820..e4ec7a1 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -60,13 +60,18 @@ static const char *sys_clkin_ck_parents[] = {
 	"virt_26000000_ck",
 };
 
+static struct clk *sys_clkin_ck_parents_ptr[] = {
+	&virt_19200000_ck, &virt_24000000_ck, &virt_25000000_ck,
+	&virt_26000000_ck,
+};
+
 /*
  * sys_clk in: input to the dpll and also used as funtional clock for,
  *   adc_tsc, smartreflex0-1, timer1-7, mcasp0-1, dcan0-1, cefuse
  *
  */
-DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
-	       AM33XX_CTRL_REGADDR(AM33XX_CONTROL_STATUS),
+DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, sys_clkin_ck_parents_ptr,
+	       0x0, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_STATUS),
 	       AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT,
 	       AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH,
 	       0, NULL);
@@ -474,6 +479,11 @@ static const char *timer1_ck_parents[] = {
 	"clk_32768_ck",
 };
 
+static struct clk *timer1_ck_parents_ptr[] = {
+	&sys_clkin_ck, &clkdiv32k_ick, &tclkin_ck, &clk_rc32k_ck,
+	&clk_32768_ck,
+};
+
 static struct clk timer1_fck;
 
 static const struct clk_ops timer1_fck_ops = {
@@ -493,7 +503,7 @@ static struct clk_hw_omap timer1_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_2_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer1_fck, timer1_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer1_fck, timer1_ck_parents, timer1_fck_ops);
 
 static const struct clksel timer2_to_7_clk_sel[] = {
 	{ .parent = &tclkin_ck, .rates = div_1_0_rates },
@@ -506,6 +516,10 @@ static const char *timer2_to_7_ck_parents[] = {
 	"tclkin_ck", "sys_clkin_ck", "clkdiv32k_ick",
 };
 
+static struct clk *timer2_to_7_ck_parents_ptr[] = {
+	&tclkin_ck, &sys_clkin_ck, &clkdiv32k_ick,
+};
+
 static struct clk timer2_fck;
 
 static struct clk_hw_omap timer2_fck_hw = {
@@ -518,7 +532,7 @@ static struct clk_hw_omap timer2_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer2_fck, timer2_to_7_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer2_fck, timer2_to_7_ck_parents, timer1_fck_ops);
 
 static struct clk timer3_fck;
 
@@ -532,7 +546,7 @@ static struct clk_hw_omap timer3_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer3_fck, timer2_to_7_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer3_fck, timer2_to_7_ck_parents, timer1_fck_ops);
 
 static struct clk timer4_fck;
 
@@ -546,7 +560,7 @@ static struct clk_hw_omap timer4_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer4_fck, timer2_to_7_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer4_fck, timer2_to_7_ck_parents, timer1_fck_ops);
 
 static struct clk timer5_fck;
 
@@ -560,7 +574,7 @@ static struct clk_hw_omap timer5_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer5_fck, timer2_to_7_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer5_fck, timer2_to_7_ck_parents, timer1_fck_ops);
 
 static struct clk timer6_fck;
 
@@ -574,7 +588,7 @@ static struct clk_hw_omap timer6_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer6_fck, timer2_to_7_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer6_fck, timer2_to_7_ck_parents, timer1_fck_ops);
 
 static struct clk timer7_fck;
 
@@ -588,7 +602,7 @@ static struct clk_hw_omap timer7_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(timer7_fck, timer2_to_7_ck_parents, timer1_fck_ops);
+DEFINE_STRUCT_CLK_MUX(timer7_fck, timer2_to_7_ck_parents, timer1_fck_ops);
 
 DEFINE_CLK_FIXED_FACTOR(cpsw_125mhz_gclk,
 			"dpll_core_m5_ck",
@@ -612,6 +626,9 @@ static const char *cpsw_cpts_rft_ck_parents[] = {
 	"dpll_core_m5_ck", "dpll_core_m4_ck",
 };
 
+static struct clk *cpsw_cpts_rft_ck_parents_ptr[] = {
+	&dpll_core_m5_ck, &dpll_core_m4_ck,
+};
 static struct clk cpsw_cpts_rft_clk;
 
 static struct clk_hw_omap cpsw_cpts_rft_clk_hw = {
@@ -624,14 +641,18 @@ static struct clk_hw_omap cpsw_cpts_rft_clk_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_0_MASK,
 };
 
-DEFINE_STRUCT_CLK(cpsw_cpts_rft_clk, cpsw_cpts_rft_ck_parents, cpsw_fck_ops);
-
+DEFINE_STRUCT_CLK_MUX(cpsw_cpts_rft_clk, cpsw_cpts_rft_ck_parents,
+		      cpsw_fck_ops);
 
 /* gpio */
 static const char *gpio0_ck_parents[] = {
 	"clk_rc32k_ck", "clk_32768_ck", "clkdiv32k_ick",
 };
 
+static struct clk *gpio0_ck_parents_ptr[] = {
+	&clk_rc32k_ck, &clk_32768_ck, &clkdiv32k_ick,
+};
+
 static const struct clksel gpio0_dbclk_mux_sel[] = {
 	{ .parent = &clk_rc32k_ck, .rates = div_1_0_rates },
 	{ .parent = &clk_32768_ck, .rates = div_1_1_rates },
@@ -658,7 +679,7 @@ static struct clk_hw_omap gpio0_dbclk_mux_ck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(gpio0_dbclk_mux_ck, gpio0_ck_parents, gpio_fck_ops);
+DEFINE_STRUCT_CLK_MUX(gpio0_dbclk_mux_ck, gpio0_ck_parents, gpio_fck_ops);
 
 DEFINE_CLK_GATE(gpio0_dbclk, "gpio0_dbclk_mux_ck", &gpio0_dbclk_mux_ck, 0x0,
 		AM33XX_CM_WKUP_GPIO0_CLKCTRL,
@@ -681,6 +702,10 @@ static const char *pruss_ck_parents[] = {
 	"l3_gclk", "dpll_disp_m2_ck",
 };
 
+static struct clk *pruss_ck_parents_ptr[] = {
+	&l3_gclk, &dpll_disp_m2_ck,
+};
+
 static const struct clksel pruss_ocp_clk_mux_sel[] = {
 	{ .parent = &l3_gclk, .rates = div_1_0_rates },
 	{ .parent = &dpll_disp_m2_ck, .rates = div_1_1_rates },
@@ -699,12 +724,16 @@ static struct clk_hw_omap pruss_ocp_gclk_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_0_MASK,
 };
 
-DEFINE_STRUCT_CLK(pruss_ocp_gclk, pruss_ck_parents, gpio_fck_ops);
+DEFINE_STRUCT_CLK_MUX(pruss_ocp_gclk, pruss_ck_parents, gpio_fck_ops);
 
 static const char *lcd_ck_parents[] = {
 	"dpll_disp_m2_ck", "dpll_core_m5_ck", "dpll_per_m2_ck",
 };
 
+static struct clk *lcd_ck_parents_ptr[] = {
+	&dpll_disp_m2_ck, &dpll_core_m5_ck, &dpll_per_m2_ck,
+};
+
 static const struct clksel lcd_clk_mux_sel[] = {
 	{ .parent = &dpll_disp_m2_ck, .rates = div_1_0_rates },
 	{ .parent = &dpll_core_m5_ck, .rates = div_1_1_rates },
@@ -733,6 +762,10 @@ static const char *gfx_ck_parents[] = {
 	"dpll_core_m4_ck", "dpll_per_m2_ck",
 };
 
+static struct clk *gfx_ck_parents_ptr[] = {
+	&dpll_core_m4_ck, &dpll_per_m2_ck,
+};
+
 static const struct clksel gfx_clksel_sel[] = {
 	{ .parent = &dpll_core_m4_ck, .rates = div_1_0_rates },
 	{ .parent = &dpll_per_m2_ck, .rates = div_1_1_rates },
@@ -750,7 +783,7 @@ static struct clk_hw_omap gfx_fclk_clksel_ck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_GFX_FCLK_MASK,
 };
 
-DEFINE_STRUCT_CLK(gfx_fclk_clksel_ck, gfx_ck_parents, gpio_fck_ops);
+DEFINE_STRUCT_CLK_MUX(gfx_fclk_clksel_ck, gfx_ck_parents, gpio_fck_ops);
 
 static const struct clk_div_table div_1_0_2_1_rates[] = {
 	{ .div = 1, .val = 0, },
@@ -768,6 +801,11 @@ static const char *sysclkout_ck_parents[] = {
 	"lcd_gclk",
 };
 
+static struct clk *sysclkout_ck_parents_ptr[] = {
+	&clk_32768_ck, &l3_gclk, &dpll_ddr_m2_ck, &dpll_per_m2_ck,
+	&lcd_gclk,
+};
+
 static const struct clksel sysclkout_pre_sel[] = {
 	{ .parent = &clk_32768_ck, .rates = div_1_0_rates },
 	{ .parent = &l3_gclk, .rates = div_1_1_rates },
@@ -788,7 +826,7 @@ static struct clk_hw_omap sysclkout_pre_ck_hw = {
 	.clksel_mask	= AM33XX_CLKOUT2SOURCE_MASK,
 };
 
-DEFINE_STRUCT_CLK(sysclkout_pre_ck, sysclkout_ck_parents, gpio_fck_ops);
+DEFINE_STRUCT_CLK_MUX(sysclkout_pre_ck, sysclkout_ck_parents, gpio_fck_ops);
 
 /* Divide by 8 clock rates with default clock is 1/1*/
 static const struct clk_div_table div8_rates[] = {
@@ -814,6 +852,10 @@ static const char *wdt_ck_parents[] = {
 	"clk_rc32k_ck", "clkdiv32k_ick",
 };
 
+static struct clk *wdt_ck_parents_ptr[] = {
+	&clk_rc32k_ck, &clkdiv32k_ick,
+};
+
 static const struct clksel wdt_clkmux_sel[] = {
 	{ .parent = &clk_rc32k_ck, .rates = div_1_0_rates },
 	{ .parent = &clkdiv32k_ick, .rates = div_1_1_rates },
@@ -832,7 +874,7 @@ static struct clk_hw_omap wdt1_fck_hw = {
 	.clksel_mask	= AM33XX_CLKSEL_0_1_MASK,
 };
 
-DEFINE_STRUCT_CLK(wdt1_fck, wdt_ck_parents, gpio_fck_ops);
+DEFINE_STRUCT_CLK_MUX(wdt1_fck, wdt_ck_parents, gpio_fck_ops);
 
 /*
  * clkdev
diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 9aa308b..8c1d2f5 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -78,7 +78,12 @@ static const char *osc_sys_ck_parents[] = {
 	"virt_38_4m_ck", "virt_16_8m_ck",
 };
 
-DEFINE_CLK_MUX(osc_sys_ck, osc_sys_ck_parents, NULL, 0x0,
+static struct clk *osc_sys_ck_parents_ptr[] = {
+	&virt_12m_ck, &virt_13m_ck, &virt_19200000_ck, &virt_26000000_ck,
+	&virt_38_4m_ck, &virt_16_8m_ck,
+};
+
+DEFINE_CLK_MUX(osc_sys_ck, osc_sys_ck_parents, osc_sys_ck_parents_ptr, 0x0,
 	       OMAP3430_PRM_CLKSEL, OMAP3430_SYS_CLKIN_SEL_SHIFT,
 	       OMAP3430_SYS_CLKIN_SEL_WIDTH, 0x0, NULL);
 
@@ -560,9 +565,13 @@ static const char *omap_54m_fck_parents[] = {
 	"dpll4_m3x2_ck", "sys_altclk",
 };
 
-DEFINE_CLK_MUX(omap_54m_fck, omap_54m_fck_parents, NULL, 0x0,
-	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1), OMAP3430_SOURCE_54M_SHIFT,
-	       OMAP3430_SOURCE_54M_WIDTH, 0x0, NULL);
+static struct clk *omap_54m_fck_parents_ptr[] = {
+	&dpll4_m3x2_ck, &sys_altclk,
+};
+
+DEFINE_CLK_MUX(omap_54m_fck, omap_54m_fck_parents, omap_54m_fck_parents_ptr,
+	       0x0, OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	       OMAP3430_SOURCE_54M_SHIFT, OMAP3430_SOURCE_54M_WIDTH, 0x0, NULL);
 
 static const struct clksel clkout2_src_clksel[] = {
 	{ .parent = &core_ck, .rates = clkout2_src_core_rates },
@@ -576,6 +585,10 @@ static const char *clkout2_src_ck_parents[] = {
 	"core_ck", "sys_ck", "cm_96m_fck", "omap_54m_fck",
 };
 
+static struct clk *clkout2_src_ck_parents_ptr[] = {
+	&core_ck, &sys_ck, &cm_96m_fck, &omap_54m_fck,
+};
+
 static const struct clk_ops clkout2_src_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
@@ -612,6 +625,10 @@ static const char *omap_48m_fck_parents[] = {
 	"cm_96m_fck", "sys_altclk",
 };
 
+static struct clk *omap_48m_fck_parents_ptr[] = {
+	&cm_96m_fck, &sys_altclk,
+};
+
 static struct clk omap_48m_fck;
 
 static const struct clk_ops omap_48m_fck_ops = {
@@ -629,7 +646,7 @@ static struct clk_hw_omap omap_48m_fck_hw = {
 	.clksel_mask	= OMAP3430_SOURCE_48M_MASK,
 };
 
-DEFINE_STRUCT_CLK(omap_48m_fck, omap_48m_fck_parents, omap_48m_fck_ops);
+DEFINE_STRUCT_CLK_MUX(omap_48m_fck, omap_48m_fck_parents, omap_48m_fck_ops);
 
 DEFINE_CLK_FIXED_FACTOR(omap_12m_fck, "omap_48m_fck", &omap_48m_fck, 0x0, 1, 4);
 
@@ -655,8 +672,12 @@ static const char *omap_96m_fck_parents[] = {
 	"cm_96m_fck", "sys_ck",
 };
 
-DEFINE_CLK_MUX(omap_96m_fck, omap_96m_fck_parents, NULL, 0x0,
-	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+static struct clk *omap_96m_fck_parents_ptr[] = {
+	&cm_96m_fck, &sys_ck,
+};
+
+DEFINE_CLK_MUX(omap_96m_fck, omap_96m_fck_parents, omap_96m_fck_parents_ptr,
+	       0x0, OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP3430_SOURCE_96M_SHIFT, OMAP3430_SOURCE_96M_WIDTH, 0x0, NULL);
 
 static struct clk core_96m_fck;
@@ -665,8 +686,12 @@ static const char *core_96m_fck_parents[] = {
 	"omap_96m_fck",
 };
 
+static struct clk *core_96m_fck_parents_ptr[] = {
+	&omap_96m_fck,
+};
+
 DEFINE_STRUCT_CLK_HW_OMAP(core_96m_fck, "core_l4_clkdm");
-DEFINE_STRUCT_CLK(core_96m_fck, core_96m_fck_parents, core_l4_ick_ops);
+DEFINE_STRUCT_CLK_MUX(core_96m_fck, core_96m_fck_parents, core_l4_ick_ops);
 
 static struct clk core_l3_ick;
 
@@ -1142,6 +1167,10 @@ static const char *emu_src_ck_parents[] = {
 	"sys_ck", "emu_core_alwon_ck", "emu_per_alwon_ck", "emu_mpu_alwon_ck",
 };
 
+static struct clk *emu_src_ck_parents_ptr[] = {
+	&sys_ck, &emu_core_alwon_ck, &emu_per_alwon_ck, &emu_mpu_alwon_ck,
+};
+
 static const struct clksel_rate emu_src_sys_rates[] = {
 	{ .div = 1, .val = 0, .flags = RATE_IN_3XXX },
 	{ .div = 0 },
@@ -1191,7 +1220,7 @@ static struct clk_hw_omap emu_src_ck_hw = {
 	.clkdm_name	= "emu_clkdm",
 };
 
-DEFINE_STRUCT_CLK(emu_src_ck, emu_src_ck_parents, emu_src_ck_ops);
+DEFINE_STRUCT_CLK_MUX(emu_src_ck, emu_src_ck_parents, emu_src_ck_ops);
 
 DEFINE_CLK_DIVIDER(atclk_fck, "emu_src_ck", &emu_src_ck, 0x0,
 		   OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
@@ -1515,6 +1544,10 @@ static const char *gpt10_fck_parents[] = {
 	"omap_32k_fck", "sys_ck",
 };
 
+static struct clk *gpt10_fck_parents_ptr[] = {
+	&omap_32k_fck, &sys_ck,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(gpt10_fck, "core_l4_clkdm", omap343x_gpt_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 			 OMAP3430_CLKSEL_GPT10_MASK,
@@ -2034,6 +2067,10 @@ static const char *mcbsp1_fck_parents[] = {
 	"core_96m_fck", "mcbsp_clks",
 };
 
+static struct clk *mcbsp1_fck_parents_ptr[] = {
+	&core_96m_fck, &mcbsp_clks,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "core_l4_clkdm", mcbsp_15_clksel,
 			 OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 			 OMAP2_MCBSP1_CLKS_MASK,
@@ -2070,6 +2107,10 @@ static const char *mcbsp2_fck_parents[] = {
 	"per_96m_fck", "mcbsp_clks",
 };
 
+static struct clk *mcbsp2_fck_parents_ptr[] = {
+	&per_96m_fck, &mcbsp_clks,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(mcbsp2_fck, "per_clkdm", mcbsp_234_clksel,
 			 OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 			 OMAP2_MCBSP2_CLKS_MASK,
@@ -2587,6 +2628,10 @@ static const char *sgx_fck_parents[] = {
 	"core_ck", "cm_96m_fck", "omap_192m_alwon_fck", "corex2_fck",
 };
 
+static struct clk *sgx_fck_parents_ptr[] = {
+	&core_ck, &cm_96m_fck, &omap_192m_alwon_fck, &corex2_fck,
+};
+
 static struct clk sgx_fck;
 
 static const struct clk_ops sgx_fck_ops = {
@@ -2738,6 +2783,10 @@ static const char *ssi_ssr_fck_3430es1_parents[] = {
 	"corex2_fck",
 };
 
+static struct clk *ssi_ssr_fck_3430es1_parents_ptr[] = {
+	&corex2_fck,
+};
+
 static const struct clk_ops ssi_ssr_fck_3430es1_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_dflt_clk_enable,
@@ -2790,8 +2839,8 @@ DEFINE_CLK_DIVIDER(sys_clkout2, "clkout2_src_ck", &clkout2_src_ck, 0x0,
 		   OMAP3430_CM_CLKOUT_CTRL, OMAP3430_CLKOUT2_DIV_SHIFT,
 		   OMAP3430_CLKOUT2_DIV_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-DEFINE_CLK_MUX(traceclk_src_fck, emu_src_ck_parents, NULL, 0x0,
-	       OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+DEFINE_CLK_MUX(traceclk_src_fck, emu_src_ck_parents, emu_src_ck_parents_ptr,
+	       0x0, OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	       OMAP3430_TRACE_MUX_CTRL_SHIFT, OMAP3430_TRACE_MUX_CTRL_WIDTH,
 	       0x0, NULL);
 
@@ -2972,6 +3021,10 @@ static const char *usb_l4_ick_parents[] = {
 	"l4_ick",
 };
 
+static struct clk *usb_l4_ick_parents_ptr[] = {
+	&l4_ick,
+};
+
 DEFINE_CLK_OMAP_MUX_GATE(usb_l4_ick, "core_l4_clkdm", usb_l4_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 			 OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
@@ -3081,6 +3134,10 @@ static const char *usim_fck_parents[] = {
 	"omap_96m_fck", "dpll5_m2_ck", "sys_ck",
 };
 
+static struct clk *usim_fck_parents_ptr[] = {
+	&omap_96m_fck, &dpll5_m2_ck, &sys_ck,
+};
+
 static struct clk usim_fck;
 
 static const struct clk_ops usim_fck_ops = {
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 3d5ab79..40fe2af 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -94,8 +94,14 @@ static const char *sys_clkin_ck_parents[] = {
 	"virt_38400000_ck",
 };
 
-DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, NULL, 0x0,
-	       OMAP4430_CM_SYS_CLKSEL, OMAP4430_SYS_CLKSEL_SHIFT,
+static struct clk *sys_clkin_ck_parents_ptr[] = {
+	&virt_12000000_ck, &virt_13000000_ck, &virt_16800000_ck,
+	&virt_19200000_ck, &virt_26000000_ck, &virt_27000000_ck,
+	&virt_38400000_ck,
+};
+
+DEFINE_CLK_MUX(sys_clkin_ck, sys_clkin_ck_parents, sys_clkin_ck_parents_ptr,
+	       0x0, OMAP4430_CM_SYS_CLKSEL, OMAP4430_SYS_CLKSEL_SHIFT,
 	       OMAP4430_SYS_CLKSEL_WIDTH, CLK_MUX_INDEX_ONE, NULL);
 
 DEFINE_CLK_FIXED_RATE(tie_low_clock_ck, CLK_IS_ROOT, 0, 0x0);
@@ -114,11 +120,17 @@ static const char *abe_dpll_bypass_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "sys_32k_ck",
 };
 
+static struct clk *abe_dpll_bypass_clk_mux_ck_parents_ptr[] = {
+	&sys_clkin_ck, &sys_32k_ck,
+};
+
 DEFINE_CLK_MUX(abe_dpll_bypass_clk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents,
-	       NULL, 0x0, OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_SHIFT,
+	       abe_dpll_bypass_clk_mux_ck_parents_ptr, 0x0,
+	       OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_SHIFT,
 	       OMAP4430_CLKSEL_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(abe_dpll_refclk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents, NULL,
+DEFINE_CLK_MUX(abe_dpll_refclk_mux_ck, abe_dpll_bypass_clk_mux_ck_parents,
+	       abe_dpll_bypass_clk_mux_ck_parents_ptr,
 	       0x0, OMAP4430_CM_ABE_PLL_REF_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -221,7 +233,12 @@ static const char *core_hsd_byp_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "dpll_abe_m3x2_ck",
 };
 
-DEFINE_CLK_MUX(core_hsd_byp_clk_mux_ck, core_hsd_byp_clk_mux_ck_parents, NULL,
+static struct clk *core_hsd_byp_clk_mux_ck_parents_ptr[] = {
+	&sys_clkin_ck, &dpll_abe_m3x2_ck,
+};
+
+DEFINE_CLK_MUX(core_hsd_byp_clk_mux_ck, core_hsd_byp_clk_mux_ck_parents,
+	       core_hsd_byp_clk_mux_ck_parents_ptr,
 	       0x0, OMAP4430_CM_CLKSEL_DPLL_CORE,
 	       OMAP4430_DPLL_BYP_CLKSEL_SHIFT, OMAP4430_DPLL_BYP_CLKSEL_WIDTH,
 	       0x0, NULL);
@@ -250,6 +267,10 @@ static const char *dpll_core_ck_parents[] = {
 	"sys_clkin_ck", "core_hsd_byp_clk_mux_ck"
 };
 
+static struct clk *dpll_core_ck_parents_ptr[] = {
+	&sys_clkin_ck, &core_hsd_byp_clk_mux_ck,
+};
+
 static struct clk dpll_core_ck;
 
 static const struct clk_ops dpll_core_ck_ops = {
@@ -265,7 +286,7 @@ static struct clk_hw_omap dpll_core_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_core_ck, dpll_core_ck_parents, dpll_core_ck_ops);
+DEFINE_STRUCT_CLK_MUX(dpll_core_ck, dpll_core_ck_parents, dpll_core_ck_ops);
 
 static const char *dpll_core_x2_ck_parents[] = {
 	"dpll_core_ck",
@@ -339,6 +360,10 @@ static const char *dpll_core_m3x2_ck_parents[] = {
 	"dpll_core_x2_ck",
 };
 
+static struct clk *dpll_core_m3x2_ck_parents_ptr[] = {
+	&dpll_core_x2_ck,
+};
+
 static const struct clksel dpll_core_m3x2_div[] = {
 	{ .parent = &dpll_core_x2_ck, .rates = div31_1to31_rates },
 	{ .parent = NULL },
@@ -360,7 +385,12 @@ static const char *iva_hsd_byp_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "div_iva_hs_clk",
 };
 
-DEFINE_CLK_MUX(iva_hsd_byp_clk_mux_ck, iva_hsd_byp_clk_mux_ck_parents, NULL,
+static struct clk *iva_hsd_byp_clk_mux_ck_parents_ptr[] = {
+	&sys_clkin_ck, &div_iva_hs_clk,
+};
+
+DEFINE_CLK_MUX(iva_hsd_byp_clk_mux_ck, iva_hsd_byp_clk_mux_ck_parents,
+	       iva_hsd_byp_clk_mux_ck_parents_ptr,
 	       0x0, OMAP4430_CM_CLKSEL_DPLL_IVA, OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
 	       OMAP4430_DPLL_BYP_CLKSEL_WIDTH, 0x0, NULL);
 
@@ -387,6 +417,10 @@ static const char *dpll_iva_ck_parents[] = {
 	"sys_clkin_ck", "iva_hsd_byp_clk_mux_ck"
 };
 
+static struct clk *dpll_iva_ck_parents_ptr[] = {
+	&sys_clkin_ck, &iva_hsd_byp_clk_mux_ck,
+};
+
 static struct clk dpll_iva_ck;
 
 static const struct clk_ops dpll_ck_ops = {
@@ -406,7 +440,7 @@ static struct clk_hw_omap dpll_iva_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_iva_ck, dpll_iva_ck_parents, dpll_ck_ops);
+DEFINE_STRUCT_CLK_MUX(dpll_iva_ck, dpll_iva_ck_parents, dpll_ck_ops);
 
 static const char *dpll_iva_x2_ck_parents[] = {
 	"dpll_iva_ck",
@@ -453,6 +487,10 @@ static const char *dpll_mpu_ck_parents[] = {
 	"sys_clkin_ck", "div_mpu_hs_clk"
 };
 
+static struct clk *dpll_mpu_ck_parents_ptr[] = {
+	&sys_clkin_ck, &div_mpu_hs_clk,
+};
+
 static struct clk dpll_mpu_ck;
 
 static struct clk_hw_omap dpll_mpu_ck_hw = {
@@ -463,7 +501,7 @@ static struct clk_hw_omap dpll_mpu_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_mpu_ck, dpll_mpu_ck_parents, dpll_ck_ops);
+DEFINE_STRUCT_CLK_MUX(dpll_mpu_ck, dpll_mpu_ck_parents, dpll_ck_ops);
 
 DEFINE_CLK_FIXED_FACTOR(mpu_periphclk, "dpll_mpu_ck", &dpll_mpu_ck, 0x0, 1, 2);
 
@@ -478,7 +516,12 @@ static const char *per_hsd_byp_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "per_hs_clk_div_ck",
 };
 
-DEFINE_CLK_MUX(per_hsd_byp_clk_mux_ck, per_hsd_byp_clk_mux_ck_parents, NULL,
+static struct clk *per_hsd_byp_clk_mux_ck_parents_ptr[] = {
+	&sys_clkin_ck, &per_hs_clk_div_ck,
+};
+
+DEFINE_CLK_MUX(per_hsd_byp_clk_mux_ck, per_hsd_byp_clk_mux_ck_parents,
+	       per_hsd_byp_clk_mux_ck_parents_ptr,
 	       0x0, OMAP4430_CM_CLKSEL_DPLL_PER, OMAP4430_DPLL_BYP_CLKSEL_SHIFT,
 	       OMAP4430_DPLL_BYP_CLKSEL_WIDTH, 0x0, NULL);
 
@@ -505,6 +548,10 @@ static const char *dpll_per_ck_parents[] = {
 	"sys_clkin_ck", "per_hsd_byp_clk_mux_ck"
 };
 
+static struct clk *dpll_per_ck_parents_ptr[] = {
+	&sys_clkin_ck, &per_hsd_byp_clk_mux_ck,
+};
+
 static struct clk dpll_per_ck;
 
 static struct clk_hw_omap dpll_per_ck_hw = {
@@ -515,7 +562,7 @@ static struct clk_hw_omap dpll_per_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_per_ck, dpll_per_ck_parents, dpll_ck_ops);
+DEFINE_STRUCT_CLK_MUX(dpll_per_ck, dpll_per_ck_parents, dpll_ck_ops);
 
 DEFINE_CLK_DIVIDER(dpll_per_m2_ck, "dpll_per_ck", &dpll_per_ck, 0x0,
 		   OMAP4430_CM_DIV_M2_DPLL_PER, OMAP4430_DPLL_CLKOUT_DIV_SHIFT,
@@ -546,6 +593,10 @@ static const char *dpll_per_m3x2_ck_parents[] = {
 	"dpll_per_x2_ck",
 };
 
+static struct clk *dpll_per_m3x2_ck_parents_ptr[] = {
+	&dpll_per_x2_ck,
+};
+
 static const struct clksel dpll_per_m3x2_div[] = {
 	{ .parent = &dpll_per_x2_ck, .rates = div31_1to31_rates },
 	{ .parent = NULL },
@@ -603,6 +654,10 @@ static const char *dpll_usb_ck_parents[] = {
 	"sys_clkin_ck", "usb_hs_clk_div_ck"
 };
 
+static struct clk *dpll_usb_ck_parents_ptr[] = {
+	&sys_clkin_ck, &usb_hs_clk_div_ck,
+};
+
 static struct clk dpll_usb_ck;
 
 static const struct clk_ops dpll_usb_ck_ops = {
@@ -624,7 +679,7 @@ static struct clk_hw_omap dpll_usb_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_usb_ck_ops);
+DEFINE_STRUCT_CLK_MUX(dpll_usb_ck, dpll_usb_ck_parents, dpll_usb_ck_ops);
 
 static const char *dpll_usb_clkdcoldo_ck_parents[] = {
 	"dpll_usb_ck",
@@ -654,7 +709,12 @@ static const char *ducati_clk_mux_ck_parents[] = {
 	"div_core_ck", "dpll_per_m6x2_ck",
 };
 
-DEFINE_CLK_MUX(ducati_clk_mux_ck, ducati_clk_mux_ck_parents, NULL, 0x0,
+static struct clk *ducati_clk_mux_ck_parents_ptr[] = {
+	&div_core_ck, &dpll_per_m6x2_ck,
+};
+
+DEFINE_CLK_MUX(ducati_clk_mux_ck, ducati_clk_mux_ck_parents,
+	       ducati_clk_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM_CLKSEL_DUCATI_ISS_ROOT, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -725,7 +785,12 @@ static const char *l4_wkup_clk_mux_ck_parents[] = {
 	"sys_clkin_ck", "lp_clk_div_ck",
 };
 
-DEFINE_CLK_MUX(l4_wkup_clk_mux_ck, l4_wkup_clk_mux_ck_parents, NULL, 0x0,
+static struct clk *l4_wkup_clk_mux_ck_parents_ptr[] = {
+	&sys_clkin_ck, &lp_clk_div_ck,
+};
+
+DEFINE_CLK_MUX(l4_wkup_clk_mux_ck, l4_wkup_clk_mux_ck_parents,
+	       l4_wkup_clk_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM_L4_WKUP_CLKSEL, OMAP4430_CLKSEL_0_0_SHIFT,
 	       OMAP4430_CLKSEL_0_0_WIDTH, 0x0, NULL);
 
@@ -795,7 +860,12 @@ static const char *dmic_sync_mux_ck_parents[] = {
 	"abe_24m_fclk", "syc_clk_div_ck", "func_24m_clk",
 };
 
-DEFINE_CLK_MUX(dmic_sync_mux_ck, dmic_sync_mux_ck_parents, NULL,
+static struct clk *dmic_sync_mux_ck_parents_ptr[] = {
+	&abe_24m_fclk, &syc_clk_div_ck, &func_24m_clk,
+};
+
+DEFINE_CLK_MUX(dmic_sync_mux_ck, dmic_sync_mux_ck_parents,
+	       dmic_sync_mux_ck_parents_ptr,
 	       0x0, OMAP4430_CM1_ABE_DMIC_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -811,6 +881,10 @@ static const char *func_dmic_abe_gfclk_parents[] = {
 	"dmic_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
 
+static struct clk *func_dmic_abe_gfclk_parents_ptr[] = {
+	&dmic_sync_mux_ck, &pad_clks_ck, &slimbus_clk,
+};
+
 DEFINE_CLK_OMAP_MUX(func_dmic_abe_gfclk, "abe_clkdm", func_dmic_abe_gfclk_sel,
 		    OMAP4430_CM1_ABE_DMIC_CLKCTRL, OMAP4430_CLKSEL_SOURCE_MASK,
 		    func_dmic_abe_gfclk_parents, func_dmic_abe_gfclk_ops);
@@ -873,6 +947,10 @@ static const char *sgx_clk_mux_parents[] = {
 	"dpll_core_m7x2_ck", "dpll_per_m7x2_ck",
 };
 
+static struct clk *sgx_clk_mux_parents_ptr[] = {
+	&dpll_core_m7x2_ck, &dpll_per_m7x2_ck,
+};
+
 DEFINE_CLK_OMAP_MUX(sgx_clk_mux, "l3_gfx_clkdm", sgx_clk_mux_sel,
 		    OMAP4430_CM_GFX_GFX_CLKCTRL, OMAP4430_CLKSEL_SGX_FCLK_MASK,
 		    sgx_clk_mux_parents, func_dmic_abe_gfclk_ops);
@@ -886,7 +964,8 @@ DEFINE_CLK_GATE(iss_ctrlclk, "func_96m_fclk", &func_96m_fclk, 0x0,
 		OMAP4430_CM_CAM_ISS_CLKCTRL, OMAP4430_OPTFCLKEN_CTRLCLK_SHIFT,
 		0x0, NULL);
 
-DEFINE_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcasp_sync_mux_ck, dmic_sync_mux_ck_parents,
+	       dmic_sync_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM1_ABE_MCASP_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -902,11 +981,16 @@ static const char *func_mcasp_abe_gfclk_parents[] = {
 	"mcasp_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
 
+static struct clk *func_mcasp_abe_gfclk_parents_ptr[] = {
+	&mcasp_sync_mux_ck, &pad_clks_ck, &slimbus_clk,
+};
+
 DEFINE_CLK_OMAP_MUX(func_mcasp_abe_gfclk, "abe_clkdm", func_mcasp_abe_gfclk_sel,
 		    OMAP4430_CM1_ABE_MCASP_CLKCTRL, OMAP4430_CLKSEL_SOURCE_MASK,
 		    func_mcasp_abe_gfclk_parents, func_dmic_abe_gfclk_ops);
 
-DEFINE_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp1_sync_mux_ck, dmic_sync_mux_ck_parents,
+	       dmic_sync_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -922,12 +1006,17 @@ static const char *func_mcbsp1_gfclk_parents[] = {
 	"mcbsp1_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
 
+static struct clk *func_mcbsp1_gfclk_parents_ptr[] = {
+	&mcbsp1_sync_mux_ck, &pad_clks_ck, &slimbus_clk,
+};
+
 DEFINE_CLK_OMAP_MUX(func_mcbsp1_gfclk, "abe_clkdm", func_mcbsp1_gfclk_sel,
 		    OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
 		    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp1_gfclk_parents,
 		    func_dmic_abe_gfclk_ops);
 
-DEFINE_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp2_sync_mux_ck, dmic_sync_mux_ck_parents,
+	       dmic_sync_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -943,12 +1032,17 @@ static const char *func_mcbsp2_gfclk_parents[] = {
 	"mcbsp2_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
 
+static struct clk *func_mcbsp2_gfclk_parents_ptr[] = {
+	&mcbsp2_sync_mux_ck, &pad_clks_ck, &slimbus_clk,
+};
+
 DEFINE_CLK_OMAP_MUX(func_mcbsp2_gfclk, "abe_clkdm", func_mcbsp2_gfclk_sel,
 		    OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
 		    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp2_gfclk_parents,
 		    func_dmic_abe_gfclk_ops);
 
-DEFINE_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(mcbsp3_sync_mux_ck, dmic_sync_mux_ck_parents,
+	       dmic_sync_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -964,6 +1058,10 @@ static const char *func_mcbsp3_gfclk_parents[] = {
 	"mcbsp3_sync_mux_ck", "pad_clks_ck", "slimbus_clk",
 };
 
+static struct clk *func_mcbsp3_gfclk_parents_ptr[] = {
+	&mcbsp3_sync_mux_ck, &pad_clks_ck, &slimbus_clk,
+};
+
 DEFINE_CLK_OMAP_MUX(func_mcbsp3_gfclk, "abe_clkdm", func_mcbsp3_gfclk_sel,
 		    OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
 		    OMAP4430_CLKSEL_SOURCE_MASK, func_mcbsp3_gfclk_parents,
@@ -973,7 +1071,12 @@ static const char *mcbsp4_sync_mux_ck_parents[] = {
 	"func_96m_fclk", "per_abe_nc_fclk",
 };
 
-DEFINE_CLK_MUX(mcbsp4_sync_mux_ck, mcbsp4_sync_mux_ck_parents, NULL, 0x0,
+static struct clk *mcbsp4_sync_mux_ck_parents_ptr[] = {
+	&func_96m_fclk, &per_abe_nc_fclk,
+};
+
+DEFINE_CLK_MUX(mcbsp4_sync_mux_ck, mcbsp4_sync_mux_ck_parents,
+	       mcbsp4_sync_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_SHIFT,
 	       OMAP4430_CLKSEL_INTERNAL_SOURCE_WIDTH, 0x0, NULL);
@@ -988,6 +1091,10 @@ static const char *per_mcbsp4_gfclk_parents[] = {
 	"mcbsp4_sync_mux_ck", "pad_clks_ck",
 };
 
+static struct clk *per_mcbsp4_gfclk_parents_ptr[] = {
+	&mcbsp4_sync_mux_ck, &pad_clks_ck,
+};
+
 DEFINE_CLK_OMAP_MUX(per_mcbsp4_gfclk, "l4_per_clkdm", per_mcbsp4_gfclk_sel,
 		    OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
 		    OMAP4430_CLKSEL_SOURCE_24_24_MASK, per_mcbsp4_gfclk_parents,
@@ -1003,6 +1110,10 @@ static const char *hsmmc1_fclk_parents[] = {
 	"func_64m_fclk", "func_96m_fclk",
 };
 
+static struct clk *hsmmc1_fclk_parents_ptr[] = {
+	&func_64m_fclk, &func_96m_fclk,
+};
+
 DEFINE_CLK_OMAP_MUX(hsmmc1_fclk, "l3_init_clkdm", hsmmc1_fclk_sel,
 		    OMAP4430_CM_L3INIT_MMC1_CLKCTRL, OMAP4430_CLKSEL_MASK,
 		    hsmmc1_fclk_parents, func_dmic_abe_gfclk_ops);
@@ -1102,6 +1213,10 @@ static const char *timer5_sync_mux_parents[] = {
 	"syc_clk_div_ck", "sys_32k_ck",
 };
 
+static struct clk *timer5_sync_mux_parents_ptr[] = {
+	&syc_clk_div_ck, &sys_32k_ck,
+};
+
 DEFINE_CLK_OMAP_MUX(timer5_sync_mux, "abe_clkdm", timer5_sync_mux_sel,
 		    OMAP4430_CM1_ABE_TIMER5_CLKCTRL, OMAP4430_CLKSEL_MASK,
 		    timer5_sync_mux_parents, func_dmic_abe_gfclk_ops);
@@ -1151,8 +1266,12 @@ static const char *utmi_p1_gfclk_parents[] = {
 	"init_60m_fclk", "xclk60mhsp1_ck",
 };
 
-DEFINE_CLK_MUX(utmi_p1_gfclk, utmi_p1_gfclk_parents, NULL, 0x0,
-	       OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+static struct clk *utmi_p1_gfclk_parents_ptr[] = {
+	&init_60m_fclk, &xclk60mhsp1_ck,
+};
+
+DEFINE_CLK_MUX(utmi_p1_gfclk, utmi_p1_gfclk_parents, utmi_p1_gfclk_parents_ptr,
+	       0x0, OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	       OMAP4430_CLKSEL_UTMI_P1_SHIFT, OMAP4430_CLKSEL_UTMI_P1_WIDTH,
 	       0x0, NULL);
 
@@ -1164,8 +1283,12 @@ static const char *utmi_p2_gfclk_parents[] = {
 	"init_60m_fclk", "xclk60mhsp2_ck",
 };
 
-DEFINE_CLK_MUX(utmi_p2_gfclk, utmi_p2_gfclk_parents, NULL, 0x0,
-	       OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
+static struct clk *utmi_p2_gfclk_parents_ptr[] = {
+	&init_60m_fclk, &xclk60mhsp2_ck,
+};
+
+DEFINE_CLK_MUX(utmi_p2_gfclk, utmi_p2_gfclk_parents, utmi_p2_gfclk_parents_ptr,
+	       0x0, OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL,
 	       OMAP4430_CLKSEL_UTMI_P2_SHIFT, OMAP4430_CLKSEL_UTMI_P2_WIDTH,
 	       0x0, NULL);
 
@@ -1209,9 +1332,13 @@ static const char *otg_60m_gfclk_parents[] = {
 	"utmi_phy_clkout_ck", "xclk60motg_ck",
 };
 
-DEFINE_CLK_MUX(otg_60m_gfclk, otg_60m_gfclk_parents, NULL, 0x0,
-	       OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL, OMAP4430_CLKSEL_60M_SHIFT,
-	       OMAP4430_CLKSEL_60M_WIDTH, 0x0, NULL);
+static struct clk *otg_60m_gfclk_parents_ptr[] = {
+	&utmi_phy_clkout_ck, &xclk60motg_ck,
+};
+
+DEFINE_CLK_MUX(otg_60m_gfclk, otg_60m_gfclk_parents, otg_60m_gfclk_parents_ptr,
+	       0x0, OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
+	       OMAP4430_CLKSEL_60M_SHIFT, OMAP4430_CLKSEL_60M_WIDTH, 0x0, NULL);
 
 DEFINE_CLK_GATE(usb_otg_hs_xclk, "otg_60m_gfclk", &otg_60m_gfclk, 0x0,
 		OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
@@ -1260,11 +1387,17 @@ static const char *pmd_stm_clock_mux_ck_parents[] = {
 	"sys_clkin_ck", "dpll_core_m6x2_ck", "tie_low_clock_ck",
 };
 
-DEFINE_CLK_MUX(pmd_stm_clock_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
+static struct clk *pmd_stm_clock_mux_ck_parents_ptr[] = {
+	&sys_clkin_ck, &dpll_core_m6x2_ck, &tie_low_clock_ck,
+};
+
+DEFINE_CLK_MUX(pmd_stm_clock_mux_ck, pmd_stm_clock_mux_ck_parents,
+	       pmd_stm_clock_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM_EMU_DEBUGSS_CLKCTRL, OMAP4430_PMD_STM_MUX_CTRL_SHIFT,
 	       OMAP4430_PMD_STM_MUX_CTRL_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(pmd_trace_clk_mux_ck, pmd_stm_clock_mux_ck_parents, NULL, 0x0,
+DEFINE_CLK_MUX(pmd_trace_clk_mux_ck, pmd_stm_clock_mux_ck_parents,
+	       pmd_stm_clock_mux_ck_parents_ptr, 0x0,
 	       OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
 	       OMAP4430_PMD_TRACE_MUX_CTRL_SHIFT,
 	       OMAP4430_PMD_TRACE_MUX_CTRL_WIDTH, 0x0, NULL);
@@ -1321,6 +1454,10 @@ static const char *auxclk_src_ck_parents[] = {
 	"sys_clkin_ck", "dpll_core_m3x2_ck", "dpll_per_m3x2_ck",
 };
 
+static struct clk *auxclk_src_ck_parents_ptr[] = {
+	&sys_clkin_ck, &dpll_core_m3x2_ck, &dpll_per_m3x2_ck,
+};
+
 static const struct clk_ops auxclk_src_ck_ops = {
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
@@ -1388,29 +1525,34 @@ static const char *auxclkreq_ck_parents[] = {
 	"auxclk5_ck",
 };
 
-DEFINE_CLK_MUX(auxclkreq0_ck, auxclkreq_ck_parents, NULL, 0x0,
-	       OMAP4_SCRM_AUXCLKREQ0, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
-	       0x0, NULL);
+static struct clk *auxclkreq_ck_parents_ptr[] = {
+	&auxclk0_ck, &auxclk1_ck, &auxclk2_ck, &auxclk3_ck, &auxclk4_ck,
+	&auxclk5_ck,
+};
 
-DEFINE_CLK_MUX(auxclkreq1_ck, auxclkreq_ck_parents, NULL, 0x0,
-	       OMAP4_SCRM_AUXCLKREQ1, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
-	       0x0, NULL);
+DEFINE_CLK_MUX(auxclkreq0_ck, auxclkreq_ck_parents, auxclkreq_ck_parents_ptr,
+	       0x0, OMAP4_SCRM_AUXCLKREQ0, OMAP4_MAPPING_SHIFT,
+	       OMAP4_MAPPING_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq2_ck, auxclkreq_ck_parents, NULL, 0x0,
-	       OMAP4_SCRM_AUXCLKREQ2, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
-	       0x0, NULL);
+DEFINE_CLK_MUX(auxclkreq1_ck, auxclkreq_ck_parents, auxclkreq_ck_parents_ptr,
+	       0x0, OMAP4_SCRM_AUXCLKREQ1, OMAP4_MAPPING_SHIFT,
+	       OMAP4_MAPPING_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq3_ck, auxclkreq_ck_parents, NULL, 0x0,
-	       OMAP4_SCRM_AUXCLKREQ3, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
-	       0x0, NULL);
+DEFINE_CLK_MUX(auxclkreq2_ck, auxclkreq_ck_parents, auxclkreq_ck_parents_ptr,
+	       0x0, OMAP4_SCRM_AUXCLKREQ2, OMAP4_MAPPING_SHIFT,
+	       OMAP4_MAPPING_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq4_ck, auxclkreq_ck_parents, NULL, 0x0,
-	       OMAP4_SCRM_AUXCLKREQ4, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
-	       0x0, NULL);
+DEFINE_CLK_MUX(auxclkreq3_ck, auxclkreq_ck_parents, auxclkreq_ck_parents_ptr,
+	       0x0, OMAP4_SCRM_AUXCLKREQ3, OMAP4_MAPPING_SHIFT,
+	       OMAP4_MAPPING_WIDTH, 0x0, NULL);
 
-DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0,
-	       OMAP4_SCRM_AUXCLKREQ5, OMAP4_MAPPING_SHIFT, OMAP4_MAPPING_WIDTH,
-	       0x0, NULL);
+DEFINE_CLK_MUX(auxclkreq4_ck, auxclkreq_ck_parents, auxclkreq_ck_parents_ptr,
+	       0x0, OMAP4_SCRM_AUXCLKREQ4, OMAP4_MAPPING_SHIFT,
+	       OMAP4_MAPPING_WIDTH, 0x0, NULL);
+
+DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, auxclkreq_ck_parents_ptr,
+	       0x0, OMAP4_SCRM_AUXCLKREQ5, OMAP4_MAPPING_SHIFT,
+	       OMAP4_MAPPING_WIDTH, 0x0, NULL);
 
 /*
  * clkdev
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 60ddd86..9dbdcb5 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -65,6 +65,16 @@ struct clockdomain;
 		.ops = &_clkops_name,				\
 	};
 
+#define DEFINE_STRUCT_CLK_MUX(_name, _parent_array_name, _clkops_name)	\
+	static struct clk _name = {				\
+		.name = #_name,					\
+		.hw = &_name##_hw.hw,				\
+		.parent_names = _parent_array_name,		\
+		.num_parents = ARRAY_SIZE(_parent_array_name),	\
+		.parents = _parent_array_name##_ptr,		\
+		.ops = &_clkops_name,				\
+	};
+
 #define DEFINE_STRUCT_CLK_FLAGS(_name, _parent_array_name,	\
 				_clkops_name, _flags)		\
 	static struct clk _name = {				\
@@ -72,6 +82,7 @@ struct clockdomain;
 		.hw = &_name##_hw.hw,				\
 		.parent_names = _parent_array_name,		\
 		.num_parents = ARRAY_SIZE(_parent_array_name),	\
+		.parents = _parent_array_name##_ptr,		\
 		.ops = &_clkops_name,				\
 		.flags = _flags,				\
 	};
@@ -97,7 +108,7 @@ struct clockdomain;
 		.clksel_mask	= _clksel_mask,			\
 		.clkdm_name	= _clkdm_name,			\
 	};							\
-	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
+	DEFINE_STRUCT_CLK_MUX(_name, _parent_names, _ops);
 
 #define DEFINE_CLK_OMAP_MUX_GATE(_name, _clkdm_name, _clksel,	\
 				 _clksel_reg, _clksel_mask,	\
@@ -116,7 +127,7 @@ struct clockdomain;
 		.clksel_mask	= _clksel_mask,			\
 		.clkdm_name	= _clkdm_name,			\
 	};							\
-	DEFINE_STRUCT_CLK(_name, _parent_names, _ops);
+	DEFINE_STRUCT_CLK_MUX(_name, _parent_names, _ops);
 
 #define DEFINE_CLK_OMAP_HSDIVIDER(_name, _parent_name,		\
 				_parent_ptr, _flags,		\
-- 
1.7.9.5

