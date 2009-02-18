From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: sched_clock() corrected
Date: Wed, 18 Feb 2009 15:39:35 -0800
Message-ID: <20090218233935.GA31436@atomide.com>
References: <1234894875-10268-1-git-send-email-Aaro.Koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63474 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZBRXji (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 18:39:38 -0500
Content-Disposition: inline
In-Reply-To: <1234894875-10268-1-git-send-email-Aaro.Koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Aaro Koskinen <Aaro.Koskinen@nokia.com> [090217 10:27]:
> After my OMAP3 board has been running for a while, I'm seeing weird
> latency traces like this:
> 
>       sh-1574    0d.h2  153us : do_timer (tick_do_update_jiffies64)
>       sh-1574    0d.h2  153us : update_wall_time (do_timer)
>       sh-1574    0d.h2  153us!: omap_32k_read (update_wall_time)
>       sh-1574    0d.h2 1883us : update_xtime_cache (update_wall_time)
>       sh-1574    0d.h2 1883us : clocksource_get_next (update_wall_time)
>       sh-1574    0d.h2 1883us+: _spin_lock_irqsave (clocksource_get_next)
> 
> and after a while:
> 
>       sh-17818   0d.h3  153us : do_timer (tick_do_update_jiffies64)
>       sh-17818   0d.h3  153us : update_wall_time (do_timer)
>       sh-17818   0d.h3  153us!: omap_32k_read (update_wall_time)
>       sh-17818   0d.h3 1915us : update_xtime_cache (update_wall_time)
>       sh-17818   0d.h3 1915us+: clocksource_get_next (update_wall_time)
>       sh-17818   0d.h3 1945us : _spin_lock_irqsave (clocksource_get_next)
> 
> Turns out that sched_clock() is using cyc2ns(), which returns NTP
> adjusted time. The sched_clock() frequency should not be adjusted. The
> patch deletes omap_32k_ticks_to_nsecs() and rewrites sched_clock()
> to do the conversion using the constant multiplier.

Nice catch! Applying to linux-omap and omap-fixes.

Tony


> Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
> ---
>  arch/arm/plat-omap/common.c |   14 +++++---------
>  1 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 8c53125..2866612 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -220,20 +220,16 @@ static struct clocksource clocksource_32k = {
>  };
>  
>  /*
> - * Rounds down to nearest nsec.
> - */
> -unsigned long long omap_32k_ticks_to_nsecs(unsigned long ticks_32k)
> -{
> -	return cyc2ns(&clocksource_32k, ticks_32k);
> -}
> -
> -/*
>   * Returns current time from boot in nsecs. It's OK for this to wrap
>   * around for now, as it's just a relative time stamp.
>   */
>  unsigned long long sched_clock(void)
>  {
> -	return omap_32k_ticks_to_nsecs(omap_32k_read());
> +	unsigned long long ret;
> +
> +	ret = (unsigned long long)omap_32k_read();
> +	ret = (ret * clocksource_32k.mult_orig) >> clocksource_32k.shift;
> +	return ret;
>  }
>  
>  static int __init omap_init_clocksource_32k(void)
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
