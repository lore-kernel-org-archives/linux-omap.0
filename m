From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 1/6] genirq: fix irq_chip_retrigger_hierarchy
Date: Thu, 13 Aug 2015 10:26:30 +0100
Message-ID: <55CC62C6.20304@arm.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com> <1439401562-28874-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439401562-28874-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "nsekhar@ti.com" <nsekhar@ti.com>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "balbi@ti.com" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

[adding Jiang to the cc list]

On 12/08/15 18:45, Grygorii Strashko wrote:
> Now irq_chip_retrigger_hierarchy() returns -ENOSYS if it
> was not able to find at least one .irq_retrigger() callback
> implemented in IRQ domain hierarchy. As result, IRQ
> re-triggering is not working now on ARM (TI OMAP) where
> ARM GIC is not implemented this callback.
> The .irq_retrigger() is optional (see check_irq_resend())
> and there are no reasons to fail if it was not found, hence
> lets return 0 in this case.
> 
> In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
> ARM GIC <- OMAP wakeupgen <- TI CBAR
> 
> Failure is reproduced during resume from suspend to RAM:
> - wakeup by IRQx
> - suspend_enter
>   + arch_suspend_enable_irqs
>     + handle_fasteoi_irq
>       + irq_may_run
>         + irq_pm_check_wakeup
>           + irq_disable(IRQx)
>   + dpm_resume_noirq()
>     + resume_device_irqs
>       + resume_irqs
>         + resume_irq
>           + __enable_irq <== IRQx is not re-triggered
> 
> Fixes: 85f08c17de26 ('genirq: Introduce helper functions...')
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  kernel/irq/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 27f4332..6de638b 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -997,7 +997,7 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
>  		if (data->chip && data->chip->irq_retrigger)
>  			return data->chip->irq_retrigger(data);
>  
> -	return -ENOSYS;
> +	return 0;
>  }
>  
>  /**
> 

I think this makes sense. Not having an irq_retrigger or having an
irq_retrigger that returns zero are the same thing.

Actually, we don't even distinguish between a retrigger that
successfully poked the HW, and a retrigger that returned an error. Both
are considered to not to require a SW retrigger... maybe we should fix
that too. Jiang, Thomas?

Anyway, for this patch:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
