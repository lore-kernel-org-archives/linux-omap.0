From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Thu, 12 Nov 2009 09:21:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436F946DD@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
 <20091111154616.GA30354@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E73940436F946DA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42382 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbZKLDvK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:51:10 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436F946DA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi,
> 
> > > +	/* get ehci regulator and enable */
> > > +	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
> > > +		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
> > > +			continue;
> > > +		sprintf(supply, "ehci%d", i);
> >
> > The use of sprintf() here looks suspicious - these things would normally
> > be completely fixed.  I appreciate that that's the result, it just looks
> > suspicous.
> > Picking out of an array of fixed names would be more idiomatic.
> 
> I think this one is good to take.
> 
> 
> >  It'd also be idiomatic to use whatever the supply on the
> > chip is called in the datasheet - ehci might be accurate but it'd be a
> > bit of a surprising choice, it'd be good to check.
> 
> Supply names on EHCI PHY SMSC-USB3320 (used on EVM) chip datasheet is
> 'vdd18' but this also may change as other boards use different PHY.

Another point,

OMAP ports can be used as OHCI over serial interface so supply name
as 'ehciN' would be confusing.

I would change it to 'hsusb-portN' in next revision.

Regards,
Ajay
> 
> >
> > If you do stick with this approach you probably want to use snprintf()
> > and make supply be 6 bytes rather than 5 bytes long.
> >
> > > +	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
> > > +		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
> > > +			continue;
> > > +		if (omap->regulator[i]) {
> > > +			if (regulator_is_enabled(omap->regulator[i]))
> > > +				regulator_disable(omap->regulator[i]);
> > > +			regulator_put(omap->regulator[i]);
> > > +		}
> >
> > For robustness I'd drop the first check for MODE_UNKNOWN here - it
> > doesn't add anything.
> 
> MODE_UNKNOWN means that the port is not connected and so no need to check
> the regulator availability.
> 
> >  You also want to call regulator_disable() before
> > you free the regulator.
> 
> It is being done under 'if (regulator_is_enabled)' check.
> 
> -Ajay
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

