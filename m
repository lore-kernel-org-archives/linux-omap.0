From: Rick Bronson <rick@efn.org>
Subject: Re: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Wed, 22 Oct 2008 20:29:48 -0700
Message-ID: <E1KsqtQ-0005Xb-EV@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:57158 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYJWD3u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 23:29:50 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 49DCC170018
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 20:29:49 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KsqtQ-0005Xb-EV
	for linux-omap@vger.kernel.org; Wed, 22 Oct 2008 20:29:48 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tony,

  Here is the patch against the latest git.  I'm a little concerned
about masking the interrupt number so that the spurious bit are
ignored.  Do you really want to turn a spurious interrupt into a
normal (good) interrupt?

> Also, AFAIK we don't have infinitely repeating irqs any longer, it's
> just an occasional single spurious interrupt.

  That's correct.  And those disappeared when I applied the S-O patch.
Without the S-O patch I was seeing one spurious interrupt in about 15
reboots, after the patch I got zero in 350 reboots.

  Rick

--- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.git	2008-10-22 20:01:33.000000000 -0700
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-22 20:11:26.000000000 -0700
@@ -67,6 +67,10 @@
 
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
+#define INTCPS_CONTROL		0x0048		/* new interrupt agreement bits */
+#define INTCPS_PENDING_IRQ_1	0x0098		/* IRQ pending reg 1 */
+#define INTCPS_PENDING_IRQ_2	0x00b8		/* IRQ pending reg 2 */
+#define INTCPS_PENDING_IRQ_3	0x00d8		/* IRQ pending reg 3 */
 
 		.macro	disable_fiq
 		.endm
@@ -79,18 +83,20 @@
 
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
-2222:
-		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		cmp	\irqnr, #0  /* check for negative */
+		movmi	\tmp, #0x1 /* Ack the spurious irq, this lets it
+					* generate a bad irq error message,
+					* but prevents infinitely repeating
+					* irq.
+					*/
+		strmi	\tmp, [\base, #INTCPS_CONTROL]
 		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
-
