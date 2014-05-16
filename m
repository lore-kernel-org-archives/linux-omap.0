From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 16 May 2014 11:01:54 -0700
Message-ID: <20140516180154.GG22031@atomide.com>
References: <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com>
 <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com>
 <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27392 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756937AbaEPSCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 14:02:04 -0400
Content-Disposition: inline
In-Reply-To: <20140516174158.GA11733@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Sebastian Reichel <sre@ring0.de> [140516 10:42]:
> On Fri, May 16, 2014 at 09:07:17AM -0700, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 22:57]:
> > > On 15/05/14 21:21, Tony Lindgren wrote:
> > > >> But you're right, having "sharp,ls037v7dw01-omap-dss" in the .dts is an
> > > >> alternative for the compatible-string conversion we do now. I guess it's
> > > >> a matter of taste, but I rather hide it inside the kernel, in an
> > > >> internal omapdss file, than pollute the .dts files with those compatible
> > > >> strings.
> > > > 
> > > > Well it avoid you parsing through all the nodes during booting
> > > > and leaves out the function to do remapping. And removes the need
> > > > for maintaining a custom display mapping table. I'd say that's a
> > > > pretty good list of advantages right there :)
> > > 
> > > Yep... I don't know. Maybe I'm being too careful about doing wrong
> > > things with .dts. I just like it more if any hacks are in kernel code,
> > > which I can remove without anyone noticing.
> > > 
> > > Anyway, we already have board.dts files using the non-omapified
> > > compatible strings in the mainline, so if I would now add the omapified
> > > compatible strings to .dts files, those old board.dts files would break.
> > > 
> > > So I guess the choice has already been made.
> > 
> > I really think you should remove this misuse of device tree code ASAP.
> > It's better to fix it up now than carry the hack for next two years
> > and keep on adding to it.
> 
> IMHO appending -omap-dss to a random device is an even bigger hack,
> since its adding lots of bloat to the API. Let's assume there is
> another OS using DT for ARM, but has no proper API for SPI
> controllers and it introduces your hack to SPI devices. That would
> mean each SPI device has -omap-spi appended (or -exynos-spi,
> -foo-spi, ...). At least I would blame them for creating a huge
> unmaintainable mess.

I think you're misunderstanding. I do not want the naming to
be Linux specific. The naming should naturally be as hardware
specific as possible. In this case something like:

compatible = "sharp,ls037v7dw01-dss", "sharp,ls037v7dw01";

Or we should probably use:

compatible = "sharp,ls037v7dw01-dpi", "sharp,ls037v7dw01";

As dpi here reflects the hardware it's connected to. The dss
is probably a Linux name.

Not use what you're after with the SPI example though, but sounds
like that's something different.

> I think Tomi's workaround is a much better hack, since it keeps the
> API clean. If the code simply prefixes "omapdss," to all
> "child"-devices of omapdss it can be left mostly untouched, too.

AFAIK that remapping not needed at all. All that is already
available with the compatible flags.

Regards,

Tony
