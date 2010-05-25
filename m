From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: DMTIMER: Ack pending interrupt always when stopping a timer
Date: Tue, 25 May 2010 09:10:57 -0700
Message-ID: <87d3wkner2.fsf@deeprootsystems.com>
References: <1274797036-21107-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54029 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab0EYQK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 12:10:59 -0400
Received: by pwi2 with SMTP id 2so1120559pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 09:10:59 -0700 (PDT)
In-Reply-To: <1274797036-21107-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Tue\, 25 May 2010 17\:17\:16 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> The kernel timer queue is being run currently from a GP timer running in a one
> shot mode, which works in a way that when it expires, it will also stop.
> Usually during this situation, the interrupt handler will ack the interrupt,
> load a new value to the timer and start it again. During suspend, the
> situation is slightly different, as we disable interrupts just before
> timekeeping is suspended, which leaves a small window where the timer can
> expire before it is stopped, and will leave the interrupt flag pending.
> This pending interrupt will prevent ARM sleep entry, thus now we ack it always
> when we are attempting to stop a timer.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/plat-omap/dmtimer.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index c64875f..023d664 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -541,11 +541,13 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
>  		  * timer is stopped
>  		  */
>  		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> -		/* Ack possibly pending interrupt */
> -		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> -				OMAP_TIMER_INT_OVERFLOW);
>  #endif
>  	}
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +	/* Ack possibly pending interrupt */
> +	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> +			OMAP_TIMER_INT_OVERFLOW);
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>  
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
