From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/11] OMAP3: PM: Ack pending interrupts before entering suspend
Date: Wed, 11 Nov 2009 15:19:24 -0800
Message-ID: <878weczm2r.fsf@deeprootsystems.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56281 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759561AbZKKXTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:19:21 -0500
Received: by yxe17 with SMTP id 17so1443984yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:19:27 -0800 (PST)
In-Reply-To: <1256313835-2391-5-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 23 Oct 2009 19\:03\:48 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Suspending drivers may still generate interrupts just before their suspend is
> completed. Any pending interrupts here will prevent sleep.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, applying to PM branch, queuing for pm-fixes.

Kevin

> ---
>  arch/arm/mach-omap2/irq.c              |    6 ++++++
>  arch/arm/mach-omap2/pm34xx.c           |    2 +-
>  arch/arm/plat-omap/include/mach/irqs.h |    1 +
>  3 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index aceedd8..ee8c68a 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -266,4 +266,10 @@ void omap3_intc_restore_context(void)
>  	}
>  	/* MIRs are saved and restore with other PRCM registers */
>  }
> +
> +void omap3_intc_suspend(void)
> +{
> +	/* A pending interrupt would prevent OMAP from entering suspend */
> +	omap_ack_irq(0);
> +}
>  #endif /* CONFIG_ARCH_OMAP3 */
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 6782792..53544d3 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -640,7 +640,7 @@ static int omap3_pm_suspend(void)
>  	}
>  
>  	omap_uart_prepare_suspend();
> -
> +	omap3_intc_suspend();
>  	regset_save_on_suspend = 1;
>  	omap_sram_idle();
>  	regset_save_on_suspend = 0;
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index 2473910..ff1faa8 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -485,6 +485,7 @@ extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
>  void omap3_intc_save_context(void);
>  void omap3_intc_restore_context(void);
> +void omap3_intc_suspend(void);
>  #endif
>  
>  #include <mach/hardware.h>
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
