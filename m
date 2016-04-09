From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 11/15] irqchip/gic: Return an error if GIC
 initialisation fails
Date: Sat, 9 Apr 2016 12:43:33 +0100
Message-ID: <20160409124333.6b7f695d@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
	<1458224359-32665-12-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-12-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Mar 2016 14:19:15 +0000
Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

> If the GIC initialisation fails, then currently we do not return an error
> or clean-up afterwards. Although for root controllers, this failure may be
> fatal anyway, for secondary controllers, it may not be fatal and so return
> an error on failure and clean-up.
> 
> For non-banked GIC controllers, make sure that we free any memory
> allocated if we fail to initialise the IRQ domain. Please note that
> free_percpu() only frees memory if the pointer passed to it is not NULL
> and so it is unnecessary to check if both pointers are valid or not.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/irqchip/irq-gic.c | 57 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index b0a781f8c450..42a1412b5186 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -999,13 +999,13 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
>  	.unmap = gic_irq_domain_unmap,
>  };
>  
> -static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
> +static int __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  			   void __iomem *dist_base, void __iomem *cpu_base,
>  			   u32 percpu_offset, struct fwnode_handle *handle)
>  {
>  	irq_hw_number_t hwirq_base;
>  	struct gic_chip_data *gic;
> -	int gic_irqs, irq_base, i;
> +	int gic_irqs, irq_base, i, ret;
>  
>  	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
>  
> @@ -1030,17 +1030,16 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  		gic->chip.irq_set_affinity = gic_set_affinity;
>  #endif
>  
> -#ifdef CONFIG_GIC_NON_BANKED
> -	if (percpu_offset) { /* Frankein-GIC without banked registers... */
> +	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
> +		/* Frankein-GIC without banked registers... */
>  		unsigned int cpu;
>  
>  		gic->dist_base.percpu_base = alloc_percpu(void __iomem *);
>  		gic->cpu_base.percpu_base = alloc_percpu(void __iomem *);
>  		if (WARN_ON(!gic->dist_base.percpu_base ||
>  			    !gic->cpu_base.percpu_base)) {
> -			free_percpu(gic->dist_base.percpu_base);
> -			free_percpu(gic->cpu_base.percpu_base);
> -			return;
> +			ret = -ENOMEM;
> +			goto error;
>  		}
>  
>  		for_each_possible_cpu(cpu) {
> @@ -1052,9 +1051,8 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  		}
>  
>  		gic_set_base_accessor(gic, gic_get_percpu_base);
> -	} else
> -#endif
> -	{			/* Normal, sane GIC... */
> +	} else {
> +		/* Normal, sane GIC... */
>  		WARN(percpu_offset,
>  		     "GIC_NON_BANKED not enabled, ignoring %08x offset!",
>  		     percpu_offset);
> @@ -1104,8 +1102,10 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  					hwirq_base, &gic_irq_domain_ops, gic);
>  	}
>  
> -	if (WARN_ON(!gic->domain))
> -		return;
> +	if (WARN_ON(!gic->domain)) {
> +		ret = -ENODEV;
> +		goto error;
> +	}
>  
>  	if (gic_nr == 0) {
>  		/*
> @@ -1127,6 +1127,18 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  	gic_dist_init(gic);
>  	gic_cpu_init(gic);
>  	gic_pm_init(gic);
> +
> +	return 0;
> +
> +error:
> +	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && percpu_offset) {
> +		free_percpu(gic->dist_base.percpu_base);
> +		free_percpu(gic->cpu_base.percpu_base);
> +	}
> +
> +	kfree(gic->chip.name);

Ah, this is where Linus' remark about "GICv2" clashes. Either you keep
the allocation in the previous patch, or you guard this with a test on
the EOImode. I'll leave it up to you.

> +
> +	return ret;
>  }
>  
>  void __init gic_init(unsigned int gic_nr, int irq_start,
> @@ -1187,7 +1199,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  	void __iomem *cpu_base;
>  	void __iomem *dist_base;
>  	u32 percpu_offset;
> -	int irq;
> +	int irq, ret;
>  
>  	if (WARN_ON(!node))
>  		return -ENODEV;
> @@ -1212,8 +1224,14 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  	if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
>  		percpu_offset = 0;
>  
> -	__gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
> +	ret = __gic_init_bases(gic_cnt, -1, dist_base, cpu_base, percpu_offset,
>  			 &node->fwnode);
> +	if (ret) {
> +		iounmap(dist_base);
> +		iounmap(cpu_base);
> +		return ret;
> +	}
> +
>  	if (!gic_cnt)
>  		gic_init_physaddr(node);
>  
> @@ -1302,7 +1320,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
>  	struct acpi_madt_generic_distributor *dist;
>  	void __iomem *cpu_base, *dist_base;
>  	struct fwnode_handle *domain_handle;
> -	int count;
> +	int count, ret;
>  
>  	/* Collect CPU base addresses */
>  	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
> @@ -1345,7 +1363,14 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
>  		return -ENOMEM;
>  	}
>  
> -	__gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
> +	ret = __gic_init_bases(0, -1, dist_base, cpu_base, 0, domain_handle);
> +	if (ret) {
> +		pr_err("Failed to initialise GIC\n");
> +		irq_domain_free_fwnode(domain_handle);
> +		iounmap(cpu_base);
> +		iounmap(dist_base);
> +		return ret;
> +	}
>  
>  	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
>  

Otherwise looks good.

	M.
-- 
Jazz is not dead. It just smells funny.
