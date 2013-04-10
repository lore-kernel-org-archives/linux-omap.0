From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and updates for
 3.10
Date: Wed, 10 Apr 2013 11:15:15 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC4A81D@DBDE01.ent.ti.com>
References: <1363768852-18125-1-git-send-email-santosh.shilimkar@ti.com>
 <20130401170539.GK10155@atomide.com> <515BA76D.3000302@ti.com>
 <alpine.DEB.2.00.1304031146230.2616@utopia.booyaka.com>
 <515D6020.2030103@ti.com> <20130404165208.GI10155@atomide.com>
 <515DB110.9000503@ti.com> <515F00B8.3000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59007 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3DJLPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 07:15:32 -0400
In-Reply-To: <515F00B8.3000501@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, "Anna, Suman" <s-anna@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Friday, April 05, 2013 10:20 PM
> To: Tony Lindgren
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Kristo, Tero; Menon, Nishanth; Nayak,
> Rajendra; Valentin, Eduardo; Anna, Suman; Bedia, Vaibhav; Hiremath,
> Vaibhav
> Subject: Re: [GIT PULL] ARM: OMAP5: hwmod, prm/cm data files and
> updates for 3.10
> 
> On Thursday 04 April 2013 10:27 PM, Santosh Shilimkar wrote:
> > On Thursday 04 April 2013 10:22 PM, Tony Lindgren wrote:
> >> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130404 04:15]:
> [..]
> 
> >> Can't we already trim the am33xx hwmod data after your patches for
> >> v3.10 as am33xx is already DT only? Unfortunately we cannot create
> >> negative diffstat in other ways for v3.10 merge window as we cannot
> >> make omap4 DT only just quite yet.
> >>
> > Yes we can and I can take a stab it tomorrow. The only thing is I
> > might need some support for testing but thats manageable. Will
> > take a stab at it tomorrow and if everything goes well, post a
> > patch for smae.
> >
> Patch for the AM33XX to trim is end of the email. Thanks to
> Sricharan and Pekon for patch and testing. Looping both
> Vaibhav's if they have any objection on the patch.
> 
> Regards,
> Santosh
> 
> From b95dd33fe59b8e77727eb3b1717d763bbf9a2893 Mon Sep 17 00:00:00 2001
> From: Sricharan R <r.sricharan@ti.com>
> Date: Fri, 5 Apr 2013 20:39:12 +0530
> Subject: [PATCH] ARM: AM33XX: hwmod data: Clean up the data file
> 
> - The IO resource information like dma request lines, irq number and
> ocp address space can be populated via dt blob. So such data can be
> stripped
> from SOC hwmod data file.
> 
> - The devices like adc, mailbox, gpmc which are missing the device
> tree bindings, hwmod data is not added since AM33XX is DT only build.
> When such devices add the dt bindings, respective hwmod data can be
> added along with it.
> 
This seems unnecessary churn to me. DT bindings for most of the devices 
which you mentioned above are submitted and are at various stages of review
process.

ADC:

GPMC:

PWM:


> - The hwmod like firewall etc which are not useful are also dropped.
> 
> This gets us around ~2000 loc of negative diff. Patch is boot tested on
> AM335X EVM.
> 
I would not recommend to get into unnecessary code churn in the future just 
to reduce temp Number of Lines of code. This will also kill our autogeneration 
concept as well.

I would suggest you to just alone drop base-addr, irq and dma references
from hwmod entries.

