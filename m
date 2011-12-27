From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/2] mt_ventoux: support for TeeJet Mt.Ventoux board
Date: Tue, 27 Dec 2011 09:56:49 +0200
Message-ID: <4EF97A41.7050605@compulab.co.il>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com> <1324940912-18164-3-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43399
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750858Ab1L0H5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 02:57:07 -0500
In-Reply-To: <1324940912-18164-3-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sasha_d@emcraft.com

Hi Ilya,

On 12/27/11 01:08, Ilya Yanok wrote:
> This patch adds support for TeeJet Mt.Ventoux board based on TAM3517
> SOM. Supported devices:
>  - Serial
>  - Ethernet
>  - NAND
>  - USB host
>  - LCD
>  - Touchscreen
>  - CAN controller
>  - ADC128S converter
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> Requires updated machine-type file, recently posted AM35xx-EMAC patch
> and "Disable PM init on AM35{05,17} patch.
> 
>  arch/arm/mach-omap2/Kconfig                   |    6 +
>  arch/arm/mach-omap2/Makefile                  |    1 +
>  arch/arm/mach-omap2/board-am3517_mt_ventoux.c |  708 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h  |    1 +
>  4 files changed, 716 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am3517_mt_ventoux.c

[...]

> diff --git a/arch/arm/mach-omap2/board-am3517_mt_ventoux.c b/arch/arm/mach-omap2/board-am3517_mt_ventoux.c
> new file mode 100644
> index 0000000..d4501d9
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-am3517_mt_ventoux.c

[...]

> +/*
> + * use fake regulator for vdds_dsi as we can't find this pin inside
> + * AM3517 datasheet.
> + */
> +static struct regulator_consumer_supply mt_ventoux_vdds_dsi_supply[] = {
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
> +};

Although the TRM states that there is a vdds_dsi signal,
it looks, from the datasheet, that VDDSHV is used to power the DSS.
Either way, it can't be switched off, I think...
Therefore, depending on your board wiring, you can leave it as fixed
regulator or bind to a supply on TPS65023.

[...]

> +static struct i2c_board_info __initdata mt_ventoux_i2c1_devices[] = {
> +	{
> +		I2C_BOARD_INFO("tps65023", 0x48),
> +		.flags = I2C_CLIENT_WAKE,
> +		.platform_data = &mt_ventoux_regulator_data[0],
> +	},
> +        {
> +                I2C_BOARD_INFO("24c02", 0x50),
> +        },
> +};

Here (and may be in some other places) you have spaces for
indentation. Can it be tabs instead for uniformity (and file size)?

> +
> +static struct i2c_board_info __initdata mt_ventoux_i2c2_devices[] = {
> +        {
> +                I2C_BOARD_INFO("24c02", 0x50),
> +        },
> +};

also here...

[...]

> +#if defined(CONFIG_TOUCHSCREEN_ADS7846)

Can't the ADS7846 be module?

> +static struct ads7846_platform_data tsc2046_config __initdata = {
> +	.x_max			= 0x0fff,
> +	.y_max			= 0x0fff,
> +	.x_plate_ohms		= 180,
> +	.pressure_max		= 255,
> +	.debounce_max		= 30,
> +	.debounce_tol		= 10,
> +	.debounce_rep		= 1,
> +	.keep_vref_on		= 1,
> +	.settle_delay_usecs	= 100,
> +};
> +#endif

[...]

> +static void __init mt_ventoux_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	mt_ventoux_i2c_init();
> +	platform_add_devices(mt_ventoux_devices, ARRAY_SIZE(mt_ventoux_devices));
> +	mt_ventoux_serial_init();
> +	omap_sdrc_init(NULL, NULL);
> +
> +	mt_ventoux_display_init();
> +
> +	/* Configure EHCI ports */
> +	omap_mux_init_gpio(USB_PHY1_RESET, OMAP_PIN_OUTPUT);
> +	usbhs_init(&usbhs_bdata);
> +
> +	/* NAND */
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, mt_ventoux_nand_partitions,
> +			     ARRAY_SIZE(mt_ventoux_nand_partitions));
> +
> +	/* touchscreen */
> +	omap_mux_init_gpio(TS_IRQ_PIN, OMAP_PIN_INPUT);
> +	omap_ads7846_init(1, TS_IRQ_PIN, 310, &tsc2046_config);

Here you call omap_ads7846_init() irregardless to
CONFIG_TOUCHSCREEN_ADS7846, but the tsc2046_config is defined only
if it is enabled...
I think, either remove the #ifdef CONFIG_TOUCHSCREEN_ADS7846
or move the above to a separate function like
mt_ventoux_touch_init() and provide a static inline version of it
in case the CONFIG_TOUCHSCREEN_ADS7846 is not enabled (just like you
did for adc128s_init()).
Otherwise, various rand_configs will fail...

> +
> +	/* Ethernet */
> +	am35xx_ethernet_init(MCX_MDIO_FREQUENCY, 1);
> +
> +	/* MMC init */
> +	omap_mux_init_gpio(SD_CARD_CD, OMAP_PIN_INPUT);
> +	omap2_hsmmc_init(mmc);
> +
> +	/* ADC128S022 init */
> +	adc128s_init();

I think you are missing the __init annotation in the adc128s_init()
function definition (just noticed after snipping).

> +}

[...]


-- 
Regards,
Igor.
