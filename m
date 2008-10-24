From: Rick Bronson <rick@efn.org>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Thu, 23 Oct 2008 21:14:08 -0700
Message-ID: <E1KtE3s-0006eE-Ri@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:52208 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbYJXEOJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2008 00:14:09 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 0416C170069
	for <linux-omap@vger.kernel.org>; Thu, 23 Oct 2008 21:14:09 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KtE3s-0006eE-Ri
	for linux-omap@vger.kernel.org; Thu, 23 Oct 2008 21:14:08 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tony,

  How does this look?

  If we set irq to NR_IRQS then arch/arm/kernel/irq.c will use
bad_irq_desc when it processes the interrupt.  NOTE: I haven't tested
this yet.

  Rick


--- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.git	2008-10-22 20:01:33.000000000 -0700
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-23 21:12:29.000000000 -0700
@@ -66,7 +66,8 @@
 #endif
 
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
-#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
+#define INTCPS_CONTROL		0x0048		/* new interrupt agreement bits */
+#define INTCPS_CONTROL_NEWIRQAGR 0x0001		/* Reset IRQ output and enable new IRQ generation */
 
 		.macro	disable_fiq
 		.endm
@@ -79,18 +80,13 @@
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =OMAP2_VA_IC_BASE
-		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
-		cmp	\irqnr, #0x0
-		bne	2222f
-		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
-		cmp	\irqnr, #0x0
-		bne	2222f
-		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
-		cmp	\irqnr, #0x0
+		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]  /* NOTE: range is 0-0x5f and 0ffffff80 to 0xffffffdf */
+		adds	\tmp, \irqnr, #1 /* change from zero based to 1 based so we clear Z */
+		bpl	2222f  /* if no spurious interrupt */
+		mov	\tmp, #INTCPS_CONTROL_NEWIRQAGR /* Ack the spurious irq */
+		str	\tmp, [\base, #INTCPS_CONTROL]
+		movw	\irqnr, #NR_IRQS /* set to NR_IRQS so that bad_irq_desc() get's called */
 2222:
-		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
-		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
-
 		.endm
 
 		.macro	irq_prio_table