Thanks,
Vaibhav

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
> Patch has to be based of the dt branch and recent cleanups which are
> already in 3.10 queue. The patch also can be found on my git tree.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git
> for_3.10/am33xx_hwmod_cleanup
> 
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1993 +-------------------
> --------
>  1 file changed, 13 insertions(+), 1980 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 31bea1c..19a35e8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -35,63 +35,6 @@
>   */
> 
>  /*
> - * 'emif_fw' class
> - * instance(s): emif_fw
> - */
> -static struct omap_hwmod_class am33xx_emif_fw_hwmod_class = {
> -	.name		= "emif_fw",
> -};
> -
> -/* emif_fw */
> -static struct omap_hwmod am33xx_emif_fw_hwmod = {
> -	.name		= "emif_fw",
> -	.class		= &am33xx_emif_fw_hwmod_class,
> -	.clkdm_name	= "l4fw_clkdm",
> -	.main_clk	= "l4fw_gclk",
> -	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_EMIF_FW_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
> - * 'emif' class
> - * instance(s): emif
> - */
> -static struct omap_hwmod_class_sysconfig am33xx_emif_sysc = {
> -	.rev_offs	= 0x0000,
> -};
> -
> -static struct omap_hwmod_class am33xx_emif_hwmod_class = {
> -	.name		= "emif",
> -	.sysc		= &am33xx_emif_sysc,
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_emif_irqs[] = {
> -	{ .name = "ddrerr0", .irq = 101 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -/* emif */
> -static struct omap_hwmod am33xx_emif_hwmod = {
> -	.name		= "emif",
> -	.class		= &am33xx_emif_hwmod_class,
> -	.clkdm_name	= "l3_clkdm",
> -	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.mpu_irqs	= am33xx_emif_irqs,
> -	.main_clk	= "dpll_ddr_m2_div2_ck",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_EMIF_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
>   * 'l3' class
>   * instance(s): l3_main, l3_s, l3_instr
>   */
> @@ -99,19 +42,11 @@ static struct omap_hwmod_class
> am33xx_l3_hwmod_class = {
>  	.name		= "l3",
>  };
> 
> -/* l3_main (l3_fast) */
> -static struct omap_hwmod_irq_info am33xx_l3_main_irqs[] = {
> -	{ .name = "l3debug", .irq = 9 + OMAP_INTC_START, },
> -	{ .name = "l3appint", .irq = 10 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_l3_main_hwmod = {
>  	.name		= "l3_main",
>  	.class		= &am33xx_l3_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
>  	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.mpu_irqs	= am33xx_l3_main_irqs,
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -196,20 +131,6 @@ static struct omap_hwmod am33xx_l4_wkup_hwmod = {
>  	},
>  };
> 
> -/* l4_fw */
> -static struct omap_hwmod am33xx_l4_fw_hwmod = {
> -	.name		= "l4_fw",
> -	.class		= &am33xx_l4_hwmod_class,
> -	.clkdm_name	= "l4fw_clkdm",
> -	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_L4FW_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
>  /*
>   * 'mpu' class
>   */
> @@ -217,21 +138,11 @@ static struct omap_hwmod_class
> am33xx_mpu_hwmod_class = {
>  	.name	= "mpu",
>  };
> 
> -/* mpu */
> -static struct omap_hwmod_irq_info am33xx_mpu_irqs[] = {
> -	{ .name = "emuint", .irq = 0 + OMAP_INTC_START, },
> -	{ .name = "commtx", .irq = 1 + OMAP_INTC_START, },
> -	{ .name = "commrx", .irq = 2 + OMAP_INTC_START, },
> -	{ .name = "bench", .irq = 3 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_mpu_hwmod = {
>  	.name		= "mpu",
>  	.class		= &am33xx_mpu_hwmod_class,
>  	.clkdm_name	= "mpu_clkdm",
>  	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.mpu_irqs	= am33xx_mpu_irqs,
>  	.main_clk	= "dpll_mpu_m2_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -253,11 +164,6 @@ static struct omap_hwmod_rst_info
> am33xx_wkup_m3_resets[] = {
>  	{ .name = "wkup_m3", .rst_shift = 3, .st_shift = 5 },
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_wkup_m3_irqs[] = {
> -	{ .name = "txev", .irq = 78 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  /* wkup_m3  */
>  static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>  	.name		= "wkup_m3",
> @@ -265,7 +171,6 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>  	.clkdm_name	= "l4_wkup_aon_clkdm",
>  	/* Keep hardreset asserted */
>  	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
> -	.mpu_irqs	= am33xx_wkup_m3_irqs,
>  	.main_clk	= "dpll_core_m4_div2_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -291,25 +196,12 @@ static struct omap_hwmod_rst_info
> am33xx_pruss_resets[] = {
>  	{ .name = "pruss", .rst_shift = 1 },
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_pruss_irqs[] = {
> -	{ .name = "evtout0", .irq = 20 + OMAP_INTC_START, },
> -	{ .name = "evtout1", .irq = 21 + OMAP_INTC_START, },
> -	{ .name = "evtout2", .irq = 22 + OMAP_INTC_START, },
> -	{ .name = "evtout3", .irq = 23 + OMAP_INTC_START, },
> -	{ .name = "evtout4", .irq = 24 + OMAP_INTC_START, },
> -	{ .name = "evtout5", .irq = 25 + OMAP_INTC_START, },
> -	{ .name = "evtout6", .irq = 26 + OMAP_INTC_START, },
> -	{ .name = "evtout7", .irq = 27 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  /* pru-icss */
>  /* Pseudo hwmod for reset control purpose only */
>  static struct omap_hwmod am33xx_pruss_hwmod = {
>  	.name		= "pruss",
>  	.class		= &am33xx_pruss_hwmod_class,
>  	.clkdm_name	= "pruss_ocp_clkdm",
> -	.mpu_irqs	= am33xx_pruss_irqs,
>  	.main_clk	= "pruss_ocp_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -332,16 +224,10 @@ static struct omap_hwmod_rst_info
> am33xx_gfx_resets[] = {
>  	{ .name = "gfx", .rst_shift = 0 },
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_gfx_irqs[] = {
> -	{ .name = "gfxint", .irq = 37 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_gfx_hwmod = {
>  	.name		= "gfx",
>  	.class		= &am33xx_gfx_hwmod_class,
>  	.clkdm_name	= "gfx_l3_clkdm",
> -	.mpu_irqs	= am33xx_gfx_irqs,
>  	.main_clk	= "gfx_fck_div_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -370,43 +256,6 @@ static struct omap_hwmod am33xx_prcm_hwmod = {
>  };
> 
>  /*
> - * 'adc/tsc' class
> - * TouchScreen Controller (Anolog-To-Digital Converter)
> - */
> -static struct omap_hwmod_class_sysconfig am33xx_adc_tsc_sysc = {
> -	.rev_offs	= 0x00,
> -	.sysc_offs	= 0x10,
> -	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			SIDLE_SMART_WKUP),
> -	.sysc_fields	= &omap_hwmod_sysc_type2,
> -};
> -
> -static struct omap_hwmod_class am33xx_adc_tsc_hwmod_class = {
> -	.name		= "adc_tsc",
> -	.sysc		= &am33xx_adc_tsc_sysc,
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_adc_tsc_irqs[] = {
> -	{ .irq = 16 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_adc_tsc_hwmod = {
> -	.name		= "adc_tsc",
> -	.class		= &am33xx_adc_tsc_hwmod_class,
> -	.clkdm_name	= "l4_wkup_clkdm",
> -	.mpu_irqs	= am33xx_adc_tsc_irqs,
> -	.main_clk	= "adc_tsc_fck",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_WKUP_ADC_TSC_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
>   * Modules omap_hwmod structures
>   *
>   * The following IPs are excluded for the moment because:
> @@ -508,16 +357,10 @@ static struct omap_hwmod_class
> am33xx_aes_hwmod_class = {
>  	.name		= "aes",
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_aes0_irqs[] = {
> -	{ .irq = 102 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_aes0_hwmod = {
>  	.name		= "aes0",
>  	.class		= &am33xx_aes_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
> -	.mpu_irqs	= am33xx_aes0_irqs,
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -532,16 +375,10 @@ static struct omap_hwmod_class
> am33xx_sha0_hwmod_class = {
>  	.name		= "sha0",
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_sha0_irqs[] = {
> -	{ .irq = 108 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_sha0_hwmod = {
>  	.name		= "sha0",
>  	.class		= &am33xx_sha0_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
> -	.mpu_irqs	= am33xx_sha0_irqs,
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -577,17 +414,10 @@ static struct omap_hwmod_class
> am33xx_smartreflex_hwmod_class = {
>  	.name		= "smartreflex",
>  };
> 
> -/* smartreflex0 */
> -static struct omap_hwmod_irq_info am33xx_smartreflex0_irqs[] = {
> -	{ .irq = 120 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_smartreflex0_hwmod = {
>  	.name		= "smartreflex0",
>  	.class		= &am33xx_smartreflex_hwmod_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
> -	.mpu_irqs	= am33xx_smartreflex0_irqs,
>  	.main_clk	= "smartreflex0_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -597,17 +427,10 @@ static struct omap_hwmod
> am33xx_smartreflex0_hwmod = {
>  	},
>  };
> 
> -/* smartreflex1 */
> -static struct omap_hwmod_irq_info am33xx_smartreflex1_irqs[] = {
> -	{ .irq = 121 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_smartreflex1_hwmod = {
>  	.name		= "smartreflex1",
>  	.class		= &am33xx_smartreflex_hwmod_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
> -	.mpu_irqs	= am33xx_smartreflex1_irqs,
>  	.main_clk	= "smartreflex1_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -624,17 +447,11 @@ static struct omap_hwmod_class
> am33xx_control_hwmod_class = {
>  	.name		= "control",
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_control_irqs[] = {
> -	{ .irq = 8 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_control_hwmod = {
>  	.name		= "control",
>  	.class		= &am33xx_control_hwmod_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
>  	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.mpu_irqs	= am33xx_control_irqs,
>  	.main_clk	= "dpll_core_m4_div2_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -664,20 +481,11 @@ static struct omap_hwmod_class
> am33xx_cpgmac0_hwmod_class = {
>  	.sysc		= &am33xx_cpgmac_sysc,
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_cpgmac0_irqs[] = {
> -	{ .name = "c0_rx_thresh_pend", .irq = 40 + OMAP_INTC_START, },
> -	{ .name = "c0_rx_pend", .irq = 41 + OMAP_INTC_START, },
> -	{ .name = "c0_tx_pend", .irq = 42 + OMAP_INTC_START, },
> -	{ .name = "c0_misc_pend", .irq = 43 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_cpgmac0_hwmod = {
>  	.name		= "cpgmac0",
>  	.class		= &am33xx_cpgmac0_hwmod_class,
>  	.clkdm_name	= "cpsw_125mhz_clkdm",
>  	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
> -	.mpu_irqs	= am33xx_cpgmac0_irqs,
>  	.main_clk	= "cpsw_125mhz_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -708,18 +516,10 @@ static struct omap_hwmod_class
> am33xx_dcan_hwmod_class = {
>  	.name = "d_can",
>  };
> 
> -/* dcan0 */
> -static struct omap_hwmod_irq_info am33xx_dcan0_irqs[] = {
> -	{ .name = "d_can_ms", .irq = 52 + OMAP_INTC_START, },
> -	{ .name = "d_can_mo", .irq = 53 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_dcan0_hwmod = {
>  	.name		= "d_can0",
>  	.class		= &am33xx_dcan_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_dcan0_irqs,
>  	.main_clk	= "dcan0_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -729,17 +529,10 @@ static struct omap_hwmod am33xx_dcan0_hwmod = {
>  	},
>  };
> 
> -/* dcan1 */
> -static struct omap_hwmod_irq_info am33xx_dcan1_irqs[] = {
> -	{ .name = "d_can_ms", .irq = 55 + OMAP_INTC_START, },
> -	{ .name = "d_can_mo", .irq = 56 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
>  static struct omap_hwmod am33xx_dcan1_hwmod = {
>  	.name		= "d_can1",
>  	.class		= &am33xx_dcan_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_dcan1_irqs,
>  	.main_clk	= "dcan1_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -749,241 +542,6 @@ static struct omap_hwmod am33xx_dcan1_hwmod = {
>  	},
>  };
> 
> -/* elm */
> -static struct omap_hwmod_class_sysconfig am33xx_elm_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.syss_offs	= 0x0014,
> -	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
> -			SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
> -			SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class am33xx_elm_hwmod_class = {
> -	.name		= "elm",
> -	.sysc		= &am33xx_elm_sysc,
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_elm_irqs[] = {
> -	{ .irq = 4 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_elm_hwmod = {
> -	.name		= "elm",
> -	.class		= &am33xx_elm_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_elm_irqs,
> -	.main_clk	= "l4ls_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	= AM33XX_CM_PER_ELM_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* pwmss  */
> -static struct omap_hwmod_class_sysconfig am33xx_epwmss_sysc = {
> -	.rev_offs	= 0x0,
> -	.sysc_offs	= 0x4,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> -			SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
> -			MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
> -	.sysc_fields	= &omap_hwmod_sysc_type2,
> -};
> -
> -static struct omap_hwmod_class am33xx_epwmss_hwmod_class = {
> -	.name		= "epwmss",
> -	.sysc		= &am33xx_epwmss_sysc,
> -};
> -
> -static struct omap_hwmod_class am33xx_ecap_hwmod_class = {
> -	.name		= "ecap",
> -};
> -
> -static struct omap_hwmod_class am33xx_eqep_hwmod_class = {
> -	.name		= "eqep",
> -};
> -
> -static struct omap_hwmod_class am33xx_ehrpwm_hwmod_class = {
> -	.name		= "ehrpwm",
> -};
> -
> -/* epwmss0 */
> -static struct omap_hwmod am33xx_epwmss0_hwmod = {
> -	.name		= "epwmss0",
> -	.class		= &am33xx_epwmss_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.main_clk	= "l4ls_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* ecap0 */
> -static struct omap_hwmod_irq_info am33xx_ecap0_irqs[] = {
> -	{ .irq = 31 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_ecap0_hwmod = {
> -	.name		= "ecap0",
> -	.class		= &am33xx_ecap_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_ecap0_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* eqep0 */
> -static struct omap_hwmod_irq_info am33xx_eqep0_irqs[] = {
> -	{ .irq = 79 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_eqep0_hwmod = {
> -	.name		= "eqep0",
> -	.class		= &am33xx_eqep_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_eqep0_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* ehrpwm0 */
> -static struct omap_hwmod_irq_info am33xx_ehrpwm0_irqs[] = {
> -	{ .name = "int", .irq = 86 + OMAP_INTC_START, },
> -	{ .name = "tzint", .irq = 58 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_ehrpwm0_hwmod = {
> -	.name		= "ehrpwm0",
> -	.class		= &am33xx_ehrpwm_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_ehrpwm0_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* epwmss1 */
> -static struct omap_hwmod am33xx_epwmss1_hwmod = {
> -	.name		= "epwmss1",
> -	.class		= &am33xx_epwmss_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.main_clk	= "l4ls_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* ecap1 */
> -static struct omap_hwmod_irq_info am33xx_ecap1_irqs[] = {
> -	{ .irq = 47 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_ecap1_hwmod = {
> -	.name		= "ecap1",
> -	.class		= &am33xx_ecap_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_ecap1_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* eqep1 */
> -static struct omap_hwmod_irq_info am33xx_eqep1_irqs[] = {
> -	{ .irq = 88 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_eqep1_hwmod = {
> -	.name		= "eqep1",
> -	.class		= &am33xx_eqep_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_eqep1_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* ehrpwm1 */
> -static struct omap_hwmod_irq_info am33xx_ehrpwm1_irqs[] = {
> -	{ .name = "int", .irq = 87 + OMAP_INTC_START, },
> -	{ .name = "tzint", .irq = 59 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_ehrpwm1_hwmod = {
> -	.name		= "ehrpwm1",
> -	.class		= &am33xx_ehrpwm_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_ehrpwm1_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* epwmss2 */
> -static struct omap_hwmod am33xx_epwmss2_hwmod = {
> -	.name		= "epwmss2",
> -	.class		= &am33xx_epwmss_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.main_clk	= "l4ls_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* ecap2 */
> -static struct omap_hwmod_irq_info am33xx_ecap2_irqs[] = {
> -	{ .irq = 61 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_ecap2_hwmod = {
> -	.name		= "ecap2",
> -	.class		= &am33xx_ecap_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_ecap2_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* eqep2 */
> -static struct omap_hwmod_irq_info am33xx_eqep2_irqs[] = {
> -	{ .irq = 89 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_eqep2_hwmod = {
> -	.name		= "eqep2",
> -	.class		= &am33xx_eqep_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_eqep2_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
> -/* ehrpwm2 */
> -static struct omap_hwmod_irq_info am33xx_ehrpwm2_irqs[] = {
> -	{ .name = "int", .irq = 39 + OMAP_INTC_START, },
> -	{ .name = "tzint", .irq = 60 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_ehrpwm2_hwmod = {
> -	.name		= "ehrpwm2",
> -	.class		= &am33xx_ehrpwm_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_ehrpwm2_irqs,
> -	.main_clk	= "l4ls_gclk",
> -};
> -
>  /*
>   * 'gpio' class: for gpio 0,1,2,3
>   */
> @@ -1015,17 +573,11 @@ static struct omap_hwmod_opt_clk
> gpio0_opt_clks[] = {
>  	{ .role = "dbclk", .clk = "gpio0_dbclk" },
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_gpio0_irqs[] = {
> -	{ .irq = 96 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_gpio0_hwmod = {
>  	.name		= "gpio1",
>  	.class		= &am33xx_gpio_hwmod_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
>  	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.mpu_irqs	= am33xx_gpio0_irqs,
>  	.main_clk	= "dpll_core_m4_div2_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1039,11 +591,6 @@ static struct omap_hwmod am33xx_gpio0_hwmod = {
>  };
> 
>  /* gpio1 */
> -static struct omap_hwmod_irq_info am33xx_gpio1_irqs[] = {
> -	{ .irq = 98 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
>  	{ .role = "dbclk", .clk = "gpio1_dbclk" },
>  };
> @@ -1053,7 +600,6 @@ static struct omap_hwmod am33xx_gpio1_hwmod = {
>  	.class		= &am33xx_gpio_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
>  	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.mpu_irqs	= am33xx_gpio1_irqs,
>  	.main_clk	= "l4ls_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1067,11 +613,6 @@ static struct omap_hwmod am33xx_gpio1_hwmod = {
>  };
> 
>  /* gpio2 */
> -static struct omap_hwmod_irq_info am33xx_gpio2_irqs[] = {
> -	{ .irq = 32 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
>  	{ .role = "dbclk", .clk = "gpio2_dbclk" },
>  };
> @@ -1081,7 +622,6 @@ static struct omap_hwmod am33xx_gpio2_hwmod = {
>  	.class		= &am33xx_gpio_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
>  	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.mpu_irqs	= am33xx_gpio2_irqs,
>  	.main_clk	= "l4ls_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1095,11 +635,6 @@ static struct omap_hwmod am33xx_gpio2_hwmod = {
>  };
> 
>  /* gpio3 */
> -static struct omap_hwmod_irq_info am33xx_gpio3_irqs[] = {
> -	{ .irq = 62 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
>  	{ .role = "dbclk", .clk = "gpio3_dbclk" },
>  };
> @@ -1109,7 +644,6 @@ static struct omap_hwmod am33xx_gpio3_hwmod = {
>  	.class		= &am33xx_gpio_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
>  	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
> -	.mpu_irqs	= am33xx_gpio3_irqs,
>  	.main_clk	= "l4ls_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1122,42 +656,6 @@ static struct omap_hwmod am33xx_gpio3_hwmod = {
>  	.dev_attr	= &gpio_dev_attr,
>  };
> 
> -/* gpmc */
> -static struct omap_hwmod_class_sysconfig gpmc_sysc = {
> -	.rev_offs	= 0x0,
> -	.sysc_offs	= 0x10,
> -	.syss_offs	= 0x14,
> -	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
> -			SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class am33xx_gpmc_hwmod_class = {
> -	.name		= "gpmc",
> -	.sysc		= &gpmc_sysc,
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_gpmc_irqs[] = {
> -	{ .irq = 100 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_gpmc_hwmod = {
> -	.name		= "gpmc",
> -	.class		= &am33xx_gpmc_hwmod_class,
> -	.clkdm_name	= "l3s_clkdm",
> -	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> -	.mpu_irqs	= am33xx_gpmc_irqs,
> -	.main_clk	= "l3s_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
>  /* 'i2c' class */
>  static struct omap_hwmod_class_sysconfig am33xx_i2c_sysc = {
>  	.sysc_offs	= 0x0010,
> @@ -1182,23 +680,10 @@ static struct omap_i2c_dev_attr i2c_dev_attr = {
>  };
> 
>  /* i2c1 */
> -static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
> -	{ .irq = 70 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info i2c1_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 0, },
> -	{ .name = "rx", .dma_req = 0, },
> -	{ .dma_req = -1 }
> -};
> -
>  static struct omap_hwmod am33xx_i2c1_hwmod = {
>  	.name		= "i2c1",
>  	.class		= &i2c_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
> -	.mpu_irqs	= i2c1_mpu_irqs,
> -	.sdma_reqs	= i2c1_edma_reqs,
>  	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
>  	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
>  	.prcm		= {
> @@ -1211,23 +696,10 @@ static struct omap_hwmod am33xx_i2c1_hwmod = {
>  };
> 
>  /* i2c1 */
> -static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
> -	{ .irq = 71 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info i2c2_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 0, },
> -	{ .name = "rx", .dma_req = 0, },
> -	{ .dma_req = -1 }
> -};
> -
>  static struct omap_hwmod am33xx_i2c2_hwmod = {
>  	.name		= "i2c2",
>  	.class		= &i2c_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= i2c2_mpu_irqs,
> -	.sdma_reqs	= i2c2_edma_reqs,
>  	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
> @@ -1240,23 +712,10 @@ static struct omap_hwmod am33xx_i2c2_hwmod = {
>  };
> 
>  /* i2c3 */
> -static struct omap_hwmod_dma_info i2c3_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 0, },
> -	{ .name = "rx", .dma_req = 0, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
> -	{ .irq = 30 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_i2c3_hwmod = {
>  	.name		= "i2c3",
>  	.class		= &i2c_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= i2c3_mpu_irqs,
> -	.sdma_reqs	= i2c3_edma_reqs,
>  	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
> @@ -1268,292 +727,28 @@ static struct omap_hwmod am33xx_i2c3_hwmod = {
>  	.dev_attr	= &i2c_dev_attr,
>  };
> 
> -
> -/* lcdc */
> -static struct omap_hwmod_class_sysconfig lcdc_sysc = {
> -	.rev_offs	= 0x0,
> -	.sysc_offs	= 0x54,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type2,
> -};
> -
> -static struct omap_hwmod_class am33xx_lcdc_hwmod_class = {
> -	.name		= "lcdc",
> -	.sysc		= &lcdc_sysc,
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_lcdc_irqs[] = {
> -	{ .irq = 36 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_lcdc_hwmod = {
> -	.name		= "lcdc",
> -	.class		= &am33xx_lcdc_hwmod_class,
> -	.clkdm_name	= "lcdc_clkdm",
> -	.mpu_irqs	= am33xx_lcdc_irqs,
> -	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> -	.main_clk	= "lcd_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_LCDC_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
> - * 'mailbox' class
> - * mailbox module allowing communication between the on-chip
> processors using a
> - * queued mailbox-interrupt mechanism.
> - */
> -static struct omap_hwmod_class_sysconfig am33xx_mailbox_sysc = {
> -	.rev_offs	= 0x0000,
> -	.sysc_offs	= 0x0010,
> -	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
> -			  SYSC_HAS_SOFTRESET),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type2,
> -};
> -
> -static struct omap_hwmod_class am33xx_mailbox_hwmod_class = {
> -	.name	= "mailbox",
> -	.sysc	= &am33xx_mailbox_sysc,
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_mailbox_irqs[] = {
> -	{ .irq = 77 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_mailbox_hwmod = {
> -	.name		= "mailbox",
> -	.class		= &am33xx_mailbox_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_mailbox_irqs,
> -	.main_clk	= "l4ls_gclk",
> -	.prcm = {
> -		.omap4 = {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/*
> - * 'mcasp' class
> - */
> -static struct omap_hwmod_class_sysconfig am33xx_mcasp_sysc = {
> -	.rev_offs	= 0x0,
> -	.sysc_offs	= 0x4,
> -	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type3,
> -};
> -
> -static struct omap_hwmod_class am33xx_mcasp_hwmod_class = {
> -	.name		= "mcasp",
> -	.sysc		= &am33xx_mcasp_sysc,
> -};
> -
> -/* mcasp0 */
> -static struct omap_hwmod_irq_info am33xx_mcasp0_irqs[] = {
> -	{ .name = "ax", .irq = 80 + OMAP_INTC_START, },
> -	{ .name = "ar", .irq = 81 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mcasp0_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 8, },
> -	{ .name = "rx", .dma_req = 9, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_hwmod am33xx_mcasp0_hwmod = {
> -	.name		= "mcasp0",
> -	.class		= &am33xx_mcasp_hwmod_class,
> -	.clkdm_name	= "l3s_clkdm",
> -	.mpu_irqs	= am33xx_mcasp0_irqs,
> -	.sdma_reqs	= am33xx_mcasp0_edma_reqs,
> -	.main_clk	= "mcasp0_fck",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* mcasp1 */
> -static struct omap_hwmod_irq_info am33xx_mcasp1_irqs[] = {
> -	{ .name = "ax", .irq = 82 + OMAP_INTC_START, },
> -	{ .name = "ar", .irq = 83 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mcasp1_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 10, },
> -	{ .name = "rx", .dma_req = 11, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_hwmod am33xx_mcasp1_hwmod = {
> -	.name		= "mcasp1",
> -	.class		= &am33xx_mcasp_hwmod_class,
> -	.clkdm_name	= "l3s_clkdm",
> -	.mpu_irqs	= am33xx_mcasp1_irqs,
> -	.sdma_reqs	= am33xx_mcasp1_edma_reqs,
> -	.main_clk	= "mcasp1_fck",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* 'mmc' class */
> -static struct omap_hwmod_class_sysconfig am33xx_mmc_sysc = {
> -	.rev_offs	= 0x1fc,
> -	.sysc_offs	= 0x10,
> -	.syss_offs	= 0x14,
> -	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
> -			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> -			  SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> -	.sysc_fields	= &omap_hwmod_sysc_type1,
> -};
> -
> -static struct omap_hwmod_class am33xx_mmc_hwmod_class = {
> -	.name		= "mmc",
> -	.sysc		= &am33xx_mmc_sysc,
> -};
> -
> -/* mmc0 */
> -static struct omap_hwmod_irq_info am33xx_mmc0_irqs[] = {
> -	{ .irq = 64 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mmc0_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 24, },
> -	{ .name = "rx", .dma_req = 25, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_mmc_dev_attr am33xx_mmc0_dev_attr = {
> -	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> -};
> -
> -static struct omap_hwmod am33xx_mmc0_hwmod = {
> -	.name		= "mmc1",
> -	.class		= &am33xx_mmc_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_mmc0_irqs,
> -	.sdma_reqs	= am33xx_mmc0_edma_reqs,
> -	.main_clk	= "mmc_clk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -	.dev_attr	= &am33xx_mmc0_dev_attr,
> -};
> -
> -/* mmc1 */
> -static struct omap_hwmod_irq_info am33xx_mmc1_irqs[] = {
> -	{ .irq = 28 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mmc1_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 2, },
> -	{ .name = "rx", .dma_req = 3, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_mmc_dev_attr am33xx_mmc1_dev_attr = {
> -	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> -};
> -
> -static struct omap_hwmod am33xx_mmc1_hwmod = {
> -	.name		= "mmc2",
> -	.class		= &am33xx_mmc_hwmod_class,
> -	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_mmc1_irqs,
> -	.sdma_reqs	= am33xx_mmc1_edma_reqs,
> -	.main_clk	= "mmc_clk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -	.dev_attr	= &am33xx_mmc1_dev_attr,
> -};
> -
> -/* mmc2 */
> -static struct omap_hwmod_irq_info am33xx_mmc2_irqs[] = {
> -	{ .irq = 29 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mmc2_edma_reqs[] = {
> -	{ .name = "tx", .dma_req = 64, },
> -	{ .name = "rx", .dma_req = 65, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_mmc_dev_attr am33xx_mmc2_dev_attr = {
> -	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
> -};
> -static struct omap_hwmod am33xx_mmc2_hwmod = {
> -	.name		= "mmc3",
> -	.class		= &am33xx_mmc_hwmod_class,
> -	.clkdm_name	= "l3s_clkdm",
> -	.mpu_irqs	= am33xx_mmc2_irqs,
> -	.sdma_reqs	= am33xx_mmc2_edma_reqs,
> -	.main_clk	= "mmc_clk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -	.dev_attr	= &am33xx_mmc2_dev_attr,
> -};
> -
> -/*
> - * 'rtc' class
> - * rtc subsystem
> - */
> -static struct omap_hwmod_class_sysconfig am33xx_rtc_sysc = {
> -	.rev_offs	= 0x0074,
> -	.sysc_offs	= 0x0078,
> -	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_NO |
> -			  SIDLE_SMART | SIDLE_SMART_WKUP),
> -	.sysc_fields	= &omap_hwmod_sysc_type3,
> -};
> +/*
> + * 'rtc' class
> + * rtc subsystem
> + */
> +static struct omap_hwmod_class_sysconfig am33xx_rtc_sysc = {
> +	.rev_offs	= 0x0074,
> +	.sysc_offs	= 0x0078,
> +	.sysc_flags	= SYSC_HAS_SIDLEMODE,
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO |
> +			  SIDLE_SMART | SIDLE_SMART_WKUP),
> +	.sysc_fields	= &omap_hwmod_sysc_type3,
> +};
> 
>  static struct omap_hwmod_class am33xx_rtc_hwmod_class = {
>  	.name		= "rtc",
>  	.sysc		= &am33xx_rtc_sysc,
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_rtc_irqs[] = {
> -	{ .name = "rtcint", .irq = 75 + OMAP_INTC_START, },
> -	{ .name = "rtcalarmint", .irq = 76 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_rtc_hwmod = {
>  	.name		= "rtc",
>  	.class		= &am33xx_rtc_hwmod_class,
>  	.clkdm_name	= "l4_rtc_clkdm",
> -	.mpu_irqs	= am33xx_rtc_irqs,
>  	.main_clk	= "clk_32768_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1582,19 +777,6 @@ static struct omap_hwmod_class
> am33xx_spi_hwmod_class = {
>  };
> 
>  /* spi0 */
> -static struct omap_hwmod_irq_info am33xx_spi0_irqs[] = {
> -	{ .irq = 65 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mcspi0_edma_reqs[] = {
> -	{ .name = "rx0", .dma_req = 17 },
> -	{ .name = "tx0", .dma_req = 16 },
> -	{ .name = "rx1", .dma_req = 19 },
> -	{ .name = "tx1", .dma_req = 18 },
> -	{ .dma_req = -1 }
> -};
> -
>  static struct omap2_mcspi_dev_attr mcspi_attrib = {
>  	.num_chipselect	= 2,
>  };
> @@ -1602,8 +784,6 @@ static struct omap_hwmod am33xx_spi0_hwmod = {
>  	.name		= "spi0",
>  	.class		= &am33xx_spi_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_spi0_irqs,
> -	.sdma_reqs	= am33xx_mcspi0_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1615,25 +795,10 @@ static struct omap_hwmod am33xx_spi0_hwmod = {
>  };
> 
>  /* spi1 */
> -static struct omap_hwmod_irq_info am33xx_spi1_irqs[] = {
> -	{ .irq = 125 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod_dma_info am33xx_mcspi1_edma_reqs[] = {
> -	{ .name = "rx0", .dma_req = 43 },
> -	{ .name = "tx0", .dma_req = 42 },
> -	{ .name = "rx1", .dma_req = 45 },
> -	{ .name = "tx1", .dma_req = 44 },
> -	{ .dma_req = -1 }
> -};
> -
>  static struct omap_hwmod am33xx_spi1_hwmod = {
>  	.name		= "spi1",
>  	.class		= &am33xx_spi_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_spi1_irqs,
> -	.sdma_reqs	= am33xx_mcspi1_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1699,16 +864,10 @@ static struct omap_hwmod_class
> am33xx_timer1ms_hwmod_class = {
>  	.sysc		= &am33xx_timer1ms_sysc,
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer1_irqs[] = {
> -	{ .irq = 67 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer1_hwmod = {
>  	.name		= "timer1",
>  	.class		= &am33xx_timer1ms_hwmod_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
> -	.mpu_irqs	= am33xx_timer1_irqs,
>  	.main_clk	= "timer1_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1718,16 +877,10 @@ static struct omap_hwmod am33xx_timer1_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer2_irqs[] = {
> -	{ .irq = 68 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer2_hwmod = {
>  	.name		= "timer2",
>  	.class		= &am33xx_timer_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_timer2_irqs,
>  	.main_clk	= "timer2_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1737,16 +890,10 @@ static struct omap_hwmod am33xx_timer2_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer3_irqs[] = {
> -	{ .irq = 69 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer3_hwmod = {
>  	.name		= "timer3",
>  	.class		= &am33xx_timer_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_timer3_irqs,
>  	.main_clk	= "timer3_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1756,16 +903,10 @@ static struct omap_hwmod am33xx_timer3_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer4_irqs[] = {
> -	{ .irq = 92 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer4_hwmod = {
>  	.name		= "timer4",
>  	.class		= &am33xx_timer_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_timer4_irqs,
>  	.main_clk	= "timer4_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1775,16 +916,10 @@ static struct omap_hwmod am33xx_timer4_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer5_irqs[] = {
> -	{ .irq = 93 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer5_hwmod = {
>  	.name		= "timer5",
>  	.class		= &am33xx_timer_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_timer5_irqs,
>  	.main_clk	= "timer5_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1794,16 +929,10 @@ static struct omap_hwmod am33xx_timer5_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer6_irqs[] = {
> -	{ .irq = 94 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer6_hwmod = {
>  	.name		= "timer6",
>  	.class		= &am33xx_timer_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_timer6_irqs,
>  	.main_clk	= "timer6_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1813,16 +942,10 @@ static struct omap_hwmod am33xx_timer6_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_timer7_irqs[] = {
> -	{ .irq = 95 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_timer7_hwmod = {
>  	.name		= "timer7",
>  	.class		= &am33xx_timer_hwmod_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_timer7_irqs,
>  	.main_clk	= "timer7_fck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1837,18 +960,10 @@ static struct omap_hwmod_class
> am33xx_tpcc_hwmod_class = {
>  	.name		= "tpcc",
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_tpcc_irqs[] = {
> -	{ .name	= "edma0", .irq = 12 + OMAP_INTC_START, },
> -	{ .name = "edma0_mperr", .irq = 13 + OMAP_INTC_START, },
> -	{ .name	= "edma0_err", .irq = 14 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_tpcc_hwmod = {
>  	.name		= "tpcc",
>  	.class		= &am33xx_tpcc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
> -	.mpu_irqs	= am33xx_tpcc_irqs,
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1858,84 +973,6 @@ static struct omap_hwmod am33xx_tpcc_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_class_sysconfig am33xx_tptc_sysc = {
> -	.rev_offs	= 0x0,
> -	.sysc_offs	= 0x10,
> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> -			  SYSC_HAS_MIDLEMODE),
> -	.idlemodes	= (SIDLE_FORCE | SIDLE_SMART | MSTANDBY_FORCE),
> -	.sysc_fields	= &omap_hwmod_sysc_type2,
> -};
> -
> -/* 'tptc' class */
> -static struct omap_hwmod_class am33xx_tptc_hwmod_class = {
> -	.name		= "tptc",
> -	.sysc		= &am33xx_tptc_sysc,
> -};
> -
> -/* tptc0 */
> -static struct omap_hwmod_irq_info am33xx_tptc0_irqs[] = {
> -	{ .irq = 112 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_tptc0_hwmod = {
> -	.name		= "tptc0",
> -	.class		= &am33xx_tptc_hwmod_class,
> -	.clkdm_name	= "l3_clkdm",
> -	.mpu_irqs	= am33xx_tptc0_irqs,
> -	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> -	.main_clk	= "l3_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_TPTC0_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* tptc1 */
> -static struct omap_hwmod_irq_info am33xx_tptc1_irqs[] = {
> -	{ .irq = 113 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_tptc1_hwmod = {
> -	.name		= "tptc1",
> -	.class		= &am33xx_tptc_hwmod_class,
> -	.clkdm_name	= "l3_clkdm",
> -	.mpu_irqs	= am33xx_tptc1_irqs,
> -	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
> -	.main_clk	= "l3_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_TPTC1_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
> -/* tptc2 */
> -static struct omap_hwmod_irq_info am33xx_tptc2_irqs[] = {
> -	{ .irq = 114 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
> -static struct omap_hwmod am33xx_tptc2_hwmod = {
> -	.name		= "tptc2",
> -	.class		= &am33xx_tptc_hwmod_class,
> -	.clkdm_name	= "l3_clkdm",
> -	.mpu_irqs	= am33xx_tptc2_irqs,
> -	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
> -	.main_clk	= "l3_gclk",
> -	.prcm		= {
> -		.omap4	= {
> -			.clkctrl_offs	=
> AM33XX_CM_PER_TPTC2_CLKCTRL_OFFSET,
> -			.modulemode	= MODULEMODE_SWCTRL,
> -		},
> -	},
> -};
> -
>  /* 'uart' class */
>  static struct omap_hwmod_class_sysconfig uart_sysc = {
>  	.rev_offs	= 0x50,
> @@ -1954,23 +991,10 @@ static struct omap_hwmod_class uart_class = {
>  };
> 
>  /* uart1 */
> -static struct omap_hwmod_dma_info uart1_edma_reqs[] = {
> -	{ .name = "tx",	.dma_req = 26, },
> -	{ .name = "rx",	.dma_req = 27, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_uart1_irqs[] = {
> -	{ .irq = 72 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_uart1_hwmod = {
>  	.name		= "uart1",
>  	.class		= &uart_class,
>  	.clkdm_name	= "l4_wkup_clkdm",
> -	.mpu_irqs	= am33xx_uart1_irqs,
> -	.sdma_reqs	= uart1_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1980,17 +1004,10 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_uart2_irqs[] = {
> -	{ .irq = 73 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_uart2_hwmod = {
>  	.name		= "uart2",
>  	.class		= &uart_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_uart2_irqs,
> -	.sdma_reqs	= uart1_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -2001,23 +1018,10 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
>  };
> 
>  /* uart3 */
> -static struct omap_hwmod_dma_info uart3_edma_reqs[] = {
> -	{ .name = "tx",	.dma_req = 30, },
> -	{ .name = "rx",	.dma_req = 31, },
> -	{ .dma_req = -1 }
> -};
> -
> -static struct omap_hwmod_irq_info am33xx_uart3_irqs[] = {
> -	{ .irq = 74 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_uart3_hwmod = {
>  	.name		= "uart3",
>  	.class		= &uart_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_uart3_irqs,
> -	.sdma_reqs	= uart3_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -2027,17 +1031,10 @@ static struct omap_hwmod am33xx_uart3_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_uart4_irqs[] = {
> -	{ .irq = 44 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_uart4_hwmod = {
>  	.name		= "uart4",
>  	.class		= &uart_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_uart4_irqs,
> -	.sdma_reqs	= uart1_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -2047,17 +1044,10 @@ static struct omap_hwmod am33xx_uart4_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_uart5_irqs[] = {
> -	{ .irq = 45 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_uart5_hwmod = {
>  	.name		= "uart5",
>  	.class		= &uart_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_uart5_irqs,
> -	.sdma_reqs	= uart1_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -2067,17 +1057,10 @@ static struct omap_hwmod am33xx_uart5_hwmod = {
>  	},
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_uart6_irqs[] = {
> -	{ .irq = 46 + OMAP_INTC_START, },
> -	{ .irq = -1 },
> -};
> -
>  static struct omap_hwmod am33xx_uart6_hwmod = {
>  	.name		= "uart6",
>  	.class		= &uart_class,
>  	.clkdm_name	= "l4ls_clkdm",
> -	.mpu_irqs	= am33xx_uart6_irqs,
> -	.sdma_reqs	= uart1_edma_reqs,
>  	.main_clk	= "dpll_per_m2_div4_ck",
>  	.prcm		= {
>  		.omap4	= {
> @@ -2123,7 +1106,7 @@ static struct omap_hwmod am33xx_wd_timer1_hwmod =
> {
>  	},
>  };
> 
> -/*
> + /*
>   * 'usb_otg' class
>   * high-speed on-the-go universal serial bus (usb_otg) controller
>   */
> @@ -2141,18 +1124,10 @@ static struct omap_hwmod_class
> am33xx_usbotg_class = {
>  	.sysc		= &am33xx_usbhsotg_sysc,
>  };
> 
> -static struct omap_hwmod_irq_info am33xx_usbss_mpu_irqs[] = {
> -	{ .name = "usbss-irq", .irq = 17 + OMAP_INTC_START, },
> -	{ .name = "musb0-irq", .irq = 18 + OMAP_INTC_START, },
> -	{ .name = "musb1-irq", .irq = 19 + OMAP_INTC_START, },
> -	{ .irq = -1, },
> -};
> -
>  static struct omap_hwmod am33xx_usbss_hwmod = {
>  	.name		= "usb_otg_hs",
>  	.class		= &am33xx_usbotg_class,
>  	.clkdm_name	= "l3s_clkdm",
> -	.mpu_irqs	= am33xx_usbss_mpu_irqs,
>  	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
>  	.main_clk	= "usbotg_fck",
>  	.prcm		= {
> @@ -2163,36 +1138,9 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
>  	},
>  };
> 
> -
>  /*
>   * Interfaces
>   */
> -
> -/* l4 fw -> emif fw */
> -static struct omap_hwmod_ocp_if am33xx_l4_fw__emif_fw = {
> -	.master		= &am33xx_l4_fw_hwmod,
> -	.slave		= &am33xx_emif_fw_hwmod,
> -	.clk		= "l4fw_gclk",
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_emif_addrs[] = {
> -	{
> -		.pa_start	= 0x4c000000,
> -		.pa_end		= 0x4c000fff,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -/* l3 main -> emif */
> -static struct omap_hwmod_ocp_if am33xx_l3_main__emif = {
> -	.master		= &am33xx_l3_main_hwmod,
> -	.slave		= &am33xx_emif_hwmod,
> -	.clk		= "dpll_core_m4_ck",
> -	.addr		= am33xx_emif_addrs,
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
>  /* mpu -> l3 main */
>  static struct omap_hwmod_ocp_if am33xx_mpu__l3_main = {
>  	.master		= &am33xx_mpu_hwmod,
> @@ -2233,14 +1181,6 @@ static struct omap_hwmod_ocp_if
> am33xx_l3_s__l4_wkup = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> -/* l3 s -> l4 fw */
> -static struct omap_hwmod_ocp_if am33xx_l3_s__l4_fw = {
> -	.master		= &am33xx_l3_s_hwmod,
> -	.slave		= &am33xx_l4_fw_hwmod,
> -	.clk		= "l3s_gclk",
> -	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> -};
> -
>  /* l3 main -> l3 instr */
>  static struct omap_hwmod_ocp_if am33xx_l3_main__l3_instr = {
>  	.master		= &am33xx_l3_main_hwmod,
> @@ -2290,1154 +1230,277 @@ static struct omap_hwmod_ocp_if
> am33xx_gfx__l3_main = {
>  };
> 
>  /* l4 wkup -> wkup m3 */
> -static struct omap_hwmod_addr_space am33xx_wkup_m3_addrs[] = {
> -	{
> -		.name		= "umem",
> -		.pa_start	= 0x44d00000,
> -		.pa_end		= 0x44d00000 + SZ_16K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{
> -		.name		= "dmem",
> -		.pa_start	= 0x44d80000,
> -		.pa_end		= 0x44d80000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__wkup_m3 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_wkup_m3_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_wkup_m3_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l4 hs -> pru-icss */
> -static struct omap_hwmod_addr_space am33xx_pruss_addrs[] = {
> -	{
> -		.pa_start	= 0x4a300000,
> -		.pa_end		= 0x4a300000 + SZ_512K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_hs__pruss = {
>  	.master		= &am33xx_l4_hs_hwmod,
>  	.slave		= &am33xx_pruss_hwmod,
>  	.clk		= "dpll_core_m4_ck",
> -	.addr		= am33xx_pruss_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l3 main -> gfx */
> -static struct omap_hwmod_addr_space am33xx_gfx_addrs[] = {
> -	{
> -		.pa_start	= 0x56000000,
> -		.pa_end		= 0x56000000 + SZ_16M - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
>  	.master		= &am33xx_l3_main_hwmod,
>  	.slave		= &am33xx_gfx_hwmod,
>  	.clk		= "dpll_core_m4_ck",
> -	.addr		= am33xx_gfx_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l4 wkup -> smartreflex0 */
> -static struct omap_hwmod_addr_space am33xx_smartreflex0_addrs[] = {
> -	{
> -		.pa_start	= 0x44e37000,
> -		.pa_end		= 0x44e37000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__smartreflex0 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_smartreflex0_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_smartreflex0_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* l4 wkup -> smartreflex1 */
> -static struct omap_hwmod_addr_space am33xx_smartreflex1_addrs[] = {
> -	{
> -		.pa_start	= 0x44e39000,
> -		.pa_end		= 0x44e39000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__smartreflex1 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_smartreflex1_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_smartreflex1_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* l4 wkup -> control */
> -static struct omap_hwmod_addr_space am33xx_control_addrs[] = {
> -	{
> -		.pa_start	= 0x44e10000,
> -		.pa_end		= 0x44e10000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__control = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_control_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_control_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* l4 wkup -> rtc */
> -static struct omap_hwmod_addr_space am33xx_rtc_addrs[] = {
> -	{
> -		.pa_start	= 0x44e3e000,
> -		.pa_end		= 0x44e3e000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_rtc_hwmod,
>  	.clk		= "clkdiv32k_ick",
> -	.addr		= am33xx_rtc_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* l4 per/ls -> DCAN0 */
> -static struct omap_hwmod_addr_space am33xx_dcan0_addrs[] = {
> -	{
> -		.pa_start	= 0x481CC000,
> -		.pa_end		= 0x481CC000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__dcan0 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_dcan0_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_dcan0_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l4 per/ls -> DCAN1 */
> -static struct omap_hwmod_addr_space am33xx_dcan1_addrs[] = {
> -	{
> -		.pa_start	= 0x481D0000,
> -		.pa_end		= 0x481D0000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__dcan1 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_dcan1_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_dcan1_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l4 per/ls -> GPIO2 */
> -static struct omap_hwmod_addr_space am33xx_gpio1_addrs[] = {
> -	{
> -		.pa_start	= 0x4804C000,
> -		.pa_end		= 0x4804C000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__gpio1 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_gpio1_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_gpio1_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l4 per/ls -> gpio3 */
> -static struct omap_hwmod_addr_space am33xx_gpio2_addrs[] = {
> -	{
> -		.pa_start	= 0x481AC000,
> -		.pa_end		= 0x481AC000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__gpio2 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_gpio2_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_gpio2_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
>  /* l4 per/ls -> gpio4 */
> -static struct omap_hwmod_addr_space am33xx_gpio3_addrs[] = {
> -	{
> -		.pa_start	= 0x481AE000,
> -		.pa_end		= 0x481AE000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__gpio3 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_gpio3_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_gpio3_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> -/* L4 WKUP -> I2C1 */
> -static struct omap_hwmod_addr_space am33xx_i2c1_addr_space[] = {
> -	{
> -		.pa_start	= 0x44E0B000,
> -		.pa_end		= 0x44E0B000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__i2c1 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_i2c1_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_i2c1_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* L4 WKUP -> GPIO1 */
> -static struct omap_hwmod_addr_space am33xx_gpio0_addrs[] = {
> -	{
> -		.pa_start	= 0x44E07000,
> -		.pa_end		= 0x44E07000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__gpio0 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_gpio0_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_gpio0_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
> 
> -/* L4 WKUP -> ADC_TSC */
> -static struct omap_hwmod_addr_space am33xx_adc_tsc_addrs[] = {
> -	{
> -		.pa_start	= 0x44E0D000,
> -		.pa_end		= 0x44E0D000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_wkup__adc_tsc = {
> -	.master		= &am33xx_l4_wkup_hwmod,
> -	.slave		= &am33xx_adc_tsc_hwmod,
> -	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_adc_tsc_addrs,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_cpgmac0_addr_space[] = {
> -	/* cpsw ss */
> -	{
> -		.pa_start	= 0x4a100000,
> -		.pa_end		= 0x4a100000 + SZ_2K - 1,
> -	},
> -	/* cpsw wr */
> -	{
> -		.pa_start	= 0x4a101200,
> -		.pa_end		= 0x4a101200 + SZ_256 - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_hs__cpgmac0 = {
>  	.master		= &am33xx_l4_hs_hwmod,
>  	.slave		= &am33xx_cpgmac0_hwmod,
>  	.clk		= "cpsw_125mhz_gclk",
> -	.addr		= am33xx_cpgmac0_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -static struct omap_hwmod_addr_space am33xx_mdio_addr_space[] = {
> -	{
> -		.pa_start	= 0x4A101000,
> -		.pa_end		= 0x4A101000 + SZ_256 - 1,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
>  	.master		= &am33xx_cpgmac0_hwmod,
>  	.slave		= &am33xx_mdio_hwmod,
> -	.addr		= am33xx_mdio_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_elm_addr_space[] = {
> -	{
> -		.pa_start	= 0x48080000,
> -		.pa_end		= 0x48080000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_elm_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_elm_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_epwmss0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48300000,
> -		.pa_end		= 0x48300000 + SZ_16 - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_epwmss0_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_epwmss0_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_ecap0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48300100,
> -		.pa_end		= 0x48300100 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
> -	.master		= &am33xx_epwmss0_hwmod,
> -	.slave		= &am33xx_ecap0_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_ecap0_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -static struct omap_hwmod_addr_space am33xx_eqep0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48300180,
> -		.pa_end		= 0x48300180 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss0__eqep0 = {
> -	.master		= &am33xx_epwmss0_hwmod,
> -	.slave		= &am33xx_eqep0_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_eqep0_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_ehrpwm0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48300200,
> -		.pa_end		= 0x48300200 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss0__ehrpwm0 = {
> -	.master		= &am33xx_epwmss0_hwmod,
> -	.slave		= &am33xx_ehrpwm0_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_ehrpwm0_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -
> -static struct omap_hwmod_addr_space am33xx_epwmss1_addr_space[] = {
> -	{
> -		.pa_start	= 0x48302000,
> -		.pa_end		= 0x48302000 + SZ_16 - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_epwmss1_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_epwmss1_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_ecap1_addr_space[] = {
> -	{
> -		.pa_start	= 0x48302100,
> -		.pa_end		= 0x48302100 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss1__ecap1 = {
> -	.master		= &am33xx_epwmss1_hwmod,
> -	.slave		= &am33xx_ecap1_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_ecap1_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_eqep1_addr_space[] = {
> -	{
> -		.pa_start	= 0x48302180,
> -		.pa_end		= 0x48302180 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss1__eqep1 = {
> -	.master		= &am33xx_epwmss1_hwmod,
> -	.slave		= &am33xx_eqep1_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_eqep1_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_ehrpwm1_addr_space[] = {
> -	{
> -		.pa_start	= 0x48302200,
> -		.pa_end		= 0x48302200 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss1__ehrpwm1 = {
> -	.master		= &am33xx_epwmss1_hwmod,
> -	.slave		= &am33xx_ehrpwm1_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_ehrpwm1_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_epwmss2_addr_space[] = {
> -	{
> -		.pa_start	= 0x48304000,
> -		.pa_end		= 0x48304000 + SZ_16 - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_epwmss2_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_epwmss2_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_ecap2_addr_space[] = {
> -	{
> -		.pa_start	= 0x48304100,
> -		.pa_end		= 0x48304100 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss2__ecap2 = {
> -	.master		= &am33xx_epwmss2_hwmod,
> -	.slave		= &am33xx_ecap2_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_ecap2_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_eqep2_addr_space[] = {
> -	{
> -		.pa_start	= 0x48304180,
> -		.pa_end		= 0x48304180 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss2__eqep2 = {
> -	.master		= &am33xx_epwmss2_hwmod,
> -	.slave		= &am33xx_eqep2_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_eqep2_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_ehrpwm2_addr_space[] = {
> -	{
> -		.pa_start	= 0x48304200,
> -		.pa_end		= 0x48304200 + SZ_128 - 1,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2 = {
> -	.master		= &am33xx_epwmss2_hwmod,
> -	.slave		= &am33xx_ehrpwm2_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_ehrpwm2_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l3s cfg -> gpmc */
> -static struct omap_hwmod_addr_space am33xx_gpmc_addr_space[] = {
> -	{
> -		.pa_start	= 0x50000000,
> -		.pa_end		= 0x50000000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
> -	.master		= &am33xx_l3_s_hwmod,
> -	.slave		= &am33xx_gpmc_hwmod,
> -	.clk		= "l3s_gclk",
> -	.addr		= am33xx_gpmc_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* i2c2 */
> -static struct omap_hwmod_addr_space am33xx_i2c2_addr_space[] = {
> -	{
> -		.pa_start	= 0x4802A000,
> -		.pa_end		= 0x4802A000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__i2c2 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_i2c2_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_i2c2_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -static struct omap_hwmod_addr_space am33xx_i2c3_addr_space[] = {
> -	{
> -		.pa_start	= 0x4819C000,
> -		.pa_end		= 0x4819C000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_per__i2c3 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_i2c3_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_i2c3_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_lcdc_addr_space[] = {
> -	{
> -		.pa_start	= 0x4830E000,
> -		.pa_end		= 0x4830E000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_main__lcdc = {
> -	.master		= &am33xx_l3_main_hwmod,
> -	.slave		= &am33xx_lcdc_hwmod,
> -	.clk		= "dpll_core_m4_ck",
> -	.addr		= am33xx_lcdc_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -static struct omap_hwmod_addr_space am33xx_mailbox_addrs[] = {
> -	{
> -		.pa_start	= 0x480C8000,
> -		.pa_end		= 0x480C8000 + (SZ_4K - 1),
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -/* l4 ls -> mailbox */
> -static struct omap_hwmod_ocp_if am33xx_l4_per__mailbox = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_mailbox_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mailbox_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* l4 ls -> spinlock */
> -static struct omap_hwmod_addr_space am33xx_spinlock_addrs[] = {
> -	{
> -		.pa_start	= 0x480Ca000,
> -		.pa_end		= 0x480Ca000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_spinlock_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_spinlock_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> mcasp0 */
> -static struct omap_hwmod_addr_space am33xx_mcasp0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48038000,
> -		.pa_end		= 0x48038000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_mcasp0_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mcasp0_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l3 s -> mcasp0 data */
> -static struct omap_hwmod_addr_space am33xx_mcasp0_data_addr_space[] =
> {
> -	{
> -		.pa_start	= 0x46000000,
> -		.pa_end		= 0x46000000 + SZ_4M - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_s__mcasp0_data = {
> -	.master		= &am33xx_l3_s_hwmod,
> -	.slave		= &am33xx_mcasp0_hwmod,
> -	.clk		= "l3s_gclk",
> -	.addr		= am33xx_mcasp0_data_addr_space,
> -	.user		= OCP_USER_SDMA,
> -};
> -
> -/* l4 ls -> mcasp1 */
> -static struct omap_hwmod_addr_space am33xx_mcasp1_addr_space[] = {
> -	{
> -		.pa_start	= 0x4803C000,
> -		.pa_end		= 0x4803C000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_mcasp1_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mcasp1_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l3 s -> mcasp1 data */
> -static struct omap_hwmod_addr_space am33xx_mcasp1_data_addr_space[] =
> {
> -	{
> -		.pa_start	= 0x46400000,
> -		.pa_end		= 0x46400000 + SZ_4M - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_s__mcasp1_data = {
> -	.master		= &am33xx_l3_s_hwmod,
> -	.slave		= &am33xx_mcasp1_hwmod,
> -	.clk		= "l3s_gclk",
> -	.addr		= am33xx_mcasp1_data_addr_space,
> -	.user		= OCP_USER_SDMA,
> -};
> -
> -/* l4 ls -> mmc0 */
> -static struct omap_hwmod_addr_space am33xx_mmc0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48060100,
> -		.pa_end		= 0x48060100 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_mmc0_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mmc0_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l4 ls -> mmc1 */
> -static struct omap_hwmod_addr_space am33xx_mmc1_addr_space[] = {
> -	{
> -		.pa_start	= 0x481d8100,
> -		.pa_end		= 0x481d8100 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1 = {
> -	.master		= &am33xx_l4_ls_hwmod,
> -	.slave		= &am33xx_mmc1_hwmod,
> -	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mmc1_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l3 s -> mmc2 */
> -static struct omap_hwmod_addr_space am33xx_mmc2_addr_space[] = {
> -	{
> -		.pa_start	= 0x47810100,
> -		.pa_end		= 0x47810100 + SZ_64K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_s__mmc2 = {
> -	.master		= &am33xx_l3_s_hwmod,
> -	.slave		= &am33xx_mmc2_hwmod,
> -	.clk		= "l3s_gclk",
> -	.addr		= am33xx_mmc2_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l4 ls -> mcspi0 */
> -static struct omap_hwmod_addr_space am33xx_mcspi0_addr_space[] = {
> -	{
> -		.pa_start	= 0x48030000,
> -		.pa_end		= 0x48030000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi0 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_spi0_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mcspi0_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> mcspi1 */
> -static struct omap_hwmod_addr_space am33xx_mcspi1_addr_space[] = {
> -	{
> -		.pa_start	= 0x481A0000,
> -		.pa_end		= 0x481A0000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi1 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_spi1_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_mcspi1_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 wkup -> timer1 */
> -static struct omap_hwmod_addr_space am33xx_timer1_addr_space[] = {
> -	{
> -		.pa_start	= 0x44E31000,
> -		.pa_end		= 0x44E31000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__timer1 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_timer1_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_timer1_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 per -> timer2 */
> -static struct omap_hwmod_addr_space am33xx_timer2_addr_space[] = {
> -	{
> -		.pa_start	= 0x48040000,
> -		.pa_end		= 0x48040000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__timer2 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_timer2_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_timer2_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 per -> timer3 */
> -static struct omap_hwmod_addr_space am33xx_timer3_addr_space[] = {
> -	{
> -		.pa_start	= 0x48042000,
> -		.pa_end		= 0x48042000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__timer3 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_timer3_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_timer3_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 per -> timer4 */
> -static struct omap_hwmod_addr_space am33xx_timer4_addr_space[] = {
> -	{
> -		.pa_start	= 0x48044000,
> -		.pa_end		= 0x48044000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__timer4 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_timer4_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_timer4_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 per -> timer5 */
> -static struct omap_hwmod_addr_space am33xx_timer5_addr_space[] = {
> -	{
> -		.pa_start	= 0x48046000,
> -		.pa_end		= 0x48046000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__timer5 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_timer5_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_timer5_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 per -> timer6 */
> -static struct omap_hwmod_addr_space am33xx_timer6_addr_space[] = {
> -	{
> -		.pa_start	= 0x48048000,
> -		.pa_end		= 0x48048000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__timer6 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_timer6_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_timer6_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 per -> timer7 */
> -static struct omap_hwmod_addr_space am33xx_timer7_addr_space[] = {
> -	{
> -		.pa_start	= 0x4804A000,
> -		.pa_end		= 0x4804A000 + SZ_1K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__timer7 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_timer7_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_timer7_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l3 main -> tpcc */
> -static struct omap_hwmod_addr_space am33xx_tpcc_addr_space[] = {
> -	{
> -		.pa_start	= 0x49000000,
> -		.pa_end		= 0x49000000 + SZ_32K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l3_main__tpcc = {
>  	.master		= &am33xx_l3_main_hwmod,
>  	.slave		= &am33xx_tpcc_hwmod,
>  	.clk		= "l3_gclk",
> -	.addr		= am33xx_tpcc_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l3 main -> tpcc0 */
> -static struct omap_hwmod_addr_space am33xx_tptc0_addr_space[] = {
> -	{
> -		.pa_start	= 0x49800000,
> -		.pa_end		= 0x49800000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_main__tptc0 = {
> -	.master		= &am33xx_l3_main_hwmod,
> -	.slave		= &am33xx_tptc0_hwmod,
> -	.clk		= "l3_gclk",
> -	.addr		= am33xx_tptc0_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l3 main -> tpcc1 */
> -static struct omap_hwmod_addr_space am33xx_tptc1_addr_space[] = {
> -	{
> -		.pa_start	= 0x49900000,
> -		.pa_end		= 0x49900000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_main__tptc1 = {
> -	.master		= &am33xx_l3_main_hwmod,
> -	.slave		= &am33xx_tptc1_hwmod,
> -	.clk		= "l3_gclk",
> -	.addr		= am33xx_tptc1_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l3 main -> tpcc2 */
> -static struct omap_hwmod_addr_space am33xx_tptc2_addr_space[] = {
> -	{
> -		.pa_start	= 0x49a00000,
> -		.pa_end		= 0x49a00000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
> -static struct omap_hwmod_ocp_if am33xx_l3_main__tptc2 = {
> -	.master		= &am33xx_l3_main_hwmod,
> -	.slave		= &am33xx_tptc2_hwmod,
> -	.clk		= "l3_gclk",
> -	.addr		= am33xx_tptc2_addr_space,
> -	.user		= OCP_USER_MPU,
> -};
> -
> -/* l4 wkup -> uart1 */
> -static struct omap_hwmod_addr_space am33xx_uart1_addr_space[] = {
> -	{
> -		.pa_start	= 0x44E09000,
> -		.pa_end		= 0x44E09000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__uart1 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_uart1_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_uart1_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> uart2 */
> -static struct omap_hwmod_addr_space am33xx_uart2_addr_space[] = {
> -	{
> -		.pa_start	= 0x48022000,
> -		.pa_end		= 0x48022000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__uart2 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_uart2_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_uart2_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> uart3 */
> -static struct omap_hwmod_addr_space am33xx_uart3_addr_space[] = {
> -	{
> -		.pa_start	= 0x48024000,
> -		.pa_end		= 0x48024000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__uart3 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_uart3_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_uart3_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> uart4 */
> -static struct omap_hwmod_addr_space am33xx_uart4_addr_space[] = {
> -	{
> -		.pa_start	= 0x481A6000,
> -		.pa_end		= 0x481A6000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__uart4 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_uart4_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_uart4_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> uart5 */
> -static struct omap_hwmod_addr_space am33xx_uart5_addr_space[] = {
> -	{
> -		.pa_start	= 0x481A8000,
> -		.pa_end		= 0x481A8000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__uart5 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_uart5_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_uart5_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
> -/* l4 ls -> uart6 */
> -static struct omap_hwmod_addr_space am33xx_uart6_addr_space[] = {
> -	{
> -		.pa_start	= 0x481aa000,
> -		.pa_end		= 0x481aa000 + SZ_8K - 1,
> -		.flags		= ADDR_TYPE_RT,
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_ls__uart6 = {
>  	.master		= &am33xx_l4_ls_hwmod,
>  	.slave		= &am33xx_uart6_hwmod,
>  	.clk		= "l4ls_gclk",
> -	.addr		= am33xx_uart6_addr_space,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* l4 wkup -> wd_timer1 */
> -static struct omap_hwmod_addr_space am33xx_wd_timer1_addrs[] = {
> -	{
> -		.pa_start	= 0x44e35000,
> -		.pa_end		= 0x44e35000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l4_wkup__wd_timer1 = {
>  	.master		= &am33xx_l4_wkup_hwmod,
>  	.slave		= &am33xx_wd_timer1_hwmod,
>  	.clk		= "dpll_core_m4_div2_ck",
> -	.addr		= am33xx_wd_timer1_addrs,
>  	.user		= OCP_USER_MPU,
>  };
> 
>  /* usbss */
>  /* l3 s -> USBSS interface */
> -static struct omap_hwmod_addr_space am33xx_usbss_addr_space[] = {
> -	{
> -		.name		= "usbss",
> -		.pa_start	= 0x47400000,
> -		.pa_end		= 0x47400000 + SZ_4K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{
> -		.name		= "musb0",
> -		.pa_start	= 0x47401000,
> -		.pa_end		= 0x47401000 + SZ_2K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{
> -		.name		= "musb1",
> -		.pa_start	= 0x47401800,
> -		.pa_end		= 0x47401800 + SZ_2K - 1,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  static struct omap_hwmod_ocp_if am33xx_l3_s__usbss = {
>  	.master		= &am33xx_l3_s_hwmod,
>  	.slave		= &am33xx_usbss_hwmod,
>  	.clk		= "l3s_gclk",
> -	.addr		= am33xx_usbss_addr_space,
>  	.user		= OCP_USER_MPU,
>  	.flags		= OCPIF_SWSUP_IDLE,
>  };
> @@ -3450,13 +1513,10 @@ static struct omap_hwmod_ocp_if
> am33xx_l3_main__ocmc = {
>  };
> 
>  static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
> -	&am33xx_l4_fw__emif_fw,
> -	&am33xx_l3_main__emif,
>  	&am33xx_mpu__l3_main,
>  	&am33xx_mpu__prcm,
>  	&am33xx_l3_s__l4_ls,
>  	&am33xx_l3_s__l4_wkup,
> -	&am33xx_l3_s__l4_fw,
>  	&am33xx_l3_main__l4_hs,
>  	&am33xx_l3_main__l3_s,
>  	&am33xx_l3_main__l3_instr,
> @@ -3474,7 +1534,6 @@ static struct omap_hwmod_ocp_if
> *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l4_wkup__rtc,
>  	&am33xx_l4_wkup__i2c1,
>  	&am33xx_l4_wkup__gpio0,
> -	&am33xx_l4_wkup__adc_tsc,
>  	&am33xx_l4_wkup__wd_timer1,
>  	&am33xx_l4_hs__pruss,
>  	&am33xx_l4_per__dcan0,
> @@ -3484,14 +1543,6 @@ static struct omap_hwmod_ocp_if
> *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l4_per__gpio3,
>  	&am33xx_l4_per__i2c2,
>  	&am33xx_l4_per__i2c3,
> -	&am33xx_l4_per__mailbox,
> -	&am33xx_l4_ls__mcasp0,
> -	&am33xx_l3_s__mcasp0_data,
> -	&am33xx_l4_ls__mcasp1,
> -	&am33xx_l3_s__mcasp1_data,
> -	&am33xx_l4_ls__mmc0,
> -	&am33xx_l4_ls__mmc1,
> -	&am33xx_l3_s__mmc2,
>  	&am33xx_l4_ls__timer2,
>  	&am33xx_l4_ls__timer3,
>  	&am33xx_l4_ls__timer4,
> @@ -3505,26 +1556,8 @@ static struct omap_hwmod_ocp_if
> *am33xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l4_ls__uart5,
>  	&am33xx_l4_ls__uart6,
>  	&am33xx_l4_ls__spinlock,
> -	&am33xx_l4_ls__elm,
> -	&am33xx_l4_ls__epwmss0,
> -	&am33xx_epwmss0__ecap0,
> -	&am33xx_epwmss0__eqep0,
> -	&am33xx_epwmss0__ehrpwm0,
> -	&am33xx_l4_ls__epwmss1,
> -	&am33xx_epwmss1__ecap1,
> -	&am33xx_epwmss1__eqep1,
> -	&am33xx_epwmss1__ehrpwm1,
> -	&am33xx_l4_ls__epwmss2,
> -	&am33xx_epwmss2__ecap2,
> -	&am33xx_epwmss2__eqep2,
> -	&am33xx_epwmss2__ehrpwm2,
> -	&am33xx_l3_s__gpmc,
> -	&am33xx_l3_main__lcdc,
>  	&am33xx_l4_ls__mcspi0,
>  	&am33xx_l4_ls__mcspi1,
> -	&am33xx_l3_main__tptc0,
> -	&am33xx_l3_main__tptc1,
> -	&am33xx_l3_main__tptc2,
>  	&am33xx_l3_main__ocmc,
>  	&am33xx_l3_s__usbss,
>  	&am33xx_l4_hs__cpgmac0,
> --
> 1.7.9.5

