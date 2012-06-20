From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Wed, 20 Jun 2012 06:28:49 -0700
Message-ID: <20120620132848.GK12766@atomide.com>
References: <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
 <4FD9E5AF.6010201@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
 <4FDA3464.4040704@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com>
 <20120615124520.GS12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A9E7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:26098 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2FTN2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 09:28:53 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99A9E7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120616 02:19]:
> Hi Tony,
> 
> On Fri, Jun 15, 2012 at 18:15:20, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120615 03:26]:
> 
> > > Here clock is required even before driver is probed, i.e for platform to
> > > calculate timings, that has to be passed through platform data.
> > 
> > Eventually we should be able to move the gpmc registration to the driver
> > probe, especially with device tree. There's no need to set up gpmc
> > before the driver probe runs for the device using gpmc. Just how the
> > gpmc init gets called from the driver probe is still a bit open though..
> 
> Sorry, I did not get you, can you please clarify

OK, I'll try :)
 
> By gpmc registration, if you meant registering platform device for
> gpmc peripherals, for a board that uses the new gpmc driver interface*,
> it will be done in probe only.

I was thinking when the gpmc needs to be initialized, and there should
not be any need to do it earlier than at the gpmc using driver probe
time. With device tree that is, as there's no need to stuff the gpmc
timings into a board-*.c file.

> All the responsibilities of old gpmc init is now taken care by probe;
> probe in addition does setting up gpmc for each peripheral, registering
> platform device (if the board makes use of new driver interface). If
> a board uses new gpmc driver interface, gpmc for that device is not
> setup before gpmc probe.

OK
 
> > It may require some bus level hooks, or wrapper drivers for the generic
> > device drivers like smsc911x.
> 
> This too, not sure whether I follow you

Well smsc911x has device tree binding, and is a generic driver. How do
we trigger the gpmc initialization from a generic driver probe?

> > > I understand the necessity for clk rate information in driver, but seems
> > > unless we have a generic way to scale timings for all the kinds of
> > > peripheral, having it may not be of much help.
> > 
> > We should not need to pass clock handles around. It's better to
> > export some helper functions in the gpmc code for the calculation.
> 
> Currently we have helper function in gpmc.c for the same, were you
> referring those ?

Yes something that let's the driver call gpmc code to do the calculation.
The other option would be to just add gpmc clock as a clock fwk node,
and then the driver could clk_get() it as ick.

Regards,

Tony
 
> *: [1] converts omap3evm & beagle board to use new interface, in addition
>  to [1], similar to it, one more series would be posted to convert remaining
>  boards also to use the new gpmc driver interface. As these cannot be tested
>  by me and as it depends on final shape of this basic driver conversion
>  series (or the present series), they have not yet been converted
> 
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69917.html
> 
