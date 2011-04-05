From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: introduce OMAP MCOP board file
Date: Tue, 5 Apr 2011 12:36:57 +0300
Message-ID: <20110405093656.GS2176@legolas.emea.dhcp.ti.com>
References: <1301995970-23699-1-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44589 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751591Ab1DEJhB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 05:37:01 -0400
Received: by mail-ey0-f172.google.com with SMTP id 13so67338eye.31
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 02:37:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301995970-23699-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Michael Fillinger <m-fillinger@ti.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2011 at 12:32:50PM +0300, Felipe Balbi wrote:
> From: Michael Fillinger <m-fillinger@ti.com>
> 
> MCOP is an FPGA-based Silicon Validation platform
> which is used to test particular IPs inside OMAP
> before we have a real ASIC.
> 
> Signed-off-by: Michael Fillinger <m-fillinger@ti.com>
> 
> [ balbi@ti.com : few cleanups here an there and also
> 	removal of some unnecessary code. ]
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

I should have RFCed this one, but bear with me for a minute.

This is just the bare minimum board-file for MCOP, there's still a bunch
of changes needed to get it actually booting. The attached diff shows
many of them.

Now, we don't want to send that patch upstream for obvious reasons and
we also don't want to add ifdefs to clock data files as that would break
multi-omap. What do you guys suggest ? How should we handle detection of
MCOP so that we choose correct HWMODs and clock data files for it ?

I don't think Linus will like if we add yet another hwmod + clk data
file just for MCOP, so we need to re-use what's in tree.

-- 
balbi

--7AUc2qLy4jB3hD7Z
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="mcop_remaining.diff"

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 0a992bc..32b98e4 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -77,10 +77,9 @@ static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 /* Without modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
+	.rate		= 19200000,
 	.ops		= &clkops_null,
-	.parent		= &osc_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &omap2xxx_sys_clk_recalc,
 };
 
 static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
@@ -192,7 +191,7 @@ static struct clk func_54m_ck = {
 static struct clk core_ck = {
 	.name		= "core_ck",
 	.ops		= &clkops_null,
-	.parent		= &dpll_ck,		/* can also be 32k */
+	.parent		= &sys_ck,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
@@ -407,13 +406,8 @@ static const struct clksel mpu_clksel[] = {
 static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
-	.parent		= &core_ck,
-	.clkdm_name	= "mpu_clkdm",
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
-	.clksel		= mpu_clksel,
-	.recalc		= &omap2_clksel_recalc,
+	.rate		= 19200000,
+	.clkdm_name	= "wkup_clkdm",
 };
 
 /*
@@ -556,11 +550,8 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.clkdm_name	= "core_l3_clkdm",
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
-	.clksel		= core_l3_clksel,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
+	.clkdm_name	= "wkup_clkdm",
 };
 
 /* usb_l4_ick */
@@ -612,11 +603,8 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
-	.clksel		= l4_clksel,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &followparent_recalc,
+	.clkdm_name	= "wkup_clkdm",
 };
 
 /*
@@ -845,76 +833,47 @@ static const struct clksel omap24xx_gpt_clksel[] = {
 
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
-	.clksel		= omap24xx_gpt_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
+	.ops		= &clkops_null,
+	.rate		= 12000000,
+	.clkdm_name	= "wkup_clkdm",
 };
 
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
-	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
-	.clksel		= omap24xx_gpt_clksel,
-	.recalc		= &omap2_clksel_recalc,
+	.ops		= &clkops_null,
+	.rate		= 12000000,
+	.clkdm_name	= "wkup_clkdm",
 };
 
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
-	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
-	.clksel		= omap24xx_gpt_clksel,
-	.recalc		= &omap2_clksel_recalc,
+	.ops		= &clkops_null,
+	.rate		= 12000000,
+	.clkdm_name	= "wkup_clkdm",
 };
 
 static struct clk gpt4_ick = {
@@ -1238,21 +1197,17 @@ static struct clk mcspi2_fck = {
 
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_fck = {
 	.name		= "uart1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_48m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.ops		= &clkops_null,
+	.parent		= &core_ck,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1298,21 +1253,17 @@ static struct clk uart3_fck = {
 
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_fck = {
 	.name		= "gpios_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1338,12 +1289,10 @@ static struct clk mpu_wdt_fck = {
 
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_null,
 	.parent		= &l4_ck,
 	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1596,7 +1545,7 @@ static struct clk sdma_fck = {
 	.name		= "sdma_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l3_clkdm",
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1604,7 +1553,7 @@ static struct clk sdma_ick = {
 	.name		= "sdma_ick",
 	.ops		= &clkops_null, /* RMK: missing? */
 	.parent		= &l4_ck,
