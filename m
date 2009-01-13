From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Changes for adding and building TPS6235x based
	PR785 board support
Date: Tue, 13 Jan 2009 21:51:54 +0000
Message-ID: <20090113215153.GB8670@sirena.org.uk>
References: <1231832505-7166-1-git-send-email-mani.pillai@ti.com> <20090113145909.GQ7344@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3744 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbZAMVwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 16:52:04 -0500
Content-Disposition: inline
In-Reply-To: <20090113145909.GQ7344@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Manikandan Pillai <mani.pillai@ti.com>, linux-omap@vger.kernel.org

On Tue, Jan 13, 2009 at 04:59:10PM +0200, Tony Lindgren wrote:

> > +int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val)

> The the read/write_reg should be in drivers/mfd somewhere.

Is this a multi-function device?  If so then there should be a similar
structure to the TWL4030 drivers should be used with the function
drivers all being platform drivers instantiated by the core (either
manually or via the MFD helpers).  The regulator driver was a regular
I2C device, suggesting that all the device does is regulation, in which
case the register I/O functions should be in there.

> > +	platform_device_register(pdev);
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +	if (bus_id == 1) {
> > +		omap_i2c_register_child(pdev, "vdd2_consumer", \
> > +				&vdd2_platform_device);
> > +		omap_i2c_register_child(pdev, "vdd1_consumer", \
> > +				&vdd1_platform_device);
> > +	}
> > +#endif
> > +	return 0;
> >  }

> Argh, i2c-omap.c is the _bus_ driver, not i2c device! Please move
> the above code to drivers/mfd somewhere.

There should be no need to do this at all.
