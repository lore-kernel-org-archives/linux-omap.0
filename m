From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] omap2/3/4: Allow booting omap4 with multi-omap
	configuration
Date: Fri, 29 Jan 2010 18:01:34 -0800
Message-ID: <20100130020134.10590.76835.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49390 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0A3CBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:01:12 -0500
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Allow booting omap4 with multi-omap configuration.

Tested only on omap2 and omap3, please somebody test
on omap4 and ack.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   36 +++++++++++++++++++-----
 1 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index fe3c9ad..ff25c7e 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -48,14 +48,18 @@ omap_irq_base:	.word	0
 		ldr	\base, =omap_irq_base	@ irq base address
 		ldr	\base, [\base, #0]	@ irq base value
 		cmp	\base, #0		@ already configured?
-		bne	9998f			@ nothing to do
+		bne	9997f			@ nothing to do
 
 		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
 		and	\tmp, \tmp, #0x000f0000	@ only check architecture
 		cmp	\tmp, #0x00060000	@ is v6?
 		beq	2400f			@ found v6 so it's omap24xx
-		cmp	\tmp, #0x000f0000	@ is cortex?
-		beq	3400f			@ found v7 so it's omap34xx
+		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
+		and	\tmp, \tmp, #0x000000f0	@ check cortex 8 or 9
+		cmp	\tmp, #0x00000080	@ cortex A-8?
+		beq	3400f			@ found A-8 so it's omap34xx
+		cmp	\tmp, #0x00000090	@ cortex A-9?
+		beq	4400f			@ found A-9 so it's omap44xx
 2400:		ldr	\base, =OMAP2_IRQ_BASE
 		ldr	\tmp, =omap_irq_base
 		str	\base, [\tmp, #0]
@@ -64,23 +68,41 @@ omap_irq_base:	.word	0
 		ldr	\tmp, =omap_irq_base
 		str	\base, [\tmp, #0]
 		b	9b
-9998:
+4400:		ldr	\base, =OMAP4_IRQ_BASE
+		ldr	\tmp, =omap_irq_base
+		str	\base, [\tmp, #0]
+		b	9b
+9997:
 		.endm
 
 		/* Check the pending interrupts. Note that base already set */
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+		tst	\base, #0x100		@ gic address?
+		bne	4401f			@ found gic
+
+		/* Handle omap2 and omap3 */
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
 		cmp	\irqnr, #0x0
-		bne	9999f
+		bne	9998f
 		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
 		cmp	\irqnr, #0x0
-		bne	9999f
+		bne	9998f
 		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
 		cmp	\irqnr, #0x0
-9999:
+9998:
 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
 		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
+		b	9999f
 
+		/* Handle omap4 */
+4401:		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
+		ldr     \tmp, =1021
+		bic     \irqnr, \irqstat, #0x1c00
+		cmp     \irqnr, #29
+		cmpcc   \irqnr, \irqnr
+		cmpne   \irqnr, \tmp
+		cmpcs   \irqnr, \irqnr
+9999:
 		.endm
 
 