-	.clkdm_name	= "core_l3_clkdm",
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1748,57 +1697,57 @@ static struct clk virt_prcm_set = {
 static struct omap_clk omap2420_clks[] = {
 	/* external root sources */
 	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_242X),
-	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_242X),
-	CLK(NULL,	"osc_ck",	&osc_ck,	CK_242X),
+	//CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_242X),
+	//CLK(NULL,	"osc_ck",	&osc_ck,	CK_242X),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_242X),
-	CLK(NULL,	"alt_ck",	&alt_ck,	CK_242X),
-	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_242X),
-	CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_242X),
-	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_242X),
+	//CLK(NULL,	"alt_ck",	&alt_ck,	CK_242X),
+	//CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_242X),
+	//CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_242X),
+	//CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_242X),
 	/* internal analog sources */
-	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_242X),
-	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_242X),
-	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_242X),
+	//CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_242X),
+	//CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_242X),
+	//CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_242X),
 	/* internal prcm root sources */
-	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_242X),
+	//CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_242X),
 	CLK(NULL,	"core_ck",	&core_ck,	CK_242X),
-	CLK("omap-mcbsp.1",	"prcm_fck",	&func_96m_ck,	CK_242X),
-	CLK("omap-mcbsp.2",	"prcm_fck",	&func_96m_ck,	CK_242X),
-	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_242X),
-	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_242X),
-	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_242X),
-	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_242X),
-	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_242X),
-	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_242X),
-	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
-	CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
+	//CLK("omap-mcbsp.1",	"prcm_fck",	&func_96m_ck,	CK_242X),
+	//CLK("omap-mcbsp.2",	"prcm_fck",	&func_96m_ck,	CK_242X),
+	//CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_242X),
+	//CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_242X),
+	//CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_242X),
+	//CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_242X),
+	//CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_242X),
+	//CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_242X),
+	//CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
+	//CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
+	//CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
 	/* mpu domain clocks */
 	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_242X),
 	/* dsp domain clocks */
-	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_242X),
-	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_242X),
-	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
-	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
-	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
+	//CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_242X),
+	//CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_242X),
+	//CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
+	//CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
+	//CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
 	/* GFX domain clocks */
-	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_242X),
-	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
-	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
+	//CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_242X),
+	//CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
+	//CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_242X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_242X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_242X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_242X),
+	//CLK("omapdss",	"ick",		&dss_ick,	CK_242X),
+	//CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_242X),
+	//CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_242X),
+	//CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_242X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
-	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_242X),
+	//CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
+	//CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_242X),
 	/* L4 domain clocks */
 	CLK(NULL,	"l4_ck",	&l4_ck,		CK_242X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
+	//CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
 	/* virtual meta-group clock */
-	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
+	//CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
@@ -1806,78 +1755,78 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
 	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
-	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
-	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_242X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_242X),
-	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_242X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_242X),
-	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_242X),
+	//CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
+	//CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
+	//CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
+	//CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
+	//CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
+	//CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
+	//CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
+	//CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
+	//CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
+	//CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
+	//CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
+	//CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
+	//CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
+	//CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
+	//CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
+	//CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
+	//CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
+	//CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
+	//CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
+	//CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
+	//CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
+	//CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_242X),
+	//CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_242X),
+	//CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_242X),
+	//CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_242X),
+	//CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_242X),
 	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_242X),
 	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_242X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_242X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_242X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_242X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_242X),
+	//CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_242X),
+	//CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_242X),
+	//CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_242X),
+	//CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_242X),
 	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_242X),
 	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
