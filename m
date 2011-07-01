From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 04/20] GPIO: OMAP: Fix pwrdm_post_transition call sequence
Date: Fri, 1 Jul 2011 15:16:58 +0530
Message-ID: <1309513634-20971-5-git-send-email-tarun.kanti@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53456 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab1GAJrZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 05:47:25 -0400
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

The context lost count is modified in omap_sram_idle() path when
pwrdm_post_transition() is called. But pwrdm_post_transition() is called
only after omap_gpio_resume_after_idle() is called. Correct this so that
context lost count is modified before calling omap_gpio_resume_after_idle().

This would be useful when OMAP GPIO save/restore context is called by
the OMAP GPIO driver itself.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c155c9d..51d5a5c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -375,7 +375,6 @@ void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
-	pwrdm_pre_transition();
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
@@ -398,6 +397,8 @@ void omap_sram_idle(void)
 			if (!console_trylock())
 				goto console_still_active;
 
+	pwrdm_pre_transition();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
@@ -467,6 +468,8 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();
 
+	pwrdm_post_transition();
+
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
@@ -490,8 +493,6 @@ console_still_active:
 		omap3_disable_io_chain();
 	}
 
-	pwrdm_post_transition();
-
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-- 
1.6.0.4

