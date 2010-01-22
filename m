From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] omap: Make get_irqnr_and_base common for
	mach-omap2 multiboot, v2
Date: Fri, 22 Jan 2010 20:56:16 +0000
Message-ID: <20100122205616.GC18461@n2100.arm.linux.org.uk>
References: <20100116013205.10065.95921.stgit@baageli.muru.com> <20100116013520.10065.17921.stgit@baageli.muru.com> <20100116115503.GA15904@n2100.arm.linux.org.uk> <20100122203953.GA11835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33724 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab0AVU4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 15:56:35 -0500
Content-Disposition: inline
In-Reply-To: <20100122203953.GA11835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Jan 22, 2010 at 12:39:53PM -0800, Tony Lindgren wrote:
> Here's this patch updated. It should now be actually more optimized for
> non-multi-omap configurations as it uses the get_irqnr_preamble :)

And the patch looks a lot cleaner and easier to read.

> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> index c7f1720..c5ea026 100644
> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> @@ -17,47 +17,85 @@
>  
>  #include <plat/omap24xx.h>
>  #include <plat/omap34xx.h>
> -
> -/* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
> -#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
> -#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
> -#elif defined(CONFIG_ARCH_OMAP34XX)
> -#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
> -#endif
> -#if defined(CONFIG_ARCH_OMAP4)
>  #include <plat/omap44xx.h>
> -#endif
> -#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
> -#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
>  
>  		.macro	disable_fiq
>  		.endm
>  
> -		.macro  get_irqnr_preamble, base, tmp
> -		.endm
> -
>  		.macro  arch_ret_to_user, tmp1, tmp2
>  		.endm
>  
> -#ifndef CONFIG_ARCH_OMAP4
> +#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430) || \
> +	defined(CONFIG_ARCH_OMAP34XX)

Isn't this equivalent to:

#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)

?

> +
> +#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
> +#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
> +#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
> +#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> +
> +		.pushsection .data
> +omap_irq_base:	.word	0
> +		.popsection
> +
> +#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_ARCH_OMAP3)
> +		/* Configure the interrupt base on the first interrupt */
> +		.macro  get_irqnr_preamble, base, tmp
> +9:
> +		ldr	\base, =omap_irq_base	@ irq base address
> +		ldr	\base, [\base, #0]	@ irq base value
> +		cmp	\base, #0		@ already configured?
> +		bne	9998f			@ nothing to do
> +
> +		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
> +		and	\tmp, \tmp, #0x000f0000	@ only check architecture
> +		cmp	\tmp, #0x00060000	@ is v6?
> +		beq	2400f			@ found v6 so it's omap24xx
> +		cmp	\tmp, #0x000f0000	@ is cortex?
> +		beq	3400f			@ found v7 so it's omap34xx
> +2400:		ldr	\base, =OMAP2_IRQ_BASE
> +		ldr	\tmp, =omap_irq_base
> +		str	\base, [\tmp, #0]
> +		b	9b
> +3400:		ldr	\base, =OMAP3_IRQ_BASE
> +		ldr	\tmp, =omap_irq_base
> +		str	\base, [\tmp, #0]
> +		b	9b
> +9998:
> +		.endm
> +#else
> +		.macro  get_irqnr_preamble, base, tmp
> +#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)

And this

#elif defined(CONFIG_ARCH_OMAP2)

?

> +		ldr	\base, =OMAP2_IRQ_BASE
> +#else
> +		ldr	\base, =OMAP3_IRQ_BASE
> +#endif

Whereas I can see the sense in loading 'base' here directly, I don't see
the point of finding a value for omap_irq_base in assembly code, when you
have to do IRQ initialization in C code.  In fact, you're already sorting
this out in omap_init_irq().
