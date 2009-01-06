From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/2] TPS6235x based Power regulator support added
Date: Tue, 6 Jan 2009 10:11:42 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECEDD319@dbde02.ent.ti.com>
References: <1229421966-11414-1-git-send-email-mani.pillai@ti.com>
 <20081217173503.GF22204@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56528 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbZAFEl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 23:41:57 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Except the comment from Mark, I have so far not received any comments on
these patch set of 2 for TPS6235x support. As attached below, there are problems
with implementing Mark's comments. Suggestions are welcome.

Regards
Manikandan

-----Original Message-----
From: Pillai, Manikandan 
Sent: Thursday, December 18, 2008 9:03 AM
To: 'Mark Brown'
Cc: linux-omap@vger.kernel.org
Subject: RE: [PATCH 1/2] TPS6235x based Power regulator support added

Hi,

I have separated out the consumers to the board files. And most of the
Init_data is provided there. But the dev pointer was not available at
that point of time. The dev pointer needs to be initialized for
regulator_get() functions. Hence, I need to init it in the xxx_probe()
function. Pls let me know if you have any other ways to fix this ?

Regards
Mani

-----Original Message-----
From: Mark Brown [mailto:broonie@sirena.org.uk] 
Sent: Wednesday, December 17, 2008 11:05 PM
To: Pillai, Manikandan
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] TPS6235x based Power regulator support added

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

