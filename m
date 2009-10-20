From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 09/17] OMAP3: PM: Ack pending interrupts before entering suspend
Date: Tue, 20 Oct 2009 10:30:49 -0700
Message-ID: <871vkykm5y.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:52492 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZJTRar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:30:47 -0400
Received: by pzk26 with SMTP id 26so4246061pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 10:30:51 -0700 (PDT)
In-Reply-To: <1255690150-16853-10-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 13\:49\:02 +0300")
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

This could also be done in omap3_intc_prepare_idle() hook.

Kevin

> ---
>  arch/arm/mach-omap2/irq.c              |    2 +-
>  arch/arm/mach-omap2/pm34xx.c           |    2 ++
>  arch/arm/plat-omap/include/mach/irqs.h |    1 +
>  3 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index aceedd8..4ed05e9 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -101,7 +101,7 @@ static int omap_check_spurious(unsigned int irq)
>  }
>  
>  /* XXX: FIQ and additional INTC support (only MPU at the moment) */
> -static void omap_ack_irq(unsigned int irq)
> +void omap_ack_irq(unsigned int irq)
>  {
>  	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
>  }
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 5854fa7..6a41811 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -778,6 +778,8 @@ static int omap3_pm_suspend(void)
>  
>  	omap_uart_prepare_suspend();
>  
> +	/* Ack pending IRQs, as a pending IRQ will cause the suspend to fail */
> +	omap_ack_irq(0);
>  	regset_save_on_suspend = 1;
>  	omap_sram_idle();
>  	regset_save_on_suspend = 0;
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index 2473910..d56be1c 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -483,6 +483,7 @@
>  #ifndef __ASSEMBLY__
>  extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
> +extern void omap_ack_irq(unsigned int irq);
>  void omap3_intc_save_context(void);
>  void omap3_intc_restore_context(void);
>  #endif
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
