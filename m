From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Fri, 19 Jan 2018 13:33:10 -0800
Message-ID: <20180119213310.GA4180@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de>
 <20180116150314.GC4042@atomide.com>
 <d32d9836-5edd-d43d-547b-f22384950f2c@ti.com>
 <20180116232243.GD4042@atomide.com>
 <10dab35c-9c79-5a77-0654-1e99621e4c0f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10dab35c-9c79-5a77-0654-1e99621e4c0f-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [180119 20:23]:
> On 01/16/2018 05:22 PM, Tony Lindgren wrote:
> > The RSTST registers mostly tell the device internal reset reason
> > like watchdog reset for an accelerator. I'm not sure how the
> > API for those would look like, do you have some ideas?
> 
> There are multiple RSTST registers, each of which with different bits. .
> The PRM_RSTST is the one where you can catch the reset reasons (along
> with few others), but otherwise most of the other IP-specific RSTST
> registers capture the local reset status. The RSTST behavior is somewhat
> similar to how the softreset status is tracked on each IP's SYSC/SYSS
> registers. It does tell the reset status for some software triggered
> resets in RSTCTRL, and can have additional bits as well for some PRCM
> triggered h/w resets (like RETention reset).

Hmm so are you using these "additional" software status bits?

If the other bits don't matter, and the RSTCTRL reset bit has
a matching RSTST bit, then we could just read that bit back
in reset_simple_status and have a separate compatible value
for those like "ti,rstctrl-rstst".

> > Hmm, aren't you currently just reading the RSTST registers
> > directly for remoteproc etc?
> 
> Nope, all the PRCM related registers are hidden away underneath the
> hwmod layer, so the only code that I use is pm_runtime_{get/put}_sync()
> directly and omap_device_{assert/deassert}_reset() through pdata-quirks.
> Take a look in drivers/iommu/omap-iommu.c and
> arch/arm/mach-omap2/pdata-quirks.c (functional in mainline for OMAP4 and
> OMAP5 DSP/IPU MMUs).

OK, sorry I was thinking of the CLKCTRL IDLEST that are directly
accessed :)

> > And then we also have the CONTEXT register that tells if module
> > context was lost during idle :) The API for that could simply be
> > bool device_context_lost(struct device *dev) to describe that
> > kind of reset. Or it could maybe also use reset_control_status()
> > that returns -ECONNRESET? But then what resets the context lost
> > state as we don't need to reset the device?
> 
> I am not sure why the CONTEXT register belongs to the same discussion as
> the reset registers. In any case, I don't think any of the current code
> relies on this (other than incrementing the debug counters).

Well they are in the same PRM instance, and behave the same way
as RSTST :) They are like interrupt status registers where you can
read the state and write to clear it. I wonder if we do really have
a proper PRM interrupt for these too, Tero?

> The OMAP IOMMU would be a better test given that there's no in-kernel
> sgx module and we are not sure if the out-of-tree driver is functional
> with these changes.
> 
> I have some unit-test code at
> https://github.com/sumananna/omap-test-iommu.git
> 
> You would need to add a test node to DTS with reference to the MMU you
> want to test.

OK let's do some tests on that, I'll take a look at doing a dts
file over next few weeks.

> If we are exposing all the other registers directly to client drivers,
> then the client drivers can use the reset API directly. But if other
> registers are hidden away underneath various frameworks, then we have
> some sequencing issues.

Right that needs to be checked. For ti-sysc driver we only need to
care about the rests that are needed to read and configure the
interconnect target module. The rest can be handled directly by
the child device drivers hopefully.

> Tero had done a series sometime back using notifiers to take care of
> these sequencing steps, but that was deferred pending the other hwmod
> cleanup. Last reference that touches it is here,
> https://marc.info/?l=linux-omap&m=147279610902646&w=2

Yeah the resets can all be device driver(s) now that we have the
clkctrl clocks usable and should have ti-sysc usable for v4.17.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
