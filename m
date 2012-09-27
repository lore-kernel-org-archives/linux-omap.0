From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Thu, 27 Sep 2012 11:43:41 -0700
Message-ID: <20120927184341.GK4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
 <20120925153806.GC4840@atomide.com>
 <1348592700.2342.49.camel@deskari>
 <20120925190721.GD4840@atomide.com>
 <1348643142.2376.13.camel@deskari>
 <20120926185912.GG4840@atomide.com>
 <1348730334.5559.9.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:47080 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753327Ab2I0Sno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 14:43:44 -0400
Content-Disposition: inline
In-Reply-To: <1348730334.5559.9.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120927 00:20]:
> On Wed, 2012-09-26 at 11:59 -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120926 00:06]:
> 
> > > So if I want to use parallel dss output, which uses dss_data0 pin,
> > > omapdss driver needs to enable vdda_dsi on omap3430, even though there's
> > > no other use for vdda_dsi in the parallel output case. But on omap4430
> > > data0 pins seems to be powered by vdds_1p8v. On AM35xx something else.
> > > So either I need to program all those into the omapdss driver, which is
> > > not the right way as they are platform specific things, or I need to
> > > pass some kind of pin data from platform data to omapdss driver, giving
> > > the required regulator for each pin.
> > 
> > Pass the device tree regulators to the DSS driver and enable the
> > ones with runtime PM in the DSS driver? I guess you have the names
> > for those regulatros?
> 
> Well, yes, I could create a pin->regulator mapping for dss that is
> filled in the DT data.

OK, that's probably the way to go as we don't have any other place
for that mapping.
 
> I just feel this is something that the omapdss driver shouldn't care
> about. The powers for the pins are in no way related to dss.

OK, maybe some of this can be done automatically later.
 
> > > And how about the uart1_cts or gpio_70 pins on 3430? Do both uart and
> > > gpio drivers need to have similar kind of platform data, giving the
> > > required regulator so that the pin can be enabled?
> > 
> > Hmm aren't those always enabled with VIO_18?
> 
> No, 3430 datamanual (OMAP34xx_ES2.0_ES2.1_POP_DM_V_K.pdf) says some uart
> and gpio pins are powered by vdds_dsi, some by vdds_sdi, some gpio pins
> are powered by vdds_csi2, etc.

OK. I guess these pins are rarely used in the alternative mux
modes as it has not been much of a problem so far.

> I could be mistaken how to HW works (but it does work like that for
> dss), but sounds to me that uart and gpio drivers (and perhaps some
> others, I didn't go through all the pins) need similar pin->regulator
> mapping as you suggested for omapdss.

Yes it seems that there are supply voltage regulator domains
that are specific to some subsystems. I wonder if these are needed
in all mux modes, or only when the pins are muxed for that particular
subsystem? It could be that the documentation is missing some
information here..

For example, what happens if you try to use some vdds_dsi powered
pin in GPIO mode without vdds_dsi?

Regards,

Tony
