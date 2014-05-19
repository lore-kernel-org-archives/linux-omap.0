From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 12:51:01 -0700
Message-ID: <20140519195100.GB11945@atomide.com>
References: <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com>
 <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com>
 <537A540E.8070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41107 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751254AbaESTvK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 15:51:10 -0400
Content-Disposition: inline
In-Reply-To: <537A540E.8070302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140519 11:58]:
> On 19/05/14 18:57, Tony Lindgren wrote:
> 
> >> I'm not sure if it's even possible to load both of those drivers at the
> >> same time, but if it was, and the first one would get probe() called for
> >> a device, and the driver would return an error, I'm quite sure the
> >> driver framework won't continue trying with the other driver, as the
> >> first driver already matched for the device.
> > 
> > No need to load multiple drivers at this point. That's why I'm saying
> > you can bail out on the undesired display controller probes using
> > of_machine_is_compatible test. It's not that uncommon for drivers to do:
> 
> Hmm, I don't follow. If both, say, omap and exynos have a panel driver
> for the same sharp panel, both need a driver for it (presuming exynos
> has a proper display component driver system, which may not be true).
> 
> Both drivers would be loaded at boot time for the probe to be even to be
> possible. Even if the other one bails out from a device probe using
> of_machine_is_compatible, afaik the driver framework will stop probing
> at that point, as that driver reports being compatible with the device
> in question.
> 
> ...
> 
> Ah, ok, now I see. I think you mean module init, not probe? For some
> reason I was just thinking about the probe stage.
> 
> Maybe that would work. I need to test tomorrow.

Ah right probe is too late as the match has been made already by then :)
 
> >>> it would be quite silly for each display controller to have to do
> >>> their own remapping for shared panels?
> >>
> >> It would, but wouldn't it be just as silly (well, even more silly in my
> >> opinion) to have each display controller require driver specific
> >> compatible strings for the panels used?
> > 
> > Not driver specific, but hardware package specific. That's being done
> > all the time. For example, compatible strings like "nvidia,tegra124",
> > "ti,omap5" describe a package of an ARM core and various devices.
> 
> It feels to me rather wrong if I'd specify the compatible string for an
> external piece of hardware based on the SoC it's connected to.
> 
> > But by using of_machine_is_compatible in the display drivers, you
> > can use the right compatible flags from the start if you want to go
> > that way.
> 
> Yes, with that we could have right compatible flags in the .dts.
> 
> >> Well, I sure hope nobody else has to implement similar thing.
> > 
> > Suuuure.. I've heard that about 20 times before and guess what
> > happenened? Things never got fixed until some poor maintainer
> > had to start fixing it all over the place about three years later.
> 
> The poor maintainer here being me =). And it's still a case of
> pick-your-poison. We need to hack around the issue, in some form or
> another. So in any case the poor maintainer has to fix it at some point
> in the future.

Yeah I agree none of the options so far have been very nice.
 
> But all this is fixed when we have a common display framework. And
> that's something that is really badly needed in some form or another,
> the sooner the better.
> 
> So the "fix" here is not just some internal thing that could be left at
> that and forgotten.

Yes..
 
> >> To open that up a bit, traditionally other display driver architectures
> >> have not had drivers for each display "entity", like the panels. So you
> >> would really just have the display subsystem in the .dts, and some raw
> >> data there (panel timings) to get the panel running.
> > 
> > Right, I believe that is the way to go, no doubt about it.
> 
> No, that's exactly _not_ the way to go =). We need proper drivers for
> display components, instead of trying to avoid that and embed panel data
> into the display controller's data.

Right, sorry I misread it :)
 
> > Here's a list of things that bothers me:
> > 
> > 1. Searching through the dtb from a driver instead of relying on the
> >    driver probe mechanism for the components in question. If the parsing
> >    of the dtb needs to be done it should be done in a Linux generic way
> >    from some framework instead.
> 
> The reason I haven't made the conversion code available for others to
> use is that there are no other users at the moment. And I hope there
> will be no other user until we get the common display framework. If
> there is, we'll need to move the code to a generic place.
> 
> > 2. Having to do this all early before we even have any debug console
> >    available. We are trying to move everything to happen later on to avoid
> >    all the issues related to initializing things early.
> 
> It worked fine for me when doing it as subsys_init level. Why do you say
> it'd be early, before debug console?

The debug console should not be needed for debugging drivers.. Just
the serial console. This is because it's hard for users to produce
decent error information when the system does not boot if DEBUG_LL
and earlyprintk need to be enabled.
 
> All the drivers with converted compatible strings are normal drivers, so
> afaik things work fine if we just convert the strings before the module
> init level.

Yes that seems like the right place to do the workarounds.
 
> > 3. Having to maintain a database in kernel of display mappings separately
> >    in addition to the .dts files.
> 
> Yes, that's slightly annoying. Not really a big burden, though, as it's
> quite rare to get a new encoder or panel driver.
> 
> > 4. Having this hack limited to device tree based booting while we are
> >    trying to unify the functions for drivers to use to get their
> >    resources.
> 
> I don't understand this one. With non-DT boot we don't have the issue at
> all, there's no need for hacks.

Hmm can't we still have multiarch booting happening with the same
panel name being used by two different display drivers?
 
> > 5. Seeing the possibility of this spreading to other drivers.
> 
> Well, until we have a common display framework, one of the hacky options
> we've discussed will spread to other drivers if they need to have their
> own drivers for the same hardware devices.
> 
> Which is not nice, but not something we can escape. And using the
> of_machine_is_compatible or having the compatible strings in .dts
> appended with "dss" or such doesn't change that, it just changes which
> hack may spread.

Yes I agree they are all hacks, but your version seems to carry some
extra early init baggage with it as I noted above :)

Regards,

Tony
