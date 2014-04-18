From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAPDSS and panel-dpi
Date: Fri, 18 Apr 2014 08:40:16 -0700
Message-ID: <20140418154015.GA5354@atomide.com>
References: <CAGhQ9VzL5fLHCNZ=y-exBAds03f8Bw_hO+KjYnwO4MgRWOfpuw@mail.gmail.com>
 <20140417192215.GA24931@atomide.com>
 <CAGhQ9VwM-rnXcMXNW40jbx6yDGCQwjODDyKhtbZNyCsexX2f3w@mail.gmail.com>
 <20140417225025.GA25732@atomide.com>
 <20140418025024.GB25732@atomide.com>
 <CAGhQ9VwZg6ww1DE=W-DjFM0=QM5WNO3Yp06YxYzB2Jv3C9=F0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15292 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbaDRPkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 11:40:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGhQ9VwZg6ww1DE=W-DjFM0=QM5WNO3Yp06YxYzB2Jv3C9=F0Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

* Joachim Eastwood <manabian@gmail.com> [140418 04:05]:
> On 18 April 2014 04:50, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [140417 15:50]:
> >> * Joachim Eastwood <manabian@gmail.com> [140417 13:51]:
> >> > On 17 April 2014 21:22, Tony Lindgren <tony@atomide.com> wrote:
> >> > > * Joachim Eastwood <manabian@gmail.com> [140417 11:05]:
> >> > >> Hi Tomi,
> >> > >>
> >> > >> My VAR-DVK-OM44 (OMAP4460) has both a HDMI and a LCD panel. As HDMI is
> >> > >> now working (thanks) I also taken a look at panel-dpi.
> >> > >>
> >> > >> I found the DT patch for panel-dpi on the mailing list.
> >> > >> OMAPDSS: panel-dpi: Add DT support:
> >> > >> http://marc.info/?l=devicetree&m=139030201815380&w=2
> >> > >>
> >> > >> And I got my display working with DT :)
> >> > >> So you add can my: Tested-by: Joachim Eastwood <manabian@gmail.com>
> >> > >>
> >> > >> Could you upstream the panel-dpi DT support and the HDMI connector
> >> > >> gpio hpd patch in 3.16?
> >> > >> I hope it's easier to upstream the stuff when it gets some users in DT.
> >> > >
> >> > > Good to hear. The DPI panel support should use gpio-backlight
> >> > > driver as discussed in the DPI thread. Did you have to patch
> >> > > anything for the timings etc?
> >> >
> >> > The only driver patches I use are those two from Tomi mentioned above.
> >> > (panel-dpi DT support and HDMI connector gpio-hpd)
> >> >
> >> > > If you have the board working, care to take a look at making
> >> > > the gpio-backlight change?
> >> >
> >> > I am already using the gpio-backlight driver.
> >>
> >> OK great, so then we can just drop that GPIO backlight handling
> >> from the DPI DT patch I presume.
> >>
> >> > You can take a look at the device tree for VAR-DVK-OM44 here:
> >> > http://slexy.org/raw/s2Pz4BELGe
> >> >
> >> > I'll post the patch set on list tomorrow.
> >>
> >> Thanks for the link, that pretty much clarifies all the parts
> >> I was wondering about.
> >
> > OK so based on the link above, I got the LDP panel DPI working with
> > the quirks now shrunk to the two panel specific GPIOs.
> >
> > Probably best to set those up based on "omapdss,panel-dpi-ldp"
> > compatible flag?
> >
> > That is after removing the backlight_gpio from panel_dpi_probe_of()
> > so the panel specific GPIOs can be handled easily based on the
> > compatible flag. Current work in progress patch below for reference
> > in case anybody has better ideas for dealing with the remaining
> > to GPIOs.
> 
> A reset gpio could be useful on more panels I think.
> omapdss,panel-dsi-cm already have a reset-gpios property so maybe
> omapdss,panel-dpi should have one too.

OK. For handling the GPIOs, looks like gpio_backlight_probe_dt
is doing:

gbl->active = (gpio_flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1

To handle the polarity. We should probably do the same for the
panels as we at least used to have the polarity flags in the
platform data earlier.
 
> A lot of panels have mode pins, but usually these are hard coded on
> the circuit board.
> If it's just a bunch of static gpio values that need to be set maybe
> you could have something like this:
> mode-gpios = <&gpio1 10 0 &gpio1 11 0>;
> mode-gpios-values = <1 1>;
> 
> Driver would set these gpios to values at init.

If mode-gpios can be is Linux generic, then it makes sense to add
it. But if it's specific to this panel, I'd like to avoid setting
up yet another custom DT *-gpios property..

In any case, with (gpio_flags & OF_GPIO_ACTIVE_LOW) mode-gpio-values
should not be needed.

If it does not make sense to set up a generic mode-gpios for the
panels, then panel dpi can parse the first two GPIOs for enable
and reset. Then we can allow the rest of the array be parsed if
needed based on the compatible flag.

Regards,

Tony
