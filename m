From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Tue, 13 Jan 2009 22:07:39 +0000
Message-ID: <20090113220738.GA13227@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2298 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbZAMWHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 17:07:50 -0500
Content-Disposition: inline
In-Reply-To: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jan 13, 2009 at 01:11:08PM +0530, Manikandan Pillai wrote:

> +static
> +int tps_6235x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct  regulator_dev           *rdev = NULL;
> +	unsigned char reg_val;
> +	struct device *dev_child = NULL;

...

> +	/* Register the regulators */
> +	dev_child = device_find_child(client->adapter->dev.parent,
> +			(void *)regulator_consumer_name[id->driver_data],
> +			omap_i2c_match_child);
> +	rdev = regulator_register(&regulators[id->driver_data],
> +			dev_child, client);

With current mainline this should be rewritten as:

	rdev = regulator_register(&regulators[id->driver_data],
				  &client->dev, client);

though I'm not sure what's currently merged up into the OMAP trees.

As discussed in the followup to your previous patch the register I/O
functions should also be moved into this driver.
