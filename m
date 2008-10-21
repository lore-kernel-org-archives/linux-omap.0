From: Tony Lindgren <tony@atomide.com>
Subject: ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Mon, 20 Oct 2008 21:58:10 -0700
Message-ID: <20081021045809.GJ7341@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PPYy/fEw/8QCHSq3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56349 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYJUE6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 00:58:13 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nathan Monson <nmonson@gmail.com>, lauri.leukkunen@nokia.com, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Rick Bronson <rick@efn.org>


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Here's a bug fix for the irq -33 issue. So far it looks like the irq
spurious bits just tell that the irq sorting is invalid.

This patch applies after undoing Lauri's patch
5dc857b34441d5c0989b68bf3a488f89983b2645.

Looks like there are still occasional spurious GPT12 interrupts, so
I'm now looking into that.

Regards,

Tony

--PPYy/fEw/8QCHSq3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0003-ARM-OMAP3-Fix-get_irqnr_and_base-to-clear-spurious-v2.patch"

commit 3e4291d575f7d694ae1d974a17b4e077b7b721de
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Oct 20 14:04:52 2008 -0700

    ARM: OMAP3: Fix get_irqnr_and_base to clear spurious interrupt bits
    
    On omap24xx, INTCPS_SIR_IRQ_OFFSET bits [6:0] contains the current
    active interrupt number.
    
    However, on 34xx INTCPS_SIR_IRQ_OFFSET bits [31:7] also contains the
    SPURIOUSIRQFLAG, which gets set if the interrupt sorting information
    is invalid.
    
    If the SPURIOUSIRQFLAG bits are not ignored, the interrupt code will
    occasionally produce a bunch of confusing errors:
    
    irq -33, desc: c02ddcc8, depth: 0, count: 0, unhandled: 0
    ->handle_irq():  c006f23c, handle_bad_irq+0x0/0x22c
    ->chip(): 00000000, 0x0
    ->action(): 00000000
    
    Fix this by masking out only the ACTIVEIRQ bits. Also fix a
    confusing comment.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index a8fca9d..47aa62c 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -65,7 +65,8 @@
 #include <mach/omap34xx.h>
 #endif
 
-#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt number */
+#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
+#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
 
 		.macro	disable_fiq
 		.endm
@@ -88,6 +89,7 @@
 		cmp	\irqnr, #0x0
 2222:
 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
 
 		.endm
 

--PPYy/fEw/8QCHSq3--
