From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Adding TPS6235x regulator support
Date: Fri, 30 Jan 2009 11:36:28 +0000
Message-ID: <20090130113627.GA18825@sirena.org.uk>
References: <1233307356-14935-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2738 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZA3Lga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 06:36:30 -0500
Content-Disposition: inline
In-Reply-To: <1233307356-14935-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jan 30, 2009 at 02:52:36PM +0530, Manikandan Pillai wrote:

Other than a few nits below this looks basically OK as a regulator
driver.  For mainline you'll want to change to use only platform_data
rather than having data passed in in both driver_data and platform_data.

> +config REGULATOR_TPS6235X
> +        tristate "TI TPS6235x Power regulators"
> +	depends on I2C
> +	help
> +          This driver supports TPS6235x voltage regulator chips, for values
> +	  of "x" from 0 to 6.  These are buck converters which support TI's
> +	  hardware based "SmartReflex" dynamic voltage scaling.

> +config REGULATOR_TPS6235X
> +	bool "TPS6235X Power regulator for OMAP3EVM"
> +	depends on I2C=y

I suspect you only want the first of these...

> --- /dev/null
> +++ b/drivers/regulator/tps6235x-regulator.c
> @@ -0,0 +1,351 @@

> +static int tps6235x_dcdc_get_voltage(struct regulator_dev *dev)
> +{
> +	struct	i2c_client *tps_info = rdev_get_drvdata(dev);

Double space here.

> +	if (reg_val & TPS6235X_PWR_OK_MSK)
> +		dev_dbg(&client->dev, "Power is OK  %x\n", reg_val);
> +	else
> +		dev_dbg(&client->dev, "Power not in range = %x\n", reg_val);

Shouldn't this print an error if the power is out of spec (using
dev_err() rather than dev_dbg())?

> +static const struct tps_info tps62352_info = {
> +	.min_uV		=  750000,
> +	.max_uV		= 1437500,
> +	.mult_uV	=   12500,
> +	.fixed		=    true,
> +};

Using 1 rather than true would be more natural for kernel code.

> +static int __init tps_6235x_init(void)
> +{
> +	return i2c_add_driver(&tps_6235x_i2c_driver);
> +}
> +
> +
> +/**
> + * tps_6235x_cleanup
> + *
> + * Module exit function
> + */
> +static void __exit tps_6235x_cleanup(void)
> +{
> +	i2c_del_driver(&tps_6235x_i2c_driver);
> +}
> +subsys_initcall(tps_6235x_init);
> +module_exit(tps_6235x_cleanup);

Normally these should immediately follow the function they annotate.
