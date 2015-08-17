From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH v3 1/6] genirq: fix irq_chip_retrigger_hierarchy
Date: Mon, 17 Aug 2015 11:28:47 +0800
Message-ID: <55D154EF.1070500@linux.intel.com>
References: <1439554830-19502-1-git-send-email-grygorii.strashko@ti.com>
 <1439554830-19502-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439554830-19502-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

On 2015/8/14 20:20, Grygorii Strashko wrote:
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
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Fixes: 85f08c17de26 ('genirq: Introduce helper functions...')
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
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

Hi Grygorii,
	Thanks for fixing this regression:)
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
