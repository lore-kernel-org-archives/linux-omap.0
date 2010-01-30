From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/9] omap2/3/4: Clean up entry-macro.s for adding support for
	omap4 multiboot
Date: Fri, 29 Jan 2010 18:01:32 -0800
Message-ID: <20100130020132.10590.94667.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52888 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132Ab0A3CBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:01:10 -0500
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Move defines around and set up handlers based on MULTI_OMAP2.

Note that this will only allow compiling in omap4 with omap2 and
omap3. It will not yet make omap4 boot with multi-omap.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   38 +++++++++++++++++++++---
 1 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 101ed79..fe3c9ad 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -19,6 +19,8 @@
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
 
+#include <plat/multi.h>
+
 #define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #define OMAP4_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
@@ -31,13 +33,15 @@
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+/*
+ * Unoptimized irq functions for multi-omap2, 3 and 4
+ */
 
+#ifdef MULTI_OMAP2
 		.pushsection .data
 omap_irq_base:	.word	0
 		.popsection
 
-#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_ARCH_OMAP3)
 		/* Configure the interrupt base on the first interrupt */
 		.macro  get_irqnr_preamble, base, tmp
 9:
@@ -62,7 +66,32 @@ omap_irq_base:	.word	0
 		b	9b
 9998:
 		.endm
-#else
+
+		/* Check the pending interrupts. Note that base already set */
+		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
+		cmp	\irqnr, #0x0
+		bne	9999f
+		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
+		cmp	\irqnr, #0x0
+		bne	9999f
+		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
+		cmp	\irqnr, #0x0
+9999:
+		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
+
+		.endm
+
+
+#else	/* MULTI_OMAP2 */
+
+
+/*
+ * Optimized irq functions for omap2, 3 and 4
+ */
+
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		.macro  get_irqnr_preamble, base, tmp
 #ifdef CONFIG_ARCH_OMAP2
 		ldr	\base, =OMAP2_IRQ_BASE
@@ -70,7 +99,7 @@ omap_irq_base:	.word	0
 		ldr	\base, =OMAP3_IRQ_BASE
 #endif
 		.endm
-#endif
+
 		/* Check the pending interrupts. Note that base already set */
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
@@ -155,6 +184,7 @@ omap_irq_base:	.word	0
 		cmp	\tmp, #0
 		.endm
 #endif
+#endif	/* MULTI_OMAP2 */
 
 		.macro	irq_prio_table
 		.endm

