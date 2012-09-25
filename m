From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Tue, 25 Sep 2012 12:07:21 -0700
Message-ID: <20120925190721.GD4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
 <20120925153806.GC4840@atomide.com>
 <1348592700.2342.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31488 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753465Ab2IYTHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 15:07:24 -0400
Content-Disposition: inline
In-Reply-To: <1348592700.2342.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 10:06]:
> On Tue, 2012-09-25 at 08:38 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 03:22]:
> > > Hi Tony,
> > > 
> > > Each pin of OMAP requires a particular power to be enabled for the pin
> > > to function (Ball Characteristics table from data manual). Is there a
> > > plan how this is managed with pinctrl? Currently each driver needs to
> > > make sure the correct regulators are enabled for the pins it uses, which
> > > is platform specific and messy.
> > > 
> > > As a driver maintainer, I would wish that the pins would just get
> > > enabled automatically when I call pm_runtime_get()...
> > 
> > Hmm can you clarify a bit what exactly do you want to do there
> > with pm_runtime_get()? Call the regulator framework?
> 
> Well, I'm not very familiar with pinctrl, but if I've understood right,
> a set of pins are assigned to a driver in DT data (or wherever, that's
> not relevant). Those pins should be automatically configured and enabled
> when the driver uses pm_runtime_get() to enable its hardware.
> 
> And if I've also understood right, the pinctrl discussions related to
> omap have only dealt with pin muxing itself. But that's not enough to
> get the pin functional, but the relevant regulator needs to be enabled
> also.
> 
> So when I call pm_runtime_get in the omapdss driver, I imagine that the
> runtime PM and pinctrl would together handle muxing the pins for
> omapdss's use, and also enable the relevant regulators to make the pins
> usable.

But aren't these regulators something that potentially are dynamically
configured by the driver? For example, vdds_(sd)mmc1 depends on which
card is plugged in.

So to me it seesm that it's best to define the regulators and claim them
by the driver using them rather than try to use automatically. It's
sort of the same situation as with GPIO pins?

Regards,

Tony

