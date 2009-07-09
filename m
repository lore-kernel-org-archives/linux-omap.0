From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: timer-gp: Fix for null pointer dereferencing issue
Date: Thu, 09 Jul 2009 08:04:23 -0700
Message-ID: <87ws6hvqx4.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B565CD5B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:46544 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbZGIPE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 11:04:27 -0400
Received: by wf-out-1314.google.com with SMTP id 26so62165wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2009 08:04:26 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B565CD5B@dbde02.ent.ti.com> (Mukund Mittal's message of "Thu\, 9 Jul 2009 17\:09\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mittal, Mukund" <mmittal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Mittal, Mukund" <mmittal@ti.com> writes:

> From: Mukund Mittal <mmittal@ti.com>
>
> OMAP: timer-gp: Fix for null pointer dereferencing issue
>
> There was a null pointer dereferencing issue for gpt pointer. 
> It was checked and an error was printed but execution was not terminated. 
> Fixed by calling function BUG().

I think BUG() is a bit drastic here.  I think it should probably
WARN() and fail gracefully instead of grind to a screeching halt.

Kevin

> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> ---
>  arch/arm/mach-omap2/timer-gp.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/timer-gp.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/timer-gp.c
> @@ -205,14 +205,13 @@ static void __init omap2_gp_clocksource_
>  {
>  	static struct omap_dm_timer *gpt;
>  	u32 tick_rate, tick_period;
> -	static char err1[] __initdata = KERN_ERR
> -		"%s: failed to request dm-timer\n";
> -	static char err2[] __initdata = KERN_ERR
> -		"%s: can't register clocksource!\n";
>  
>  	gpt = omap_dm_timer_request();
> -	if (!gpt)
> -		printk(err1, clocksource_gpt.name);
> +	if (!gpt) {
> +		printk(KERN_ERR "%s: failed to request dm-timer\n",
> +			clocksource_gpt.name);
> +		BUG();
> +	}
>  	gpt_clocksource = gpt;
>  
>  	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> @@ -224,7 +223,8 @@ static void __init omap2_gp_clocksource_
>  	clocksource_gpt.mult =
>  		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
>  	if (clocksource_register(&clocksource_gpt))
> -		printk(err2, clocksource_gpt.name);
> +		printk(KERN_ERR "%s: can't register clocksource!\n",
> +			clocksource_gpt.name);
>  }
>  #endif
>
>  --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
