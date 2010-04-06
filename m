From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 2/3] arm: omap1: remove dead code from timer32k.c
Date: Tue, 06 Apr 2010 14:30:56 -0700
Message-ID: <87sk78mfov.fsf@deeprootsystems.com>
References: <1270033995-12516-1-git-send-email-felipe.balbi@nokia.com>
	<1270033995-12516-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50681 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab0DFVbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 17:31:00 -0400
Received: by pva18 with SMTP id 18so290489pva.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 14:31:00 -0700 (PDT)
In-Reply-To: <1270033995-12516-3-git-send-email-felipe.balbi@nokia.com> (Felipe Balbi's message of "Wed\, 31 Mar 2010 14\:13\:14 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi <felipe.balbi@nokia.com> writes:

> Trivial patch, no functional changes
>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap1/timer32k.c |   15 ---------------
>  1 files changed, 0 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> index 9ad1185..20cfbcc 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -68,12 +68,6 @@ struct sys_timer omap_timer;
>   * ---------------------------------------------------------------------------
>   */
>  
> -#if defined(CONFIG_ARCH_OMAP16XX)
> -#define TIMER_32K_SYNCHRONIZED		0xfffbc410
> -#else
> -#error OMAP 32KHz timer does not currently work on 15XX!
> -#endif
> -
>  /* 16xx specific defines */
>  #define OMAP1_32K_TIMER_BASE		0xfffb9000
>  #define OMAP1_32K_TIMER_CR		0x08
> @@ -150,15 +144,6 @@ static struct clock_event_device clockevent_32k_timer = {
>  	.set_mode	= omap_32k_timer_set_mode,
>  };
>  
> -/*
> - * The 32KHz synchronized timer is an additional timer on 16xx.
> - * It is always running.
> - */
> -static inline unsigned long omap_32k_sync_timer_read(void)
> -{
> -	return omap_readl(TIMER_32K_SYNCHRONIZED);
> -}
> -
>  static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
>  {
>  	struct clock_event_device *evt = &clockevent_32k_timer;
> -- 
> 1.7.0.rc0.33.g7c3932
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
