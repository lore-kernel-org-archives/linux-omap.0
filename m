From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 16/19] irqchip: crossbar: introduce
 ti,max-crossbar-sources to identify valid crossbar mapping
Date: Thu, 12 Jun 2014 09:54:53 -0400
Message-ID: <20140612135453.GB8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-17-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-17-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:24PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> Currently we attempt to map any crossbar value to an IRQ, however,
> this is not correct from hardware perspective. There is a max crossbar
> event number upto which hardware supports. So describe the same in
> device tree using 'ti,max-crossbar-sources' property and use it to
> validate requests.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/omap/crossbar.txt      |    2 ++
>  drivers/irqchip/irq-crossbar.c                     |   21 ++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> index fb88585..6d2e2f5 100644
> --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> @@ -10,6 +10,7 @@ Required properties:
>  - compatible : Should be "ti,irq-crossbar"
>  - reg: Base address and the size of the crossbar registers.
>  - ti,max-irqs: Total number of irqs available at the interrupt controller.
> +- ti,max-crossbar-sources: Maximum number of crossbar sources that can be routed.
>  - ti,reg-size: Size of a individual register in bytes. Every individual
>  	    register is assumed to be of same size. Valid sizes are 1, 2, 4.
>  - ti,irqs-reserved: List of the reserved irq lines that are not muxed using
> @@ -22,6 +23,7 @@ Examples:
>  			compatible = "ti,irq-crossbar";
>  			reg = <0x4a002a48 0x130>;
>  			ti,max-irqs = <160>;
> +			ti,max-crossbar-sources = <400>;
>  			ti,reg-size = <2>;
>  			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
>  		};
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 2a73a66..cf69c4d 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -26,6 +26,7 @@
>  /**
>   * struct crossbar_device - crossbar device descriptio
>   * @int_max: maximum number of supported interrupts
> + * @max_crossbar_sources: Maximum number of crossbar sources
>   * @irq_map: array of interrupts to crossbar number mapping
>   * @crossbar_base: crossbar base address
>   * @register_offsets: offsets for each irq number
> @@ -33,6 +34,7 @@
>   */
>  struct crossbar_device {
>  	uint int_max;
> +	uint max_crossbar_sources;
>  	uint *irq_map;
>  	void __iomem *crossbar_base;
>  	int *register_offsets;
> @@ -126,12 +128,19 @@ static int crossbar_domain_xlate(struct irq_domain *d,
>  				 unsigned int *out_type)
>  {
>  	int ret;
> +	int req_num = intspec[1];
>  
> -	ret = get_prev_map_irq(intspec[1]);
> +	if (req_num >= cb->max_crossbar_sources) {
> +		pr_err("%s: requested crossbar number %d > max %d\n",
> +		       __func__, req_num, cb->max_crossbar_sources);
> +		return -EINVAL;
> +	}
> +
> +	ret = get_prev_map_irq(req_num);
>  	if (ret >= 0)
>  		goto found;
>  
> -	ret = allocate_free_irq(intspec[1]);
> +	ret = allocate_free_irq(req_num);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -164,6 +173,14 @@ static int __init crossbar_of_init(struct device_node *node,
>  	if (!cb->crossbar_base)
>  		goto err_cb;
>  
> +	of_property_read_u32(node, "ti,max-crossbar-sources",
> +			     &cb->max_crossbar_sources);
> +	if (!cb->max_crossbar_sources) {
> +		pr_err("missing 'ti,max-crossbar-sources' property\n");
> +		ret = -EINVAL;
> +		goto err_base;
> +	}

This completely breaks all boards using old dtbs.  Please set
max_crossbar_sources to a sane value (400) when the property is missing.

> +
>  	of_property_read_u32(node, "ti,max-irqs", &max);
>  	if (!max) {
>  		pr_err("missing 'ti,max-irqs' property\n");

I know this is context, but you may want to look at this property as
well and set it to a sane value instead of erroring out.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
