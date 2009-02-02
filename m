From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Add and build TPS6235x based PR785 board support
Date: Mon, 2 Feb 2009 11:59:51 +0000
Message-ID: <20090202115951.GC16510@sirena.org.uk>
References: <1233568325-6938-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4103 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbZBBL7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 06:59:53 -0500
Content-Disposition: inline
In-Reply-To: <1233568325-6938-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Feb 02, 2009 at 03:22:05PM +0530, Manikandan Pillai wrote:

> +int omap_i2c_register_child(struct platform_device *pdev_parent,
> +			const char *name, struct platform_device **pdev)
> +{

> +	(*pdev)->dev.parent = &pdev_parent->dev;
> +	if (!strcmp(name, "vdd2_consumer"))
> +		(*pdev)->dev.platform_data = &vdd2_tps_regulator_data;
> +	else if (!strcmp(name, "vdd1_consumer"))
> +		(*pdev)->dev.platform_data = &vdd1_tps_regulator_data;

With a name like that this function shouldn't have this sort of device
specific stuff in it.  I'm really not clear what you're trying to do
here so it's difficult to comment in any detail.

> +	/* Initialize the regulator consumer platform devices here */
> +	pdev = &omap_i2c_devices[0];
> +	omap_i2c_register_child(pdev, "vdd2_consumer", \
> +		&vdd2_platform_device);
> +	omap_i2c_register_child(pdev, "vdd1_consumer", \
> +		&vdd1_platform_device);
> +	tps62352_core_consumers.dev = &vdd2_platform_device->dev;
> +	tps62352_mpu_consumers.dev = &vdd1_platform_device->dev;

The concerns previously raised by myself and David still appear to exist
here: you shouldn't be adding platform devices as children of the I2C
controller like this and the "vdd1_consumer" and "vdd2_consumer" names
look very suspicious - I'd be surprised to see someone adding a device
driver with either name.

Given the large number of interations this has been through I feel it
would be better if you were to remove configuration of the consumers
from this patch and then add it in later along with the code for the
consumer devices.  I expect that review of the drivers for the consumer
devices is likely to also address the issues here.

>  #define OMAP_I2C_SIZE		0x3f
>  #define OMAP1_I2C_BASE		0xfffb3800
> @@ -69,7 +71,7 @@ static struct resource i2c_resources[][2] = {
>  	}
>  
>  static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
> -static struct platform_device omap_i2c_devices[] = {
> +struct platform_device omap_i2c_devices[] = {
>  	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
>  #if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),

You should not need to do this.

> diff --git a/drivers/regulator/tps6235x-regulator.c b/drivers/regulator/tps6235x-regulator.c
> index f10fae6..36e6fcf 100644
> --- a/drivers/regulator/tps6235x-regulator.c
> +++ b/drivers/regulator/tps6235x-regulator.c
> @@ -82,12 +82,12 @@ static inline int tps_6235x_write_reg(struct tps *tps, u8 reg, u8 val)

As previously mentioned you should merge this in with the regulator
patch if it is required.  Either this patch is broken or the regulator
driver is quite clearly broken without this patch.
