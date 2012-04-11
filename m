From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 02/12] arm: omap3: Only sleep during cpu_idle if I/O wake-ups work
Date: Wed, 11 Apr 2012 12:05:37 -0700
Message-ID: <1334171147-7517-3-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50001 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761119Ab2DKTsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:11 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Currently in the OMAP3 code, cpu_idle() calls pm_idle(),
which is a function pointer set to omap3_pm_idle()).
omap3_pm_idle() calls omap_sram_idle() which eventually
causes a 'wfi' instruction to be executed effectively
putting the system to sleep.  It is assumed that an
I/O wake-up event will occur to wake the system up again.
This doesn't work on systems that don't support I/O wake-ups
(indicated by omap3_has_io_wakeup() returning false).

Leaving pm_idle() pointing to default_idle() won't work
either because the cpu_<processor>_do_idle() routine which
is eventually called may also execute a 'wfi' instruction
(e.g., cpu_v7_do_idle()).

To handle this, leave pm_idle() pointing to omap3_pm_idle()
but add a check in omap3_pm_idle() so it avoids calling
omap_sram_idle() when I/O wake-ups aren't supported.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ec92676..b7bbcee 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -397,7 +397,7 @@ static void omap3_pm_idle(void)
 {
 	local_fiq_disable();
 
-	if (omap_irq_pending())
+	if (omap_irq_pending() || !omap3_has_io_wakeup())
 		goto out;
 
 	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-- 
1.7.9.4

