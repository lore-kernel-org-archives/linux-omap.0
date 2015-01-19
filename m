From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 14/21] ARM: imx6: convert GPC to stacked domains
Date: Mon, 19 Jan 2015 11:12:46 +0000
Message-ID: <54BCE6AE.4020908@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>	 <1421660655-21394-15-git-send-email-marc.zyngier@arm.com> <1421664450.3388.14.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421664450.3388.14.camel@pengutronix.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infra
List-Id: linux-omap@vger.kernel.org

On 19/01/15 10:47, Lucas Stach wrote:
> Am Montag, den 19.01.2015, 09:44 +0000 schrieb Marc Zyngier:
>> IMX6 has been (ab)using the gic_arch_extn to provide
>> wakeup from suspend, and it makes a lot of sense to convert
>> this code to use stacked domains instead.
>>
>> This patch does just this, updating the DT files to actually
>> reflect what the HW provides.
>>
>> BIG FAT WARNING: because the DTs were so far lying by not
>> exposing the fact that the GPC block is actually the first
>> interrupt controller in the chain, kernels with this patch
>> applied wont have any suspend-resume facility when booted
>> with old DTs, and old kernels with updated DTs won't even boot.
>>
>> Tested-by: Stefan Agner <stefan@agner.ch>
>> Acked-by: Stefan Agner <stefan@agner.ch>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi  |   7 ++-
>>  arch/arm/boot/dts/imx6sl.dtsi   |   6 +-
>>  arch/arm/boot/dts/imx6sx.dtsi   |   6 +-
>>  arch/arm/mach-imx/common.h      |   1 -
>>  arch/arm/mach-imx/gpc.c         | 127 ++++++++++++++++++++++++++++++++--------
>>  arch/arm/mach-imx/mach-imx6q.c  |   1 -
>>  arch/arm/mach-imx/mach-imx6sl.c |   1 -
>>  arch/arm/mach-imx/mach-imx6sx.c |   1 -
>>  8 files changed, 119 insertions(+), 31 deletions(-)
>>
> [...]
> 
>> --- a/arch/arm/mach-imx/common.h
>> +++ b/arch/arm/mach-imx/common.h
>> @@ -102,7 +102,6 @@ static inline void imx_scu_map_io(void) {}
>>  static inline void imx_smp_prepare(void) {}
>>  #endif
>>  void imx_src_init(void);
>> -void imx_gpc_init(void);
>>  void imx_gpc_pre_suspend(bool arm_power_off);
>>  void imx_gpc_post_resume(void);
>>  void imx_gpc_mask_all(void);
>> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
>> index 5f3602e..838da3c 100644
>> --- a/arch/arm/mach-imx/gpc.c
>> +++ b/arch/arm/mach-imx/gpc.c
>> @@ -22,6 +22,7 @@
>>  #define GPC_PGC_CPU_PDN		0x2a0
>>  
>>  #define IMR_NUM			4
>> +#define GPC_MAX_IRQS		(IMR_NUM * 32)
>>  
>>  static void __iomem *gpc_base;
>>  static u32 gpc_wake_irqs[IMR_NUM];
>> @@ -56,17 +57,17 @@ void imx_gpc_post_resume(void)
>>  
>>  static int imx_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
>>  {
>> -	unsigned int idx = d->hwirq / 32 - 1;
>> +	unsigned int idx = d->hwirq / 32;
>>  	u32 mask;
>>  
>> -	/* Sanity check for SPI irq */
>> -	if (d->hwirq < 32)
>> -		return -EINVAL;
>> -
>>  	mask = 1 << d->hwirq % 32;
>>  	gpc_wake_irqs[idx] = on ? gpc_wake_irqs[idx] | mask :
>>  				  gpc_wake_irqs[idx] & ~mask;
>>  
>> +	/*
>> +	 * Do *not* call into the parent, as the GIC doesn't have any
>> +	 * wake-up facility...
>> +	 */
>>  	return 0;
>>  }
>>  
>> @@ -96,7 +97,7 @@ void imx_gpc_hwirq_unmask(unsigned int hwirq)
>>  	void __iomem *reg;
>>  	u32 val;
>>  
>> -	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
>> +	reg = gpc_base + GPC_IMR1 + hwirq / 32 * 4;
>>  	val = readl_relaxed(reg);
>>  	val &= ~(1 << hwirq % 32);
>>  	writel_relaxed(val, reg);
>> @@ -107,7 +108,7 @@ void imx_gpc_hwirq_mask(unsigned int hwirq)
>>  	void __iomem *reg;
>>  	u32 val;
>>  
>> -	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
>> +	reg = gpc_base + GPC_IMR1 + hwirq / 32 * 4;
>>  	val = readl_relaxed(reg);
>>  	val |= 1 << (hwirq % 32);
>>  	writel_relaxed(val, reg);
>> @@ -115,37 +116,115 @@ void imx_gpc_hwirq_mask(unsigned int hwirq)
>>  
>>  static void imx_gpc_irq_unmask(struct irq_data *d)
>>  {
>> -	/* Sanity check for SPI irq */
>> -	if (d->hwirq < 32)
>> -		return;
>> -
>>  	imx_gpc_hwirq_unmask(d->hwirq);
>> +	irq_chip_unmask_parent(d);
>>  }
>>  
>>  static void imx_gpc_irq_mask(struct irq_data *d)
>>  {
>> -	/* Sanity check for SPI irq */
>> -	if (d->hwirq < 32)
>> -		return;
>> -
>>  	imx_gpc_hwirq_mask(d->hwirq);
>> +	irq_chip_mask_parent(d);
>> +}
>> +
>> +static struct irq_chip imx_gpc_chip = {
>> +	.name		= "GPC",
>> +	.irq_eoi	= irq_chip_eoi_parent,
>> +	.irq_mask	= imx_gpc_irq_mask,
>> +	.irq_unmask	= imx_gpc_irq_unmask,
>> +	.irq_retrigger	= irq_chip_retrigger_hierarchy,
>> +	.irq_set_wake	= imx_gpc_irq_set_wake,
>> +};
>> +
>> +static int imx_gpc_domain_xlate(struct irq_domain *domain,
>> +				struct device_node *controller,
>> +				const u32 *intspec,
>> +				unsigned int intsize,
>> +				unsigned long *out_hwirq,
>> +				unsigned int *out_type)
>> +{
>> +	if (domain->of_node != controller)
>> +		return -EINVAL;	/* Shouldn't happen, really... */
>> +	if (intsize != 3)
>> +		return -EINVAL;	/* Not GIC compliant */
>> +	if (intspec[0] != 0)
>> +		return -EINVAL;	/* No PPI should point to this domain */
>> +
>> +	*out_hwirq = intspec[1];
>> +	*out_type = intspec[2];
>> +	return 0;
>> +}
>> +
>> +static int imx_gpc_domain_alloc(struct irq_domain *domain,
>> +				  unsigned int irq,
>> +				  unsigned int nr_irqs, void *data)
>> +{
>> +	struct of_phandle_args *args = data;
>> +	struct of_phandle_args parent_args;
>> +	irq_hw_number_t hwirq;
>> +	int i;
>> +
>> +	if (args->args_count != 3)
>> +		return -EINVAL;	/* Not GIC compliant */
>> +	if (args->args[0] != 0)
>> +		return -EINVAL;	/* No PPI should point to this domain */
>> +
>> +	hwirq = args->args[1];
>> +	if (hwirq >= GPC_MAX_IRQS)
>> +		return -EINVAL;	/* Can't deal with this */
>> +
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
>> +					      &imx_gpc_chip, NULL);
>> +
>> +	parent_args = *args;
>> +	parent_args.np = domain->parent->of_node;
>> +	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
>>  }
>>  
>> -void __init imx_gpc_init(void)
>> +static struct irq_domain_ops imx_gpc_domain_ops = {
>> +	.xlate	= imx_gpc_domain_xlate,
>> +	.alloc	= imx_gpc_domain_alloc,
>> +	.free	= irq_domain_free_irqs_common,
>> +};
>> +
>> +static int __init imx_gpc_init(struct device_node *node,
>> +			       struct device_node *parent)
>>  {
>> -	struct device_node *np;
>> +	struct irq_domain *parent_domain, *domain;
>>  	int i;
>>  
>> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
>> -	gpc_base = of_iomap(np, 0);
>> -	WARN_ON(!gpc_base);
>> +	if (!parent) {
>> +		pr_err("%s: no parent, giving up\n", node->full_name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	parent_domain = irq_find_host(parent);
>> +	if (!parent_domain) {
>> +		pr_err("%s: unable to obtain parent domain\n", node->full_name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	gpc_base = of_iomap(node, 0);
>> +	if (WARN_ON(!gpc_base))
>> +	        return -ENOMEM;
>> +
>> +	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
>> +					  node, &imx_gpc_domain_ops,
>> +					  NULL);
>> +	if (!domain) {
>> +		iounmap(gpc_base);
>> +		return -ENOMEM;
>> +	}
>>  
>>  	/* Initially mask all interrupts */
>>  	for (i = 0; i < IMR_NUM; i++)
>>  		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
>>  
>> -	/* Register GPC as the secondary interrupt controller behind GIC */
>> -	gic_arch_extn.irq_mask = imx_gpc_irq_mask;
>> -	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
>> -	gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
>> +	return 0;
>>  }
>> +
>> +/*
>> + * We cannot use the IRQCHIP_DECLARE macro that lives in
>> + * drivers/irqchip, so we're forced to roll our own. Not very nice.
>> + */
>> +OF_DECLARE_2(irqchip, imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
> 
> The above seems to be a recurring pattern, so it might be a good idea to
> expose the irqchip header.

My theory is that by keeping it ugly, the maintainers will get the
message and move the code around on their own. Probably wishful
thinking, but hey...

> But in the case of the GPC I don't see anything after your patch that
> would make it tied into the arch. So can you just move this driver to
> the irqchip directory?

At least imx_gpc_hwirq_[un]mask are directly used from the PM code, and
I have no idea how this interacts with the rest of the platform.

It would be possible to force the creation of an irq mapped to hwirq #32
at boot time, and then use that to drive the mask/unmask using the
standard kernel API, but that will also have an impact on the GIC
masking, and someone needs to find out if that breaks anything.

Furthermore, I do not have access to the HW, so whoever cares about it
should go ahead and fix it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