-	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
-	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
+	//CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
+	//CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
-	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
-	CLK("omap24xxcam", "ick",	&cam_ick,	CK_242X),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_242X),
-	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_242X),
-	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_242X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_242X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_242X),
-	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
-	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_242X),
-	CLK(NULL,	"fac_fck",	&fac_fck,	CK_242X),
-	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
-	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_242X),
-	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_242X),
-	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_242X),
-	CLK("omap_i2c.1", "fck",	&i2c1_fck,	CK_242X),
-	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_242X),
-	CLK("omap_i2c.2", "fck",	&i2c2_fck,	CK_242X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
+	//CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
+	//CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
+	//CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
+	//CLK("omap24xxcam", "ick",	&cam_ick,	CK_242X),
+	//CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_242X),
+	//CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_242X),
+	//CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_242X),
+	//CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
+	//CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
+	//CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_242X),
+	//CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_242X),
+	//CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
+	//CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
+	//CLK(NULL,	"fac_ick",	&fac_ick,	CK_242X),
+	//CLK(NULL,	"fac_fck",	&fac_fck,	CK_242X),
+	//CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
+	//CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
+	//CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_242X),
+	//CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_242X),
+	//CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_242X),
+	//CLK("omap_i2c.1", "fck",	&i2c1_fck,	CK_242X),
+	//CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_242X),
+	//CLK("omap_i2c.2", "fck",	&i2c2_fck,	CK_242X),
+	//CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_242X),
 	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_242X),
-	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
-	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
-	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
-	CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
-	CLK("omap-aes",	"ick",	&aes_ick,	CK_242X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
-	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
-	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
+	//CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
+	//CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
+	//CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
+	//CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
+	//CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
+	//CLK("omap-aes",	"ick",	&aes_ick,	CK_242X),
+	//CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
+	//CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
+	//CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
 };
 
 /*
@@ -1886,12 +1835,12 @@ static struct omap_clk omap2420_clks[] = {
 
 int __init omap2420_clk_init(void)
 {
-	const struct prcm_config *prcm;
+	//const struct prcm_config *prcm;
 	struct omap_clk *c;
 	u32 clkrate;
 
-	prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
-	cm_idlest_pll = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST);
+	//prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
+	//cm_idlest_pll = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST);
 	cpu_mask = RATE_IN_242X;
 	rate_table = omap2420_rate_table;
 
@@ -1901,9 +1850,9 @@ int __init omap2420_clk_init(void)
 	     c++)
 		clk_preinit(c->lk.clk);
 
-	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
-	propagate_rate(&osc_ck);
-	sys_ck.rate = omap2xxx_sys_clk_recalc(&sys_ck);
+	//osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
+	//propagate_rate(&osc_ck);
+	//sys_ck.rate = omap2xxx_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
 	for (c = omap2420_clks; c < omap2420_clks + ARRAY_SIZE(omap2420_clks);
@@ -1914,22 +1863,22 @@ int __init omap2420_clk_init(void)
 	}
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			break;
-	}
-	curr_prcm_set = prcm;
+	//clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
+	//for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+	//	if (!(prcm->flags & cpu_mask))
+	//		continue;
+	//	if (prcm->xtal_speed != sys_ck.rate)
+	//		continue;
+	//	if (prcm->dpll_speed <= clkrate)
+	//		break;
+	//}
+	//curr_prcm_set = prcm;
 
 	recalculate_root_clocks();
 
-	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
+	pr_info("Clocking rate (Crystal/MPU): %ld.%01ld/%ld MHz\n",
 		(sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-		(dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+		(mpu_ck.rate / 1000000)) ;
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
@@ -1938,9 +1887,9 @@ int __init omap2420_clk_init(void)
 	clk_enable_init_clocks();
 
 	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
-	vclk = clk_get(NULL, "virt_prcm_set");
+	//vclk = clk_get(NULL, "virt_prcm_set");
 	sclk = clk_get(NULL, "sys_ck");
-	dclk = clk_get(NULL, "dpll_ck");
+	//dclk = clk_get(NULL, "dpll_ck");
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 5f9086c..a83b3b8 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -57,7 +57,7 @@ int omap_type(void)
 	u32 val = 0;
 
 	if (cpu_is_omap24xx()) {
-		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+		//val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
@@ -459,7 +459,7 @@ void __init omap2_check_revision(void)
 	 * earlier with omap2_set_globals_tap().
 	 */
 	if (cpu_is_omap24xx()) {
-		omap24xx_check_revision();
+		//omap24xx_check_revision();
 	} else if (cpu_is_omap34xx()) {
 		omap3_check_revision();
 		omap3_check_features();
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c203204..a9253d7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -245,7 +245,7 @@ static void __init _omap2_map_common_io(void)
 void __init omap242x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
-	iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
+	//iotable_init(omap242x_io_desc, ARRAY_SIZE(omap242x_io_desc));
 	_omap2_map_common_io();
 }
 #endif
