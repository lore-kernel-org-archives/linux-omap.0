From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] omap2/3/4: Clean up defines for entry-macro.S
Date: Fri, 29 Jan 2010 18:01:27 -0800
Message-ID: <20100130020127.10590.67010.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49306 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab0A3CBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:01:05 -0500
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Define the irq base the same way as for omap2 and omap3,
and start using get_irqnr_preamble.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 4fd6b1b..3e63aaa 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -19,6 +19,12 @@
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
 
+#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP4_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
+#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
+#define	ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
+
 		.macro	disable_fiq
 		.endm
 
@@ -27,11 +33,6 @@
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
-#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
-#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
-#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
-
 		.pushsection .data
 omap_irq_base:	.word	0
 		.popsection
@@ -90,8 +91,6 @@ omap_irq_base:	.word	0
 
 #ifdef CONFIG_ARCH_OMAP4
 
-#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
-
 		.macro  get_irqnr_preamble, base, tmp
 		.endm
 
@@ -115,7 +114,7 @@ omap_irq_base:	.word	0
 		 * valid range for an IRQ (30-1020 inclusive).
 		 */
 		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr     \base, =OMAP44XX_VA_GIC_CPU_BASE
+		ldr     \base, =OMAP4_IRQ_BASE
 		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
 
 		ldr     \tmp, =1021

