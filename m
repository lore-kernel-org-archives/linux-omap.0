From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/6] TI816X: Update common omap platform files
Date: Thu, 05 Aug 2010 07:28:46 -0700
Message-ID: <87ocdh2kwx.fsf@deeprootsystems.com>
References: <1280523096-25041-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51067 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab0HEO2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 10:28:49 -0400
Received: by pxi14 with SMTP id 14so2469035pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 07:28:49 -0700 (PDT)
In-Reply-To: <1280523096-25041-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Sat, 31 Jul 2010 02:21:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch updates the common platform files with TI816X specific additions.
>
> Also adds new files for TI816X modules base addresseses and irq definitions.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/entry-macro.S |   44 ++++++++-
>  arch/arm/plat-omap/common.c                    |   20 ++++
>  arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
>  arch/arm/plat-omap/include/plat/clock.h        |    1 +
>  arch/arm/plat-omap/include/plat/common.h       |    1 +
>  arch/arm/plat-omap/include/plat/control.h      |   23 ++++
>  arch/arm/plat-omap/include/plat/hardware.h     |    1 +
>  arch/arm/plat-omap/include/plat/io.h           |   20 ++++
>  arch/arm/plat-omap/include/plat/irqs-ti816x.h  |  128 ++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/irqs.h         |    3 +
>  arch/arm/plat-omap/include/plat/serial.h       |    5 +
>  arch/arm/plat-omap/include/plat/ti816x.h       |   40 ++++++++
>  arch/arm/plat-omap/io.c                        |    7 ++
>  13 files changed, 291 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
>  create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h
>
> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> index 50fd749..6516cbd 100644
> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> @@ -34,7 +34,7 @@
>  		.endm
>  
>  /*
> - * Unoptimized irq functions for multi-omap2, 3 and 4
> + * Unoptimized irq functions for multi-omap2, 3, 4 and ti816x
>   */
>  
>  #ifdef MULTI_OMAP2
> @@ -57,7 +57,8 @@ omap_irq_base:	.word	0
>  		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
>  		and	\tmp, \tmp, #0x000000f0	@ check cortex 8 or 9
>  		cmp	\tmp, #0x00000080	@ cortex A-8?
> -		beq	3400f			@ found A-8 so it's omap34xx
> +		beq	3400f			@ found A-8 so it's omap34xx or
> +						@ ti816x
>  		cmp	\tmp, #0x00000090	@ cortex A-9?
>  		beq	4400f			@ found A-9 so it's omap44xx
>  2400:		ldr	\base, =OMAP2_IRQ_BASE
> @@ -80,7 +81,7 @@ omap_irq_base:	.word	0
>  		tst	\base, #0x100		@ gic address?
>  		bne	4401f			@ found gic
>  
> -		/* Handle omap2 and omap3 */
> +		/* Handle omap2, omap3 and ti816x */
>  		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
>  		cmp	\irqnr, #0x0
>  		bne	9998f
> @@ -89,6 +90,14 @@ omap_irq_base:	.word	0
>  		bne	9998f
>  		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
>  		cmp	\irqnr, #0x0
> +		bne	9998f
> +
> +		/*
> +		 * ti816x has additional IRQ pending register. Checking this
> +		 * register on omap2 & omap3 has no effect (read as 0).
> +		 */
> +		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
> +		cmp	\irqnr, #0x0

This part makes me a slightly nervous.  At least according to the TRMs,
this address is undefined on OMAP2 & OMAP3 (yet still in the INTC block.)
Was this tested on OMAP2/3 hardware and verified to return 0?

You might also consider wrapping this section in 
#ifdef CONFIG_ARCH_TI816X so a multi-OMAP kernel without 816x support
would avoid this extra read.

>  9998:
>  		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
>  		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
> @@ -139,6 +148,35 @@ omap_irq_base:	.word	0
>  		.endm
>  #endif
>  
> +/*
> + * Optimized irq functions for ti816x
> + */
> +
> +#ifdef CONFiG_ARCH_TI816X
              ^
typo?  these are case-sensitive, so this part would never be compiled

> +		.macro  get_irqnr_preamble, base, tmp
> +		ldr	\base, =OMAP3_IRQ_BASE
> +		.endm
> +
> +		/* Check the pending interrupts. Note that base already set */
> +		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> +		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
> +		cmp	\irqnr, #0x0
> +		bne	9999f
> +		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
> +		cmp	\irqnr, #0x0
> +		bne	9999f
> +		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
> +		cmp	\irqnr, #0x0
> +		bne	9999f
> +		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
> +		cmp	\irqnr, #0x0
> +9999:
> +		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
> +		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK
> +
> +		.endm
> +#endif
> +

Kevin
