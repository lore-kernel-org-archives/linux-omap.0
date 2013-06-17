From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4 Panda DVI problem
Date: Mon, 17 Jun 2013 04:18:35 -0700
Message-ID: <20130617111834.GR20992@atomide.com>
References: <51BB201C.3000605@ti.com>
 <51BEC4D7.2080903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35483 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756044Ab3FQLSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 07:18:40 -0400
Content-Disposition: inline
In-Reply-To: <51BEC4D7.2080903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Roger Quadros <rogerq@ti.com> [130617 01:18]:
> Hi Tomi,
> 
> On 06/14/2013 04:52 PM, Tomi Valkeinen wrote:
> > Hi Tony, Roger,
> > 
> > I recently raised the i2c issue with reading EDID from a DVI monitor on
> > Panda, when booting with DT. I just couldn't get reading EDID work at
> > all reliably.
> > 
> > I now see problems with non-DT also. Booting with 3.10-rc5, with DSS
> > compiled into the kernel, reading EDID fails during the boot. I can
> > later read the EDID fine from userspace.
> > 
> > With help from Roger, we found the issue.
> > 
> > DVI cable has a +5V line, that the source (i.e. Panda) has to provide.
> > This +5V is required to read EDID, but according to the documentation I
> > think it's actually required to show video also (although I guess this
> > could depend on the monitor).
> > 
> > I think for OMAP3 boards the +5V is always-on (I haven't looked at OMAP3
> > boards yet, though). For Panda, the +5V comes from DC_HST_5V, controlled
> > with a GPIO, which is used for USB and currently managed by USB in
> > arch/arm/mach-omap2/usb-host.c, which creates a fixed voltage hsusbX_vcc
> > regulator.
> > 
> > So, basically, if USB is disabled, DVI doesn't work. This is why I see
> > problems with DT (no USB), and non-DT (USB enabled after DVI is enabled).
> > 
> > To fix this properly I need to add regulator handling to the DVI driver,
> > and we need to share the same supply with USB and DVI.
> > 
> > However, while the above shouldn't be particularly difficult, it's still
> > not simple. And additional complications come with DT boot, as DSS
> > doesn't support DT yet. We have the hack that enables DSS for Panda and
> > SDP board when booting with DT, but I don't think it's possible to
> > manage the shared regulator easily in that setup (ie. USB and the
> > regulator being described in DT, DSS and DVI added the old way in
> > dss-common.c).

You should be able to get the regulator based on the name just fine
from the drivers even if one driver is using DT and one is not. That is
as long as the regulator is defined. Then the regulator fwk will track
the usecount properly.

> > So I think the simplest solution is to make DC_HST_5V always-on. This
> > should be fixed for 3.10 also.
> 
> I am fine with this.

For a short term fix I'm fine with that, but please investigate using
the regulator, it might be simpler than you think.

> > Any idea if DC_HST_5V is a big power sink if it's always enabled? If
> > it's a big one, I could look at how to hack the DVI driver so that it
> > would find the regulator. I'm quite sure I won't be neat, though.
> > 
> 
> DC_HST_5V is going to be active if USB is active. So I wouldn't be much
> worried if this supply is left always ON for people needing USB host &
> ethernet. (NOTE, ethernet is part of the same USB hub chip)

Of course power management will suffer, but it's currently not working
with EHCI anyways AFAIK.

Regards,

Tony
