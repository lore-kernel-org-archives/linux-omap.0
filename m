From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: Fixed crash bug with serial + suspend
Date: Thu, 05 Mar 2009 09:10:17 -0800
Message-ID: <87vdqnaoau.fsf@deeprootsystems.com>
References: <1236263543-7085-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:53019 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZCERKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 12:10:24 -0500
Received: by gxk22 with SMTP id 22so66568gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2009 09:10:21 -0800 (PST)
In-Reply-To: <1236263543-7085-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\,  5 Mar 2009 16\:32\:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> It was possible for an unhandled interrupt to occur if there was incoming
> serial traffic during wakeup from suspend. This was caused by the code
> in arch-arm/mach-omap2/serial.c keeping interrupt enabled all the time,
> but not acking its interrupts. Applies on top of PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, pushed to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c             |   15 +++++++++++++++
>  arch/arm/mach-omap2/serial.c             |   14 ++++++++++++++
>  arch/arm/plat-omap/include/mach/serial.h |    1 +
>  3 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9102cee..5a627db 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -629,7 +629,22 @@ static void omap3_pm_finish(void)
>  	pm_idle = saved_idle;
>  }
>  
> +/* Hooks to enable / disable UART interrupts during suspend */
> +static int omap3_pm_begin(suspend_state_t state)
> +{
> +	omap_uart_enable_irqs(0);
> +	return 0;
> +}
> +
> +static void omap3_pm_end(void)
> +{
> +	omap_uart_enable_irqs(1);
> +	return;
> +}
> +
>  static struct platform_suspend_ops omap_pm_ops = {
> +	.begin		= omap3_pm_begin,
> +	.end		= omap3_pm_end,
>  	.prepare	= omap3_pm_prepare,
>  	.enter		= omap3_pm_enter,
>  	.finish		= omap3_pm_finish,
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 90f1c67..e77567a 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -432,6 +432,20 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	WARN_ON(ret);
>  }
>  
> +void omap_uart_enable_irqs(int enable)
> +{
> +	int ret;
> +	struct omap_uart_state *uart;
> +
> +	list_for_each_entry(uart, &uart_list, node) {
> +		if (enable)
> +			ret = request_irq(uart->p->irq, omap_uart_interrupt,
> +				IRQF_SHARED, "serial idle", (void *)uart);
> +		else
> +			free_irq(uart->p->irq, (void *)uart);
> +	}
> +}
> +
>  static ssize_t sleep_timeout_show(struct kobject *kobj,
>  				  struct kobj_attribute *attr,
>  				  char *buf)
> diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
> index 8e89585..7ca1f27 100644
> --- a/arch/arm/plat-omap/include/mach/serial.h
> +++ b/arch/arm/plat-omap/include/mach/serial.h
> @@ -47,6 +47,7 @@ extern void omap_uart_check_wakeup(void);
>  extern void omap_uart_prepare_suspend(void);
>  extern void omap_uart_prepare_idle(int num);
>  extern void omap_uart_resume_idle(int num);
> +extern void omap_uart_enable_irqs(int enable);
>  #endif
>  
>  #endif
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
