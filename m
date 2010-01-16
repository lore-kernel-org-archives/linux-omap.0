From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] omap: Make get_irqnr_and_base common for mach-omap2
	multiboot
Date: Fri, 15 Jan 2010 17:35:20 -0800
Message-ID: <20100116013520.10065.17921.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59160 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758587Ab0APBfK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 20:35:10 -0500
In-Reply-To: <20100116013205.10065.95921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Make get_irqnr_and_base common for mach-omap2 multiboot

Note that this will only work currently for 24xx and 34xx.

The overhead of this should be minimal, it basically adds one
cmp to see if omap_irq_base has been configured already.
If necessary, we can set separate optimized get_irqnr_and_base
for non-multiboot configurations.

Support for 44xx can be added later on for basic multiboot,
and similar patch should be done for mach-omap1/entry-macro.S.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   55 ++++++++++++++++--------
 1 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index c7f1720..3f75a09 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -17,18 +17,7 @@
 
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
@@ -39,23 +28,53 @@
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
-#ifndef CONFIG_ARCH_OMAP4
+#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430) || \
+	defined(CONFIG_ARCH_OMAP34XX)
+
+#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
+#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
+
+omap_irq_base:	.word	0x0
+
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =OMAP2_VA_IC_BASE
-		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
+		ldr	\base, omap_irq_base
+		cmp	\base, #0		@ is irq base configured?
+		bne	9998f			@ already configured
+
+		/* Check the processor type */
+		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
+		and	\tmp, \tmp, #0x000f0000	@ only check architecture
+		cmp	\tmp, #0x00060000	@ is v6?
+		beq	2400f			@ found v6 so it's omap24xx
+		cmp	\tmp, #0x000f0000	@ is cortex?
+		beq	3400f			@ found v7 so it's omap34xx
+
+2400:		ldr	\base, =OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
+		str	\base, omap_irq_base
+		b	9998f
+
+3400:		ldr	\base, =OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
+		str	\base, omap_irq_base
+
+		/* Check the pending interrupts */
+9998:		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
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
 
 		/*

