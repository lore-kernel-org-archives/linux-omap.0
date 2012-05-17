From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Thu, 17 May 2012 17:27:55 -0600
Message-ID: <20120517232755.EF4383E062C@localhost>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com> <1335536018-16004-9-git-send-email-tarun.kanti@ti.com> <87y5oqtpnw.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32895 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760642Ab2EQX16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 19:27:58 -0400
Received: by pbbrp8 with SMTP id rp8so3153275pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 16:27:57 -0700 (PDT)
In-Reply-To: <87y5oqtpnw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, 17 May 2012 15:21:07 -0700, Kevin Hilman <khilman@ti.com> wrote:
> Tarun, Santosh,
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > We do checking for bank->enabled_non_wakeup_gpios in order
> > to skip redundant operations. Somehow, the check got missed
> > while doing the cleanup series.
> >
> > Just to make sure that we do context restore correctly in
> > *_runtime_resume(), the bank->workaround_enabled check is
> > moved after context restore. Otherwise, it would prevent
> > context restore when bank->enabled_non_wakeup_gpios is 0.
> >
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Cousson, Benoit <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> I just noticed that this patch has caused some strange problems, notably
> with the GPIO IRQ used by smsc911x NIC (Overo, Zoom3, 2430SDP, etc. etc.)
> 
> The patch itself is OK, but it has exposed a bug in other parts of the
> context restore path that was previously hidden.
> 
> We seem to have been finding lots of GPIO bugs by just testing the
> network chips with GPIO IRQs.  Can I suggest that a platform with a GPIO
> IRQ NIC be added to the test platforms you're using? 
> 
> > ---
> >  drivers/gpio/gpio-omap.c |   13 ++++++++-----
> >  1 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index d238f84..59a4af1 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1160,6 +1160,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
> >  
> >  	spin_lock_irqsave(&bank->lock, flags);
> >  
> > +	if (!bank->enabled_non_wakeup_gpios)
> > +		goto update_gpio_context_count;
> > +
> >  	/*
> >  	 * Only edges can generate a wakeup event to the PRCM.
> >  	 *
> > @@ -1235,11 +1238,6 @@ static int omap_gpio_runtime_resume(struct device *dev)
> >  	__raw_writel(bank->context.risingdetect,
> >  		     bank->base + bank->regs->risingdetect);
> >  
> > -	if (!bank->workaround_enabled) {
> > -		spin_unlock_irqrestore(&bank->lock, flags);
> > -		return 0;
> > -	}
> > -
> 
> My moving this below, you exposed some buggy code that can now get
> executed in non-OFF mode, wherease before $SUBJECT patch, it would never
> be exectued in non-OFF mode.
> 
> >  	if (bank->get_context_loss_count) {
> >  		context_lost_cnt_after =
> >  			bank->get_context_loss_count(bank->dev);
> 
> ...right below this line, we have:
> 
> 		if (context_lost_cnt_after != bank->context_loss_count ||
> 						!context_lost_cnt_after) {
> 			omap_gpio_restore_context(bank);
> 
> While we've never hit off-mode, context_lost_cnt_after will always be
> zero.  However, becasue of the !context_lost_cnt_after check there, we
> will *always* restore the bank context, even though context has never
> been lost.
> 
> I have no idea why that !context_lost_cnt_after check is there, but
> clearly it is wrong.  Now that you moved the 'workraound_enabled' check
> below this section, as long as off-mode is disabled, the some GPIO
> context will be restored here on *every* runtime PM transition.
> 
> The patch below fixes the problem.
> 
> Grant, after Tarun/Santosh have a chance to review/ack this, can you
> still get this in for 3.5?  If not, getting it into -rc should be fine.

Yes.  Do you have any other omap patches?  Do you want to send me a
pull req?

g.

> > Kevin
> 
> 
> From 83874df8e0dd78a3609f5ba81d608df7217fd212 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Thu, 17 May 2012 14:52:56 -0700
> Subject: [PATCH] gpio/omap: fix broken context restore for non-OFF mode
>  transitions
> 
> The fix in commit 1b12870 (gpio/omap: fix missing check in
> *_runtime_suspend()) exposed another bug in the context restore path.
> 
> Currently, the per-bank context restore happens whenever the context
> loss count is different in runtime suspend and runtime resume *and*
> whenever the per-bank contex_loss_count == 0:
> 
> 	if (context_lost_cnt_after != bank->context_loss_count ||
> 					!context_lost_cnt_after) {
> 		omap_gpio_restore_context(bank);
> 
> Restoring context when the context_lost_cnt_after == 0 is clearly
> wrong, since this will be true until the first off-mode transition
> (which could be never, if off-mode is never enabled.)  This check
> causes the context to be restored on *every* runtime PM transition.
> 
> Before commit 1b12870 (gpio/omap: fix missing check in
> *_runtime_suspend()), this code was never executed in non-OFF mode, so
> there were never spurious context restores happening.  After that
> change though, spurious context restores could happen.
> 
> To fix, simply remove the !context_lost_cnt_after check. It is not
> needed.
> 
> This bug was found when noticing that the smc911x NIC on 3530/Overo
> was not working, and git bisect tracked it down to this patch.  It
> seems that the spurious context restore was causing the smsc911x to
> not be properly probed on this platform.
> 
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 9b71f04..b570a6a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1238,8 +1238,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
>  	if (bank->get_context_loss_count) {
>  		context_lost_cnt_after =
>  			bank->get_context_loss_count(bank->dev);
> -		if (context_lost_cnt_after != bank->context_loss_count ||
> -						!context_lost_cnt_after) {
> +		if (context_lost_cnt_after != bank->context_loss_count) {
>  			omap_gpio_restore_context(bank);
>  		} else {
>  			spin_unlock_irqrestore(&bank->lock, flags);
> -- 
> 1.7.9.2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
