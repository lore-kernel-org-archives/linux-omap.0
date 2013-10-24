From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/6] DRIVERS: IRQCHIP: IRQ-GIC: Add support for
 routable irqs
Date: Thu, 24 Oct 2013 11:12:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1310241104430.4983@ionos.tec.linutronix.de>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com> <1380549564-31045-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380549564-31045-2-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, rob.herring@calxeda.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On Mon, 30 Sep 2013, Sricharan R wrote:
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 1760ceb..c5778ab 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -72,6 +72,8 @@ struct gic_chip_data {
>  
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>  
> +const struct irq_domain_ops *gic_routable_irq_domain_ops;
> +
>  /*
>   * The GIC mapping of CPU interfaces does not necessarily match
>   * the logical CPU numbering.  Let's use a mapping as returned
> @@ -675,11 +677,26 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  		irq_set_chip_and_handler(irq, &gic_chip,
>  					 handle_fasteoi_irq);
>  		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +
> +		if (gic_routable_irq_domain_ops &&
> +		    gic_routable_irq_domain_ops->map)
> +			gic_routable_irq_domain_ops->map(d, irq, hw);

Shudder. Why are you sprinkling these if (ops && ops->fun)
conditionals all over the place instead of having a default ops
implementation which handles the non crossbar case by proper empty
functions. That code is not on a hot path so it does not matter at
all.

>  	}
>  	irq_set_chip_data(irq, d->host_data);
>  	return 0;
>  }
>  
> +static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
> +{
> +	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
> +
> +	if (hw > 32) {

Groan. This wants to be in the ops->unmap function. It's not related
to the GIC core code.

> +		if (gic_routable_irq_domain_ops &&
> +		    gic_routable_irq_domain_ops->unmap)
> +			gic_routable_irq_domain_ops->unmap(d, irq);
> +	}
> +}
> +
>  static int gic_irq_domain_xlate(struct irq_domain *d,
>  				struct device_node *controller,
>  				const u32 *intspec, unsigned int intsize,
> @@ -694,8 +711,15 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>  	*out_hwirq = intspec[1] + 16;
>  
>  	/* For SPIs, we need to add 16 more to get the GIC irq ID number */
> -	if (!intspec[0])
> -		*out_hwirq += 16;
> +	if (!intspec[0]) {
> +		if (gic_routable_irq_domain_ops &&
> +		    gic_routable_irq_domain_ops->xlate)
> +			*out_hwirq = gic_routable_irq_domain_ops->xlate(d,
> +						controller, intspec, intsize,
> +						out_hwirq, out_type);
> +		else
> +			*out_hwirq += 16;
> +	}

So if you have a default xlate ops implementation then this boils down to

      if (!intspec[0])
		*out_hwirq = routing_ops->xlate()

And the default (non crossbar) implementation would be:

    	return *out_hwirq + 16;
    

Thanks,

	tglx
