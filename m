From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Tue, 13 May 2014 08:25:18 -0700
Message-ID: <20140513152518.GA16837@atomide.com>
References: <20140509155504.GE17814@atomide.com>
 <53707A64.2060203@ti.com>
 <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
 <53709706.10501@ti.com>
 <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
 <20140512142646.GA31772@atomide.com>
 <5370E0C9.8050201@ti.com>
 <20140512155132.GH31772@atomide.com>
 <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56361 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753599AbaEMPZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 11:25:25 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Javier Martinez Canillas <javier@dowhile0.org> [140513 04:40]:
> On Tue, May 13, 2014 at 12:51 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On 12/05/14 18:51, Tony Lindgren wrote:
> >
> >>> It's already in v3.15.
> >>
> >> Oh great.. And you dumped it into arch/arm/mach-omap2 too and I somehow
> >> even acked it :( Looks like there's also the custom mux hacks. And
> >> custom hwmod hacks. And ongoing soc_is_xxx tinkering. Now let's not add
> >
> > The omap2_dss_hwmod_data, create_dss_pdev and create_simple_dss_pdev,
> > omap_display_init stuff can be removed when the DT conversion has been done.

Yes great that helps :)

> > For the omap4_dsi_mux_pads (or the omap5 dsi muxing that was recently
> > discussed) I still have no solution, but I haven't spent time on it. I
> > have dropped the omap5 dsi muxing from the latest series for that reason.

OK

> > dispc_disable_outputs and omap_dss_reset are needed because omap_device
> > doesn't handle resetting DSS properly, as special steps need to be done
> > for that. omap_dss_reset is called from the hwmod/omap_device code, so I
> > don't think this code can be anywhere else.

OK that we should be able to do with drivers/reset eventually. The reset
and idle of drivers is also needed for unused devices too, so we can't
have drivers do it in those cases.

> > For the omap_display_get_version() I have no good solution. Making
> > separate .dts versions for all the needed OMAP ES versions seems like a
> > huge hassle to me, but that is one solution.
> >
> > I think that would mean having separate .dtsi files for omapdss for
> > omap3_es1, omap3_es3plus, omap4_es1, omap4_es2, omap4_es3plus, and then
> > having separate omapxxxx.dtsi files for all of those, and then separate
> > board .dts files for the ES versions used on each board.
> >
> > Or is there some sane way to define such things in dts?
> >
> 
> Unfortunately there isn't.
> 
> I have a similar problem with the IGEP boards since there are just too
> many variations of them (e.g: DM3730 SoC vs OMAP3530 SoC, NAND vs
> OneNAND, 256MB vs 512MB flash memory sizes, with and without wifi
> chip, etc).
> 
> Since dts are supposed to describe the hardware, each revision with a
> slighter variation forces to have a different dts. My solution was to
> not try to have a dts for every single variation in mainline but only
> one for the most common revision and that could be used as a reference
> to modify and ship on each device. Unfortunately that is not possible
> to you since each DSS IP block is used by many boards.

Well ideally the revision info for a device would come from device
revision registers rather using the SoC revision. In the DSS case when
the SoC revision is needed by a device it maybe it can be deciphered
from a combination of compatible flag and the clock rate for example?

But yeah I agree we still need revision detection in the kernel
rather than try to create separate .dtsi files for sub-revisions.
 
> >> _any_ new crap into arch/arm/mach-omap2/display.c.
> >>
> >> So please consider this a huge eternal NAK to add any more crap to
> >> arch/arm/mach-omap2/display.c from me. No more new soc_is beyond
> >> the soc_is_am43xx() you have in linux next. No more adding
> >> of_find_compatible_node() beyond ti,omap5-dss you have in linux next.
> >>
> >> And no more new panel remapping in this file as soon as you have found
> >> a better solution. Preferrably by v3.17 merge window. This file just
> >> needs to disappear. Yuk.
> >
> > Do you object to the compatible string remapping as such, or just that
> > it's in arch/arm/mach-omap2?

It's something I'd rather not have under mach-omap2 as that means that
I may need to deal with it too to some extent. And I don't think we
need to do such remapping, we should be able to use the panel compatible
strings as they are just fine. It should be possible to figure out from
the device tree properties what controller the panel belongs to. Or
for now, use the panel registration to figure out what display controller
it belongs to.

> > I guess nothing prevents me from moving it to drivers/, and having some
> > early-ish initcall doing the job.

/me likes this idea if you need it at all. Stuff like this tends to stay
and spread, so I'd rather not do the remapping of compatible strings at
all.

> > If the remapping as such is horrible, I'm all ears for better ideas. I
> > spent quite a lot of time on it, and that's the best I could come up with.
> >
> > It's rather simple prefixing of the compatible strings for selected
> > devices. The purpose of that is to have proper data in the .dts files
> > (which I think is very important) with the cost of having some rather
> > simple internal hacks in the kernel, which can be removed immediately
> > when we have a common display driver framework.
> >
> 
> Even though the compatible trick that I said before could be an
> alternative, it has the problem that does not describes the hardware
> as you said. The restriction of the DT being a stable API and get it
> right from the beginning forces us to make these kind of technical
> decisions.
> 
> So, since we can change the kernel later but not the DTS, I agree with
> you that the remapping is the least bad of our options.

Yes the binding for the panel should just describe the panel so it can be
used with whatever display controller. But we do have quite a few buses
probing devices. How about set up the panel probing the same way?

For the panels on display controller, just do the usual
for_each_child_of_node(pdev->dev.of_node, child) and probe them?

It seems the remapping of compatible strings is not needed in this
as we're only picking up panels that are children of the display
controller.
 
> >>> I'm not sure what it would give us to try to be compatible with
> >>> simple-panel.txt. The simple-panel bindings won't probably be compatible
> >>> with the future common display drivers in any case, as the simple-panel
> >>> binding is just too limited and doesn't describe the hardware fully.
> >>
> >> Hmm what else does a panel need where the existing binding cannot be
> >> extended?
> >
> > The existing simple-panel binding doesn't describe the connections of
> > the panel, i.e. its video input. I guess it can be extended, but I don't
> > see what the benefit is of trying to create new panel bindings
> > compatible with the simple-panel bindings. As I see, the simple-panel
> > bindings work only with very limited use cases, where the drivers make
> > assumptions. Simple panel bindings cannot be used with omapdss, nor can
> > it be used with the future common display framework.

Well it seems at least the reset and enable pin standard from that
binding can be kept.

> > But I'm not really familiar with using extending current bindings, and
> > making new bindings compatible with old ones. Can you explain why it'd
> > be good to have the sharp panel bindings compatible with simple-panel?
> > In what kind of scenario would it be used?

Ideally the panel binding just describes the panel and it should not
matter which display controller it is a child of.

Regards,

Tony
