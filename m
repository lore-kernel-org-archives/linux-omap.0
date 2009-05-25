From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/6] ARM: OMAP3: Initialize more devices for LDP
Date: Mon, 25 May 2009 13:59:20 +0100
Message-ID: <20090525125920.GD30553@n2100.arm.linux.org.uk>
References: <20090522223543.31586.44534.stgit@localhost> <20090522224541.31586.68943.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48439 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZEYM71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 08:59:27 -0400
Content-Disposition: inline
In-Reply-To: <20090522224541.31586.68943.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, May 22, 2009 at 03:45:41PM -0700, Tony Lindgren wrote:
> +static struct regulator_consumer_supply ldp_vmmc1_supply = {
> +	.supply			= "vmmc",
> +};
> +
> +/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
> +static struct regulator_init_data ldp_vmmc1 = {
> +	.consumer_supplies	= &ldp_vmmc1_supply,
> +};
> +
>  static struct twl4030_platform_data ldp_twldata = {
> +	.vmmc1		= &ldp_vmmc1,
>  };
>  
>  static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {

> @@ -185,9 +379,17 @@ static void __init omap_ldp_init(void)
>  	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
>  	omap_board_config = ldp_config;
>  	omap_board_config_size = ARRAY_SIZE(ldp_config);
> +	ts_gpio = 54;
> +	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
> +	spi_register_board_info(ldp_spi_board_info,
> +				ARRAY_SIZE(ldp_spi_board_info));
> +	ads7846_dev_init();
>  	omap_serial_init();
> -	twl4030_mmc_init(mmc);
>  	usb_musb_init();
> +
> +	twl4030_mmc_init(mmc);
> +	/* link regulators to MMC adapters */
> +	ldp_vmmc1_supply.dev = mmc[0].dev;

This feels wrong - setup after registering devices.  All it takes is to
have to move various device drivers to be earlier in the initialization
ordering and things start breaking in unexpected ways.

If MMC controls the Vmmc1 supply, then why does the Vmmc1 supply need
the struct device pointer for the MMC controller?
