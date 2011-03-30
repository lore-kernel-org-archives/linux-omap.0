From: jean.pihet@newoldbits.com
Subject: [PATCH 2/8] OMAP2+: powerdomain: control power domains next state
Date: Wed, 30 Mar 2011 17:19:18 +0200
Message-ID: <1301498364-726-3-git-send-email-j-pihet@ti.com>
References: <1301498364-726-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62111 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab1C3PTf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 11:19:35 -0400
Received: by wwa36 with SMTP id 36so1626013wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 08:19:34 -0700 (PDT)
In-Reply-To: <1301498364-726-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

When a wake-up latency constraint is requested or removed the omap device
layer dispatches the updated strongest constraint value to the
corresponding power domain.
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
 arch/arm/mach-omap2/powerdomain.c |  206 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |   42 +++++++-
 2 files changed, 246 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 49c6513..b8d3860 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <trace/events/power.h>
@@ -104,6 +105,12 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	for (i = 0; i < pwrdm->banks; i++)
 		pwrdm->ret_mem_off_counter[i] = 0;
 
+	/* Initialize the per-od wake-up constraints list and spinlock */
+	spin_lock_init(&pwrdm->wkup_lat_plist_lock);
+	plist_head_init(&pwrdm->wkup_lat_plist_head,
+			&pwrdm->wkup_lat_plist_lock);
+
+	/* Initialize the pwrdm state */
 	pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
@@ -191,6 +198,103 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
+/**
+ * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
+ * @pwrdm: struct powerdomain * to which requesting device belongs to.
+ * @min_latency: the allowed wake-up latency for the given power domain. A
+ *  value of 0 means 'no constraint' on the pwrdm.
+ *
+ * Finds the power domain next power state that fulfills the constraint.
+ * Programs a new target state if it is different from current power state.
+ *
+ * Note about PM QOS: the MPU and CORE power domains get the next power
+ * state via cpuidle, which get the strongest wake-up latency constraint
+ * by querying PM QOS. The usage of PM QOS is temporary, until a generic
+ * solution is in place.
+ * The power domains other then MPU and CORE get the next power state
+ * programmed directly in the registers.
+ *
+ * Returns 0 upon success.
+ */
+static int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
+					long min_latency)
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
+	if (pwrdm->flags & PWRDM_USES_PM_QOS_CONSTRAINTS) {
+		if (pm_qos_request_active(&pwrdm->pm_qos_request))
+			pm_qos_remove_request(&pwrdm->pm_qos_request);
+
+		if (min_latency > 0) {
+			pm_qos_add_request(&pwrdm->pm_qos_request,
+					   PM_QOS_CPU_DMA_LATENCY,
+					   min_latency);
+			pr_debug("powerdomain: %s: pwrdm %s: "
+				 "adding a PM_QOS_CPU_DMA_LATENCY request, "
+				 "min_latency=%ld\n", __func__, pwrdm->name,
+				 min_latency);
+		}
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
+	case PWRDM_FUNC_PWRST_INACTIVE:
+		new_state = PWRDM_POWER_INACTIVE;
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
@@ -930,6 +1034,108 @@ int pwrdm_post_transition(void)
 	return 0;
 }
 
