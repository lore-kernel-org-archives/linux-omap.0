From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Tue, 13 Dec 2011 14:45:12 +0530
Message-ID: <4EE717A0.8020304@ti.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com> <1323291049-24964-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56707 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752768Ab1LMJPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 04:15:21 -0500
Received: by mail-yx0-f175.google.com with SMTP id m12so4833091yen.6
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 01:15:19 -0800 (PST)
In-Reply-To: <1323291049-24964-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 012bac7..bcfccc2 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -156,6 +156,16 @@ void omap3_intc_resume_idle(void);
>   void omap2_intc_handle_irq(struct pt_regs *regs);
>   void omap3_intc_handle_irq(struct pt_regs *regs);
>
> +struct device_node;
> +#ifdef CONFIG_OF
> +int __init intc_of_init(struct device_node *node, struct device_node *parent);
> +#else
> +int __init intc_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	return 0;
> +}

This seems to break !CONFIG_OF builds as common.h is included in
multiple c files causing 'multiple definition' errors.

regards,
Rajendra

> +#endif
> +
>   /*
>    * wfi used in low power code. Directly opcode is used instead
>    * of instruction to avoid mulit-omap build break
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 42b1d65..cafc663 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -17,6 +17,9 @@
>   #include<mach/hardware.h>
>   #include<asm/exception.h>
>   #include<asm/mach/irq.h>
> +#include<linux/of.h>
> +#include<linux/of_address.h>
> +#include<linux/irqdomain.h>
>
>
>   /* selected INTC register offsets */
> @@ -166,7 +169,7 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
>   		/* Static mapping, never released */
>   		bank->base_reg = ioremap(base, SZ_4K);
>   		if (!bank->base_reg) {
> -			printk(KERN_ERR "Could not ioremap irq bank%i\n", i);
> +			pr_err("Could not ioremap irq bank%i\n", i);
>   			continue;
>   		}
>
> @@ -179,8 +182,8 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
>   		nr_banks++;
>   	}
>
> -	printk(KERN_INFO "Total of %ld interrupts on %d active controller%s\n",
> -	       nr_of_irqs, nr_banks, nr_banks>  1 ? "s" : "");
> +	pr_info("Total of %ld interrupts on %d active controller%s\n",
> +		nr_of_irqs, nr_banks, nr_banks>  1 ? "s" : "");
>   }
>
>   void __init omap2_init_irq(void)
> @@ -236,6 +239,32 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
>   	omap_intc_handle_irq(base_addr, regs);
>   }
>
> +#ifdef CONFIG_OF
> +int __init intc_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct resource res;
> +	u32 nr_irqs;
> +
> +	if (WARN_ON(!node))
> +		return -ENODEV;
> +
> +	if (of_address_to_resource(node, 0,&res)) {
> +		WARN(1, "unable to get intc registers\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_property_read_u32(node, "ti,intc-size",&nr_irqs)) {
> +		WARN(1, "unable to get intc-size\n");
> +		return -EINVAL;
> +	}
> +
> +	omap_init_irq(res.start, nr_irqs);
> +	irq_domain_add_simple(node, 0);
> +
> +	return 0;
> +}
> +#endif
> +
>   #ifdef CONFIG_ARCH_OMAP3
>   static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
>

