From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP: Fix get_irqnr_and_base to clear spurious interrupt bits
Date: Thu, 30 Oct 2008 19:11:17 -0700
Message-ID: <1225419078-32213-4-git-send-email-tony@atomide.com>
References: <1225419078-32213-1-git-send-email-tony@atomide.com>
 <1225419078-32213-2-git-send-email-tony@atomide.com>
 <1225419078-32213-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54063 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbYJaCLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:11:25 -0400
In-Reply-To: <1225419078-32213-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

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
---
 arch/arm/plat-omap/include/mach/entry-macro.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 030118e..2276f89 100644
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
 
-- 
1.5.6.rc3.21.g8c6b5

