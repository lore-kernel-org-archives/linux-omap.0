From: Rick Bronson <rick@efn.org>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Tue, 28 Oct 2008 09:10:06 -0700
Message-ID: <E1Kur8w-0000c8-IR@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:43749 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbYJ1QKO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Oct 2008 12:10:14 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 5D74A1700EF
	for <linux-omap@vger.kernel.org>; Tue, 28 Oct 2008 09:10:12 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1Kur8w-0000c8-IR
	for linux-omap@vger.kernel.org; Tue, 28 Oct 2008 09:10:06 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tony,

  The last patch I posted didn't work quite right.  It seems we do
actually come into this macro with none of the pending bits set.
Presumably, because the interrupt hasn't been ack'd yet.  Anyway, I've
tested this patch and I think it's golden.  It ack's spurious
interrupts and lets the user know that one has occured by setting irq
to NR_IRQS then arch/arm/kernel/irq.c will use bad_irq_desc when it
processes the interrupt.  This message get's printed upon spurious
interrupt:

->handle_irq():  c0073448, handle_bad_irq+0x0/0x228                             
->chip(): 00000000, 0x0                                                         
->action(): 00000000                                                            

  The only bad thing is that it doesn't notify the user WHICH spurious
interrupt happened.  Any ideas on solving that?

  Rick

--- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.git	2008-10-22 20:01:33.000000000 -0700
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-27 08:41:08.000000000 -0700
@@ -66,7 +66,11 @@
 #endif
 
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
-#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
+#define INTCPS_CONTROL		0x0048		/* new interrupt agreement bits */
+#define INTCPS_PENDING_IRQ_1	0x0098		/* IRQ pending reg 1 */
+#define INTCPS_PENDING_IRQ_2	0x00b8		/* IRQ pending reg 2 */
+#define INTCPS_PENDING_IRQ_3	0x00d8		/* IRQ pending reg 3 */
+#define INTCPS_CONTROL_NEWIRQAGR 0x0001		/* Reset IRQ output and enable new IRQ generation */
 
 		.macro	disable_fiq
 		.endm
@@ -79,18 +83,19 @@
 
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
+		ldr	\irqstat, [\base, #INTCPS_PENDING_IRQ_1] /* IRQ pending reg 1 */
+		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_2] /* IRQ pending reg 2 */
+		orr	\irqstat, \irqstat, \tmp  /* or them all together */
+		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_3] /* IRQ pending reg 3 */
+		orrs	\irqstat, \irqstat, \tmp  /* set condition code Z if interrupt */
+		beq	2222f  /* if there are no interrupt bits set, leave with Z=1 */
+		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		adds	\tmp, \irqnr, #1 /* change from zero based to 1 based so we clear Z */
+		bpl	2222f  /* if no spurious interrupt */
+		mov	\tmp, #INTCPS_CONTROL_NEWIRQAGR /* Ack the spurious irq	*/
+		str	\tmp, [\base, #INTCPS_CONTROL]
+		movw	\irqnr, #NR_IRQS /* set to NR_IRQS so that bad_irq_desc() get's called */
 2222:
-		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
-		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
-
 		.endm
 
 		.macro	irq_prio_table
