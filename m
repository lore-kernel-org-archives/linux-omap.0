From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 06/15] irqdomain: Ensure type settings match for an
 existing mapping
Date: Thu, 17 Mar 2016 18:18:09 +0000
Message-ID: <56EAF4E1.5020201@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-7-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-7-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 17/03/16 14:19, Jon Hunter wrote:
> When mapping an IRQ, if a mapping already exists, then we simply return
> the virtual IRQ number. However, we do not check that the type settings
> for the existing mapping match those for the mapping that is about to be
> created. It may be unlikely that the type settings would not match, but
> check for this and don't return a valid IRQ mapping if the type settings
> do not match.
> 
> WARN if the type return by irq_domain_translate() has bits outside the
> sense mask set and then clear these bits. If these bits are not cleared
> then this will cause the comparision of the type settings for an
> existing mapping to fail with that of the new mapping even if the sense
> bit themselves match. The reason being is that the existing type
> settings are read by calling irq_get_trigger_type() which will clear
> any bits outside the sense mask. This will allow us to detect irqchips
> that are not correctly clearing these bits and fix them.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  kernel/irq/irqdomain.c | 59 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 3a519a01118b..0ea285baa619 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -549,6 +549,13 @@ static int irq_domain_translate(struct irq_domain *d,
>  				     fwspec->param, fwspec->param_count,
>  				     hwirq, type);
>  
> +	/*
> +	 * WARN if the irqchip returns a type with bits
> +	 * outside the sense mask set and clear these bits.
> +	 */
> +	if (WARN_ON(*type & ~IRQ_TYPE_SENSE_MASK))
> +		*type &= IRQ_TYPE_SENSE_MASK;
> +
>  	/* If domain has no translation, then we assume interrupt line */
>  	*hwirq = fwspec->param[0];
>  	return 0;
> @@ -570,6 +577,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  {
>  	struct irq_domain *domain;
>  	irq_hw_number_t hwirq;
> +	unsigned int cur_type = IRQ_TYPE_NONE;
>  	unsigned int type = IRQ_TYPE_NONE;
>  	int virq;
>  
> @@ -592,23 +600,42 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  	if (irq_domain_translate(domain, fwspec, &hwirq, &type))
>  		return 0;
>  
> -	if (irq_domain_is_hierarchy(domain)) {
> -		/*
> -		 * If we've already configured this interrupt,
> -		 * don't do it again, or hell will break loose.
> -		 */
> -		virq = irq_find_mapping(domain, hwirq);
> -		if (virq)
> -			return virq;
> -
> -		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
> -		if (virq <= 0)
> -			return 0;
> +	/*
> +	 * If we've already configured this interrupt,
> +	 * don't do it again, or hell will break loose.
> +	 */
> +	virq = irq_find_mapping(domain, hwirq);
> +	if (!virq) {
> +		if (irq_domain_is_hierarchy(domain)) {
> +			virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE,
> +						     fwspec);
> +			if (virq <= 0)
> +				return 0;
> +		} else {
> +			/* Create mapping */
> +			virq = irq_create_mapping(domain, hwirq);
> +			if (!virq)
> +				return virq;
> +		}
>  	} else {
> -		/* Create mapping */
> -		virq = irq_create_mapping(domain, hwirq);
> -		if (!virq)
> -			return virq;
> +		cur_type = irq_get_trigger_type(virq);
> +	}
> +
> +	/*
> +	 * If the trigger type is not specified or matches the current
> +	 * trigger type then we are done so return the interrupt number.
> +	 */
> +	if (type == IRQ_TYPE_NONE || type == cur_type)
> +		return virq;
> +
> +	/*
> +	 * If the trigger type is already set and does
> +	 * not match this interrupt, then return 0.
> +	 */
> +	if (cur_type != IRQ_TYPE_NONE) {
> +		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
> +			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
> +		return 0;

If we created a new mapping and return here, then this will leak the
mapping. I will fix this. Sorry should have caught this before!

Jon
