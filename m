From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 11 Oct 2013 08:36:55 -0700
Message-ID: <20131011153654.GN29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
 <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14825 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757484Ab3JKPhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 11:37:02 -0400
Content-Disposition: inline
In-Reply-To: <5257BD3E.5000707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prakash Manjunathappa <prakash.pm@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>

* Roger Quadros <rogerq@ti.com> [131011 02:04]:
> On 10/11/2013 11:00 AM, Linus Walleij wrote:
> > On Thu, Oct 10, 2013 at 6:20 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Linus Walleij <linus.walleij@linaro.org> [131010 09:19]:
> >>> On Thu, Oct 10, 2013 at 6:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>>> * Roger Quadros <rogerq@ti.com> [131010 06:32]:
> >>>>>
> >>>>> I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
> >>>>> while the system is still running and only the EHCI controller is runtime suspended.
> >>>>>
> >>>>> It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
> >>>>> whenever the pad wakeup_enable bit is changed.
> >>>>
> >>>> Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
> >>>> pcs_irq_handle() like the comments there suggest? At least for me that keeps
> >>>> the wake-up interrupts continuously running on omap3 instead of just idle modes.
> >>>
> >>> If the rearm() function is calling this _reconfigure_io_chain my comments
> >>> on the fact that this is something that should be handled by the pin
> >>> control driver still apply I think ....
> >>
> >> Yes, except that the reconfigure_io_chain registers are in the PRM module, not in
> >> the SCM module where the pinctrl registers are.. And that shared PRM interrupt is
> >> used mostly for the internal domain wake-ups, so we should keep that in the PRM
> >> driver.
> > 
> > That depends.
> > 
> > One-iorange-equals-one-driver is a fallacy, especially given that MFD for
> > memory-mapped things exist for a reason.
> 
> +1
> 
> Another place I faced a similar problem was the OMAP control module, which contains
> registers for a number of different non related peripherals. (e.g. PHY for USB, SATA,
> Display clock, etc)

Guys, we really need to keep the register access between hardware modules
under control because the hardware blocks can live separate life from clocking
and power state point of view.

Regmap could be probably used for the register access across various hardware
modules in a controlled way that is also aware of the clocking and PM state of
the hardware modules in question. As long as it's done sanely, I'm OK with that.

But for any other kind of random direct register tinkering between hardware
modules, that's a no no.

> > What the pin control driver should do is control the pins. Whether the registers
> > are spread out in the entire IO-memory does not matter. We did have one system
> > which placed the IO-muxing together with each peripheral (!) and I did
> > still want
> > that to be handled by a single pinctrl driver picking out windows to all these
> > IO-ranges.
> > 
> > Things like the PRM which has (my guess) a gazillion registers related to its
> > deep-core SoC stuff should be handled by things like
> > drivers/mfd/syscon.c, which means it is dead simple for some other driver
> > using "just this one register" in that range to get a handle at it and poke it
> > using syscon_node_to_regmap() (just derference an ampersand ref)
> > syscon_regmap_lookup_by_compatible() (use a compatible string)
> > all returning a regmap * that you can use to poke these registers.
> 
> The register handling is fine. But how do we deal with resource handling?
> e.g. the block that has the deep-core registers might need to be clocked or powered
> before the registers can be accessed.

Right, that's the key issue here. The register access would have to be conditional
based on the hardware modules PM state. Otherwise we'll have hard to trace hangs
and oopses.

Regards,

Tony
