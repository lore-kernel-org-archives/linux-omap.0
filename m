From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 1/4] ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
Date: Fri, 20 Jul 2012 11:34:41 +0530
Message-ID: <1342764284-8143-2-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2GTGFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 02:05:33 -0400
In-Reply-To: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>

We do not support MPU OSWR on OMAP3. Get rid of the complex/multiple
save_state handling in omap_sram_idle() and just use 2 save_state
definitions

save_state = 1, all logic and memory lost, MPU hits OFF
save_state = 0, nothing lost, MPU hits CSWR or shallower state

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c    |   35 +++++++++--------------------------
 arch/arm/mach-omap2/sleep34xx.S |    4 +---
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7c7b173..8d96b1f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -256,19 +256,16 @@ static void omap34xx_save_context(u32 *save)
 
 static int omap34xx_do_sram_idle(unsigned long save_state)
 {
+	/*
+	 * save_state = 1 indicates all logic and memory/cache lost
+	 * save_state = 0 indicates nothing lost
+	 */
 	omap34xx_cpu_suspend(save_state);
 	return 0;
 }
 
 void omap_sram_idle(void)
 {
-	/* Variable to tell what needs to be saved and restored
-	 * in omap_sram_idle*/
-	/* save_state = 0 => Nothing to save and restored */
-	/* save_state = 1 => Only L1 and logic lost */
-	/* save_state = 2 => Only L2 lost */
-	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0;
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
@@ -277,20 +274,6 @@ void omap_sram_idle(void)
 	u32 sdrc_pwr = 0;
 
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
-	switch (mpu_next_state) {
-	case PWRDM_POWER_ON:
-	case PWRDM_POWER_RET:
-		/* No need to save context */
-		save_state = 0;
-		break;
-	case PWRDM_POWER_OFF:
-		save_state = 3;
-		break;
-	default:
-		/* Invalid state */
-		pr_err("Invalid mpu state in sram_idle\n");
-		return;
-	}
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
@@ -342,12 +325,12 @@ void omap_sram_idle(void)
 	 * get saved. The rest is placed on the stack, and restored
 	 * from there before resuming.
 	 */
-	if (save_state)
+	if (mpu_next_state == PWRDM_POWER_OFF) {
 		omap34xx_save_context(omap3_arm_context);
-	if (save_state == 1 || save_state == 3)
-		cpu_suspend(save_state, omap34xx_do_sram_idle);
-	else
-		omap34xx_do_sram_idle(save_state);
+		cpu_suspend(1, omap34xx_do_sram_idle);
+	} else {
+		omap34xx_do_sram_idle(0);
+	}
 
 	/* Restore normal SDRC POWER settings */
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 1f62f23..a4d04a4 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -157,9 +157,7 @@ ENTRY(omap34xx_cpu_suspend)
 	/*
 	 * r0 contains information about saving context:
 	 *   0 - No context lost
-	 *   1 - Only L1 and logic lost
-	 *   2 - Only L2 lost (Even L1 is retained we clean it along with L2)
-	 *   3 - Both L1 and L2 lost and logic lost
+	 *   1 - Both L1 and L2 lost and logic lost
 	 */
 
 	/*
-- 
1.7.1

