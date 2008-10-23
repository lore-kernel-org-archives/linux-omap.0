From: Rick Bronson <rick@efn.org>
Subject: Re: ALSA sound on beagleboard
Date: Thu, 23 Oct 2008 10:39:52 -0700
Message-ID: <E1Kt4A4-0003OH-R7@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:58516 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbYJWRjy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 13:39:54 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id B738B17006B
	for <linux-omap@vger.kernel.org>; Thu, 23 Oct 2008 10:39:53 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1Kt4A4-0003OH-R7
	for linux-omap@vger.kernel.org; Thu, 23 Oct 2008 10:39:52 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tony,

  I checked out some other ARM spurious interrupt handling and it
seems that they ack the interrupt but left the macro with the Z bit
set which means that asm_do_IRQ() does not get called.  Seems to me we
should do the same, see the patch below.  Although, ideally, we should
be logging these.  Is there a mechanism for doing this?

> Are these defines above still needed?

  Yes.

  BTW, I haven't checked this patch so don't do anything with it, just
comment on it ;-)

 Rick

--- linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S.git	2008-10-22 20:01:33.000000000 -0700
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/entry-macro.S	2008-10-23 10:25:57.000000000 -0700
@@ -66,7 +66,11 @@
 #endif
 
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
-#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
+#define INTCPS_CONTROL		0x0048		/* new interrupt agreement bits offset */
+#define INTCPS_CONTROL_NEWIRQAGR 0x0001		/* Reset IRQ output and enable new IRQ generation */
+#define INTCPS_PENDING_IRQ_1	0x0098		/* IRQ pending reg 1 */
+#define INTCPS_PENDING_IRQ_2	0x00b8		/* IRQ pending reg 2 */
+#define INTCPS_PENDING_IRQ_3	0x00d8		/* IRQ pending reg 3 */
 
 		.macro	disable_fiq
 		.endm
@@ -79,18 +83,18 @@
 
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
-		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
-
+		ldr	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		mvn	\tmp, \irqnr  /* flip MSBit */
+		bics	\tmp, #0x80000000  /* test MSBit */
+		moveq	\tmp, #INTCPS_CONTROL_NEWIRQAGR /* Ack the spurious irq */
+		streq	\tmp, [\base, #INTCPS_CONTROL]
+		beq	2223f  /* if we got a spurious interrupt, ignore it */
+		ldr	\irqstat, [\base, #INTCPS_PENDING_IRQ_1] /* IRQ pending reg 1 */
+		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_2] /* IRQ pending reg 2 */
+		orr	\irqstat, \irqstat, \tmp  /* or them all together */
+		ldr	\tmp, [\base, #INTCPS_PENDING_IRQ_3] /* IRQ pending reg 3 */
+		orrs	\irqstat, \irqstat, \tmp  /* clear condition code Z if interrupt */
+2223:
 		.endm
 
 		.macro	irq_prio_table
