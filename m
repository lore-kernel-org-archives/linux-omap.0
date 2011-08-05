From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] OMAP2: PM debug: remove leftover debug code
Date: Fri,  5 Aug 2011 15:15:58 +0200
Message-ID: <1312550158-4553-1-git-send-email-michael.jones@matrix-vision.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:42373 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab1HENQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 09:16:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>

commit 20d5d5514981f9a68832bffb27a698545ecba77a left some code
lying around which doesn't do anything. Clean it up.

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---

It looks to me like if you remove the register dump, the debug if's
don't do anything at all.

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
