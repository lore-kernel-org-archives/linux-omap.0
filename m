From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq
Date: Fri, 13 Aug 2010 11:02:10 +0300
Message-ID: <20100813080210.18750.68209.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52514 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0HMICN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 04:02:13 -0400
In-Reply-To: <20100813080034.18750.15410.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we get the following error when enabling CONFIG_SMP
for omap3_defconfig:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq r0,r6,r5,lr'

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 50fd749..06e64e1 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -177,7 +177,10 @@ omap_irq_base:	.word	0
 		cmpne   \irqnr, \tmp
 		cmpcs   \irqnr, \irqnr
 		.endm
+#endif
+#endif	/* MULTI_OMAP2 */
 
+#ifdef CONFIG_SMP
 		/* We assume that irqstat (the raw value of the IRQ acknowledge
 		 * register) is preserved from the macro above.
 		 * If there is an IPI, we immediately signal end of interrupt
@@ -205,8 +208,7 @@ omap_irq_base:	.word	0
 		streq	\irqstat, [\base, #GIC_CPU_EOI]
 		cmp	\tmp, #0
 		.endm
-#endif
-#endif	/* MULTI_OMAP2 */
+#endif	/* CONFIG_SMP */
 
 		.macro	irq_prio_table
 		.endm

