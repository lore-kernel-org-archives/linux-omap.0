From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 08:57:33 -0700
Message-ID: <20140519155732.GA4849@atomide.com>
References: <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com>
 <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com>
 <5379D35F.8040207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46201 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaESP5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 11:57:41 -0400
Content-Disposition: inline
In-Reply-To: <5379D35F.8040207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140519 02:49]:
> On 17/05/14 00:39, Tony Lindgren wrote:
> 
> >> AFAIK that remapping not needed at all. All that is already
> >> available with the compatible flags.
> > 
> > And alternatively we can also just use the sharp,ls037v7dw01
> > in the panel driver(s). We can have the panels bail out in driver
> > probe based on of_machine_is_compatible if nothing else is available.
> 
> I don't think that would work. Then we could have two panel drivers,
> both loaded into the kernel and both having the same driver name and the
> same compatible-string.
> 
> I'm not sure if it's even possible to load both of those drivers at the
> same time, but if it was, and the first one would get probe() called for
> a device, and the driver would return an error, I'm quite sure the
> driver framework won't continue trying with the other driver, as the
> first driver already matched for the device.

No need to load multiple drivers at this point. That's why I'm saying
you can bail out on the undesired display controller probes using
of_machine_is_compatible test. It's not that uncommon for drivers to do:

$ git grep of_machine_is_compatible drivers/ | wc -l
116
 
> > Also, currently the remapping code also probably keeps prepending
> > more and more omapdss,omapdss,omapdss,... on each kexec reboot? And
> 
> I don't think so. The code looks for, say, "ti,tfp410", and it wouldn't
> match for "omapdss,ti,tfp410".

OK
 
> > it would be quite silly for each display controller to have to do
> > their own remapping for shared panels?
> 
> It would, but wouldn't it be just as silly (well, even more silly in my
> opinion) to have each display controller require driver specific
> compatible strings for the panels used?

Not driver specific, but hardware package specific. That's being done
all the time. For example, compatible strings like "nvidia,tegra124",
"ti,omap5" describe a package of an ARM core and various devices.

But by using of_machine_is_compatible in the display drivers, you
can use the right compatible flags from the start if you want to go
that way.

> Until we have a common display framework, we need _some_ way to handle
> this problem. Either we mess up the .dts files as you suggest, or we
> have a driver internal hack.

It seems that there's no need to mess up the .dts files here by
using the of_machine_is_compatible check in the drivers.
 
> > If we still still despite all these reasons decide to go with
> > the remapping of the compatible strings, it should really be a
> > Linux generic (or drivers/video generic function), not implemented
> > for each display controller.
> 
> Well, I sure hope nobody else has to implement similar thing.

Suuuure.. I've heard that about 20 times before and guess what
happenened? Things never got fixed until some poor maintainer
had to start fixing it all over the place about three years later.
 
> The reason why we have this code, and others do not, is mainly that
> omapdss is maybe the first driver to implement the display components
> properly, both in the SW side and in the .dts side, and that I wanted
> omapdss to behave correctly even if there are other display
> subsystems/panels compiled into the same kernel.
> 
> To open that up a bit, traditionally other display driver architectures
> have not had drivers for each display "entity", like the panels. So you
> would really just have the display subsystem in the .dts, and some raw
> data there (panel timings) to get the panel running.

Right, I believe that is the way to go, no doubt about it.
 
> Now, with omapdss, we have separate drivers for each display entity.
> Unfortunately those drivers are all tied to the omapdss driver's API
> (and cannot thus be used on anything else than OMAP), as there's not yet
> a driver framework for display entities (DRM is a bit different thing,
> in my opinion).
> 
> Everything with that was simple with platform data, as the omap board
> files created the panel devices, and there were no name clashing
> problems with other platforms.
> 
> With DT that changed, as the bindings are common, and thus the
> compatible strings are common also. But we still have omapdss specific
> panel drivers. This is the reason we do the compatible-string conversion
> hack. As soon as we can create platform agnostic panel drivers, we can
> remove the hack.
> 
> And, I want to remind, it's an omapdss internal hack (after the patch I
> sent), not visible to anyone else. The .dts files, the arch/arm files,
> they are all not touched. So I don't quite understand why you see it as
> such a bad thing. It's ugly, sure, but what harm does it do (except some
> maintainer burden, for me)?

Here's a list of things that bothers me:

1. Searching through the dtb from a driver instead of relying on the
   driver probe mechanism for the components in question. If the parsing
   of the dtb needs to be done it should be done in a Linux generic way
   from some framework instead.

2. Having to do this all early before we even have any debug console
   available. We are trying to move everything to happen later on to avoid
   all the issues related to initializing things early.

3. Having to maintain a database in kernel of display mappings separately
   in addition to the .dts files.

4. Having this hack limited to device tree based booting while we are
   trying to unify the functions for drivers to use to get their
   resources.

5. Seeing the possibility of this spreading to other drivers.

Regards,

Tony
