From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 1/2] regulator: tps65910: Add backup battery regulator
Date: Thu, 19 Dec 2013 09:23:40 +0100
Message-ID: <20131219082340.GD23493@pengutronix.de>
References: <1387378208-26841-1-git-send-email-mpa@pengutronix.de>
 <20131218162452.GX28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50242 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3LSIXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 03:23:45 -0500
Content-Disposition: inline
In-Reply-To: <20131218162452.GX28455@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Wed, Dec 18, 2013 at 04:24:52PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 03:50:07PM +0100, Markus Pargmann wrote:
> 
> > @@ -771,7 +794,7 @@ static struct regulator_ops tps65910_ops = {
> >  	.get_voltage_sel	= tps65910_get_voltage_sel,
> >  	.set_voltage_sel	= tps65910_set_voltage_sel,
> >  	.list_voltage		= regulator_list_voltage_table,
> > -	.map_voltage		= regulator_map_voltage_ascend,
> > +	.map_voltage		= regulator_map_voltage_iterate,
> >  };
> 
> You should make separate ops for this rather than make all the other
> regulators take the performance hit.

Fixed.

> 
> >  static struct regulator_ops tps65911_ops = {
> > @@ -944,6 +967,7 @@ static struct of_regulator_match tps65910_matches[] = {
> >  	{ .name = "vaux2",	.driver_data = (void *) &tps65910_regs[10] },
> >  	{ .name = "vaux33",	.driver_data = (void *) &tps65910_regs[11] },
> >  	{ .name = "vmmc",	.driver_data = (void *) &tps65910_regs[12] },
> > +	{ .name = "vbb",	.driver_data = (void *) &tps65910_regs[13] },
> >  };
> 
> Ugh, these numbered tables aren't good.  Not a problem from this patch
> though.
> 
> > -		pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;
> > +		if (tps65910_chip_id(tps65910) == TPS65910 &&
> > +				i == TPS65910_REG_VBB)
> > +			pmic->desc[i].enable_mask = BBCH_BBCHEN_MASK;
> > +		else
> > +			pmic->desc[i].enable_mask = TPS65910_SUPPLY_STATE_ENABLED;
> 
> switch statements please - it means if additional things need
> customising they can drop right in.

Fixed.


Thank you,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
