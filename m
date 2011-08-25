From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH v3] OMAP3EVM: ehci: Fix EHCI support
Date: Thu, 25 Aug 2011 07:33:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC007D18@dbde02.ent.ti.com>
References: <1314203836-3799-1-git-send-email-bdefaria@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50499 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1HYCEC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 22:04:02 -0400
In-Reply-To: <1314203836-3799-1-git-send-email-bdefaria@adeneo-embedded.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan DE FARIA <bdefaria@adeneo-embedded.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,
[...]
>  arch/arm/mach-omap2/board-omap3evm.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index c452b3f..13a2b71 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct device
> *dev,
>  	if (r)
>  		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
> 
> +	/* gpio + 2 == HSUSB2 Clock Enable */
This comment should be modified. gpio+2 not only enables EHCI but also camera and
Audio lines.

> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> +		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW,
> "EN_HSUSB2_CLK");
This name "EN_HSUSB2_CLK" should also be changed.

Ajay

> +
>  	/* gpio + 7 == DVI Enable */
>  	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
> 
> @@ -450,6 +454,25 @@ static struct regulator_init_data omap3evm_vio = {
>  	.consumer_supplies	= omap3evm_vio_supply,
>  };
> 
> +/* VAUX2 for EHCI */
> +static struct regulator_consumer_supply omap3evm_vaux2_supplies[] = {
> +	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
> +};
> +
> +static struct regulator_init_data omap3evm_vaux2 = {
> +	.constraints = {
> +		.min_uV      		= 1800000,
> +		.max_uV      		= 1800000,
> +		.apply_uV    		= true,
> +		.valid_modes_mask  	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask  	= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = ARRAY_SIZE(omap3evm_vaux2_supplies),
> +	.consumer_supplies   	= omap3evm_vaux2_supplies,
> +};
> +
>  #ifdef CONFIG_WL12XX_PLATFORM_DATA
> 
>  #define OMAP3EVM_WLAN_PMENA_GPIO	(150)
> @@ -510,6 +533,8 @@ static int __init omap3_evm_i2c_init(void)
> 
>  	omap3evm_twldata.vdac->constraints.apply_uV = true;
>  	omap3evm_twldata.vpll2->constraints.apply_uV = true;
> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> +		omap3evm_twldata.vaux2 = &omap3evm_vaux2;
> 
>  	omap3_pmic_init("twl4030", &omap3evm_twldata);
>  	omap_register_i2c_bus(2, 400, NULL, 0);
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
