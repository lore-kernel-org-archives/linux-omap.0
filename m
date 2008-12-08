From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] TPS6235x driver added into the power regulator framework
Date: Mon, 8 Dec 2008 12:22:41 +0000
Message-ID: <20081208122240.GG5159@sirena.org.uk>
References: <1228730882-22328-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4508 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbYLHMWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2008 07:22:43 -0500
Content-Disposition: inline
In-Reply-To: <1228730882-22328-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Dec 08, 2008 at 03:38:02PM +0530, Manikandan Pillai wrote:
> Resending this patch after fixing comments received.
> CONFIG_OMAP3EVM_PR785 has been moved to arch/arm/mach-omap2/Kconfig
> MUX patch has been separated and sent out separately
> regulator/core.c changes have been separated and send out earlier
> Platform driver has been removed
> Renamed supplies to vdd1 and vdd2
> regulator_get_drvdata() is being used to get driver data

This really needs to be split up further into a patch series still.  The
new regulator driver should be added separately to the board stuff at
least, and any MFD patch should go in separately.

>  static int __init omap3_evm_i2c_init(void)
>  {
> +#if defined(CONFIG_OMAP3EVM_PR785)
> +	omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
> +		ARRAY_SIZE(tps_6235x_i2c_board_info));
> +#endif
> +#if defined(CONFIG_TWL4030_CORE)
>  	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
>  			ARRAY_SIZE(omap3evm_i2c_boardinfo));
> +#endif

Hrm.  If the relevant chips have ID registers it's probably possible to
detect which is present at run time in which case there should be one
set of board info.  If they don't and the code needs to be exclusive it
might be better to express that here.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 650b51c..ff5fbd5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -61,20 +61,6 @@ config UCB1400_CORE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ucb1400_core.
>  
> -config TWL4030_CORE
> -	bool "Texas Instruments TWL4030/TPS659x0 Support"
> -	depends on I2C=y && GENERIC_HARDIRQS
> -	help
> -	  Say yes here if you have TWL4030 family chip on your board.
> -	  This core driver provides register access and IRQ handling
> -	  facilities, and registers devices for the various functions
> -	  so that function-specific drivers can bind to them.
> -
> -	  These multi-function chips are found on many OMAP2 and OMAP3
> -	  boards, providing power management, RTC, GPIO, keypad, a
> -	  high speed USB OTG transceiver, an audio codec (on most
> -	  versions) and many other features.
> -

This should be left here - there's nothing specific to the board about
this configuration at all.

> +config REGULATOR_TPS6235X
> +	bool "TPS6235X Power regulator for OMAP3EVM"
> +	depends on I2C=y
> +	help
> +	  This driver supports the voltage regulators provided by TPS6235x chips.
> +	  The TPS62352 and TPS62353 are mounted on PR785 Power module card for
> +	  providing voltage regulator functions.
> +

The description should probably mention the manufacturer of the PR785
card to help people find it if they need to.

> --- /dev/null
> +++ b/drivers/regulator/tps6235x-regulator.c

> +/* Maximum number of bytes to be read in a single read */
> +#define PR785_RETRY_COUNT       0x3

As mentioned last time the name and comment don't seem to correspond to
each other.

> +#ifndef REGULATOR_MODE_OFF
> +#define REGULATOR_MODE_OFF 0
> +#endif

Remove this; you're not using it anyway.

> +/* Device addresses for PR785 card */
> +#define	PR785_62352_CORE_ADDR	0x4A
> +#define	PR785_62353_MPU_ADDR	0x48

This and all the other PR785 support shouldn't be in this driver, it
should be in a separate PR785 driver or the board driver.

> +EXPORT_SYMBOL(pr785_enbl_dcdc);

I'm not sure why this (and the other functions) are being exported?

> +static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
> +{
> +	struct  tps_6235x_info *tps_info =
> +		(struct tps_6235x_info *)rdev_get_drvdata(dev);
> +	return tps_info->state;
> +}

Uneeded cast (and similarly for all the other functions).

> +/* CORE voltage regulator */
> +static struct regulator_consumer_supply tps62352_core_consumers = {
> +	.supply = "vdd2",
> +};

> +/* MPU voltage regulator */
> +static struct regulator_consumer_supply tps62352_mpu_consumers = {
> +	.supply = "vdd1",
> +};

This is a machine driver and should be split out from the driver for teh
chips - normally I'd expect this stuff under arch/arm.

> @@ -97,12 +99,14 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
>  static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
>  						unsigned int level)
>  {
> +#if defined(CONFIG_TWL4030_CORE)
>  	u8 c;
>  	if ((level >= 0) && (level <= 100)) {
>  		c = (125 * (100 - level)) / 100 + 2;
>  		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
>  		bklight_level = level;
>  	}
> +#endif
>  	return 0;
>  }

This isn't ideal - it reports that it's succesfully updated the
backlight even if it can't.
