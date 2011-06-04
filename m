From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Sat, 04 Jun 2011 11:01:44 +0300
Message-ID: <1307174504.1777.24.camel@lappyti>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
	 <87hb86a5mm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53667 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790Ab1FDIBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jun 2011 04:01:53 -0400
In-Reply-To: <87hb86a5mm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

On Fri, 2011-06-03 at 15:53 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > Hi Kevin,
> >
> > On Fri, 2011-06-03 at 09:45 -0700, Kevin Hilman wrote:
> >> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> >> 
> >> > Use PM runtime and HWMOD support to handle enabling and disabling of DSS
> >> > modules.
> >> >
> >> > Each DSS module will have get and put functions which can be used to
> >> > enable and disable that module. The functions use pm_runtime and hwmod
> >> > opt-clocks to enable the hardware.
> >> >
> >> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> 
> >> [...]
> >> 
> >> > +int dispc_runtime_get(void)
> >> > +{
> >> > +	int r;
> >> > +
> >> > +	mutex_lock(&dispc.runtime_lock);
> >> 
> >> It's not clear to me what the lock is trying to protect.  I guess it's
> >> the counter?  I don't think it should be needed...
> >
> > Yes, the counter. I don't think
> >
> > if (dispc.runtime_count++ == 0)
> >
> > is thread safe.
> 
> OK, if it's just the counter, you can drop the mutex and use an atomic
> variable and use atomic_inc(), atomic_dec() etc.  Then it will be clear
> from reading what exactly is protected.

Hmm, sorry, my mistake. It's actually for the whole function: we can't
do "put" before the whole "get" has finished. Otherwise we could end up,
for example, disabling a clock before enabling it.

> >> > +	if (dispc.runtime_count++ == 0) {
> >> 
> >> You shouldn't need your own use-counting here.  The runtime PM core is
> >> already doing usage counting.
> >> 
> >> Instead, you need to use the ->runtime_suspend() and ->runtime_resume()
> >> callbacks (in dev_pm_ops).  These callbacks are called by the runtime PM
> >> core when the usage count goes to/from zero.
> >
> > Yes, I wish I could do that =).
> >
> > I tried to explain this in the 00-patch, I guess I should've explained
> > it in this patch also. Perhaps also in a comment.
> 
> Oops, my fault.  I didn't read the whole 00 patch.  I'm pretty ignorant
> about DSS, so I was focused in on the runtime PM implementation only.
> Sorry about that.
> 
> > From the introduction:
> >
> > ---
> >
> > Due to DSS' peculiar clock setup the code is not as elegant as I'd like. The
> > problem is that on OMAP4 we have to enable an optional clock before calling
> > pm_runtime_get(), and similarly we need to keep the optional clock enabled
> > until after pm_runtime_put() has been called.
> 
> Just to clarify, what exactly does the opt clock have to be enabled for?

I'm not sure if this is a valid definition, but in my mind the opt clock
has two uses: 1) a functional clock, to make the HW tick and registers
accessible, and 2) act as a source clock for the outgoing pixel clock.

Of these, the first one is the one that matters in this scope. So, it's
a mandatory clock, but it's optional in the sense that there are other
clocks that can be used in place of that clock.

All OMAPs support the DSS fclk from PRCM (this is the default). If I
remember right, OMAP2 also supports using sys clock as the DSS fclk.
OMAP3 and 4 support using DSI PLL (whose source clock is sys clock) as
the fclk.

> From what I can gather, this particular opt clock has to be enabled for
> the hwmod itself to be enabled (or disabled), correct?

Yes, the registers are unaccessible and the HW doesn't come out of reset
without the fclk.

