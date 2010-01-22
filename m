From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] omap: Make get_irqnr_and_base common for
 mach-omap2 multiboot, v2
Date: Fri, 22 Jan 2010 12:39:53 -0800
Message-ID: <20100122203953.GA11835@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013520.10065.17921.stgit@baageli.muru.com>
 <20100116115503.GA15904@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56765 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab0AVUjz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 15:39:55 -0500
Content-Disposition: inline
In-Reply-To: <20100116115503.GA15904@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100116 03:53]:
> On Fri, Jan 15, 2010 at 05:35:20PM -0800, Tony Lindgren wrote:
> > -#ifndef CONFIG_ARCH_OMAP4
> > +#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430) || \
> > +	defined(CONFIG_ARCH_OMAP34XX)
> > +
> > +#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
> > +#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> > +
> > +omap_irq_base:	.word	0x0
> 
> You have no idea where this word will be placed - it could be in the middle
> of a read only section, which might really be read only.  It might also be
> out of reach of the "ldr \base, [pc, #offset]" instructions you're using
> below - which is what an "ldr \base, address" instruction really is.
> 
> > +
> >  		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> > -		ldr	\base, =OMAP2_VA_IC_BASE
> > -		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
> > +		ldr	\base, omap_irq_base
> > +		cmp	\base, #0		@ is irq base configured?
> > +		bne	9998f			@ already configured
> 
> First thing, why not use get_irqnr_preamble to load the base address?
> That means you only do all this computation once per group of IRQs
> processed.
> 
> Secondly, is this really worth the overhead, or can't you move
> omap_irq_base into the data section, and have your IRQ initialization
> function set the pointer?
> 
> You then don't have to make these two tests every time you check for
> an interrupt/enter to process interrupts.

Here's this patch updated. It should now be actually more optimized for
non-multi-omap configurations as it uses the get_irqnr_preamble :)

Regards,

Tony

--zhXaljGHf11kAtnf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="multi-omap-entry-macro-v2.patch"

>From 6f9a0d37612db2833d280748bedc9c35a2c366ab Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 22 Jan 2010 11:36:16 -0800
Subject: [PATCH] omap2/3: Make get_irqnr_and_base common for mach-omap2 multiboot

Make get_irqnr_and_base common for mach-omap2 multiboot

Note that this will only work currently for 24xx and 34xx.

The overhead of this should be minimal, it basically adds one
cmp to see if omap_irq_base has been configured already.
If necessary, we can set separate optimized get_irqnr_and_base
for non-multiboot configurations.

Support for 44xx can be added later on for basic multiboot,
and similar patch should be done for mach-omap1/entry-macro.S.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index c7f1720..c5ea026 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -17,47 +17,85 @@
 
 #include <plat/omap24xx.h>
 #include <plat/omap34xx.h>
-
-/* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
-#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
-#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
-#elif defined(CONFIG_ARCH_OMAP34XX)
-#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
 #include <plat/omap44xx.h>
-#endif
-#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
-#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
 
 		.macro	disable_fiq
 		.endm
 
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
-#ifndef CONFIG_ARCH_OMAP4
+#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430) || \
+	defined(CONFIG_ARCH_OMAP34XX)
+
+#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
+#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
+#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
+
+		.pushsection .data
+omap_irq_base:	.word	0
+		.popsection
+
+#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_ARCH_OMAP3)
+		/* Configure the interrupt base on the first interrupt */
+		.macro  get_irqnr_preamble, base, tmp
+9:
+		ldr	\base, =omap_irq_base	@ irq base address
+		ldr	\base, [\base, #0]	@ irq base value
+		cmp	\base, #0		@ already configured?
+		bne	9998f			@ nothing to do
+
+		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
+		and	\tmp, \tmp, #0x000f0000	@ only check architecture
+		cmp	\tmp, #0x00060000	@ is v6?
+		beq	2400f			@ found v6 so it's omap24xx
+		cmp	\tmp, #0x000f0000	@ is cortex?
+		beq	3400f			@ found v7 so it's omap34xx
+2400:		ldr	\base, =OMAP2_IRQ_BASE
+		ldr	\tmp, =omap_irq_base
+		str	\base, [\tmp, #0]
+		b	9b
+3400:		ldr	\base, =OMAP3_IRQ_BASE
+		ldr	\tmp, =omap_irq_base
+		str	\base, [\tmp, #0]
+		b	9b
+9998:
+		.endm
+#else
+		.macro  get_irqnr_preamble, base, tmp
+#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
+		ldr	\base, =OMAP2_IRQ_BASE
+#else
+		ldr	\base, =OMAP3_IRQ_BASE
+#endif
+		.endm
+#endif
+		/* Check the pending interrupts. Note that base already set */
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =OMAP2_VA_IC_BASE
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
 		cmp	\irqnr, #0x0
-		bne	2222f
+		bne	9999f
 		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
 		cmp	\irqnr, #0x0
-		bne	2222f
+		bne	9999f
 		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
 		cmp	\irqnr, #0x0
-2222:
+9999:
 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
 		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
 
 		.endm
-#else
+#endif
+
+
+#ifdef CONFIG_ARCH_OMAP4
+
 #define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
 
+		.macro  get_irqnr_preamble, base, tmp
+		.endm
+
 		/*
 		 * The interrupt numbering scheme is defined in the
 		 * interrupt controller spec.  To wit:

--zhXaljGHf11kAtnf--
