From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Tue, 13 Jan 2009 21:15:25 +0000
Message-ID: <20090113211523.GA8670@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1379 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbZAMVPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 16:15:36 -0500
Content-Disposition: inline
In-Reply-To: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jan 13, 2009 at 01:11:08PM +0530, Manikandan Pillai wrote:

> +config REGULATOR_TPS6235X
> +	bool "TPS6235X Power regulator for OMAP3EVM"
> +	depends on I2C=y

This driver should not be OMAP3EVM specific, I'd expect.

> +extern struct regulator_consumer_supply tps62352_core_consumers;
> +extern struct regulator_consumer_supply tps62352_mpu_consumers;

These should not be required.

> +	/* Register the regulators */
> +	dev_child = device_find_child(client->adapter->dev.parent,
> +			(void *)regulator_consumer_name[id->driver_data],
> +			omap_i2c_match_child);
> +	rdev = regulator_register(&regulators[id->driver_data],
> +			dev_child, client);

I'm not 100% sure what this is intended to do but apart from anything
else it depends on specific consumer names which means that dependency
on the specific board hasn't been removed.  This is also OMAP-specific.

You should be using a device which is specific to the regulator as the
device that is being registered.
