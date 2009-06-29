From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [ARM][OMAP] TWL4030 IRQ
Date: Mon, 29 Jun 2009 21:04:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
 <20090624075756.GA13052@n2100.arm.linux.org.uk>
 <20090629093004.GA2111@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60028 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbZF2PfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 11:35:17 -0400
In-Reply-To: <20090629093004.GA2111@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> And here it is - I've only build-tested it so far.
> 
>  drivers/mfd/twl4030-irq.c |   55 
> ++++++++++++++++++--------------------------
>  1 files changed, 23 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index bae61b2..4bb1ea7 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -180,15 +180,9 @@ static struct completion irq_event;
>  static int twl4030_irq_thread(void *data)
>  {
>  	long irq = (long)data;
> -	struct irq_desc *desc = irq_to_desc(irq);
>  	static unsigned i2c_errors;
>  	static const unsigned max_i2c_errors = 100;
>  
> -	if (!desc) {
> -		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
> -		return -EINVAL;
> -	}
> -
>  	current->flags |= PF_NOFREEZE;
>  
>  	while (!kthread_should_stop()) {
> @@ -240,38 +234,25 @@ static int twl4030_irq_thread(void *data)
>  		}
>  		local_irq_enable();
>  
> -		desc->chip->unmask(irq);
> +		enable_irq(irq);
>  	}
>  
>  	return 0;
>  }
Russell,
Just a question here.

In the enable_irq(irq) and disable_irq(irq) call tree, internally there are calls to 
the interrupt controller chip.

In disable_irq() path:
	desc->chip->disable(irq);
And in emable_irq() path:
	desc->chip->enable(irq);

But the in gic gic_chip, enable/disable fn are not populated.

static struct irq_chip gic_chip = {
	.name		= "GIC",
	.ack		= gic_ack_irq,
	.mask		= gic_mask_irq,
	.unmask		= gic_unmask_irq,
#ifdef CONFIG_SMP
	.set_affinity	= gic_set_cpu,
#endif
}
Do we need these(disable/enable) hooks in gic_chip as well ?

Regards,
Santosh
 

  
