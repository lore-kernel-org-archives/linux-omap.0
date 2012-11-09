From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
Date: Fri, 9 Nov 2012 11:40:23 -0800
Message-ID: <20121109194023.17381.62227@nucleus>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
 <1352417516-15213-1-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
 <20121109011738.17381.88199@nucleus>
 <alpine.DEB.2.00.1211091900250.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211091906340.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35251 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab2KITkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 14:40:45 -0500
In-Reply-To: <alpine.DEB.2.00.1211091906340.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Quoting Paul Walmsley (2012-11-09 11:08:00)
> On Fri, 9 Nov 2012, Paul Walmsley wrote:
> 
> > On Thu, 8 Nov 2012, Mike Turquette wrote:
> > 
> > > You're right.  In my rush I glossed over the clkdm decrement part.  In
> > > light of the suspend/resume issues I'm not sure this approach is really
> > > valid.  I think getting to the bottom of those issues will give the
> > > final word.
> > 
> > What do you think about something like this?  It's still under test and 
> > review here, but seems to avoid the warnings on 3530ES3 Beagle at least.
> > 
> > The usage of __clk_get_enable_count() in this code still seems like a hack 
> > to me.  It would be better for the CCF to call a different clk_hw_ops 
> > function pointer for the disable-unused-clocks case.  But if you agree, 
> > and plan to fix this, or have some other cleaner fix in mind for the near 
> > future, then something like this seems reasonable for the short term to 
> > me.  What do you think?
> 

For avoiding the WARNs, this seems fine to me.  And I agree that a new
clk_ops function pointer is needed.  Maybe something like,

void (*unused_disable)(struct clk_hw *hw);

But I'm OK with the below patch in the short term.  I just have one
question: did you observe any PM regressions by skipping the clkdm
programming?

Thanks,
Mike

> Here's the patch.  The changes to clkdm_clk_disable() are the important 
> ones, the rest can be ignored for the purposes of this review.
> 
> 
> - Paul
> 
> From: Mike Turquette <mturquette@ti.com>
> Date: Fri, 9 Nov 2012 11:28:42 -0700
> Subject: [PATCH] ARM: OMAP2+: clockdomain: bypass clockdomain handling when
>  disabling unused clks
> 
> The OMAP port to the common clk framework[1] resulted in spurious WARNs
> while disable unused clocks.  This is due to _clkdm_clk_hwmod_disable
> catching clkdm->usecount's with a value of zero.  Even less desirable it
> would not allow the clkdm_clk_disable function pointer to get called due
> to an early return of -ERANGE.
> 
> This patch adds a check for such a corner case by skipping the WARN and
> early return in the event that clkdm->usecount and clk->enable_usecount
> are both zero.  Presumably this could only happen during the check for
> unused clocks at boot-time.
> 
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/88824
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> [paul@pwsan.com: split the hwmod and clock disable cases; modified the
>  code to skip the clockdomain handling during the disable-unused-clocks phase]
> ---
>  arch/arm/mach-omap2/clockdomain.c |   91 ++++++++++++++++++++++---------------
>  1 file changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index 64e5046..1bd0ff0 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -22,6 +22,7 @@
>  #include <linux/clk.h>
>  #include <linux/limits.h>
>  #include <linux/err.h>
> +#include <linux/clk-private.h>
>  
>  #include <linux/io.h>
>  
> @@ -947,35 +948,6 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
>         return 0;
>  }
>  
> -static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
> -{
> -       unsigned long flags;
> -
> -       if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&clkdm->lock, flags);
> -
> -       if (atomic_read(&clkdm->usecount) == 0) {
> -               spin_unlock_irqrestore(&clkdm->lock, flags);
> -               WARN_ON(1); /* underflow */
> -               return -ERANGE;
> -       }
> -
> -       if (atomic_dec_return(&clkdm->usecount) > 0) {
> -               spin_unlock_irqrestore(&clkdm->lock, flags);
> -               return 0;
> -       }
> -
> -       arch_clkdm->clkdm_clk_disable(clkdm);
> -       pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> -
> -       pr_debug("clockdomain: %s: disabled\n", clkdm->name);
> -
> -       return 0;
> -}
> -
>  /**
>   * clkdm_clk_enable - add an enabled downstream clock to this clkdm
>   * @clkdm: struct clockdomain *
> @@ -1018,15 +990,39 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
>   */
>  int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
>  {
> -       /*
> -        * XXX Rewrite this code to maintain a list of enabled
> -        * downstream clocks for debugging purposes?
> -        */
> +       unsigned long flags;
> +       int force_disable = 0;
>  
> -       if (!clk)
> +       if (!clkdm || !clk || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
>                 return -EINVAL;
>  
> -       return _clkdm_clk_hwmod_disable(clkdm);
> +       spin_lock_irqsave(&clkdm->lock, flags);
> +
> +       /* corner case: disabling unused clocks */
> +       force_disable = (__clk_get_enable_count(clk) == 0) ? 1 : 0;
> +       if (force_disable)
> +               goto ccd_exit;
> +
> +       if (atomic_read(&clkdm->usecount) == 0) {
> +               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               WARN_ON(1); /* underflow */
> +               return -ERANGE;
> +       }
> +
> +       if (atomic_dec_return(&clkdm->usecount) > 0) {
> +               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               return 0;
> +       }
> +
> +       arch_clkdm->clkdm_clk_disable(clkdm);
> +       pwrdm_state_switch(clkdm->pwrdm.ptr);
> +
> +       pr_debug("clockdomain: %s: disabled\n", clkdm->name);
> +
> +ccd_exit:
> +       spin_unlock_irqrestore(&clkdm->lock, flags);
> +
> +       return 0;
>  }
>  
>  /**
> @@ -1077,6 +1073,8 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>   */
>  int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>  {
> +       unsigned long flags;
> +
>         /* The clkdm attribute does not exist yet prior OMAP4 */
>         if (cpu_is_omap24xx() || cpu_is_omap34xx())
>                 return 0;
> @@ -1086,9 +1084,28 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>          * downstream hwmods for debugging purposes?
>          */
>  
> -       if (!oh)
> +       if (!clkdm || !oh || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
>                 return -EINVAL;
>  
> -       return _clkdm_clk_hwmod_disable(clkdm);
> +       spin_lock_irqsave(&clkdm->lock, flags);
> +
> +       if (atomic_read(&clkdm->usecount) == 0) {
> +               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               WARN_ON(1); /* underflow */
> +               return -ERANGE;
> +       }
> +
> +       if (atomic_dec_return(&clkdm->usecount) > 0) {
> +               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               return 0;
> +       }
> +
> +       arch_clkdm->clkdm_clk_disable(clkdm);
> +       pwrdm_state_switch(clkdm->pwrdm.ptr);
> +       spin_unlock_irqrestore(&clkdm->lock, flags);
> +
> +       pr_debug("clockdomain: %s: disabled\n", clkdm->name);
> +
> +       return 0;
>  }
>  
> -- 
> 1.7.10.4
