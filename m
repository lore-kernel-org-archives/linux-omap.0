From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Fri, 28 Sep 2012 07:37:04 -0700
Message-ID: <20120928143703.GY4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
 <20120925153806.GC4840@atomide.com>
 <1348592700.2342.49.camel@deskari>
 <20120925190721.GD4840@atomide.com>
 <1348643142.2376.13.camel@deskari>
 <20120926185912.GG4840@atomide.com>
 <1348730334.5559.9.camel@lappyti>
 <20120927184341.GK4840@atomide.com>
 <20120927185138.GL4840@atomide.com>
 <1348812827.4872.10.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42619 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757302Ab2I1OhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 10:37:07 -0400
Content-Disposition: inline
In-Reply-To: <1348812827.4872.10.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120927 23:15]:
> On Thu, 2012-09-27 at 11:51 -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120927 11:45]:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120927 00:20]:
> > > 
> > > > I could be mistaken how to HW works (but it does work like that for
> > > > dss), but sounds to me that uart and gpio drivers (and perhaps some
> > > > others, I didn't go through all the pins) need similar pin->regulator
> > > > mapping as you suggested for omapdss.
> > > 
> > > Yes it seems that there are supply voltage regulator domains
> > > that are specific to some subsystems. I wonder if these are needed
> > > in all mux modes, or only when the pins are muxed for that particular
> > > subsystem? It could be that the documentation is missing some
> > > information here..
> > > 
> > > For example, what happens if you try to use some vdds_dsi powered
> > > pin in GPIO mode without vdds_dsi?
> 
> I have not tested that.
> 
> > Seems like this may provide some clues from "3.6 Power-up and Power-down":
> > 
> >  "If the SDI, DSI, or CSI2 and CSIb interfaces are used in standard
> >  LVCMOS mode (that is, GPIO mode) rather than PHY mode (that is, serial
> >  differential mode), then vdds_sdi, vdds_dsi, vdds_csi2, and vdds_csib
> >  may also be connected to vdds. Please, see the recommended SDI, DSI,
> >  CSI2, and CSIb power supply noise of Table 3-5, Recommended Operating
> >  Conditions."
> > 
> > So based on that it seems that tweaking of the regulators for these
> > pins is only needed for DSS etc, not for GPIO or serial usage.
> 
> I don't read the above paragraph the same way.
> 
> What I think it means is that if, say, a board does not use DSI at all,
> the vdds_dsi input pin in OMAP could be connected to vdds instead of the
> normal DSI power from the TWL chip, thus making the OMAP's vdds_dsi
> "always on". Which means that in some boards the vdds_dsi in TWL is not
> needed if the pins are used.
> 
> However, that doesn't mean that the vdds_dsi input is always connected
> to vdds if the pins are used for non-DSI uses. A board may well use only
> some of the DSI pins for display, leaving the rest free for other uses.
> E.g. on omap3 there are 6 DSI pins, and a display panel could well use
> only 4 of them. If the 2 other pins are used as GPIOs, handling vdds_dsi
> is still required when using those GPIOs.

Right, I meant not for typical GPIO usage. The power depends how
how it's wired.
 
> So I think the above paragraph confirms that the power for the pins is
> indeed required, and handling for the regulator is needed for GPIOs,
> uarts, etc. also.

And then you most likely are using these pins for SDI, DSI etc and not
for GPIO :) But yeah I see your point, if you don't use all DSI pins
and use some for GPIOs, you'd also have to take care of the regulators
somewhere.

Regards,

Tony
 


