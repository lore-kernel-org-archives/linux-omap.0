From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O wake-ups work
Date: Wed, 11 Apr 2012 12:05:38 -0700
Message-ID: <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:49980 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761118Ab2DKTsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:11 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Currently, the OMAP3 cpuidle driver calls omap3_enter_idle()
which calls omap_sram_idle().  omap_sram_idle() eventually
causes a 'wfi' instruction to be executed effectively putting
the system to sleep.  It is assumed that an I/O wake-up event
will occur to wake the system up again.  This doesn't work on
systems that don't support I/O wake-ups (indicated by
omap3_has_io_wakeup() returning false).

To handle this, follow the same path in omap3_enter_idle()
that would be followed if an interrupt were pending.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5358664..12cf81d 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -100,7 +100,7 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
-	if (omap_irq_pending() || need_resched())
+	if (omap_irq_pending() || need_resched() || !omap3_has_io_wakeup())
 		goto return_sleep_time;
 
 	/* Deny idle for C1 */
-- 
1.7.9.4

