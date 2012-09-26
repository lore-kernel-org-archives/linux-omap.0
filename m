From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Wed, 26 Sep 2012 11:59:12 -0700
Message-ID: <20120926185912.GG4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
 <20120925153806.GC4840@atomide.com>
 <1348592700.2342.49.camel@deskari>
 <20120925190721.GD4840@atomide.com>
 <1348643142.2376.13.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38737 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758068Ab2IZS7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 14:59:15 -0400
Content-Disposition: inline
In-Reply-To: <1348643142.2376.13.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120926 00:06]:
> On Tue, 2012-09-25 at 12:07 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 10:06]:
> > > On Tue, 2012-09-25 at 08:38 -0700, Tony Lindgren wrote:
> > > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 03:22]:
> > > > > Hi Tony,
> > > > > 
> > > > > Each pin of OMAP requires a particular power to be enabled for the pin
> > > > > to function (Ball Characteristics table from data manual). Is there a
> > > > > plan how this is managed with pinctrl? Currently each driver needs to
> > > > > make sure the correct regulators are enabled for the pins it uses, which
> > > > > is platform specific and messy.
> > > > > 
> > > > > As a driver maintainer, I would wish that the pins would just get
> > > > > enabled automatically when I call pm_runtime_get()...
> > > > 
> > > > Hmm can you clarify a bit what exactly do you want to do there
> > > > with pm_runtime_get()? Call the regulator framework?
> > > 
> > > Well, I'm not very familiar with pinctrl, but if I've understood right,
> > > a set of pins are assigned to a driver in DT data (or wherever, that's
> > > not relevant). Those pins should be automatically configured and enabled
> > > when the driver uses pm_runtime_get() to enable its hardware.
> > > 
> > > And if I've also understood right, the pinctrl discussions related to
> > > omap have only dealt with pin muxing itself. But that's not enough to
> > > get the pin functional, but the relevant regulator needs to be enabled
> > > also.
> > > 
> > > So when I call pm_runtime_get in the omapdss driver, I imagine that the
> > > runtime PM and pinctrl would together handle muxing the pins for
> > > omapdss's use, and also enable the relevant regulators to make the pins
> > > usable.
> > 
> > But aren't these regulators something that potentially are dynamically
> > configured by the driver? For example, vdds_(sd)mmc1 depends on which
> > card is plugged in.
> 
> Ah, ok. Are there other cases than mmc where the voltage(?) needs to be
> dynamically configured?

Seems VSIM too and possibly some USB pins if you search for PBIAS in
the 44xx TRM.
 
> > So to me it seesm that it's best to define the regulators and claim them
> > by the driver using them rather than try to use automatically. It's
> 
> Well, in mmc case it sounds it's the driver's job. Perhaps the DSS pins
> are special cases, then. I don't see any dynamic configuration needed
> there.
> 
> Sometimes the regulator for the pins is implicitly enabled as it's
> needed by a DSS component. For example when using DSI pins, the vdda_dsi
> used by the pins is already enabled as it's used for the DSI itself, so
> the pins just happen to work.

OK
 
> But then the same pins that are used for DSI can be used for other
> things. On omap3430 DSI's dx0 pin can also be muxed to dss_data0,
> uart1_cts, gpio_70. Of these, I'm mainly interested in the dss_data0, of
> course.
> 
> So if I want to use parallel dss output, which uses dss_data0 pin,
> omapdss driver needs to enable vdda_dsi on omap3430, even though there's
> no other use for vdda_dsi in the parallel output case. But on omap4430
> data0 pins seems to be powered by vdds_1p8v. On AM35xx something else.
> So either I need to program all those into the omapdss driver, which is
> not the right way as they are platform specific things, or I need to
> pass some kind of pin data from platform data to omapdss driver, giving
> the required regulator for each pin.

Pass the device tree regulators to the DSS driver and enable the
ones with runtime PM in the DSS driver? I guess you have the names
for those regulatros?
 
> And how about the uart1_cts or gpio_70 pins on 3430? Do both uart and
> gpio drivers need to have similar kind of platform data, giving the
> required regulator so that the pin can be enabled?

Hmm aren't those always enabled with VIO_18?
 
> > sort of the same situation as with GPIO pins?
> 
> How are the GPIO pins handled? They have this kind of pin-regulator
> mapping?

There's some support documented under Documentation, but in many
cases the usage is drivers specific, like enabling GPIO wake-up event
for RX pin only etc.

Regards,

Tony

