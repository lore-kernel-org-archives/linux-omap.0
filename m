From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
Date: Thu, 16 Jun 2011 18:42:20 +0530
Message-ID: <1308229940-27025-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40845 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab1FPNMj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 09:12:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

When multiple wakeup sources are defined in a system,
there is a small window, when more than one source
can trigger wakeup interrupt.

In the current implementation, the do-while() loop
can handle all wakeup sources that are recorded when
probing the status register in prcm_interrupt_handler().

When the ISR executes due to next queued wakeup, it
there is nothing to be handled and value of "c" is 0.

The comment in the code, attributing this behavior to
race with IVA2 along with WARN (and associated text)
makes this condition appear as an error condition -
while it isn't.

Though the problem was found in kernel version 2.6.32
running on AM3703 (no IVA2), it is still relevant.

This patch also fixes the comment that attributes current
behavior to race with interrupt handler on IVA2.

Quoting specific instances, on entry into the ISR, the
PM_WKST_WKUP read either 0x00010101 or 0x00010001

Where,
 Bit 0	: ST_GPT1     - GPTIMER wakeup occurred
 Bit 8	: ST_IO_EN    - IO pad wakeup occurred
 Bit 16	: ST_IO_CHAIN - The I/O wake-up scheme is enabled

This time value of "c" is 2 (or 3), but then on next
and immediate entry, value of "c" is 0 leading to WARN().

Another approach I considered was to keep track of the
number of wakeup sources handled in previous execution
of ISR, but it fails when status register indicates 3
wakeup sources.

Downgrading the WARN seemed to be the simplest solution.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 History:
 v1: Original RFC posted:
     http://marc.info/?l=linux-omap&m=130754890807333&w=2
 
 arch/arm/mach-omap2/pm34xx.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c155c9d..d24942b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -289,11 +289,12 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 			c = _prcm_int_handle_wakeup();
 
 			/*
-			 * Is the MPU PRCM interrupt handler racing with the
-			 * IVA2 PRCM interrupt handler ?
+			 * If multiple wakeup events get handled in certain
+			 * execution through this do-while, value of "c" will
+			 * be returned as 0.
 			 */
-			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
-			     "but no wakeup sources are marked\n");
+			if (c == 0)
+				pr_debug ("prcm: no more wakeup event to handle") ;
 		} else {
 			/* XXX we need to expand our PRCM interrupt handler */
 			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
-- 
1.7.2.2

