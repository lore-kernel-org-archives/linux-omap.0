From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3] omap: pm: Move set_pwrdm_state routine to common pm.c
Date: Tue, 14 Sep 2010 19:25:48 +0530
Message-ID: <1284472548-32151-4-git-send-email-santosh.shilimkar@ti.com>
References: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
 <1284472548-32151-2-git-send-email-santosh.shilimkar@ti.com>
 <1284472548-32151-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40486 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab0INNz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 09:55:57 -0400
In-Reply-To: <1284472548-32151-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The set_pwrdm_state() is needed on omap4 as well so move
this routine to common pm.c file so that it's available for omap3/4

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c     |   50 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h     |    2 +-
 arch/arm/mach-omap2/pm34xx.c |   53 +++--------------------------------------
 3 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 68f9f2e..053f01f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,6 +18,9 @@
 #include <plat/omap_device.h>
 #include <plat/common.h>
 
+#include <plat/powerdomain.h>
+#include <plat/clockdomain.h>
+
 static struct omap_device_pm_latency *pm_lats;
 
 static struct device *mpu_dev;
@@ -73,6 +76,53 @@ static void omap2_init_processor_devices(void)
 	_init_omap_device("l3_main", &l3_dev);
 }
 
+/*
+ * This sets pwrdm state (other than mpu & core. Currently only ON &
+ * RET are supported. Function is assuming that clkdm doesn't have
+ * hw_sup mode enabled.
+ */
+int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
+{
+	u32 cur_state;
+	int sleep_switch = 0;
+	int ret = 0;
+
+	if (pwrdm == NULL || IS_ERR(pwrdm))
+		return -EINVAL;
+
+	while (!(pwrdm->pwrsts & (1 << state))) {
+		if (state == PWRDM_POWER_OFF)
+			return ret;
+		state--;
+	}
+
+	cur_state = pwrdm_read_next_pwrst(pwrdm);
+	if (cur_state == state)
+		return ret;
+
+	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
+		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+		sleep_switch = 1;
+		pwrdm_wait_transition(pwrdm);
+	}
+
+	ret = pwrdm_set_next_pwrst(pwrdm, state);
+	if (ret) {
+		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
+		       pwrdm->name);
+		goto err;
+	}
+
+	if (sleep_switch) {
+		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+		pwrdm_wait_transition(pwrdm);
+		pwrdm_state_switch(pwrdm);
+	}
+
+err:
+	return ret;
+}
+
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c74d35c..6e3c7bf 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,7 +22,7 @@ extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
-extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
+extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 
 struct cpuidle_params {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4fd48e0..c33b8b9 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -495,51 +495,6 @@ int omap3_can_sleep(void)
 	return 1;
 }
 
-/* This sets pwrdm state (other than mpu & core. Currently only ON &
- * RET are supported. Function is assuming that clkdm doesn't have
- * hw_sup mode enabled. */
-int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
-{
-	u32 cur_state;
-	int sleep_switch = 0;
-	int ret = 0;
-
-	if (pwrdm == NULL || IS_ERR(pwrdm))
-		return -EINVAL;
-
-	while (!(pwrdm->pwrsts & (1 << state))) {
-		if (state == PWRDM_POWER_OFF)
-			return ret;
-		state--;
-	}
-
-	cur_state = pwrdm_read_next_pwrst(pwrdm);
-	if (cur_state == state)
-		return ret;
-
-	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
-		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-		sleep_switch = 1;
-		pwrdm_wait_transition(pwrdm);
-	}
-
-	ret = pwrdm_set_next_pwrst(pwrdm, state);
-	if (ret) {
-		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
-		       pwrdm->name);
-		goto err;
-	}
-
-	if (sleep_switch) {
-		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
-		pwrdm_wait_transition(pwrdm);
-		pwrdm_state_switch(pwrdm);
-	}
-
-err:
-	return ret;
-}
-
 static void omap3_pm_idle(void)
 {
 	local_irq_disable();
@@ -581,7 +536,7 @@ static int omap3_pm_suspend(void)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
 	/* Set ones wanted by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
+		if (omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
 			goto restore;
 		if (pwrdm_clear_all_prev_pwrst(pwrst->pwrdm))
 			goto restore;
@@ -602,7 +557,7 @@ restore:
 			       pwrst->pwrdm->name, pwrst->next_state);
 			ret = -1;
 		}
-		set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
+		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
 	}
 	if (ret)
 		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
@@ -951,7 +906,7 @@ void omap3_pm_off_mode_enable(int enable)
 
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->next_state = state;
-		set_pwrdm_state(pwrst->pwrdm, state);
+		omap_set_pwrdm_state(pwrst->pwrdm, state);
 	}
 }
 
@@ -996,7 +951,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (pwrdm_has_hdwr_sar(pwrdm))
 		pwrdm_enable_hdwr_sar(pwrdm);
 
-	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
 /*
-- 
1.6.0.4

