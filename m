From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 08/21] irqchip: crossbar: convert dra7 crossbar to
 stacked domains
Date: Thu, 8 Jan 2015 09:20:59 -0600
Message-ID: <20150108152059.GB24705@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-9-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45909 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbbAHPWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 10:22:00 -0500
Content-Disposition: inline
In-Reply-To: <1420652576-22309-9-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
a few more minor comments follow:

[..]
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
[..]
> @@ -33,6 +34,7 @@
>   * @write: register write function pointer
>   */
>  struct crossbar_device {
> +	raw_spinlock_t lock;

^^ kernel doc missing.

[...]
> +static int crossbar_domain_alloc(struct irq_domain *d, unsigned int virq,
> +				 unsigned int nr_irqs, void *data)
>  {
> -	if (needs_crossbar_write(hw))
> -		cb->write(hw - GIC_IRQ_START, cb->irq_map[hw - GIC_IRQ_START]);
> +	struct of_phandle_args *args = data;
> +	irq_hw_number_t hwirq;
> +	int i;
> +
> +	if (args->args_count != 3)
> +		return -EINVAL;	/* Not GIC compliant */
> +	if (args->args[0] != 0)
> +		return -EINVAL;	/* No PPI should point to this domain */
> +
> +	hwirq = args->args[1];
> +	if ((hwirq + nr_irqs) > cb->max_crossbar_sources)
> +		return -EINVAL;	/* Can't deal with this */
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		int err = allocate_gic_irq(d, virq + i, hwirq + i);

^^ add a blank line here?

> +		if (err)
> +			return err;
> +
> +		irq_domain_set_hwirq_and_chip(d, virq + i, hwirq + i,
> +					      &crossbar_chip, NULL);
> +	}
>  
>  	return 0;
>  }
>  
>  /**
> - * crossbar_domain_unmap - unmap a crossbar<->irq connection
> + * crossbar_domain_free - unmap/free a crossbar<->irq connection
>   * @d: domain of irq to unmap

      ^^ should be @domain?

> - * @irq: virq number
> + * @virq: virq number
> + * @nr_irqs: number of irqs to free
>   *
>   * We do not maintain a use count of total number of map/unmap
>   * calls for a particular irq to find out if a irq can be really
> @@ -117,14 +144,19 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
>   * after which irq is anyways unusable. So an explicit map has to be called
>   * after that.
>   */
> -static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
> +static void crossbar_domain_free(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs)
>  {
> -	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
> +	int i;
>  
> -	if (needs_crossbar_write(hw)) {
> -		cb->irq_map[hw - GIC_IRQ_START] = IRQ_FREE;
> -		cb->write(hw - GIC_IRQ_START, cb->safe_map);
> +	raw_spin_lock(&cb->lock);
> +	for (i = 0; i < nr_irqs; i++) {
> +		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);

^^ Add a blank line here.

-- 
Regards,
Nishanth Menon
