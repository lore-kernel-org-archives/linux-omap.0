From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
Date: Mon, 18 Nov 2013 10:11:10 -0800
Message-ID: <20131118181110.GM10317@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50668 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab3KRSLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 13:11:16 -0500
Content-Disposition: inline
In-Reply-To: <20131118174638.GQ13640@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

* Lee Jones <lee.jones@linaro.org> [131118 09:47]:
> > > > +static struct of_dev_auxdata twl_auxdata_lookup[] = {
> > > > +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> > > > +	{ /* sentinel */ },
> > > > +};
> > > > +
> > > >  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
> > > >  static int
> > > >  twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > > > @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > > >  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> > > >  	}
> > > >  
> > > > -	if (node)
> > > > -		status = of_platform_populate(node, NULL, NULL, &client->dev);
> > > > -	else
> > > > +	if (node) {
> > > > +		if (pdata)
> > > > +			twl_auxdata_lookup[0].platform_data = pdata->gpio;
> > > > +		status = of_platform_populate(node, NULL, twl_auxdata_lookup,
> > > > +					      &client->dev);
> > > > +	} else {
> > > >  		status = add_children(pdata, irq_base, id->driver_data);
> > > 
> > > Why doesn't the TWL driver use the MFD framework for this stuff?
> > 
> > that's reminiscent from years ago and, surely, needs to be fixed. Should
> > we gate $subject for that, though ? This has been in tree for quite a
> > few years already and Tony's patch is still a step forward, since most
> > omap3 platforms would break on DT-only without it.
> 
> I didn't say that I would reject the patch. I was just surprised to
> see so much hand-rolling, as the MFD core code does much of it
> automatically. This is the first time I've taken a look at this and it
> seems to be quite the relic.

Yeah it seems something from the early days of MFD code. Then grepping for
add_children shows that drivers/mfd/dm355evm_msp.c is doing it too, which
should also be fixed while at it.
 
> > There are quite a few folks who could volunteer to fixing that after
> > Tony's patch is in (me included, although there could be better choices
> > hehe).
> 
> Well it's not doing any harm. I'll make a note to fix it myself if a)
> no one has done so already and b) I manage to find some spare
> time. The latter issue is less likely to be resolved. :)

Sounds like Felipe has already picked it up for future work :)
 
> Are you Acking this patch by the way?

If this looks acceptable to you guys, I'd like to merge this via my fixes
branch this week with your acks if that works for you. That way I can base
my omap legacy platform data removal patches on my fixes branch while keep
things working for the drivers. Alternatively I can naturally base my
legacy data removal on -rc2 too if this gets merged to mainline by then 
via the MFD tree.

Regards,

Tony
