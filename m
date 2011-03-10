From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 18/19] OMAP4: cpuidle: Add CPU hotplug notifier and prepare() hook.
Date: Thu, 10 Mar 2011 19:38:14 +0530
Message-ID: <1299766095-23879-19-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50200 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab1CJOIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:08:42 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4 CPUidle, the low power states are triggered when CPU1
is offlined to OFF power state. When the CPU1 is online, no
low power states are supported.

The patch adds CPU hotplug notifier to manage the C-state
states using CPUidle prepare() hook and CPUIDLE_FLAG_IGNORE
c-state flag.

This was suggested by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   64 +++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index daf41e1..83b7f95 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -13,6 +13,8 @@
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
 #include <linux/clockchips.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/proc-fns.h>
 
@@ -51,6 +53,8 @@ struct omap4_processor_cx {
 
 struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES];
 static struct powerdomain *mpu_pd, *cpu1_pd, *core_pd;
+static int needs_state_data_update;
+static unsigned int state_flags = CPUIDLE_FLAG_IGNORE;
 
 /*
  * FIXME: Full latency numbers needs to be updated as part of
@@ -72,6 +76,31 @@ static struct cpuidle_params cpuidle_params_table[] = {
 };
 
 /**
+ * omap4_prepare_idle - Update C-state parameters dynamically
+ * @dev: cpuidle device
+ *
+ * Called from the CPUidle framework to prepare the device
+ * for idle before before calling the governor's select function.
+ */
+static int omap4_prepare_idle(struct cpuidle_device *dev)
+{
+	int i, ret = 0;
+
+	if (!needs_state_data_update)
+		return ret;
+
+	/*
+	 * Update the C-state flags based on CPU1 online
+	 * or offline state. On OMAP4, the low power C-states
+	 * are made available when only CPU1 is offline.
+	 */
+	for (i = OMAP4_STATE_C2; i < OMAP4_MAX_STATES; i++)
+		dev->states[i].flags = state_flags;
+
+	return ret;
+}
+
+/**
  * omap4_enter_idle - Programs OMAP4 to enter the specified state
  * @dev: cpuidle device
  * @state: The target state to be programmed
@@ -227,6 +256,36 @@ struct cpuidle_driver omap4_idle_driver = {
 	.owner =	THIS_MODULE,
 };
 
+/*
+ * CPU hotplug notifier to update the C-states when
+ * CPU1 is offline or onine. While updating C-state flag,
+ * keep the cpuidle disabled.
+ */
+static int __cpuinit omap_cpu_hotplug_notify(struct notifier_block *self,
+					 unsigned long action, void *unused)
+{
+	switch (action) {
+	case CPU_ONLINE:
+		disable_hlt();
+		needs_state_data_update = 1;
+		state_flags = CPUIDLE_FLAG_IGNORE;
+		enable_hlt();
+		break;
+	case CPU_DEAD:
+		disable_hlt();
+		needs_state_data_update = 1;
+		state_flags = CPUIDLE_FLAG_TIME_VALID;
+		enable_hlt();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __refdata omap_ilde_hotplug_notifier = {
+	.notifier_call = omap_cpu_hotplug_notify,
+};
+
 /**
  * omap4_idle_init - Init routine for OMAP4 idle
  *
@@ -272,12 +331,17 @@ int __init omap4_idle_init(void)
 	if (!count)
 		return -EINVAL;
 	dev->state_count = count;
+	dev->prepare = omap4_prepare_idle;
 
 	if (cpuidle_register_device(dev)) {
 		pr_err("%s: CPUidle register device failed\n", __func__);
 			return -EIO;
 		}
 
+	ret = register_hotcpu_notifier(&omap_ilde_hotplug_notifier);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 #else
-- 
1.6.0.4

