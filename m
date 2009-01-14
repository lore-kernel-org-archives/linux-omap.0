From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 09:55:58 -0800
Message-ID: <200901140955.58616.david-b@pacbell.net>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <200901131619.28700.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403ECF70CCA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:34100 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752133AbZANR4B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 12:56:01 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CCA@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@sirena.org.uk" <broonie@sirena.org.uk>

On Wednesday 14 January 2009, Pillai, Manikandan wrote:
> Let me summarise the main problem I have been facing with regulators.
> 
> The TPS6235x are I2C based devices.
> 
> The regulator_register() functions require that the regulator_init_data is
> passed as platform_data(). But for i2c_client's platform data is initialized
> to some other value in the I2C driver. So the regulator_register() function
> fails.

Then you're initializing the i2c_board_info.platform_data field
incorrectly.  Do that right (pass regulator_init_data), and this
problem vanishes.  Only the tps6235x.c driver, and in this case
the regulator framework (sigh), care about that platform_data. 


> The other problem which I encounter is with the function regulator_get().
> Regulator_get() requires 2 parameters - device pointer should point to the
> One passed during regulator_register. It also takes a string a second parameter
> Which is compared with the supply string initialized in the regulator init data
> element regulator_consumer_supply.supply.

You need to intialize regulator_init_data.consumer_supplies
(and num_consumer_supplies) to include those two parameters.

Your pr785.c file will need to set up the regulator_init_data
before it declares the regulators.

(And yes, there *could* be a chicken/egg problem there where
it gets awkward to get all those devices in hand -- and pass
them to the regulator framework -- before their probe routines
get called and try using their regulators.  So far, careful
initcall sequencing has sufficed to resolve that...)

 
> Passing the client->dev, invoking regulator_register() fails.

Of course.  That's the regulator -- an I2C device -- not the
regulated device.  You pass regulator_get() the name of the
regulated device and a logical name for its supply regulator.
It then looks for data from a regulator_consumer_supply, which
was handed to the regulator framework via regulator_init_data.

Remember:  the whole point of a driver using regulator_get() to
get a client handle to its supply regulator is that it won't
already *have* any knowledge about what regulator is used on
any given board.

- Dave

