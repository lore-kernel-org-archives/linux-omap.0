From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/6] ARM: OMAP: wakeupgen: fix arm gic irq type
 configuration
Date: Thu, 13 Aug 2015 02:50:48 -0700
Message-ID: <20150813095048.GA4215@atomide.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
 <1439401562-28874-6-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439401562-28874-6-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tglx@linutronix.de, marc.zyngier@arm.com, linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150812 10:49]:
> It's observed that ARM GIC IRQ triggering type is not configured
> properly when IRQ is routed through IRQ domain hierarchy and
> system started using DT. As result, system will start using default
> ARM GIC configuration, ignore DT IRQ triggering configuration,
> and value of desc->irq_data.state_use_accessors = 0.
> 
> In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
> ARM GIC <- OMAP wakeupgen <- TI CBAR
> 
> Failed call chain:
>      irq_create_of_mapping
>      irq_set_irq_type
>      __irq_set_trigger
>      if (!chip || !chip->irq_set_type) {
>         return 0; <- return here
>      }
> OMAP wakeupgen has no .irq_set_type() defined and, so, IRQ triggering
> configuration will not be propagated to parent IRQ domain.
> 
> Hence, fix it by using irq_chip_set_type_parent() for
> propagation IRQ triggering type to parent IRQ domains.
> 
> Fixes: 7136d457f365 ('ARM: omap: convert wakeupgen to stacked domains')
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Makse sense to merge this along with the irqchip changes once those
are ready, so feel free to add to this one:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/omap-wakeupgen.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index 8e52621..e1d2e99 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -392,6 +392,7 @@ static struct irq_chip wakeupgen_chip = {
>  	.irq_mask		= wakeupgen_mask,
>  	.irq_unmask		= wakeupgen_unmask,
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_type		= irq_chip_set_type_parent,
>  	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
>  #ifdef CONFIG_SMP
>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
> -- 
> 2.5.0
> 
