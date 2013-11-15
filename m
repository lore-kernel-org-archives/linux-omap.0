From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] input: touchscreen: fix spelling mistake in
 TSC/ADC DT binding
Date: Fri, 15 Nov 2013 15:55:40 +0000
Message-ID: <20131115155540.GF24831@e106331-lin.cambridge.arm.com>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
 <1382386404-6659-2-git-send-email-balbi@ti.com>
 <52663A58.9070706@linutronix.de>
 <20131022120253.GD9340@gimli>
 <20131114111958.GG16396@e106331-lin.cambridge.arm.com>
 <20131114155404.GE15835@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56130 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751085Ab3KOPz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Nov 2013 10:55:57 -0500
Content-Disposition: inline
In-Reply-To: <20131114155404.GE15835@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "rob@landley.net" <rob@landley.net>, "bcousson@baylibre.com" <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Nov 14, 2013 at 03:54:04PM +0000, Felipe Balbi wrote:
> HI,
> 
> On Thu, Nov 14, 2013 at 11:19:59AM +0000, Mark Rutland wrote:
> > > On Tue, Oct 22, 2013 at 10:42:00AM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 10/21/2013 10:13 PM, Felipe Balbi wrote:
> > > > > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > index e1c5300..b61df9d 100644
> > > > > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > @@ -348,9 +348,16 @@ static int titsc_parse_dt(struct platform_device *pdev,
> > > > >  	if (err < 0)
> > > > >  		return err;
> > > > >  
> > > > > -	err = of_property_read_u32(node, "ti,coordiante-readouts",
> > > > > +	/*
> > > > > +	 * try with new binding first. If it fails, still try with
> > > > > +	 * bogus, miss-spelled version.
> > > > > +	 */
> > > > > +	err = of_property_read_u32(node, "ti,coordinate-readouts",
> > > > >  			&ts_dev->coordinate_readouts);
> > > > >  	if (err < 0)
> > > > > +		err = of_property_read_u32(node, "ti,coordiante-readouts",
> > > > > +				&ts_dev->coordinate_readouts);
> > > > > +	if (err < 0)
> > > > >  		return err;
> > > > 
> > > > Thanks, very good. Do we keep this fallback for ever or just for a year
> > > > or two?
> > > 
> > > That's for DT maintainers to decide but considering DT is an ABI, I
> > > guess we need to keep for 30 years or so :-p
> > 
> > We keep it as long as we have to. If no-one's relying on the typo by the
> > next merge window, I see no reason we'd have to keep support for the
> 
> and how could you know that ? considering it's an ABI, how could you
> ever know that ?

If you know that the only user of a binding is a dts for a particular
product that you're in charge of, then you'd know the set of kernel +
dtb combinations out there, and can judge.

If a bug is found in a driver such that it hasn't worked for a number of
releases, and no-one's complained, the binding is clearly not in use and
thus support for it can be removed.

If maintaining compatibility becomes too hard, and all users are happy
to migrate to a newer dtb, then it's not necessary to maintain
compatiblity for the old binding.

While we can't always remove existing bindings, there are cases where
it's possible and appropriate. However, we should strive for
compatibility for as long a term as possible.

Thanks,
Mark.
