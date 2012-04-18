From: jean.pihet@newoldbits.com
Subject: [PATCH 1/6] ARM: OMAP2+: PM QoS: control the power domains next state from the constraints
Date: Wed, 18 Apr 2012 15:45:15 +0200
Message-ID: <1334756720-29166-2-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52950 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab2DRNps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:48 -0400
Received: by wejx9 with SMTP id x9so4728704wej.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:47 -0700 (PDT)
In-Reply-To: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

When a PM QoS device latency constraint is requested or removed the
constraint is stored in the constraints list of the corresponding power
domain, then the aggregated constraint value is applied by programming
the next functional power state using omap_set_pwrdm_state.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
wake-up latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |  216 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |   17 +++
 2 files changed, 233 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3f78f16..100c422 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -17,8 +17,10 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/pm_qos.h>
 #include <trace/events/power.h>
 
 #include "cm2xxx_3xxx.h"
@@ -113,6 +115,12 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	for (i = 0; i < pwrdm->banks; i++)
 		pwrdm->ret_mem_off_counter[i] = 0;
 
+	/* Initialize the per-device wake-up constraints framework data */
+	mutex_init(&pwrdm->wkup_lat_plist_lock);
+	plist_head_init(&pwrdm->wkup_lat_plist_head);
+	pwrdm->wkup_lat_next_state = PWRDM_FUNC_PWRST_OFF;
+
+	/* Initialize the pwrdm state */
 	pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_func_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
