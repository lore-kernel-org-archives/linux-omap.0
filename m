From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection
 instead of always dummy
Date: Thu, 14 Mar 2013 10:28:07 +0000
Message-ID: <20130314102807.GG13483@e106331-lin.cambridge.arm.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
 <514046B6.9020005@ti.com>
 <20130313101641.GA13483@e106331-lin.cambridge.arm.com>
 <514061D1.20603@ti.com>
 <20130313122550.GD13483@e106331-lin.cambridge.arm.com>
 <51409EC3.5050905@ti.com>
 <20130313161811.GF13483@e106331-lin.cambridge.arm.com>
 <5141800A.2000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35851 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756205Ab3CNK2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 06:28:32 -0400
Content-Disposition: inline
In-Reply-To: <5141800A.2000307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>

On Thu, Mar 14, 2013 at 07:45:14AM +0000, Santosh Shilimkar wrote:
> On Wednesday 13 March 2013 09:48 PM, Mark Rutland wrote:
> > On Wed, Mar 13, 2013 at 03:44:03PM +0000, Santosh Shilimkar wrote:
> >> On Wednesday 13 March 2013 05:55 PM, Mark Rutland wrote:
> >>> On Wed, Mar 13, 2013 at 11:24:01AM +0000, Santosh Shilimkar wrote:
> >>>> On Wednesday 13 March 2013 03:46 PM, Mark Rutland wrote:
> >>>>> Hi Santosh,
> >>
> >> [..]
> >>
> >>>>>
> >>>>> Is the problem that the dummy timer is being registered as the broadcast
> >>>>> source, or that it is selected as a local timer in preference of real timers?
> >>>>>
> >>>> Dummy timer is preferred over real broadcast timer.
> >>>
> >>> Ok.
> > 
> > [...]
> > 
> >>> I do agree it'd be worth lowering the dummy timer's rating to ensure it doesn't
> >>> override a real timer elsewhere. 
> >>>
> >> Yep. Can I add you acked-by tag then for $subject patch ?
> >> Would be good to get this one merged as well.
> > 
> > Sure. Though could you reword the commit message? The patch solves the more
> > general issue of a dummy being preferred over real hardware even outside of
> > choosing the broadcast device.
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks. For record, patch is in end of the email which I plan
> to put into patch system.
> 
> Regards,
> Santosh

The below patch seems fine. Are you intending for this to go in as a fix for
3.9-rc*, or as a cleanup for 3.10?

If you're aiming for the latter, it's going to clash with Stephen Boyd's local
timer API removal [1], in which the generic dummy timer driver [2] (replacing
the arm-specific dummy [3]) also has a rating of 100.

It would be nice if we could reduce the possibility of a conflict.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/154724.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/154725.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/154726.html

Thanks,
Mark.

> 
> From 57c501bcdc88c7ff26a5c63956be07e94a5083c5 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Wed, 13 Mar 2013 12:33:16 +0530
> Subject: [PATCH 1/2] ARM: smp: Avoid dummy clockevent being preferred over real hardware clock-event
> 
> With recent arm broadcast time clean-up from Mark Rutland, the dummy
> broadcast device is always registered with timer subsystem. And since
> the rating of the dummy clock event is very high, it may be preferred
> over a real clock event.
> 
> This is a change in behavior from past and not an intended
> one. So reduce the rating of the dummy clockevent so that
> real clockevent device is selected when available.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/kernel/smp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 31644f1..79078ed 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -480,7 +480,7 @@ static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
>  	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
>  			  CLOCK_EVT_FEAT_PERIODIC |
>  			  CLOCK_EVT_FEAT_DUMMY;
> -	evt->rating	= 400;
> +	evt->rating	= 100;
>  	evt->mult	= 1;
>  	evt->set_mode	= broadcast_timer_set_mode;
>  
> -- 
> 1.7.9.5
> 
> 
> 
