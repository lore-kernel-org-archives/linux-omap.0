From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: Regression with AM43xx devices
Date: Tue, 2 Jun 2015 14:25:40 -0500
Message-ID: <556E0334.2020603@ti.com>
References: <20150602191752.GE9623@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52177 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbbFBT0L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 15:26:11 -0400
In-Reply-To: <20150602191752.GE9623@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On 06/02/2015 02:17 PM, Felipe Balbi wrote:
> Hi Dave,
> 
> You commit fabbe6df130a46d5b5e7484b2273d69c4be3012a (ARM: OMAP: AM43xx
> hwmod: Add data for am43xx emif hwmod) listed below added a new WARNING
> during boot to all AM43xx-based boards. Full boot logs can be found at
> [1], but it seems like we should, at least for the merge window, revert
> said commit unless a fix could come it the next couple days or so.o
> 
> ps: note that boot log is for AM43xx IDK, but the same thing has been
> reproduced on AM437x SK.
> 
> [1] http://hastebin.com/kasenikevo
> 

This is because the base address will come from the DT node, patch is here:
http://www.spinics.net/lists/arm-kernel/msg416286.html

Regards,
Dave

> ------------------------------------------------------------------------
> 
> commit fabbe6df130a46d5b5e7484b2273d69c4be3012a
> Author: Dave Gerlach <d-gerlach@ti.com>
> Date:   Mon Jun 1 19:22:11 2015 -0600
> 
>     ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod
>     
>     Without a hwmod for am43xx emif use counting for emif clockdomain does
>     not happen correctly so it may be shut off by pm code unintentionally.
>     
>     Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>     [paul@pwsan.com: updated to apply]
>     Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> index 130332c0534d..7f737965f543 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> @@ -145,6 +145,7 @@ extern struct omap_hwmod am33xx_uart5_hwmod;
>  extern struct omap_hwmod am33xx_uart6_hwmod;
>  extern struct omap_hwmod am33xx_wd_timer1_hwmod;
>  
> +extern struct omap_hwmod_class am33xx_emif_hwmod_class;
>  extern struct omap_hwmod_class am33xx_l4_hwmod_class;
>  extern struct omap_hwmod_class am33xx_wkup_m3_hwmod_class;
>  extern struct omap_hwmod_class am33xx_control_hwmod_class;
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> index ae0cb673a3d1..907a452b78ea 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> @@ -203,6 +203,19 @@ struct omap_hwmod am33xx_prcm_hwmod = {
>  };
>  
>  /*
> + * 'emif' class
> + * instance(s): emif
> + */
> +static struct omap_hwmod_class_sysconfig am33xx_emif_sysc = {
> +	.rev_offs	= 0x0000,
> +};
> +
> +struct omap_hwmod_class am33xx_emif_hwmod_class = {
> +	.name		= "emif",
> +	.sysc		= &am33xx_emif_sysc,
> +};
> +
> +/*
>   * 'aes0' class
>   */
>  static struct omap_hwmod_class_sysconfig am33xx_aes0_sysc = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 0cf7b563dcd1..cc0791d9125b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -34,19 +34,6 @@
>   * IP blocks
>   */
>  
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
>  /* emif */
>  static struct omap_hwmod am33xx_emif_hwmod = {
>  	.name		= "emif",
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index 17e8004fc20f..215d5efa0dba 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> @@ -24,6 +24,20 @@
>  
>  
>  /* IP blocks */
> +static struct omap_hwmod am43xx_emif_hwmod = {
> +	.name		= "emif",
> +	.class		= &am33xx_emif_hwmod_class,
> +	.clkdm_name	= "emif_clkdm",
> +	.flags		= HWMOD_INIT_NO_IDLE,
> +	.main_clk	= "dpll_ddr_m2_ck",
> +	.prcm		= {
> +		.omap4	= {
> +			.clkctrl_offs	= AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET,
> +			.modulemode	= MODULEMODE_SWCTRL,
> +		},
> +	},
> +};
> +
>  static struct omap_hwmod am43xx_l4_hs_hwmod = {
>  	.name		= "l4_hs",
>  	.class		= &am33xx_l4_hwmod_class,
> @@ -583,6 +597,13 @@ static struct omap_hwmod am43xx_vpfe1_hwmod = {
>  };
>  
>  /* Interfaces */
> +static struct omap_hwmod_ocp_if am43xx_l3_main__emif = {
> +	.master		= &am33xx_l3_main_hwmod,
> +	.slave		= &am43xx_emif_hwmod,
> +	.clk		= "dpll_core_m4_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
>  	.master		= &am33xx_l3_main_hwmod,
>  	.slave		= &am43xx_l4_hs_hwmod,
> @@ -918,6 +939,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>  	&am33xx_l3_main__l3_instr,
>  	&am33xx_l3_main__gfx,
>  	&am33xx_l3_s__l3_main,
> +	&am43xx_l3_main__emif,
>  	&am33xx_pruss__l3_main,
>  	&am43xx_wkup_m3__l4_wkup,
>  	&am33xx_gfx__l3_main,
> diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
> index d0261996db6d..7eebc27fa892 100644
> --- a/arch/arm/mach-omap2/prcm43xx.h
> +++ b/arch/arm/mach-omap2/prcm43xx.h
> @@ -146,4 +146,6 @@
>  #define AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET		0x04a0
>  #define AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET		0x0068
>  #define AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET		0x0070
> +#define AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET		0x0720
> +
>  #endif
> 
> --------------------------------------------------------------------------
> 
> git bisect start
> # good: [e26081808edadfd257c6c9d81014e3b25e9a6118] Linux 4.1-rc4
> git bisect good e26081808edadfd257c6c9d81014e3b25e9a6118
> # bad: [073c2e3b6d0b06be76e9d80e0879a95f7bd4a421] Merge tag 'omap-for-v4.2/o2_dc' into for-next
> git bisect bad 073c2e3b6d0b06be76e9d80e0879a95f7bd4a421
> # good: [f044523a11ca9b32bfa7f663cded1071e55fb51a] Merge branch 'omap-for-v4.2/dt' into for-next
> git bisect good f044523a11ca9b32bfa7f663cded1071e55fb51a
> # good: [c663484536a2c3f7be583b72c014a850dd1b43c6] Merge tag 'omap-for-v4.1/fixes-rc6' into for-next
> git bisect good c663484536a2c3f7be583b72c014a850dd1b43c6
> # good: [5fbfa07151978e2432bc4321003ac2c40d22382d] Merge tag 'omap-for-v4.2/wakeirq-drivers' into for-next
> git bisect good 5fbfa07151978e2432bc4321003ac2c40d22382d
> # bad: [436bbc12452c23b9e7385f3fcabc82fdd387a55a] Merge tag 'for-v4.2/omap-hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v4.2/soc
> git bisect bad 436bbc12452c23b9e7385f3fcabc82fdd387a55a
> # bad: [fabbe6df130a46d5b5e7484b2273d69c4be3012a] ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod
> git bisect bad fabbe6df130a46d5b5e7484b2273d69c4be3012a
> # good: [63aa945b1013c34b145dcf218d4ea323cbd93f86] memory: omap-gpmc: Add Kconfig option for debug
> git bisect good 63aa945b1013c34b145dcf218d4ea323cbd93f86
> # first bad commit: [fabbe6df130a46d5b5e7484b2273d69c4be3012a] ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod
> 

