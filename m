From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Thu, 27 Sep 2012 11:51:39 -0700
Message-ID: <20120927185138.GL4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
 <20120925153806.GC4840@atomide.com>
 <1348592700.2342.49.camel@deskari>
 <20120925190721.GD4840@atomide.com>
 <1348643142.2376.13.camel@deskari>
 <20120926185912.GG4840@atomide.com>
 <1348730334.5559.9.camel@lappyti>
 <20120927184341.GK4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61504 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752697Ab2I0Svl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 14:51:41 -0400
Content-Disposition: inline
In-Reply-To: <20120927184341.GK4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Tony Lindgren <tony@atomide.com> [120927 11:45]:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120927 00:20]:
> 
> > I could be mistaken how to HW works (but it does work like that for
> > dss), but sounds to me that uart and gpio drivers (and perhaps some
> > others, I didn't go through all the pins) need similar pin->regulator
> > mapping as you suggested for omapdss.
> 
> Yes it seems that there are supply voltage regulator domains
> that are specific to some subsystems. I wonder if these are needed
> in all mux modes, or only when the pins are muxed for that particular
> subsystem? It could be that the documentation is missing some
> information here..
> 
> For example, what happens if you try to use some vdds_dsi powered
> pin in GPIO mode without vdds_dsi?

Seems like this may provide some clues from "3.6 Power-up and Power-down":

 "If the SDI, DSI, or CSI2 and CSIb interfaces are used in standard
 LVCMOS mode (that is, GPIO mode) rather than PHY mode (that is, serial
 differential mode), then vdds_sdi, vdds_dsi, vdds_csi2, and vdds_csib
 may also be connected to vdds. Please, see the recommended SDI, DSI,
 CSI2, and CSIb power supply noise of Table 3-5, Recommended Operating
 Conditions."

So based on that it seems that tweaking of the regulators for these
pins is only needed for DSS etc, not for GPIO or serial usage.

Regards,

Tony

