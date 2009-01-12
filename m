From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] TPS6235x based Power regulator support added
Date: Mon, 12 Jan 2009 11:18:07 +0000
Message-ID: <20090112111806.GA32299@sirena.org.uk>
References: <1231741650-9209-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4543 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZALLSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 06:18:08 -0500
Content-Disposition: inline
In-Reply-To: <1231741650-9209-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jan 12, 2009 at 11:57:30AM +0530, Manikandan Pillai wrote:


> +extern int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val);
> +extern int tps_6235x_write_reg(struct i2c_client *client, u8 reg, u8 val);

Either these should be in the header file or they shouldn't have the
extern.  Forward declarations in the file are OK, but the extern makes
it look like they ought to be a header.

> +static int tps6235x_dcdc_set_voltage(struct regulator_dev *dev,
> +				int min_uV, int max_uV)
> +{
> +	unsigned char vsel1;
> +	unsigned int volt;
> +	struct	i2c_client *tps_info = rdev_get_drvdata(dev);
> +	unsigned int millivolts = min_uV / 1000;
> +
> +	/* check if the millivolts is within range */
> +	if ((millivolts < TPS62352_MIN_CORE_VOLT) ||
> +		(millivolts > TPS62352_MAX_CORE_VOLT))
> +		return -1;

Should be a real error code such as -EINVAL.

> +	if (reg_val & TPS6235X_PWR_OK_MSK)
> +		dev_dbg(&client->dev, "Power is OK  %x\n", reg_val);
> +	else {
> +		printk(KERN_ERR "Power not within range = %x\n", reg_val);
> +		return -2;
> +	}

Should use dev_err() for the printk and return a real error code.

> +	/* Register the regulators */
> +	if (client->addr == TPS_62352_CORE_ADDR) {
> +		dev_child = device_find_child(client->adapter->dev.parent,
> +				"vdd2", omap_i2c_match_child);
> +		/* dev needs to be inited since this is required to for get() */
> +		rdev = regulator_register(&regulators[0], dev_child,
> +					client);
> +	} else if (client->addr == TPS_62353_MPU_ADDR) {
> +		/* dev needs to be inited since this is required to for get() */
> +		dev_child = device_find_child(client->adapter->dev.parent,
> +				"vdd1", omap_i2c_match_child);
> +		rdev = regulator_register(&regulators[1], dev_child,
> +					client);
> +	}

This should look like the equivalent code for other regulators.
