From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 6/7] OMAP: PM CONSTRAINTS: control power domains next state
Date: Thu, 10 Mar 2011 18:47:26 +0100
Message-ID: <1299779247-20511-7-git-send-email-j-pihet@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55430 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab1CJRrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:52 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so1681959wya.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:51 -0800 (PST)
In-Reply-To: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

When a wake-up constraint is requested or removed the omap device layer
dispatches the updated strongest constraint value.
The power domains get the next power state programmed directly in the
registers via pwrdm_wakeuplat_update_pwrst.

Note about PM QOS: the MPU and CORE power domains get the next power
state via cpuidle, which get the strongest wake-up latency constraint
by querying PM QOS. The usage of PM QOS is temporary, until a generic
solution is in place.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |  100 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |   24 ++++++++-
 2 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index eaed0df..54ac955 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+
 #include "cm2xxx_3xxx.h"
 #include "prcm44xx.h"
 #include "cm44xx.h"
@@ -176,6 +177,105 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
+/*
+ * Test if the current powerdomain is MPU or CORE
+ *
+ * This function is only used by pwrdm_wakeuplat_update_pwrst
+ * which applies the MPU and CORE power domains constraints using PM QOS.
+ *
+ * This will disappear when all power domains will be controlled directly
+ * from the wake-up latency constraints framework
+ */
+static inline int is_pwrdm_mpu_or_core(struct powerdomain *pwrdm)
+{
+	if ((pwrdm == pwrdm_lookup("mpu_pwrdm")) ||
+	    (pwrdm == pwrdm_lookup("core_pwrdm")))
+		return 1;
+	else
+		return 0;
+}
+
+/**
+ * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
+ * @pwrdm: struct powerdomain * to which requesting device belongs to.
+ * @min_latency: the allowed wake-up latency for the given power domain. A
+ *  value of 0 means 'no constraint' on the pwrdm.
+ *
+ * Finds the power domain next power state that fulfills the constraint.
+ * Programs a new target state if it is different from current power state.
+ *
+ * Returns 0 upon success.
+ */
+int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long min_latency)
+{
+	int ret = 0, new_state = 0;
+
+	if (!pwrdm) {
+		WARN(1, "powerdomain: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Apply constraints to MPU and CORE via the PM QOS API.
+	 * Every power domain struct has a pm_qos_request_list field
+	 */
+	if (is_pwrdm_mpu_or_core(pwrdm)) {
+		if (pm_qos_request_active(&(pwrdm->pm_qos_request)))
+			pm_qos_remove_request(&(pwrdm->pm_qos_request));
+
+		if (min_latency > 0)
+			pm_qos_add_request(&(pwrdm->pm_qos_request),
+					   PM_QOS_CPU_DMA_LATENCY,
+					   min_latency);
+
+		return 0;
+	}
+
+	/*
+	 * Apply constraints to pwrdm other than MPU and CORE by programming
+	 * the pwrdm next power state.
+	 */
+
+	/* Find power state with wakeup latency < minimum constraint */
+	for (new_state = 0x0; new_state < PWRDM_MAX_PWRSTS; new_state++) {
+		if (min_latency == 0 ||
+		    pwrdm->wakeup_lat[new_state] <= min_latency)
+			break;
+	}
+
+	switch (new_state) {
+	case PWRDM_FUNC_PWRST_OFF:
+		new_state = PWRDM_POWER_OFF;
+		break;
+	case PWRDM_FUNC_PWRST_OSWR:
+		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
+		new_state = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_CSWR:
+		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
+		new_state = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_ON:
+		new_state = PWRDM_POWER_ON;
+		break;
+	default:
+		pr_warn("powerdomain: requested latency constraint not "
+			"supported %s set to ON state\n", pwrdm->name);
+		new_state = PWRDM_POWER_ON;
+		break;
+	}
+
+	if (pwrdm_read_pwrst(pwrdm) != new_state)
+		ret = omap_set_pwrdm_state(pwrdm, new_state);
+
+	pr_debug("powerdomain: %s pwrst: curr=%d, prev=%d next=%d "
+		 "min_latency=%ld, set_state=%d\n", pwrdm->name,
+		 pwrdm_read_pwrst(pwrdm), pwrdm_read_prev_pwrst(pwrdm),
+		 pwrdm_read_next_pwrst(pwrdm), min_latency, new_state);
+
+	return ret;
+}
+
 /* Public functions */
 
 /**
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0b7a357..23b3408 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -19,7 +19,10 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-
+#include <linux/plist.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/pm_qos_params.h>
 #include <linux/atomic.h>
 
 #include <plat/cpu.h>
@@ -46,6 +49,15 @@
 
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
 
+/* Powerdomain functional power states */
+#define PWRDM_FUNC_PWRST_OFF	0x0
+#define PWRDM_FUNC_PWRST_OSWR	0x1
+#define PWRDM_FUNC_PWRST_CSWR	0x2
+#define PWRDM_FUNC_PWRST_ON	0x3
+
+#define PWRDM_MAX_FUNC_PWRSTS	4
+
+#define UNSUP_STATE		-1
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
@@ -96,7 +108,11 @@ struct powerdomain;
  * @state_counter:
  * @timer:
  * @state_timer:
- *
+ * @wakeup_lat: wakeup latencies (in us) for possible powerdomain power states
+ * Note about the wakeup latencies ordering: the values must be sorted
+ *  in decremental order
+ * @pm_qos_request: PM QOS handle, only used to control the MPU and CORE power
+ *  domains states; to be removed when a generic solution is in place.
  * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
  */
 struct powerdomain {
@@ -121,6 +137,8 @@ struct powerdomain {
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
 #endif
+	const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
+	struct pm_qos_request_list pm_qos_request;
 };
 
 /**
@@ -210,6 +228,8 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
+
+int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long min_latency);
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 
 extern void omap2xxx_powerdomains_init(void);
-- 
1.7.2.3