+/*
+ * pwrdm_set_wkup_lat_constraint - Set/update/remove a powerdomain wakeup
+ *  latency constraint and apply it
+ * @pwrdm: struct powerdomain * which the constraint applies to
+ * @cookie: constraint identifier, used for tracking.
+ * @min_latency: minimum wakeup latency constraint (in microseconds) for
+ *  the given pwrdm. The value of 0 removes the constraint.
+ *
+ * Tracks the constraints by @cookie.
+ * Constraint set/update: Adds a new entry to powerdomain's wake-up latency
+ * constraint list.
+ * If the constraint identifier already exists in the list, the old value is
+ * overwritten.
+ * Constraint removal: Removes the identifier's entry from powerdomain's
+ * wakeup latency constraint list.
+ *
+ * Applies the strongest constraint value for the given pwrdm by calling
+ * pwrdm_wakeuplat_update_pwrst.
+ *
+ * Returns 0 upon success or a negative value in case of error.
+ *
+ * The caller must check the validity of the parameters.
+ */
+int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *cookie,
+				  long min_latency)
+{
+	struct pwrdm_wkup_constraints_entry *user = NULL, *tmp_user;
+	int ret = 0;
+	long value = 0;
+	unsigned long flags;
+
+	pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
+		 __func__, pwrdm->name, cookie, min_latency);
+
+	/* Check if there already is a constraint for cookie */
+	spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
+	plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
+		if (tmp_user->cookie == cookie) {
+			user = tmp_user;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
+
+	if (min_latency > 0) {
+		/* Nothing to update, job done */
+		if (user && (user->node.prio == min_latency))
+			goto exit_ok;
+
+		/* Add new entry to the list or update existing request */
+		if (!user) {
+			user = kzalloc(
+				sizeof(struct pwrdm_wkup_constraints_entry),
+				GFP_KERNEL);
+			if (!user) {
+				pr_err("%s: FATAL ERROR: kzalloc failed\n",
+				       __func__);
+				ret = -ENOMEM;
+				goto exit_error;
+			}
+			user->cookie = cookie;
+		} else {
+			spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
+			plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
+			spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock,
+					       flags);
+		}
+
+		spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
+		plist_node_init(&user->node, min_latency);
+		plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
+		spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
+	} else {
+		/* Remove the constraint from the list */
+		if (!user) {
+			pr_err("%s: Error: no prior constraint to release\n",
+			       __func__);
+			ret = -EINVAL;
+			goto exit_error;
+		}
+
+		spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
+		plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
+		spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
+		kfree(user);
+	}
+
+exit_ok:
+	/* Find the strongest constraint from the list */
+	spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
+	value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
+	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
+
+	/* Apply the constraint to the pwrdm */
+	pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
+		 __func__, pwrdm->name, value);
+	pwrdm_wakeuplat_update_pwrst(pwrdm, value);
+
+exit_error:
+	return ret;
+}
+
 /**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 027f40b..523ba9e 100644
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
@@ -43,6 +46,16 @@
 #define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
 
+/* Powerdomain functional power states */
+#define PWRDM_FUNC_PWRST_OFF		0x0
+#define PWRDM_FUNC_PWRST_OSWR		0x1
+#define PWRDM_FUNC_PWRST_CSWR		0x2
+#define PWRDM_FUNC_PWRST_INACTIVE	0x3
+#define PWRDM_FUNC_PWRST_ON		0x4
+
+#define PWRDM_MAX_FUNC_PWRSTS	5
+
+#define UNSUP_STATE		-1
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
@@ -56,6 +69,12 @@
 						  * state without waking up the
 						  * powerdomain
 						  */
+#define PWRDM_USES_PM_QOS_CONSTRAINTS	(1 << 3) /* Uses the PM QOS framework
+						  * for wake-up latency
+						  * constraints.
+						  * Note: temporary until the
+						  * generic OMAP PM is in place
+						  */
 
 /*
  * Number of memory banks that are power-controllable.	On OMAP4430, the
@@ -93,7 +112,13 @@ struct powerdomain;
  * @state_counter:
  * @timer:
  * @state_timer:
- *
+ * @wakeup_lat: wakeup latencies (in us) for possible powerdomain power states
+ * Note about the wakeup latencies ordering: the values must be sorted
+ *  in decremental order
+ * @wkup_lat_plist_head: pwrdm wake-up latency constraints list
+ * @wkup_lat_plist_lock: spinlock that protects the constraints lists
+ * @pm_qos_request: PM QOS handle, only used to control the MPU and CORE power
+ *  domains states; to be removed when a generic solution is in place.
  * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
  */
 struct powerdomain {
@@ -118,6 +143,16 @@ struct powerdomain {
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
 #endif
+	const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
+	struct plist_head wkup_lat_plist_head;
+	spinlock_t wkup_lat_plist_lock;
+	struct pm_qos_request_list pm_qos_request;
+};
+
+/* Linked list for the wake-up latency constraints */
+struct pwrdm_wkup_constraints_entry {
+	void			*cookie;
+	struct plist_node	node;
 };
 
 /**
@@ -207,6 +242,9 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
+
+int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *cookie,
+				  long min_latency);
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
-- 
1.7.2.5

