From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Fri, 24 Sep 2010 16:17:18 +0530
Message-ID: <1285325239-6110-2-git-send-email-vishwanath.bs@ti.com>
References: <1285325239-6110-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48648 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab0IXKtk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 06:49:40 -0400
In-Reply-To: <1285325239-6110-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Kevin Hillman <khilman@deeprootsystems.com>

There is no need to keep omap3 sleep code in SRAM. This code can be run very
well on DDR. This would help us to instrument CPUIdle latencies.

Tested on ZOOM3.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Kevin Hillman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 85ef245..ed9d12c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -79,8 +79,6 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-static void (*_omap_sram_idle)(u32 *addr, int save_state);
-
 static int (*_omap_save_secure_sram)(u32 *addr);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
@@ -360,9 +358,6 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 
-	if (!_omap_sram_idle)
-		return;
-
 	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
 	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
@@ -438,7 +433,7 @@ void omap_sram_idle(void)
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
 	 */
-	_omap_sram_idle(omap3_arm_context, save_state);
+	omap34xx_cpu_suspend(omap3_arm_context, save_state);
 	cpu_init();
 
 	if (is_suspending())
@@ -995,8 +990,6 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 
 void omap_push_sram_idle(void)
 {
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					omap34xx_cpu_suspend_sz);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
 		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
 				save_secure_ram_context_sz);
-- 
1.7.0.4

