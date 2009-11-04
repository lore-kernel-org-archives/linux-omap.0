From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Wed, 4 Nov 2009 20:15:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB912@dbde02.ent.ti.com>
 <20091103153046.GA30320@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436F9375B@dbde02.ent.ti.com>
 <20091104133922.GD25044@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
 <20091104144126.GA30644@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47322 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbZKDOpH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 09:45:07 -0500
In-Reply-To: <20091104144126.GA30644@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Mark Brown wrote:
> On Wed, Nov 04, 2009 at 08:00:52PM +0530, Gadiyar, Anand wrote:
> > Mark Brown wrote:
> > > On Wed, Nov 04, 2009 at 06:02:48PM +0530, Gupta, Ajay Kumar wrote:
> 
> > > > I can do regulator_get() and regulator_enable() but where ? Are you referring to board file?
> 
> > > > I was thinking of doing it in a generic form within EHCI driver (ehci-omap.c).
> 
> > > Do it in the EHCI driver.  The EHCI driver should just unconditionally
> > > use the regulators, the regulator API will be compiled out if support is
> > > disabled in Kconfig.
> 
> > NAK to do it unconditionally in the driver. This is board specific.
> > It just so happens that this is the regulator used on the beagleboard
> > and EVM, but it could very easily be another one (like on the SDP).
> 
> Obviously the physical regulator hookup is board specific - please take
> a look at how the regulator API operates here, none of this needs to be
> handled by drivers using the API which was what the discussion above
> (regarding regulator_get() and regulator_enable()) was about.
> 
> regulator_get() takes the struct device for the consumer (the EHCI
> controller in this case) and a name for the supply both of which depend
> only on the consumer.  The board drivers set up the mapping from these
> to actual physical regulators during initialisation and the whole
> process is completely transparent to the consumer drivers, they can just
> ask for a fixed thing.
> 

Okay. I see now. Thanks.

So, if a board does not need a regulator at all, then the APIs do nothing?

> > How about a hook from the platform code in mach-omap2/usb-ehci.c instead?
> 
> If this is needed something is broken.
> 
> 