From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection instead
 of always dummy
Date: Thu, 14 Mar 2013 09:50:17 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303140950000.22263@ionos>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com> <514046B6.9020005@ti.com> <20130313101641.GA13483@e106331-lin.cambridge.arm.com> <514061D1.20603@ti.com> <20130313122550.GD13483@e106331-lin.cambridge.arm.com> <51409EC3.5050905@ti.com>
 <20130313161811.GF13483@e106331-lin.cambridge.arm.com> <5141800A.2000307@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50204 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab3CNIuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 04:50:21 -0400
In-Reply-To: <5141800A.2000307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On Thu, 14 Mar 2013, Santosh Shilimkar wrote:

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
> 
> >From 57c501bcdc88c7ff26a5c63956be07e94a5083c5 Mon Sep 17 00:00:00 2001
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

Acked-by: Thomas Gleixner <tglx@linutronix.de>

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
