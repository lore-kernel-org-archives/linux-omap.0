From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/5] ARM: OMAP2/3: intc: Add irqdomain support
Date: Fri, 6 Jan 2012 14:22:30 -0700
Message-ID: <20120106212230.GB7457@ponder.secretlab.ca>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35090 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab2AFVWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 16:22:31 -0500
Received: by iaeh11 with SMTP id h11so3175603iae.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 13:22:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1324388398-2683-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rob.herring@calxeda.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 20, 2011 at 02:39:55PM +0100, Benoit Cousson wrote:
> Introduce the usage of the irqdomain to prepare the DT support.
> The irq_base is still hard coded to 0 to allow non-DT drivers
> to work with the previous assumption that was hwirq = irq.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-omap2/irq.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 42b1d65..2f65dfd 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -17,6 +17,7 @@
>  #include <mach/hardware.h>
>  #include <asm/exception.h>
>  #include <asm/mach/irq.h>
> +#include <linux/irqdomain.h>
>  
>  
>  /* selected INTC register offsets */
> @@ -57,6 +58,8 @@ static struct omap_irq_bank {
>  	},
>  };
>  
> +static struct irq_domain domain;
> +
>  /* Structure to save interrupt controller context */
>  struct omap3_intc_regs {
>  	u32 sysconfig;
> @@ -158,6 +161,17 @@ static void __init omap_init_irq(u32 base, int nr_irqs)
>  	if (WARN_ON(!omap_irq_base))
>  		return;
>  
> +	/*
> +	 * XXX: Use a 0 irq_base for the moment since the legacy devices
> +	 * created statically are expected a hwirq = irq mapping.
> +	 * A proper offset will be added later, when IRQ resource creation
> +	 * will be handled by DT.
> +	 */
> +	domain.irq_base = 0;
> +	domain.nr_irq = nr_irqs;
> +	domain.ops = &irq_domain_simple_ops;
> +	irq_domain_add(&domain);

The omap doesn't need anything special from irq_domain.  You can use
irq_domain_add_simple().  A recent patch was posted that makes
irq_domain_add_simple() accepts a nr_irqs parameter and returns the
allocated irq domain.

However, that isn't enough reason for me to reject this patch if there
is any opportunity to get it into v3.3 provided you promise to fix it
up later.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +
>  	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
>  		struct omap_irq_bank *bank = irq_banks + i;
>  
> @@ -225,8 +239,10 @@ out:
>  		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
>  		irqnr &= ACTIVEIRQ_MASK;
>  
> -		if (irqnr)
> +		if (irqnr) {
> +			irqnr = irq_domain_to_irq(&domain, irqnr);
>  			handle_IRQ(irqnr, regs);
> +		}
>  	} while (irqnr);
>  }
>  
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
