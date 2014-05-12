From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 12 May 2014 08:51:32 -0700
Message-ID: <20140512155132.GH31772@atomide.com>
References: <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C8293.4070506@ti.com>
 <20140509155504.GE17814@atomide.com>
 <53707A64.2060203@ti.com>
 <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
 <53709706.10501@ti.com>
 <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
 <20140512142646.GA31772@atomide.com>
 <5370E0C9.8050201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18867 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752685AbaELPvh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 11:51:37 -0400
Content-Disposition: inline
In-Reply-To: <5370E0C9.8050201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 07:55]:
> On 12/05/14 17:26, Tony Lindgren wrote:
> 
> >>> The omapdss case is different, there the "omapdss" points to a sw thing,
> >>> it does not describe the hardware. It's only needed as we don't have
> >>> proper sw drivers for the devices.
> >>>
> >>> That said, I think what you describe would work. But I would rather keep
> >>> the .dts files clean and correct, and keep that hacks hidden inside the
> >>> kernel.
> >>>
> >>
> >> Thanks for the explanation. Since DT are meant to describe hardware
> >> and not software I agree with you that we shouldn't leak an
> >> implementation detail to the DeviceTrees.
> >>
> >> And after all fortunately we don't have a stable API in the kernel
> >> like the one that is enforced in the DT so we can fix it later ;-)
> > 
> > This remapping of compatible flags sounds smelly to me, please discuss
> > it first with the device tree people.
> 
> It's already in v3.15.

Oh great.. And you dumped it into arch/arm/mach-omap2 too and I somehow
even acked it :( Looks like there's also the custom mux hacks. And
custom hwmod hacks. And ongoing soc_is_xxx tinkering. Now let's not add
_any_ new crap into arch/arm/mach-omap2/display.c.

So please consider this a huge eternal NAK to add any more crap to
arch/arm/mach-omap2/display.c from me. No more new soc_is beyond
the soc_is_am43xx() you have in linux next. No more adding 
of_find_compatible_node() beyond ti,omap5-dss you have in linux next.

And no more new panel remapping in this file as soon as you have found
a better solution. Preferrably by v3.17 merge window. This file just
needs to disappear. Yuk.

> I agree it's smelly, but it smelly only inside the kernel, not visible
> anywhere, and we can remove it when we have common panel drivers,
> without any modifications to .dts files.
> 
> > I think we're better off just using the compatible properties limited
> > to the simple-panel.txt for now and actually describe the real
> > hardware. The fact that the panel is connected to DSS should be possible
> > to find out based on the phandles.
> 
> I'm not sure what you mean. We do describe only the real hardware. The
> compatible string in the .dts file is "sharp,ls037v7dw01".
> 
> Prepending the "omapdss" to the compatible string is required for the
> device/driver matching to work, because we can't use the
> "sharp,ls037v7dw01" compatible string in our omap specific panel driver.
> 
> I'm not sure what it would give us to try to be compatible with
> simple-panel.txt. The simple-panel bindings won't probably be compatible
> with the future common display drivers in any case, as the simple-panel
> binding is just too limited and doesn't describe the hardware fully.

Hmm what else does a panel need where the existing binding cannot be
extended? 

Regards,

Tony
