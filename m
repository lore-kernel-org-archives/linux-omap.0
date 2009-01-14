From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 15:32:17 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
 <20090113220738.GA13227@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbZANKCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 05:02:40 -0500
In-Reply-To: <20090113220738.GA13227@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi ,

Pls find my comments below

Regards


> -----Original Message-----
> From: Mark Brown [mailto:broonie@sirena.org.uk]
> Sent: Wednesday, January 14, 2009 3:38 AM
> To: Pillai, Manikandan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
> 
> On Tue, Jan 13, 2009 at 01:11:08PM +0530, Manikandan Pillai wrote:
> 
> > +static
> > +int tps_6235x_probe(struct i2c_client *client, const struct i2c_device_id
> *id)
> > +{
> > +	struct  regulator_dev           *rdev = NULL;
> > +	unsigned char reg_val;
> > +	struct device *dev_child = NULL;
> 
> ...
> 
> > +	/* Register the regulators */
> > +	dev_child = device_find_child(client->adapter->dev.parent,
> > +			(void *)regulator_consumer_name[id->driver_data],
> > +			omap_i2c_match_child);
> > +	rdev = regulator_register(&regulators[id->driver_data],
> > +			dev_child, client);
> 
> With current mainline this should be rewritten as:
> 
> 	rdev = regulator_register(&regulators[id->driver_data],
> 				  &client->dev, client);
> 
> though I'm not sure what's currently merged up into the OMAP trees.
[Pillai, Manikandan] 
The issue is that passing the initial value for regulators is done by

struct regulator_init_data *init_data = dev->platform_data;

in regulator_register() function. Do we have a way to initialize the
platform data for the i2c client struct.

> 
> As discussed in the followup to your previous patch the register I/O
> functions should also be moved into this driver.

