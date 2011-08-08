From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH v2] OMAP2: PM debug: remove leftover debug code
Date: Mon,  8 Aug 2011 09:46:20 +0200
Message-ID: <1312789580-10007-1-git-send-email-michael.jones@matrix-vision.de>
References: <87bow3uc4p.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.matrix-vision.com ([78.47.19.71]:34971 "EHLO
	mail1.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab1HHHrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 03:47:01 -0400
In-Reply-To: <87bow3uc4p.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

commit 20d5d5514981f9a68832bffb27a698545ecba77a (OMAP2: PM debug:
remove register dumping) left some code lying around which doesn't
do anything. Clean it up.

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
Changes for v2:
- included short log text of the commit referenced in commit message

 arch/arm/mach-omap2/pm24xx.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bf089e7..cf0c216 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -53,8 +53,6 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 
-static int omap2_pm_debug;
-
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
 static inline bool is_suspending(void)
@@ -96,7 +94,6 @@ static int omap2_fclks_active(void)
 static void omap2_enter_full_retention(void)
 {
 	u32 l;
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 
 	/* There is 1 reference hold for all children of the oscillator
 	 * clock, the following will remove it. If no one else uses the
@@ -124,10 +121,6 @@ static void omap2_enter_full_retention(void)
 
 	omap2_gpio_prepare_for_idle(0);
 
-	if (omap2_pm_debug) {
-		getnstimeofday(&ts_preidle);
-	}
-
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
 	if (omap_irq_pending())
@@ -155,13 +148,6 @@ static void omap2_enter_full_retention(void)
 		console_unlock();
 
 no_sleep:
-	if (omap2_pm_debug) {
-		unsigned long long tmp;
-
-		getnstimeofday(&ts_postidle);
-		ts_idle = timespec_sub(ts_postidle, ts_preidle);
-		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
-	}
 	omap2_gpio_resume_after_idle();
 
 	clk_enable(osc_ck);
@@ -219,7 +205,6 @@ static int omap2_allow_mpu_retention(void)
 static void omap2_enter_mpu_retention(void)
 {
 	int only_idle = 0;
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 
 	/* Putting MPU into the WFI state while a transfer is active
 	 * seems to cause the I2C block to timeout. Why? Good question. */
@@ -246,19 +231,7 @@ static void omap2_enter_mpu_retention(void)
 		only_idle = 1;
 	}
 
-	if (omap2_pm_debug) {
-		getnstimeofday(&ts_preidle);
-	}
-
 	omap2_sram_idle();
-
-	if (omap2_pm_debug) {
-		unsigned long long tmp;
-
-		getnstimeofday(&ts_postidle);
-		ts_idle = timespec_sub(ts_postidle, ts_preidle);
-		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
-	}
 }
 
 static int omap2_can_sleep(void)
-- 
1.7.6


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
