From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt
	bits
Date: Wed, 22 Oct 2008 11:30:07 -0700
Message-ID: <20081022183005.GB7341@atomide.com>
References: <E1Kshoz-0002rO-61@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55970 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbYJVSaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 14:30:11 -0400
Content-Disposition: inline
In-Reply-To: <E1Kshoz-0002rO-61@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

* Rick Bronson <rick@efn.org> [081022 11:03]:
> 
>   Sorry if I'm late in the game for changes to entry-macro.S but I
> worked on this code a bit ago and have been testing it.  What I have,
> I think, is a little more straight forward.  Note that it doesn't have
> the added mask for the spurious bits, but it does check for
> spurious interrupts and handles them.

Can you refresh it against the current l-o tree? We need to mask out
the spurious bits from the irqnr, otherwise the irqnr data will be
bogus.

Also, AFAIK we don't have infinitely repeating irqs any longer, it's
just an occasional single spurious interrupt.

Tony

> 
>   Rick
> 
> 
> 
> --- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.~1~	2008-10-16 13:33:31.000000000 -0700
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-17 11:38:18.000000000 -0700
> @@ -65,7 +65,11 @@
>  #include <mach/omap34xx.h>
>  #endif
>  
> -#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt number */
> +#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* Active interrupt number */
> +#define INTCPS_CONTROL		0x0048	/* new interrupt agreement bits */
> +#define INTCPS_PENDING_IRQ_1	0x0098	/* IRQ pending reg 1 */
> +#define INTCPS_PENDING_IRQ_2	0x00b8	/* IRQ pending reg 2 */
> +#define INTCPS_PENDING_IRQ_3	0x00d8	/* IRQ pending reg 3 */
>  
>  		.macro	disable_fiq
>  		.endm
> @@ -78,17 +82,19 @@
>  
>  		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
>  		ldr	\base, =OMAP2_VA_IC_BASE
> -		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
> -		cmp	\irqnr, #0x0
> -		bne	2222f
> -		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
> -		cmp	\irqnr, #0x0
> -		bne	2222f
> -		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
> -		cmp	\irqnr, #0x0
> -2222:
> -		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> -
> +		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> +		cmp	\irqnr, #0  /* check for negative */
> +		movmi	\tmp, #0x1 /* Ack the spurious irq, this lets it
> +					* generate a bad irq error message,
> +					* but prevents infinitely repeating
> +					* irq.
> +					*/
> +		strmi	\tmp, [\base, #INTCPS_CONTROL]
> +		ldr	\irqstat, [\base, #INTCPS_PENDING_IRQ_1] /* IRQ pending reg 1 */
> +		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_2] /* IRQ pending reg 2 */
> +		orr	\irqstat, \irqstat, \tmp  /* or them all together */
> +		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_3] /* IRQ pending reg 3 */
> +		orrs	\irqstat, \irqstat, \tmp  /* set condition code Z if interrupt */
>  		.endm
>  
>  		.macro	irq_prio_table
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