@@ -200,6 +208,58 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
+/**
+ * _pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
+ * @pwrdm: struct powerdomain * to which requesting device belongs to.
+ * @min_latency: the allowed wake-up latency for the given power domain. A
+ *  value of PM_QOS_DEV_LAT_DEFAULT_VALUE means 'no constraint' on the pwrdm.
+ *
+ * Finds the power domain next power state that fulfills the constraint.
+ * Programs a new target state if it is different from current power state.
+ * The power domains get the next power state programmed directly in the
+ * registers.
+ *
+ * Returns 0 in case of success, -EINVAL in case of invalid parameters,
+ * or the return value from omap_set_pwrdm_state.
+ */
+static int _pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
+					 long min_latency)
+{
+	int ret = 0, state, new_state = PWRDM_FUNC_PWRST_ON;
+
+	if (!pwrdm) {
+		WARN(1, "powerdomain: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * Find the next supported power state with
+	 *  wakeup latency <= min_latency.
+	 * Pick the lower state if no constraint on the pwrdm
+	 *  (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE).
+	 * Skip the states marked as unsupported (UNSUP_STATE).
+	 * If no power state found, fall back to PWRDM_FUNC_PWRST_ON.
+	 */
+        for (state = 0x0; state < PWRDM_MAX_FUNC_PWRSTS; state++) {
+                if ((min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE) ||
+                    ((pwrdm->wakeup_lat[state] != UNSUP_STATE) &&
+                     (pwrdm->wakeup_lat[state] <= min_latency))) {
+                        new_state = state;
+                        break;
+                }
+        }
+
+	pwrdm->wkup_lat_next_state = new_state;
+	ret = omap_set_pwrdm_state(pwrdm, new_state);
+
+	pr_debug("%s: func pwrst for %s: curr=%d, next=%d, min_latency=%ld, new_state=%d\n",
+		 __func__, pwrdm->name, pwrdm_read_func_pwrst(pwrdm),
+		 pwrdm_read_next_func_pwrst(pwrdm), min_latency, new_state);
+
+	return ret;
+}
+
+
 /* Public functions */
 
 /**
@@ -1224,6 +1284,162 @@ int pwrdm_post_transition(void)
 }
 
 /**
+ * pwrdm_wakeuplat_update_constraint - Set or update a powerdomain wakeup
+ *  latency constraint and apply it
+ * @pwrdm: struct powerdomain * which the constraint applies to
+ * @cookie: constraint identifier, used for tracking
+ * @min_latency: minimum wakeup latency constraint (in microseconds) for
+ *  the given pwrdm
+ *
+ * Tracks the constraints by @cookie.
+ * Constraint set/update: Adds a new entry to powerdomain's wake-up latency
+ * constraint list. If the constraint identifier already exists in the list,
+ * the old value is overwritten.
+ *
+ * Applies the aggregated constraint value for the given pwrdm by calling
+ * _pwrdm_wakeuplat_update_pwrst.
+ *
+ * Returns 0 upon success, -ENOMEM in case of memory shortage, -EINVAL in
+ * case of invalid latency value, or the return value from
+ * _pwrdm_wakeuplat_update_pwrst.
+ *
+ * The caller must check the validity of the parameters.
+ */
+int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, void *cookie,
+				      long min_latency)
+{
+	struct pwrdm_wkup_constraints_entry *tmp_user, *new_user, *user = NULL;
+	long value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	int free_new_user = 0;
+
+	pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
+		 __func__, pwrdm->name, cookie, min_latency);
+
+	if (min_latency <= PM_QOS_DEV_LAT_DEFAULT_VALUE) {
+		pr_warn("%s: min_latency >= PM_QOS_DEV_LAT_DEFAULT_VALUE\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	/* Allocate a new entry for insertion in the list */
+	new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
+			   GFP_KERNEL);
+	if (!new_user) {
+		pr_err("%s: FATAL ERROR: kzalloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&pwrdm->wkup_lat_plist_lock);
+
+	/* Check if there already is a constraint for cookie */
+	plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
+		if (tmp_user->cookie == cookie) {
+			user = tmp_user;
+			break;
+		}
+	}
+
+	/* If nothing to update, job done */
+	if (user && (user->node.prio == min_latency))
+		goto out;
+
+	if (!user) {
+		/* Add new entry to the list */
+		user = new_user;
+		user->cookie = cookie;
+	} else {
+		/* Update existing entry */
+		plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
+		free_new_user = 1;
+	}
+
+	plist_node_init(&user->node, min_latency);
+	plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
+
+	/* Find the aggregated constraint value from the list */
+	if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
+		value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
+
+	mutex_unlock(&pwrdm->wkup_lat_plist_lock);
+
+	/* Free the newly allocated entry if not in use */
+	if (free_new_user)
+		kfree(new_user);
+
+	/* Apply the constraint to the pwrdm */
+	pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
+		 __func__, pwrdm->name, value);
+	return _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
+
+out:
+	mutex_unlock(&pwrdm->wkup_lat_plist_lock);
+	return 0;
+}
+
+/**
+ * pwrdm_wakeuplat_remove_constraint - Release a powerdomain wakeup latency
+ *  constraint and apply it
+ * @pwrdm: struct powerdomain * which the constraint applies to
+ * @cookie: constraint identifier, used for tracking
+ *
+ * Tracks the constraints by @cookie.
+ * Constraint removal: Removes the identifier's entry from powerdomain's
+ * wakeup latency constraint list.
+ *
+ * Applies the aggregated constraint value for the given pwrdm by calling
+ * _pwrdm_wakeuplat_update_pwrst.
+ *
+ * Returns 0 upon success, -EINVAL in case the constraint to remove is not
+ * existing, or the return value from _pwrdm_wakeuplat_update_pwrst.
+ *
+ * The caller must check the validity of the parameters.
+ */
+int pwrdm_wakeuplat_remove_constraint(struct powerdomain *pwrdm, void *cookie)
+{
+	struct pwrdm_wkup_constraints_entry *tmp_user, *user = NULL;
+	long value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
+
+	pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p\n",
+		 __func__, pwrdm->name, cookie);
+
+	mutex_lock(&pwrdm->wkup_lat_plist_lock);
+
+	/* Check if there is a constraint for cookie */
+	plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
+		if (tmp_user->cookie == cookie) {
+			user = tmp_user;
+			break;
+		}
+	}
+
+	/* If constraint not existing or list empty, do nothing */
+	if (!user) {
+		goto out;
+	}
+
+	/* Remove the constraint from the list */
+	plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
+
+	/* Find the aggregated constraint value from the list */
+	if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
+		value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
+
+	mutex_unlock(&pwrdm->wkup_lat_plist_lock);
+
+	/* Release the constraint memory */
+	kfree(user);
+
+	/* Apply the constraint to the pwrdm */
+	pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
+		 __func__, pwrdm->name, value);
+	return _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
+
+out:
+	mutex_unlock(&pwrdm->wkup_lat_plist_lock);
+	return -EINVAL;
+}
+
+/**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
  *
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 9249d42..63028c0 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -19,6 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/plist.h>
 #include <linux/mutex.h>
 #include <linux/atomic.h>
 
@@ -53,6 +54,7 @@
 #define PWRDM_FUNC_PWRST_ON		0x4
 
 #define PWRDM_MAX_FUNC_PWRSTS	5
+#define UNSUP_STATE		-1
 
 /*
  * Powerdomains logic and memory functional power states,
@@ -143,6 +145,16 @@ struct powerdomain {
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_FUNC_PWRSTS];
 #endif
+	const s32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
+	struct plist_head wkup_lat_plist_head;
+	struct mutex wkup_lat_plist_lock;
+	int wkup_lat_next_state;
+};
+
+/* Linked list for the wake-up latency constraints */
+struct pwrdm_wkup_constraints_entry {
+	void			*cookie;
+	struct plist_node	node;
 };
 
 /**
@@ -253,6 +265,11 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
+
+int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, void *cookie,
+				      long min_latency);
+int pwrdm_wakeuplat_remove_constraint(struct powerdomain *pwrdm, void *cookie);
+
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
-- 
1.7.7.6

