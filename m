From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Thu, 12 Nov 2009 12:18:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702ADA2@dbde02.ent.ti.com>
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
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8293@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbZKLGsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 01:48:15 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8293@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi,
> > > If you do stick with this approach you probably want to use snprintf()
> > > and make supply be 6 bytes rather than 5 bytes long.
> > >
> > > > +	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
> > > > +		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
> > > > +			continue;
> > > > +		if (omap->regulator[i]) {
> > > > +			if (regulator_is_enabled(omap->regulator[i]))
> > > > +				regulator_disable(omap->regulator[i]);
> > > > +			regulator_put(omap->regulator[i]);
> > > > +		}
> > >
> > > For robustness I'd drop the first check for MODE_UNKNOWN here - it
> > > doesn't add anything.
> >
> > MODE_UNKNOWN means that the port is not connected and so no
> > need to check
> > the regulator availability.
> 
> Ajay,
> 
> It's better to check for EHCI_HCD_OMAP_MODE_PHY instead
> of EHCI_HCD_OMAP_MODE_UNKNOWN. The other option is
> EHCI_HCD_OMAP_MODE_TLL, and it will never use a regulator.

Ok fine, I will take this one also in next revision.

-Ajay
> 
> 
> Regards,
> Anand
> 
> >
> > >  You also want to call regulator_disable() before
> > > you free the regulator.
> >
> > It is being done under 'if (regulator_is_enabled)' check.
> >
> > -Ajay
> >
