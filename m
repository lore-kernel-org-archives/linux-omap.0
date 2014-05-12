From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 12 May 2014 07:26:46 -0700
Message-ID: <20140512142646.GA31772@atomide.com>
References: <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com>
 <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com>
 <536C8293.4070506@ti.com>
 <20140509155504.GE17814@atomide.com>
 <53707A64.2060203@ti.com>
 <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
 <53709706.10501@ti.com>
 <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51700 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758478AbaELO0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 10:26:55 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Javier Martinez Canillas <javier@dowhile0.org> [140512 03:01]:
> Hello Tomi,
> 
> On Mon, May 12, 2014 at 11:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On 12/05/14 12:34, Javier Martinez Canillas wrote:
> >
> >> Maybe we can remove this hackery by relying on the fact that a
> >> compatible string can have a set of values that goes from more
> >> specific to more general. So you can have something like:
> >>
> >> compatible = "sony,panel-foobar", "omapdss,panel-foobar"
> >>
> >> So right now only "omapdss,panel-foobar" will be matched and later
> >> when we have common panel drivers then that driver could handle the
> >> "sony,panel-foobar" compatible string.
> >>
> >> Other platforms could do something similar and have
> >>
> >> compatible = "sony,panel-foobar", "baz,panel-foobar"
> >>
> >> That way you won't break DT backward compatible but still not require
> >> hacks on arch/arm/mach-omap2/display.c.
> >>
> >> We do the same for OMAP boards, we now have the following compatible string:
> >>
> >> compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
> >>
> >> There isn't a struct machine_desc that matches "isee,omap3-igep0020"
> >> but later if we find that we need some board specific initialization
> >> we could add one without breaking existing DTS. In fact it used to be
> >> a single machine_desc that matched "ti,omap3" for both omap36xx and
> >> omap34xx but later when some DT clocks changes were introduced we
> >> needed to split both SoC families.
> >
> > I think that's a different thing. "isee,omap3-igep0020" is a proper
> > compatible string, if the board is "isee,...".  No matter what software
> > you run, that's correct and fine.
> >
> > The omapdss case is different, there the "omapdss" points to a sw thing,
> > it does not describe the hardware. It's only needed as we don't have
> > proper sw drivers for the devices.
> >
> > That said, I think what you describe would work. But I would rather keep
> > the .dts files clean and correct, and keep that hacks hidden inside the
> > kernel.
> >
> 
> Thanks for the explanation. Since DT are meant to describe hardware
> and not software I agree with you that we shouldn't leak an
> implementation detail to the DeviceTrees.
> 
> And after all fortunately we don't have a stable API in the kernel
> like the one that is enforced in the DT so we can fix it later ;-)

This remapping of compatible flags sounds smelly to me, please discuss
it first with the device tree people.

I think we're better off just using the compatible properties limited
to the simple-panel.txt for now and actually describe the real
hardware. The fact that the panel is connected to DSS should be possible
to find out based on the phandles.

Regards,

Tony
