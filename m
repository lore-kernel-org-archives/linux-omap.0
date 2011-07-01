From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 9/9] OMAP3: PM: Disable / enable PRCM chain interrupts during wakeup from suspend
Date: Fri, 01 Jul 2011 13:10:03 -0700
Message-ID: <87oc1dwyn8.fsf@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
	<1309338303-2086-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57383 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751921Ab1GAUKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 16:10:09 -0400
Received: by pzk9 with SMTP id 9so89147pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 13:10:07 -0700 (PDT)
In-Reply-To: <1309338303-2086-10-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 29 Jun 2011 12:05:03 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> This prevents system hang while attempting to access suspended console.

Please add more detail.  Who is accessing console?   This sounds more
like it's masking a UART/console bug.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e626a3d..dae0a8a 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -418,6 +418,10 @@ void omap_sram_idle(void)
>  	pwrdm_post_transition();
>  
>  	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
> +	if (suspend_state != PM_SUSPEND_ON) {
> +		disable_irq(prcm_io_irq);
> +		disable_irq(prcm_wkup_irq);
> +	}

>  }
>  
>  int omap3_can_sleep(void)
> @@ -524,6 +528,8 @@ static void omap3_pm_end(void)
>  	suspend_state = PM_SUSPEND_ON;
>  	omap_uart_enable_irqs(1);
>  	enable_hlt();
> +	enable_irq(prcm_io_irq);
> +	enable_irq(prcm_wkup_irq);
>  	return;
>  }

The re-enable is in ->end(), shouldn't the disable be in ->begin() ?

Kevin


