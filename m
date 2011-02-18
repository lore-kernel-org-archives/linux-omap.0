From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: omap3evm: add support for the WL12xx WLAN module
 to the AM/DM3xx Evaluation Module
Date: Fri, 18 Feb 2011 21:03:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024B83BFDA@dbde02.ent.ti.com>
References: <EC51CDB0807A51469E0C9CB8CF72D65F032D484171@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab1BRPd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 10:33:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IFXswB006579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 09:33:56 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IFXrmi007077
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 21:03:53 +0530 (IST)
In-Reply-To: <EC51CDB0807A51469E0C9CB8CF72D65F032D484171@dnce02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reizer, Eyal" <eyalr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Reizer, Eyal
> Sent: Thursday, January 27, 2011 3:20 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] omap: omap3evm: add support for the WL12xx WLAN module to
> the AM/DM3xx Evaluation Module

[sp] prefix "omap:" seems redundant when "omap3evm" is specified.
     Similarly, " the AM/DM3xx Evaluation Module" seems redundant
     when "omap3evm" is specified.

> 
> Adds platform initialization for working with the WLAN module attached to
> the evaluation module.
> The patch includes MMC2 initialization, SDIO and control pins muxing and
> platform device registration

[sp] The description text has too many characters per line.
     Consider reformatting the same.

> 
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   78
> ++++++++++++++++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index 323c380..2d2092a 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -30,6 +30,8 @@
>  #include <linux/usb/otg.h>
>  #include <linux/smsc911x.h>
> 
> +#include <linux/wl12xx.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/mmc/host.h>
> 
> @@ -381,6 +383,16 @@ static struct omap2_hsmmc_info mmc[] = {
>  		.gpio_cd	= -EINVAL,
>  		.gpio_wp	= 63,
>  	},
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA

[sp] Haven't seen this config option earlier.
     Just wanted to know where is this defined?
     Any reason why simple CONFIG_WL12XX wasn't sufficient?

> +	{
> +		.name		= "wl1271",
> +		.mmc            = 2,

[sp] There are spaces before "=". Stands apart from
     rest of the assignments in this block.

> +		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
> +		.gpio_wp	= -EINVAL,
> +		.gpio_cd	= -EINVAL,
> +		.nonremovable	= true,
> +	},
> +#endif
>  	{}	/* Terminator */
>  };
> 
> @@ -538,6 +550,50 @@ static struct regulator_init_data omap3_evm_vpll2 = {
>  	.consumer_supplies	= &omap3_evm_vpll2_supply,
>  };
> 
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> +
> +#define OMAP3EVM_WLAN_PMENA_GPIO	(150)
> +#define OMAP3EVM_WLAN_IRQ_GPIO		(149)
> +
> +static struct regulator_consumer_supply omap3evm_vmmc2_supply = {
> +	.supply			= "vmmc",
> +	.dev_name		= "mmci-omap-hs.1",
> +};

[sp] Consider use of macro REGULATOR_SUPPLY() here.

> +
> +/* VMMC2 for driving the WL12xx module */
> +static struct regulator_init_data omap3evm_vmmc2 = {

[sp] Consider following the convention is rest of the file
     e.g. omap3_evm_vdac, omap3_evm_vpll2, omap3_evm_vusb.

     I see another exception to this convention; in the current
     file but that should be fixed.

> +	.constraints = {
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,

[sp] Any specific reason for not including REGULATOR_CHANGE_MODE
     in the mask above?

> +	},
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies = &omap3evm_vmmc2_supply,
> +};
> +
> +static struct fixed_voltage_config omap3evm_vwlan = {
> +	.supply_name		= "vwl1271",
> +	.microvolts		= 1800000, /* 1.80V */
> +	.gpio			= OMAP3EVM_WLAN_PMENA_GPIO,
> +	.startup_delay		= 70000, /* 70ms */
> +	.enable_high		= 1,
> +	.enabled_at_boot	= 0,
> +	.init_data		= &omap3evm_vmmc2,
> +};
> +
> +static struct platform_device omap3evm_vwlan_device = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 1,
> +	.dev = {
> +		.platform_data	= &omap3evm_vwlan,
> +	},
> +};

[sp] The name of platform device here apears to be name of regulator.
     Otherwise, should you explain why it is named "reg-fixed-voltage".

> +
> +struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
> +	.irq = OMAP_GPIO_IRQ(OMAP3EVM_WLAN_IRQ_GPIO),
> +	/* ref clock is 38.4 MHz */
> +	.board_ref_clock = 2,

[sp] Suggest putting the comment on ref clock after the assignment.

> +};
> +#endif
> +
>  static struct twl4030_platform_data omap3evm_twldata = {
>  	.irq_base	= TWL4030_IRQ_BASE,
>  	.irq_end	= TWL4030_IRQ_END,
> @@ -658,6 +714,21 @@ static struct omap_board_mux board_mux[] __initdata =
> {
>  				OMAP_PIN_OFF_WAKEUPENABLE),
>  	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
>  				OMAP_PIN_OFF_INPUT_PULLUP |
> OMAP_PIN_OFF_OUTPUT_LOW),
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> +	/* WLAN IRQ - GPIO 149 */
> +	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
> +
> +	/* WLAN POWER ENABLE - GPIO 150 */
> +	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +
> +	/* MMC2 SDIO pin muxes for WL12xx */
> +	OMAP3_MUX(SDMMC2_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(SDMMC2_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(SDMMC2_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(SDMMC2_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(SDMMC2_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
> +	OMAP3_MUX(SDMMC2_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),

[sp] What about the MUX settings corresponding to OFF mode?
     OR, Do you believe that these are sufficient for WLAN to work
     with OFF mode enabled.

> +#endif
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #endif
> @@ -715,6 +786,13 @@ static void __init omap3_evm_init(void)
>  	ads7846_dev_init();
>  	omap3evm_init_smsc911x();
>  	omap3_evm_display_init();
> +
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> +	/* WL12xx WLAN Init */
> +	if (wl12xx_set_platform_data(&omap3evm_wlan_data))
> +		pr_err("error setting wl12xx data\n");
> +	platform_device_register(&omap3evm_vwlan_device);
> +#endif
>  }
> 
>  MACHINE_START(OMAP3EVM, "OMAP3 EVM")
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
