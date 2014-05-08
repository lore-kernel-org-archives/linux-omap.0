From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Thu, 8 May 2014 14:24:08 -0500
Message-ID: <536BD9D8.4080905@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com> <1399299527-10955-4-git-send-email-r.sricharan@ti.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40744 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754884AbaEHTYe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 15:24:34 -0400
In-Reply-To: <1399299527-10955-4-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nm@ti.com, tony@atomide.com, rnayak@ti.com, santosh.shilimkar@ti.com

On 05/05/2014 09:18 AM, Sricharan R wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> When, in the system due to varied reasons, interrupts might be unusable
> due to hardware behavior, but register maps do exist, then those interrupts
> should be skipped while mapping irq to crossbars.
> 

Just wondering, instead of hardcoding this data in the code, and
introducing additional flags (IRQ_SKIP), why not just put these GIC IRQs
in the ti,irq-reserved property in DTS for platforms where such IRQs are
not usable. That way you're skipping these IRQs anyway.

Also that would avoid adding more hard coded data for future SoCs into
the source for such IRQs that must be skipped, and also reduces LOC.

thanks,

-Joel


> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  drivers/irqchip/irq-crossbar.c |   47 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 51d4b87..847f6e3 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -13,11 +13,13 @@
>  #include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/irqchip/arm-gic.h>
>  
>  #define IRQ_FREE	-1
>  #define IRQ_RESERVED	-2
> +#define IRQ_SKIP	-3
>  #define GIC_IRQ_START	32
>  
>  /*
> @@ -34,6 +36,16 @@ struct crossbar_device {
>  	void (*write) (int, int);
>  };
>  
> +/**
> + * struct crossbar_data: Platform specific data
> + * @irqs_unused: array of irqs that cannot be used because of hw erratas
> + * @size: size of the irqs_unused array
> + */
> +struct crossbar_data {
> +	const uint *irqs_unused;
> +	const uint size;
> +};
> +
>  static struct crossbar_device *cb;
>  
>  static inline void crossbar_writel(int irq_no, int cb_no)
> @@ -119,10 +131,12 @@ const struct irq_domain_ops routable_irq_domain_ops = {
>  	.xlate = crossbar_domain_xlate
>  };
>  
> -static int __init crossbar_of_init(struct device_node *node)
> +static int __init crossbar_of_init(struct device_node *node,
> +				   const struct crossbar_data *data)
>  {
>  	int i, size, max, reserved = 0, entry;
>  	const __be32 *irqsr;
> +	const int *irqsk = NULL;
>  
>  	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
>  
> @@ -194,6 +208,22 @@ static int __init crossbar_of_init(struct device_node *node)
>  		reserved += size;
>  	}
>  
> +	/* Skip the ones marked as unused */
> +	if (data) {
> +		irqsk = data->irqs_unused;
> +		size = data->size;
> +
> +		for (i = 0; i < size; i++) {
> +			entry = irqsk[i];
> +
> +			if (entry > max) {
> +				pr_err("Invalid skip entry\n");
> +				goto err3;
> +			}
> +			cb->irq_map[entry] = IRQ_SKIP;
> +		}
> +	}
> +
>  	register_routable_domain_ops(&routable_irq_domain_ops);
>  	return 0;
>  
> @@ -208,18 +238,27 @@ err1:
>  	return -ENOMEM;
>  }
>  
> +/* irq number 10 cannot be used because of hw bug */
> +int dra_irqs_unused[] = { 10 };
> +struct crossbar_data cb_dra_data = { dra_irqs_unused,
> +				     ARRAY_SIZE(dra_irqs_unused) };
> +
>  static const struct of_device_id crossbar_match[] __initconst = {
> -	{ .compatible = "ti,irq-crossbar" },
> +	{ .compatible = "ti,irq-crossbar", .data = &cb_dra_data },
>  	{}
>  };
>  
>  int __init irqcrossbar_init(void)
>  {
>  	struct device_node *np;
> -	np = of_find_matching_node(NULL, crossbar_match);
> +	const struct of_device_id *of_id;
> +	const struct crossbar_data *cdata;
> +
> +	np = of_find_matching_node_and_match(NULL, crossbar_match, &of_id);
>  	if (!np)
>  		return -ENODEV;
>  
> -	crossbar_of_init(np);
> +	cdata = of_id->data;
> +	crossbar_of_init(np, cdata);
>  	return 0;
>  }
> 

