From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 25/25] OMAP3: CPUidle: Make use of CPU PM notifiers
Date: Sun, 4 Sep 2011 19:24:26 +0530
Message-ID: <1315144466-9395-26-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab1IDN4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 09:56:17 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

These notifiers can be used to isolate non-cpu specific PM
code from CPU idle code.

To start with, we can already leverage VFP handlers using notifier
chain for low power idle code. So use them.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..1112519 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
@@ -118,9 +119,15 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
 	}
 
+	if (mpu_state == PWRDM_POWER_OFF)
+		cpu_pm_enter();
+
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
+	if (pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
+		cpu_pm_exit();
+
 	/* Re-allow idle for C1 */
 	if (state == &dev->states[0]) {
 		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
-- 
1.7.4.1

