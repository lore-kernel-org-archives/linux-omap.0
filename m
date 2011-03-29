From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/10] omap: Use separate init_irq functions to avoid cpu_is_omap tests early
Date: Tue, 29 Mar 2011 10:11:12 -0700
Message-ID: <874o6lg8cv.fsf@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222128.4046.70846.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35918 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab1C2RLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 13:11:17 -0400
Received: by mail-pv0-f180.google.com with SMTP id 2so83219pvg.39
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 10:11:15 -0700 (PDT)
In-Reply-To: <20110328222128.4046.70846.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:28 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

Tony Lindgren <tony@atomide.com> writes:

> This allows us to remove cpu_is_omap calls from init_irq functions
> and the irq handler. There should not be any need for cpu_is_omap
> as at this point we only care about SoC generation, and not about
> subcategories.
>
> The main reason for the patch is that we want to initialize only
> minimal omap specific code from the init_early call, and this and
> the following patches get us closer to that goal.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

[...]

A couple of minor comments on naming below...

> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index bc524b9..33a5c0d 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -103,28 +103,36 @@ static void omap_ack_irq(struct irq_data *d)
>  	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
>  }
>  
> +static inline void _omap_mask_irq(int irq)
> +{
> +	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
> +	irq &= (IRQ_BITS_PER_REG - 1);
> +	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
> +}
> +
>  static void omap_mask_irq(struct irq_data *d)
>  {
>  	unsigned int irq = d->irq;
> -	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
>  
> -	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
> -		int spurious = 0;
> +	_omap_mask_irq(irq);
> +}
>  
> -		/*
> -		 * INT_34XX_GPT12_IRQ is also the spurious irq. Maybe because
> -		 * it is the highest irq number?
> -		 */
> -		if (irq == INT_34XX_GPT12_IRQ)
> -			spurious = omap_check_spurious(irq);
> +static void omap_mask_irq_omap3(struct irq_data *d)

how about omap3_mask_irq().

In most other code we're using the SoC name as a prefix instead of
suffix.

> +{
> +	unsigned int irq = d->irq;
> +	int spurious = 0;
>  
> -		if (!spurious)
> -			previous_irq = irq;
> -	}
> +	/*
> +	 * INT_34XX_GPT12_IRQ is also the spurious irq. Maybe because
> +	 * it is the highest irq number?
> +	 */
> +	if (irq == INT_34XX_GPT12_IRQ)
> +		spurious = omap_check_spurious(irq);
>  
> -	irq &= (IRQ_BITS_PER_REG - 1);
> +	if (!spurious)
> +		previous_irq = irq;
>  
> -	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
> +	_omap_mask_irq(irq);
>  }
>  
>  static void omap_unmask_irq(struct irq_data *d)
> @@ -143,6 +151,12 @@ static void omap_mask_ack_irq(struct irq_data *d)
>  	omap_ack_irq(d);
>  }
>  
> +static void omap_mask_ack_irq_omap3(struct irq_data *d)

Also here: omap3_mask_ack_irq()

Kevin
