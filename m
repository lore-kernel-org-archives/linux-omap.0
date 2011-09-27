From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 REPOST 04/24] gpio/omap: fix pwrdm_post_transition call sequence
Date: Tue, 27 Sep 2011 05:44:00 +0530
Message-ID: <1317082460-31706-5-git-send-email-tarun.kanti@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44130 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab1I0AOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 20:14:34 -0400
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

The context lost count is modified in omap_sram_idle() path when
pwrdm_post_transition() is called. But pwrdm_post_transition() is called
only after omap_gpio_resume_after_idle() is called. Correct this so that
context lost count is modified before calling omap_gpio_resume_after_idle().

This would be useful when OMAP GPIO save/restore context is called by
the OMAP GPIO driver itself.

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..1915050 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -363,7 +363,6 @@ void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
-	pwrdm_pre_transition();
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
@@ -386,6 +385,8 @@ void omap_sram_idle(void)
 			if (!console_trylock())
 				goto console_still_active;
 
+	pwrdm_pre_transition();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
@@ -455,6 +456,8 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();
 
+	pwrdm_post_transition();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
@@ -478,8 +481,6 @@ console_still_active:
 		omap3_disable_io_chain();
 	}
 
-	pwrdm_post_transition();
-
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-- 
1.7.0.4

