From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/6] ARM: OMAP3xxx: CPUIdle: simplify the PER next-state code
Date: Fri, 23 Nov 2012 20:42:36 -0700
Message-ID: <20121124034235.24638.52997.stgit@dusk.lan>
References: <20121124033809.24638.11090.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57023 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab2KXDoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 22:44:16 -0500
In-Reply-To: <20121124033809.24638.11090.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>

The OMAP3xxx CPUIdle driver contains some code to place a lower bound
on the PER powerdomain's power state.  Convert this code to a data-driven
implementation to remove branches and to improve readability.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   44 +++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index bca7a88..0067467 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -36,38 +36,51 @@
 
 /* Mach specific information to be recorded in the C-state driver_data */
 struct omap3_idle_statedata {
-	u32 mpu_state;
-	u32 core_state;
+	u8 mpu_state;
+	u8 core_state;
+	u8 per_min_state;
 };
 
+/*
+ * Prevent PER OFF if CORE is not in RETention or OFF as this would
+ * disable PER wakeups completely.
+ */
 static struct omap3_idle_statedata omap3_idle_data[] = {
 	{
 		.mpu_state = PWRDM_POWER_ON,
 		.core_state = PWRDM_POWER_ON,
+		/* In C1 do not allow PER state lower than CORE state */
+		.per_min_state = PWRDM_POWER_ON,
 	},
 	{
 		.mpu_state = PWRDM_POWER_ON,
 		.core_state = PWRDM_POWER_ON,
+		.per_min_state = PWRDM_POWER_RET,
 	},
 	{
 		.mpu_state = PWRDM_POWER_RET,
 		.core_state = PWRDM_POWER_ON,
+		.per_min_state = PWRDM_POWER_RET,
 	},
 	{
 		.mpu_state = PWRDM_POWER_OFF,
 		.core_state = PWRDM_POWER_ON,
+		.per_min_state = PWRDM_POWER_RET,
 	},
 	{
 		.mpu_state = PWRDM_POWER_RET,
 		.core_state = PWRDM_POWER_RET,
+		.per_min_state = PWRDM_POWER_OFF,
 	},
 	{
 		.mpu_state = PWRDM_POWER_OFF,
 		.core_state = PWRDM_POWER_RET,
+		.per_min_state = PWRDM_POWER_OFF,
 	},
 	{
 		.mpu_state = PWRDM_POWER_OFF,
 		.core_state = PWRDM_POWER_OFF,
+		.per_min_state = PWRDM_POWER_OFF,
 	},
 };
 
@@ -207,10 +220,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv,
 			       int index)
 {
-	int new_state_idx;
-	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
+	int new_state_idx, ret;
+	u8 per_next_state, per_saved_state;
 	struct omap3_idle_statedata *cx;
-	int ret;
 
 	/*
 	 * Use only C1 if CAM is active.
@@ -231,25 +243,13 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 
 	/* Program PER state */
 	cx = &omap3_idle_data[new_state_idx];
-	core_next_state = cx->core_state;
-	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
-	if (new_state_idx == 0) {
-		/* In C1 do not allow PER state lower than CORE state */
-		if (per_next_state < core_next_state)
-			per_next_state = core_next_state;
-	} else {
-		/*
-		 * Prevent PER OFF if CORE is not in RETention or OFF as this
-		 * would disable PER wakeups completely.
-		 */
-		if ((per_next_state == PWRDM_POWER_OFF) &&
-		    (core_next_state > PWRDM_POWER_RET))
-			per_next_state = PWRDM_POWER_RET;
-	}
 
-	/* Are we changing PER target state? */
-	if (per_next_state != per_saved_state)
+	per_next_state = pwrdm_read_next_pwrst(per_pd);
+	per_saved_state = per_next_state;
+	if (per_next_state < cx->per_min_state) {
+		per_next_state = cx->per_min_state;
 		pwrdm_set_next_pwrst(per_pd, per_next_state);
+	}
 
 	ret = omap3_enter_idle(dev, drv, new_state_idx);
 


