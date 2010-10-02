From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap3: Restore the powerdomian states post wfi in omap_sram_idle
Date: Sat,  2 Oct 2010 15:13:10 +0530
Message-ID: <1286012590-1013-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850Ab0JBJnS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Oct 2010 05:43:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Restore the mpu, neon per and core power domain states to ON otherwise
power domain can transition to already programmed low power state
while issuing WFI outside the idle thread when dependencies are met.
On HS/EMU devices, mpu can do WFI as part of secure code execution
like waiting on DMA interrupt or waiting for encryption to be done etc.
This can result in undesired power domain transition if the power
state control is not restored from previously programmed OFF/RET
state as part of cpuidle. This patch addresses the restore need post
wfi

While doing this patch, I came across a deadlock in cpudile when OFF mode
is enabled. This was mainly happening because an invalid per and core power
domain states getting programmed with above restore change. The per is
never getting programmed explicitly. When you enable "enable_off_mode", all
power domains including per are set to OFF mode once for all. Since I
was restoring the per to ON state post idle, in the next idle iteration,
per ON and core OFF was getting programmed. And this was leading
to the deadlock.
To avoid such problems, this patch programs the per state explicitly
before wfi based on the idle settings

There is a thread going on to move the device idle code from cpuidle
but the per power domain change in this patch still not following that
suggestion. Ofcourse this code change will get moved together with
other device idle code eventually once that happens

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
The patch applies against Kevin's pm branch. It's tested both suspend
and cpuidle path on OMAP3630 ZOOM board
 arch/arm/mach-omap2/cpuidle34xx.c |   11 +++++++++++
 arch/arm/mach-omap2/pm34xx.c      |   17 +++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 8ea012e..54a8c27 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -267,6 +267,17 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	}
 
 	/*
+	 * Program PER explicitly like core to avoid any unsupported
+	 * PER/CORE combination which can lead to deadlock
+	 */
+	if (sleep_while_idle) {
+		if (enable_off_mode)
+			pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_OFF);
+		else
+			pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_RET);
+	}
+
+	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 570ce1d..ca5fb12 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -455,6 +455,23 @@ void omap_sram_idle(void)
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
 
+	/*
+	 * Restore the mpu, neon per and core power domain
+	 * states to ON otherwise power domain can transition
+	 * to already programmed low power state while issuing WFI
+	 * outside the idle thread when dependencies are met.
+	 * On HS/EMU devices, mpu can do WFI as part of secure code
+	 * execution like waiting on DMA interrupt or waiting for
+	 * encryption to be done etc.
+	 * This can result in undesired power domain transition
+	 * if the power state control is not restored from
+	 * previously programmed OFF/RET stated as part of cpuidle.
+	 */
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
+	pwrdm_set_next_pwrst(neon_pwrdm, PWRDM_POWER_ON);
+	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
+	pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_ON);
+
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-- 
1.6.0.4

