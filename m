From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during
 HWMOD init
Date: Thu, 26 May 2011 14:06:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D177F72@dbde02.ent.ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
 <1306375016-707-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54929 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188Ab1EZIhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 04:37:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4Q8axG2013644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 03:37:01 -0500
In-Reply-To: <1306375016-707-4-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Sonasath, Moiz" <m-sonasath@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, May 26, 2011 7:27 AM
> To: linux-omap
> Cc: Sonasath, Moiz; Menon, Nishanth
> Subject: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 
> during HWMOD init

[sp] typo in the subject. "DO" -> "Do"

     Another nit: Are 2 HWMODs required in the subject?

~sanjeev

> 
> From: Moiz Sonasath <m-sonasath@ti.com>
> 
> For OMAP4460, GPIO-7 of bank1 is used for controling
> the TPS modes, hence GPIO1 should not be reset
> during init as reset will cause the TPS voltage to
> drop to 0.9 V.
> 
> Originally from:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=52ae
> 4f0de03b17c064d9ce90a580230f1a596ec1
> 
> [nm@ti.com: upstream version]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   27 
> ++++++++++++++++++++++++---
>  1 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 2f51a5a..27319c4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1745,7 +1745,7 @@ static struct omap_hwmod_opt_clk 
> gpio1_opt_clks[] = {
>  	{ .role = "dbclk", .clk = "gpio1_dbclk" },
>  };
>  
> -static struct omap_hwmod omap44xx_gpio1_hwmod = {
> +static struct omap_hwmod omap443x_gpio1_hwmod = {
>  	.name		= "gpio1",
>  	.class		= &omap44xx_gpio_hwmod_class,
>  	.mpu_irqs	= omap44xx_gpio1_irqs,
> @@ -1761,7 +1761,27 @@ static struct omap_hwmod 
> omap44xx_gpio1_hwmod = {
>  	.dev_attr	= &gpio_dev_attr,
>  	.slaves		= omap44xx_gpio1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +static struct omap_hwmod omap446x_gpio1_hwmod = {
> +	.name		= "gpio1",
> +	.class		= &omap44xx_gpio_hwmod_class,
> +	.flags          = HWMOD_INIT_NO_RESET,
> +	.mpu_irqs	= omap44xx_gpio1_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
> +	.main_clk	= "gpio1_ick",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
> +		},
> +	},
> +	.opt_clks	= gpio1_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
> +	.dev_attr	= &gpio_dev_attr,
> +	.slaves		= omap44xx_gpio1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4460),
>  };
>  
>  /* gpio2 */
> @@ -5079,7 +5099,8 @@ static __initdata struct omap_hwmod 
> *omap44xx_hwmods[] = {
>  	&omap44xx_dss_venc_hwmod,
>  
>  	/* gpio class */
> -	&omap44xx_gpio1_hwmod,
> +	&omap443x_gpio1_hwmod,
> +	&omap446x_gpio1_hwmod,
>  	&omap44xx_gpio2_hwmod,
>  	&omap44xx_gpio3_hwmod,
>  	&omap44xx_gpio4_hwmod,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 