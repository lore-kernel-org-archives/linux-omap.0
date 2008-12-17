From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] TPS6235x based Power regulator support added
Date: Wed, 17 Dec 2008 17:35:03 +0000
Message-ID: <20081217173503.GF22204@sirena.org.uk>
References: <1229421966-11414-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2121 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYLQRfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2008 12:35:05 -0500
Content-Disposition: inline
In-Reply-To: <1229421966-11414-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Dec 16, 2008 at 03:36:06PM +0530, Manikandan Pillai wrote:

> +extern struct regulator_consumer_supply tps62352_core_consumers;
> +extern struct regulator_consumer_supply tps62352_mpu_consumers;

...

> +	/* Register the regulators */
> +	if (client->addr == TPS_62352_CORE_ADDR) {
> +		/* dev needs to be inited since this is required to for get() */
> +		tps62352_core_consumers.dev = &client->dev;
> +		rdev = regulator_register(&regulators[0], &client->dev,
> +					client);
> +	} else if (client->addr == TPS_62353_MPU_ADDR) {
> +		/* dev needs to be inited since this is required to for get() */
> +		tps62352_mpu_consumers.dev = &client->dev;
> +		rdev = regulator_register(&regulators[1], &client->dev,
> +					client);
> +	}

This should be done in the style of other regulators with the list of
consumers passed in as part of the regulator init data supplied by the
board.  This would then allow you to remove all the conditionals (since
the regulator array index is provided for you in the i2c_device_id value
you get passed in).