@@ -336,7 +336,7 @@ void __init omap2_init_common_infrastructure(void)
 	u8 postsetup_state;
 
 	if (cpu_is_omap242x()) {
-		omap2xxx_powerdomains_init();
+		//omap2xxx_powerdomains_init();
 		omap2_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
@@ -402,11 +402,11 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 
 	omap_hwmod_late_init();
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
-		_omap2_init_reprogram_sdrc();
-	}
-	gpmc_init();
+	//if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+	//	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
+	//	_omap2_init_reprogram_sdrc();
+	//}
+	//gpmc_init();
 
 	omap_irq_base_init();
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..53f7360 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -959,9 +959,10 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 	/* XXX check clock enable states */
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
+		//ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
+		//				 oh->prcm.omap2.idlest_reg_id,
+		//				 oh->prcm.omap2.idlest_idle_bit);
+		ret = 0;
 	} else if (cpu_is_omap44xx()) {
 		ret = omap4_cm_wait_module_ready(oh->prcm.omap4.clkctrl_reg);
 	} else {
@@ -2212,9 +2213,9 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 	struct powerdomain *pwrdm;
 	int ret = 0;
 
-	pwrdm = omap_hwmod_get_pwrdm(oh);
+	/*pwrdm = omap_hwmod_get_pwrdm(oh);
 	if (pwrdm)
-		ret = pwrdm_get_context_loss_count(pwrdm);
+		ret = pwrdm_get_context_loss_count(pwrdm);*/
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b85c630..60e4c60 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -567,8 +567,8 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 /* l4_wkup -> gpio1 */
 static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
 	{
-		.pa_start	= 0x48018000,
-		.pa_end		= 0x480181ff,
+		.pa_start	= 0x4a310000,
+		.pa_end		= 0x4a3101ff,
 		.flags		= ADDR_TYPE_RT
 	},
 };
@@ -815,8 +815,8 @@ static struct omap_hwmod_irq_info omap2420_dma_system_irqs[] = {
 
 static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] = {
 	{
-		.pa_start	= 0x48056000,
-		.pa_end		= 0x4a0560ff,
+		.pa_start	= 0x4a056000,
+		.pa_end		= 0x4a056fff,
 		.flags		= ADDR_TYPE_RT
 	},
 };
@@ -869,19 +869,19 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
-	&omap2420_iva_hwmod,
-	&omap2420_wd_timer2_hwmod,
+	//&omap2420_iva_hwmod,
+	//&omap2420_wd_timer2_hwmod,
 	&omap2420_uart1_hwmod,
-	&omap2420_uart2_hwmod,
-	&omap2420_uart3_hwmod,
-	&omap2420_i2c1_hwmod,
-	&omap2420_i2c2_hwmod,
+	//&omap2420_uart2_hwmod,
+	//&omap2420_uart3_hwmod,
+	//&omap2420_i2c1_hwmod,
+	//&omap2420_i2c2_hwmod,
 
 	/* gpio class */
 	&omap2420_gpio1_hwmod,
-	&omap2420_gpio2_hwmod,
-	&omap2420_gpio3_hwmod,
-	&omap2420_gpio4_hwmod,
+	//&omap2420_gpio2_hwmod,
+	//&omap2420_gpio3_hwmod,
+	//&omap2420_gpio4_hwmod,
 
 	/* dma_system class*/
 	&omap2420_dma_system_hwmod,
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 0fc550e..e59a206 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -148,9 +148,9 @@ static void __init omap2_gp_clockevent_init(void)
 	     "secure 32KiHz clock source\n");
 #endif
 
