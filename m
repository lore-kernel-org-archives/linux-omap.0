From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 03/19] irqchip: crossbar: Skip some irqs from
 getting mapped to crossbar
Date: Thu, 12 Jun 2014 10:07:29 -0400
Message-ID: <20140612140729.GD8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-4-git-send-email-r.sricharan@ti.com>
 <20140612125134.GS8664@titan.lakedaemon.net>
 <5399A8D5.6070105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5399A8D5.6070105-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 06:49:17PM +0530, Sricharan R wrote:
> Hi Jason,
> 
> On Thursday 12 June 2014 06:21 PM, Jason Cooper wrote:
> > On Thu, Jun 12, 2014 at 05:23:11PM +0530, Sricharan R wrote:
> >> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >>
> >> When, in the system due to varied reasons, interrupts might be unusable
> >> due to hardware behavior, but register maps do exist, then those interrupts
> >> should be skipped while mapping irq to crossbars.
> >>
> >> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > 
> > Tony, have you applied these somewhere already?
> > 
> >> ---
> >>  drivers/irqchip/irq-crossbar.c |   47 ++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 43 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> >> index 51d4b87..847f6e3 100644
> >> --- a/drivers/irqchip/irq-crossbar.c
> >> +++ b/drivers/irqchip/irq-crossbar.c
> >> @@ -13,11 +13,13 @@
> >>  #include <linux/io.h>
> >>  #include <linux/of_address.h>
> >>  #include <linux/of_irq.h>
> >> +#include <linux/of_device.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/irqchip/arm-gic.h>
> >>  
> >>  #define IRQ_FREE	-1
> >>  #define IRQ_RESERVED	-2
> >> +#define IRQ_SKIP	-3
> >>  #define GIC_IRQ_START	32
> >>  
> >>  /*
> >> @@ -34,6 +36,16 @@ struct crossbar_device {
> >>  	void (*write) (int, int);
> >>  };
> >>  
> >> +/**
> >> + * struct crossbar_data: Platform specific data
> >> + * @irqs_unused: array of irqs that cannot be used because of hw erratas
> >> + * @size: size of the irqs_unused array
> >> + */
> >> +struct crossbar_data {
> >> +	const uint *irqs_unused;
> >> +	const uint size;
> >> +};
> >> +
> >>  static struct crossbar_device *cb;
> >>  
> >>  static inline void crossbar_writel(int irq_no, int cb_no)
> >> @@ -119,10 +131,12 @@ const struct irq_domain_ops routable_irq_domain_ops = {
> >>  	.xlate = crossbar_domain_xlate
> >>  };
> >>  
> >> -static int __init crossbar_of_init(struct device_node *node)
> >> +static int __init crossbar_of_init(struct device_node *node,
> >> +				   const struct crossbar_data *data)
> >>  {
> >>  	int i, size, max, reserved = 0, entry;
> >>  	const __be32 *irqsr;
> >> +	const int *irqsk = NULL;
> >>  
> >>  	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
> >>  
> >> @@ -194,6 +208,22 @@ static int __init crossbar_of_init(struct device_node *node)
> >>  		reserved += size;
> >>  	}
> >>  
> >> +	/* Skip the ones marked as unused */
> >> +	if (data) {
> >> +		irqsk = data->irqs_unused;
> >> +		size = data->size;
> >> +
> >> +		for (i = 0; i < size; i++) {
> >> +			entry = irqsk[i];
> >> +
> >> +			if (entry > max) {
> >> +				pr_err("Invalid skip entry\n");
> >> +				goto err3;
> >> +			}
> >> +			cb->irq_map[entry] = IRQ_SKIP;
> >> +		}
> >> +	}
> >> +
> >>  	register_routable_domain_ops(&routable_irq_domain_ops);
> >>  	return 0;
> >>  
> >> @@ -208,18 +238,27 @@ err1:
> >>  	return -ENOMEM;
> >>  }
> >>  
> >> +/* irq number 10 cannot be used because of hw bug */
> >> +int dra_irqs_unused[] = { 10 };
> >> +struct crossbar_data cb_dra_data = { dra_irqs_unused,
> >> +				     ARRAY_SIZE(dra_irqs_unused) };
> >> +
> >>  static const struct of_device_id crossbar_match[] __initconst = {
> >> -	{ .compatible = "ti,irq-crossbar" },
> >> +	{ .compatible = "ti,irq-crossbar", .data = &cb_dra_data },
> >>  	{}
> >>  };
> > 
> > This is a bug in all implementations of this IP?  Or, a specific
> > SoC's implementation?  Would this be better expressed in the dts via a
> > property?  Can we expect future implementations to be fixed?
> > 
> > thx,
> > 
> > Jason.
>  Infact this and PATCH#10 should be merged. I will change that.
> 
>  So in Socs's (2 so far) that do have a crossbar, some irqs are mapped
>  through a crossbar and some are directly wired to the irqchip.
>  These 'unused irqs' are those which are directly wired but they still
>  have a crossbar register. Their routing cannot be changed. So this
>  is not really expected usage of the crossbar hw ip. We initially thought
>  having a dts property separately for this, but took this path to avoid
>  loading the dts with additional bindings which may not be generic.

How do you plan to handle future SoCs with this IP and possibly
different hard-wired irqs?

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
