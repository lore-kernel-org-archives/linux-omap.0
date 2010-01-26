From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/14] omap2/3: Make get_irqnr_and_base common for mach-omap2
	multiboot
Date: Tue, 26 Jan 2010 12:12:43 -0800
Message-ID: <20100126201243.15382.49505.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60359 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab0AZUMY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:24 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Make get_irqnr_and_base common for mach-omap2 multiboot

Thanks to a tip from Russell King <rmk+kernel@arm.linux.org.uk>,
this also optimizes the code for non-multiboot configurations by
using get_irqnr_preamble.

Note that this will only work currently for 24xx and 34xx.
Support for 44xx can be added later on for basic multiboot,
and similar patch should be done for mach-omap1/entry-macro.S.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   77 ++++++++++++++++++------
 1 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index c7f1720..4fd6b1b 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -17,47 +17,84 @@
 
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
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
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
+#ifdef CONFIG_ARCH_OMAP2
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

