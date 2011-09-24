From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 23/24] OMAP3: CPUidle: Make use of CPU PM notifiers
Date: Sat, 24 Sep 2011 11:44:43 +0530
Message-ID: <1316844884-21700-24-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39757 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab1IXGPV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:21 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Save VFP CPU context using CPU PM notifier chain. VFP context
is lost when CPU hits OFF state.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..861920a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
@@ -118,9 +119,23 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
 	}
 
+	/*
+	 * Call idle CPU PM enter notifier chain so that
+	 * VFP context is saved.
+	 */
+	if (mpu_state == PWRDM_POWER_OFF)
+		cpu_pm_enter();
+
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
+	/*
+	 * Call idle CPU PM enter notifier chain to restore
+	 * VFP context.
+	 */
+	if (pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
+		cpu_pm_exit();
+
 	/* Re-allow idle for C1 */
 	if (state == &dev->states[0]) {
 		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
-- 
1.7.4.1