-	if (gptimer_id != 12)
-		WARN(IS_ERR_VALUE(omap_dm_timer_set_source(gptimer, src)),
-		     "timer-gp: omap_dm_timer_set_source() failed\n");
+	//if (gptimer_id != 12)
+	//	WARN(IS_ERR_VALUE(omap_dm_timer_set_source(gptimer, src)),
+	//	     "timer-gp: omap_dm_timer_set_source() failed\n");
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1d706cf..fea368fae 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -185,10 +185,10 @@ static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP2
 static struct omap_dm_timer omap2_dm_timers[] = {
-	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
+	{ .phys_base = 0x4A318000, .irq = INT_24XX_GPTIMER1 },
+	{ .phys_base = 0x4A320000, .irq = INT_24XX_GPTIMER2 },
 	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
+/*	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
 	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
 	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
 	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
@@ -196,13 +196,13 @@ static struct omap_dm_timer omap2_dm_timers[] = {
 	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
 	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
 	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
+	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },*/
 };
 
 static const char *omap2_dm_source_names[] __initdata = {
-	"sys_ck",
-	"func_32k_ck",
-	"alt_ck",
+	//"sys_ck",
+	//"func_32k_ck",
+	//"alt_ck",
 	NULL
 };
 
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index ef4106c..e8f5543 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -104,7 +104,7 @@
 #define L3_24XX_SIZE	SZ_1M		/* 44kB of 128MB used, want 1MB sect */
 #define L4_24XX_PHYS	L4_24XX_BASE	/* 0x48000000 --> 0xfa000000 */
 #define L4_24XX_VIRT	(L4_24XX_PHYS + OMAP2_L4_IO_OFFSET)
-#define L4_24XX_SIZE	SZ_1M		/* 1MB of 128MB used, want 1MB sect */
+#define L4_24XX_SIZE	SZ_64M		/* 1MB of 128MB used, want 1MB sect */
 
 #define L4_WK_243X_PHYS		L4_WK_243X_BASE	/* 0x49000000 --> 0xfb000000 */
 #define L4_WK_243X_VIRT		(L4_WK_243X_PHYS + OMAP2_L4_IO_OFFSET)
diff --git a/arch/arm/plat-omap/include/plat/omap24xx.h b/arch/arm/plat-omap/include/plat/omap24xx.h
index 92df9e2..715456b 100644
--- a/arch/arm/plat-omap/include/plat/omap24xx.h
+++ b/arch/arm/plat-omap/include/plat/omap24xx.h
@@ -37,11 +37,11 @@
 #define L3_24XX_BASE		0x68000000
 
 /* interrupt controller */
-#define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
+#define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0x200000)
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 
 #define OMAP242X_CTRL_BASE	L4_24XX_BASE
-#define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
+#define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x2304000)
 #define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
 #define OMAP2420_CM_BASE	(L4_24XX_BASE + 0x8000)
 #define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index 9967d5e..b9d3927 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -81,7 +81,7 @@ static inline void omap_push_sram_idle(void) {}
  * OMAP2+: define the SRAM PA addresses.
  * Used by the SRAM management code and the idle sleep code.
  */
-#define OMAP2_SRAM_PA		0x40200000
+#define OMAP2_SRAM_PA		0x80E00000
 #define OMAP3_SRAM_PA           0x40200000
 #define OMAP4_SRAM_PA		0x40300000
 
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9d6feaa..c3cb07e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -3316,3 +3316,4 @@ rover_g8		MACH_ROVER_G8		ROVER_G8		3335
 t5388p			MACH_T5388P		T5388P			3336
 dingo			MACH_DINGO		DINGO			3337
 goflexhome		MACH_GOFLEXHOME		GOFLEXHOME		3338
+omap_mcop		MACH_OMAP_MCOP		OMAP_MCOP		3450

--7AUc2qLy4jB3hD7Z--
