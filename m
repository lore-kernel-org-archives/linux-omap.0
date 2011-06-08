From: Sanjeev Premi <premi@ti.com>
Subject: [RFC] omap3: pm: Downgrade WARN for no wakeup source
Date: Wed, 8 Jun 2011 21:31:24 +0530
Message-ID: <1307548884-10343-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57568 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756608Ab1FHQBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 12:01:31 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p58G1SlZ029447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 8 Jun 2011 11:01:30 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p58G1RBf000813
	for <linux-omap@vger.kernel.org>; Wed, 8 Jun 2011 21:31:27 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
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

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
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

