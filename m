From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 15:51:45 +0100
Message-ID: <1290091906-32539-2-git-send-email-j-pihet@ti.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38000 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668Ab0KROwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 09:52:46 -0500
Received: by wyb28 with SMTP id 28so3314898wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 06:52:45 -0800 (PST)
In-Reply-To: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Kevin Hillman <khilman@deeprootsystems.com>, Jean Pihet <j-pihet@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

For historical reasons the OMAP3 sleep code is run from SRAM.
This code can run from DDR which provides better performance and
leaves the SRAM available for other uses.

Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
with full RET and OFF modes.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Kevin Hillman <khilman@deeprootsystems.com>

Changed the commit comments.

Cc: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 75c0cd1..035ca47 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -65,8 +65,6 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-static void (*_omap_sram_idle)(u32 *addr, int save_state);
-
 static int (*_omap_save_secure_sram)(u32 *addr);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
@@ -346,9 +344,6 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 
-	if (!_omap_sram_idle)
-		return;
-
 	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
 	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
@@ -422,7 +417,7 @@ void omap_sram_idle(void)
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
 	 */
-	_omap_sram_idle(omap3_arm_context, save_state);
+	omap34xx_cpu_suspend(omap3_arm_context, save_state);
 	cpu_init();
 
 	/* Restore normal SDRC POWER settings */
@@ -972,8 +967,6 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 
 void omap_push_sram_idle(void)
 {
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					omap34xx_cpu_suspend_sz);
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
 		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
 				save_secure_ram_context_sz);
-- 
1.7.2.3

