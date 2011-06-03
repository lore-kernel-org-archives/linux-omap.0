From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Fri, 03 Jun 2011 20:43:05 +0300
Message-ID: <1307122985.2016.72.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41519 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753182Ab1FCRnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 13:43:10 -0400
In-Reply-To: <871uzahnib.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com

Hi Kevin,

On Fri, 2011-06-03 at 09:45 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > Use PM runtime and HWMOD support to handle enabling and disabling of DSS
> > modules.
> >
> > Each DSS module will have get and put functions which can be used to
> > enable and disable that module. The functions use pm_runtime and hwmod
> > opt-clocks to enable the hardware.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> [...]
> 
> > +int dispc_runtime_get(void)
> > +{
> > +	int r;
> > +
> > +	mutex_lock(&dispc.runtime_lock);
> 
> It's not clear to me what the lock is trying to protect.  I guess it's
> the counter?  I don't think it should be needed...

Yes, the counter. I don't think

if (dispc.runtime_count++ == 0)

is thread safe.

> > +	if (dispc.runtime_count++ == 0) {
> 
> You shouldn't need your own use-counting here.  The runtime PM core is
> already doing usage counting.
> 
> Instead, you need to use the ->runtime_suspend() and ->runtime_resume()
> callbacks (in dev_pm_ops).  These callbacks are called by the runtime PM
> core when the usage count goes to/from zero.

Yes, I wish I could do that =).

I tried to explain this in the 00-patch, I guess I should've explained
it in this patch also. Perhaps also in a comment.

>From the introduction:

---

Due to DSS' peculiar clock setup the code is not as elegant as I'd like. The
problem is that on OMAP4 we have to enable an optional clock before calling
pm_runtime_get(), and similarly we need to keep the optional clock enabled
until after pm_runtime_put() has been called.

This causes some extra complications. For example, we can't use runtime_resume
callback to enable the opt clocks, as they are required before calling
pm_runtime_get().

---

So, the opt clock handling required by the driver pretty much messes the
whole idea of pm_runtime callbacks here. We can't do pretty much
anything in the suspend and resume callbacks.

We can't do save_context() in the suspend callback, because suspend
could be called later, after pm_runtime_put_sync() and
dispc_runtime_put() has returned. And and that point we've turned off
the opt clock and can't touch the registers. If we'd move the opt-clock
clk_disable to suspend, but clk_enable in dispc_runtime_get(), we'd get
mismatched clk_disable/enable, so we can't do that. etc.

I didn't come up with any other solutions to this. In the end, the
dispc_runtime_get/put are quite clean functions (well, says me =), and
their usage is more or less equivalent to pm_runtime_get/put. So I don't
see it as a horrible solution.

If and when the hwmod/pm_runtime/something handles this opt-clock issue,
it shouldn't be too big of a job to use pm_runtime properly in the
omapdss. Of course, if you or somebody else has a solution for this now,
I'm more than happy to use it =).

And this opt-clock problem pretty much covers all your comments below,
except one which I've answered also.

> IOW, this function should simply be a pm_runtime_get_sync(), and the
> rest of the stuff in this function should be done in the
> ->runtime_resume() callback, which is only executed when the usage_count
> transitions from zero.
> 
> > +		DSSDBG("dispc_runtime_get\n");
> > +
> > +		r = dss_runtime_get();
> > +		if (r)
> > +			goto err_dss_get;
> > +
> > +		/* XXX dispc fclk can also come from DSI PLL */
> > +		clk_enable(dispc.dss_clk);
> > +
> > +		r = pm_runtime_get_sync(&dispc.pdev->dev);
> > +		WARN_ON(r);
> > +		if (r < 0)
> > +			goto err_runtime_get;
> > +
> > +		if (dispc_need_ctx_restore())
> > +			dispc_restore_context();
> > +	}
> > +
> > +	mutex_unlock(&dispc.runtime_lock);
> > +
> > +	return 0;
> > +
> > +err_runtime_get:
> > +	clk_disable(dispc.dss_clk);
> > +	dss_runtime_put();
> > +err_dss_get:
> > +	mutex_unlock(&dispc.runtime_lock);
> > +
> > +	return r;
> >  }
> >  
> > +void dispc_runtime_put(void)
> > +{
> > +	mutex_lock(&dispc.runtime_lock);
> > +
> > +	if (--dispc.runtime_count == 0) {
> > +		int r;
> 
> Same problem here.  
> 
> No usage counting is required (and probably no locking either.)  This
> function should simply be a pm_runtime_put(), and the rest of the stuff
> should be in the driver's ->runtime_suspend() callback.
> 
> > +		DSSDBG("dispc_runtime_put\n");
> > +
> > +		dispc_save_context();
> > +
> > +		r = pm_runtime_put_sync(&dispc.pdev->dev);
> 
> Does this need to be the _sync() version?  It looks like it could be use
> the "normal" (async) version.: pm_runtime_put().

It's sync because we turn off the opt clock below, and the HW shouldn't
be touched after that, which I guess pm_runtime_put (or the subsequent
async suspend) could do.

 Tomi


