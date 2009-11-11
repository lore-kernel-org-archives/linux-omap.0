From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/11] OMAP2/3: DMTIMER: Clear pending interrupts when stopping a timer
Date: Wed, 11 Nov 2009 15:18:17 -0800
Message-ID: <87d43ozm4m.fsf@deeprootsystems.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:55665 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759532AbZKKXSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:18:15 -0500
Received: by gxk26 with SMTP id 26so1548891gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:18:20 -0800 (PST)
In-Reply-To: <1256313835-2391-4-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 23 Oct 2009 19\:03\:47 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> OMAP GP timers keep running for a few cycles after they are stopped,
> which can cause the timer to expire and generate an interrupt. The pending
> interrupt will prevent e.g. OMAP from entering suspend, thus we ack it
> manually.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, applying to PM branch, queueing in pm-fixes.

Kevin

> ---
>  arch/arm/plat-omap/dmtimer.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 830b072..09a623d 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -551,6 +551,16 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
>  	if (l & OMAP_TIMER_CTRL_ST) {
>  		l &= ~0x1;
>  		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> +		/* Readback to make sure write has completed */
> +		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> +		 /*
> +		  * Wait for functional clock period x 3.5 to make sure that
> +		  * timer is stopped
> +		  */
> +		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> +		/* Ack possibly pending interrupt */
> +		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> +				OMAP_TIMER_INT_OVERFLOW);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
