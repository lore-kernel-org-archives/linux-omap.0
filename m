From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Fri, 03 Jun 2011 15:53:53 -0700
Message-ID: <87hb86a5mm.fsf@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	<1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	<871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50337 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754247Ab1FCWx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 18:53:57 -0400
In-Reply-To: <1307122985.2016.72.camel@deskari> (Tomi Valkeinen's message of
	"Fri, 03 Jun 2011 20:43:05 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> Hi Kevin,
>
> On Fri, 2011-06-03 at 09:45 -0700, Kevin Hilman wrote:
>> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>> 
>> > Use PM runtime and HWMOD support to handle enabling and disabling of DSS
>> > modules.
>> >
>> > Each DSS module will have get and put functions which can be used to
>> > enable and disable that module. The functions use pm_runtime and hwmod
>> > opt-clocks to enable the hardware.
>> >
>> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> 
>> [...]
>> 
>> > +int dispc_runtime_get(void)
>> > +{
>> > +	int r;
>> > +
>> > +	mutex_lock(&dispc.runtime_lock);
>> 
>> It's not clear to me what the lock is trying to protect.  I guess it's
>> the counter?  I don't think it should be needed...
>
> Yes, the counter. I don't think
>
> if (dispc.runtime_count++ == 0)
>
> is thread safe.

OK, if it's just the counter, you can drop the mutex and use an atomic
variable and use atomic_inc(), atomic_dec() etc.  Then it will be clear
from reading what exactly is protected.

>> > +	if (dispc.runtime_count++ == 0) {
>> 
>> You shouldn't need your own use-counting here.  The runtime PM core is
>> already doing usage counting.
>> 
>> Instead, you need to use the ->runtime_suspend() and ->runtime_resume()
>> callbacks (in dev_pm_ops).  These callbacks are called by the runtime PM
>> core when the usage count goes to/from zero.
>
> Yes, I wish I could do that =).
>
> I tried to explain this in the 00-patch, I guess I should've explained
> it in this patch also. Perhaps also in a comment.

Oops, my fault.  I didn't read the whole 00 patch.  I'm pretty ignorant
about DSS, so I was focused in on the runtime PM implementation only.
Sorry about that.

> From the introduction:
>
> ---
>
> Due to DSS' peculiar clock setup the code is not as elegant as I'd like. The
> problem is that on OMAP4 we have to enable an optional clock before calling
> pm_runtime_get(), and similarly we need to keep the optional clock enabled
> until after pm_runtime_put() has been called.

Just to clarify, what exactly does the opt clock have to be enabled for?

>From what I can gather, this particular opt clock has to be enabled for
the hwmod itself to be enabled (or disabled), correct?

This has been a known issue for reset[1], but I wasn't aware that it was
needed for a normal (re)enable of the hwmod.

> This causes some extra complications. For example, we can't use runtime_resume
> callback to enable the opt clocks, as they are required before calling
> pm_runtime_get().
>

Yuck.

> ---
>
> So, the opt clock handling required by the driver pretty much messes the
> whole idea of pm_runtime callbacks here. We can't do pretty much
> anything in the suspend and resume callbacks.
>
> We can't do save_context() in the suspend callback, because suspend
> could be called later, after pm_runtime_put_sync() and
> dispc_runtime_put() has returned. And and that point we've turned off
> the opt clock and can't touch the registers. If we'd move the opt-clock
> clk_disable to suspend, but clk_enable in dispc_runtime_get(), we'd get
> mismatched clk_disable/enable, so we can't do that. etc.

Double yuck.

It's clear now that you at least wanted to do the "right" thing and
thought about the variousways to do it, but weren't able to for various
reasons.  Thanks!

> I didn't come up with any other solutions to this. In the end, the
> dispc_runtime_get/put are quite clean functions (well, says me =), and
> their usage is more or less equivalent to pm_runtime_get/put. So I don't
> see it as a horrible solution.

I agree, it's not horrible.  Just induces very mild nausea.  ;)

> If and when the hwmod/pm_runtime/something handles this opt-clock issue,
> it shouldn't be too big of a job to use pm_runtime properly in the
> omapdss. 

Agreed.  I certainly won't hold up this patch unless we come up with an
alternate solution very quickly (which I will try below, and wait for
Paul/Benoit to correct me.)

> Of course, if you or somebody else has a solution for this now, I'm
> more than happy to use it =).

I don't have a solid solution, but so far, this sounds like an IP
requirement that should be managed at the hwmod level.

One approach would be to have an option to selectively manage optional
clocks in the hwmod enable/idle path.  We're doing it for reset[1], but
not for anything else.  And based on the changelog there[1], it doesn't
even sound like we fully understand the exact requirements around reset.

>From the contortions you've had to go through though, it sounds like the
same optional clocks that are needed for reset are needed for a "normal"
module enable/disable.

I tried a simple hack to do that below[2].  Can you see if that works
for you and if you can remove the opt clk mgmt from your driver(s)?  I
only boot tested it on 3430/n900 which only has this opt-clk flag set
for the GPIO IP blocks.
 
Another idea off the top of my head is to extend runtime PM to have a
couple additional callbacks.  Something like ->runtime_resume_prepare()
which would be called before the HW is enabled (and thus before
->runtime_resume()), and similarily ->runtime_suspend_complete() which
would be called after ->runtime_suspend() and after the HW has been
disabled.

I don't really like this approach because so far this is the only driver
that has needed something like this.  And in the case of this IP the
enable/disable of the optional clocks seems like a HW requirement for
the correct enable/disable of the IP, so it seems like something that
should be managed by the hwmod.

Now I'll wait for Benoit/Paul to enlighten us.

> And this opt-clock problem pretty much covers all your comments below,
> except one which I've answered also.
>
>> IOW, this function should simply be a pm_runtime_get_sync(), and the
>> rest of the stuff in this function should be done in the
>> ->runtime_resume() callback, which is only executed when the usage_count
>> transitions from zero.
>> 
>> > +		DSSDBG("dispc_runtime_get\n");
>> > +
>> > +		r = dss_runtime_get();
>> > +		if (r)
>> > +			goto err_dss_get;
>> > +
>> > +		/* XXX dispc fclk can also come from DSI PLL */
>> > +		clk_enable(dispc.dss_clk);
>> > +
>> > +		r = pm_runtime_get_sync(&dispc.pdev->dev);
>> > +		WARN_ON(r);
>> > +		if (r < 0)
>> > +			goto err_runtime_get;
>> > +
>> > +		if (dispc_need_ctx_restore())
>> > +			dispc_restore_context();
>> > +	}
>> > +
>> > +	mutex_unlock(&dispc.runtime_lock);
>> > +
>> > +	return 0;
>> > +
>> > +err_runtime_get:
>> > +	clk_disable(dispc.dss_clk);
>> > +	dss_runtime_put();
>> > +err_dss_get:
>> > +	mutex_unlock(&dispc.runtime_lock);
>> > +
>> > +	return r;
>> >  }
>> >  
>> > +void dispc_runtime_put(void)
>> > +{
>> > +	mutex_lock(&dispc.runtime_lock);
>> > +
>> > +	if (--dispc.runtime_count == 0) {
>> > +		int r;
>> 
>> Same problem here.  
>> 
>> No usage counting is required (and probably no locking either.)  This
>> function should simply be a pm_runtime_put(), and the rest of the stuff
>> should be in the driver's ->runtime_suspend() callback.
>> 
>> > +		DSSDBG("dispc_runtime_put\n");
>> > +
>> > +		dispc_save_context();
>> > +
>> > +		r = pm_runtime_put_sync(&dispc.pdev->dev);
>> 
>> Does this need to be the _sync() version?  It looks like it could be use
>> the "normal" (async) version.: pm_runtime_put().
>
> It's sync because we turn off the opt clock below, and the HW shouldn't
> be touched after that, which I guess pm_runtime_put (or the subsequent
> async suspend) could do.

OK, I see now.

Kevin


[1]
commit 96835af970e5d6aeedf868e53590a947be5e4a7a
Author: Benoit Cousson <b-cousson@ti.com>
Date:   Tue Sep 21 18:57:58 2010 +0200

    OMAP: hwmod: Fix softreset for modules with optional clocks
    
    Some modules (like GPIO, DSS...) require optionals clock to be enabled
    in order to complete the sofreset properly.
    Add a HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to force all optional clocks
    to be enabled before reset. Disabled them once the reset is done.
    
    TODO:
    For the moment it is very hard to understand from the HW spec, which
    optional clock is needed and which one is not. So the current approach
    will enable all the optional clocks.
    Paul proposed a much finer approach that will allow to tag only the needed
    clock in the optional clock table. This might be doable as soon as we have
    a clear understanding of these dependencies.
    
    Reported-by: Partha Basak <p-basak2@ti.com>
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Kevin Hilman <khilman@deeprootsystems.com>


[2]
>From d2806a4148fbed869eff8703b1137cd35d16ef53 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 3 Jun 2011 15:33:25 -0700
Subject: [PATCH] OMAP2+: omap_hwmod: selectively manage optional clocks in enable/disable

Only-a-Test-Hack-and-Certainly-Not-Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..7bcf802 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -586,6 +586,9 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 	return ret;
 }
 
+static void _enable_optional_clocks(struct omap_hwmod *oh);
+static void _disable_optional_clocks(struct omap_hwmod *oh);
+
 /**
  * _enable_clocks - enable hwmod main clock and interface clocks
  * @oh: struct omap_hwmod *
@@ -599,6 +602,9 @@ static int _enable_clocks(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_enable_optional_clocks(oh);
+
 	if (oh->_clk)
 		clk_enable(oh->_clk);
 
@@ -642,6 +648,9 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		}
 	}
 
+	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
+		_disable_optional_clocks(oh);
+
 	/* The opt clocks are controlled by the device driver. */
 
 	return 0;
-- 
1.7.4