> This has been a known issue for reset[1], but I wasn't aware that it was
> needed for a normal (re)enable of the hwmod.
> 
> > This causes some extra complications. For example, we can't use runtime_resume
> > callback to enable the opt clocks, as they are required before calling
> > pm_runtime_get().
> >
> 
> Yuck.
> 
> > ---
> >
> > So, the opt clock handling required by the driver pretty much messes the
> > whole idea of pm_runtime callbacks here. We can't do pretty much
> > anything in the suspend and resume callbacks.
> >
> > We can't do save_context() in the suspend callback, because suspend
> > could be called later, after pm_runtime_put_sync() and
> > dispc_runtime_put() has returned. And and that point we've turned off
> > the opt clock and can't touch the registers. If we'd move the opt-clock
> > clk_disable to suspend, but clk_enable in dispc_runtime_get(), we'd get
> > mismatched clk_disable/enable, so we can't do that. etc.
> 
> Double yuck.
> 
> It's clear now that you at least wanted to do the "right" thing and
> thought about the variousways to do it, but weren't able to for various
> reasons.  Thanks!
> 
> > I didn't come up with any other solutions to this. In the end, the
> > dispc_runtime_get/put are quite clean functions (well, says me =), and
> > their usage is more or less equivalent to pm_runtime_get/put. So I don't
> > see it as a horrible solution.
> 
> I agree, it's not horrible.  Just induces very mild nausea.  ;)
> 
> > If and when the hwmod/pm_runtime/something handles this opt-clock issue,
> > it shouldn't be too big of a job to use pm_runtime properly in the
> > omapdss. 
> 
> Agreed.  I certainly won't hold up this patch unless we come up with an
> alternate solution very quickly (which I will try below, and wait for
> Paul/Benoit to correct me.)
> 
> > Of course, if you or somebody else has a solution for this now, I'm
> > more than happy to use it =).
> 
> I don't have a solid solution, but so far, this sounds like an IP
> requirement that should be managed at the hwmod level.

I agree.

How I imagine things should work is that the hwmod code defaults to the
standard PRCM clock, but allows us to change the functional clock at a
later time, allowing the original clock to be disabled.

But I don't know how this would work in practice. The DSI PLL clock has
to be programmed via DSI HW, and the bits that control the clock muxes
are inside DSS. So the HWMOD code can't probably handle this by itself,
but needs the DSS to do certain things at certain times.

> One approach would be to have an option to selectively manage optional
> clocks in the hwmod enable/idle path.  We're doing it for reset[1], but
> not for anything else.  And based on the changelog there[1], it doesn't
> even sound like we fully understand the exact requirements around reset.

Yes, the OMAP4 DSS reset is a bit unclear for me.

> From the contortions you've had to go through though, it sounds like the
> same optional clocks that are needed for reset are needed for a "normal"
> module enable/disable.
> 
> I tried a simple hack to do that below[2].  Can you see if that works
> for you and if you can remove the opt clk mgmt from your driver(s)?  I
> only boot tested it on 3430/n900 which only has this opt-clk flag set
> for the GPIO IP blocks.

I didn't test it yet, but I would imagine it works. But it doesn't help
us towards properly using the other clocks as fclk.

However, it's not really any worse than the current DSS code. We don't
currently turn off the DSS fclk from the PRCM, even if we would use the
clock from the DSI PLL.

So perhaps an approach where hwmod would enable the fclk from the PRCM
automatically would be good. It's no worse than the other option, and 
it'd give us the ability to use pm_runtime in the proper way.

In this (hopefully temporary) solution the clock wouldn't really be
optional clock, but mandatory.

> Another idea off the top of my head is to extend runtime PM to have a
> couple additional callbacks.  Something like ->runtime_resume_prepare()
> which would be called before the HW is enabled (and thus before
> ->runtime_resume()), and similarily ->runtime_suspend_complete() which
> would be called after ->runtime_suspend() and after the HW has been
> disabled.
> 
> I don't really like this approach because so far this is the only driver
> that has needed something like this.  And in the case of this IP the
> enable/disable of the optional clocks seems like a HW requirement for
> the correct enable/disable of the IP, so it seems like something that
> should be managed by the hwmod.

Yes, I agree, that doesn't sound like a very good approach.

 Tomi


