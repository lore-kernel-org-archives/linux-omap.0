From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] OMAP: PM: implement devices wakeup latency constraints APIs
Date: Fri,  4 Mar 2011 15:52:55 +0100
Message-ID: <1299250375-26134-3-git-send-email-j-pihet@ti.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55703 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759662Ab1CDOxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 09:53:30 -0500
Received: by mail-ww0-f44.google.com with SMTP id 22so2782024wwb.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 06:53:29 -0800 (PST)
In-Reply-To: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
creating similar APIs at the omap_device and omap_hwmod levels. The
omap_hwmod level call is the layer with access to the powerdomain
core, so it is the place where the powerdomain is queried to set and
release the constraints.

NOTE: only works for devices which have been converted to use
      omap_device/omap_hwmod.

Longer term, we could possibly remove this API from the OMAP PM layer,
and instead directly use the device level API.

The power domains get the next power state programmed directly in
the registers via pwrdm_wakeuplat_update_pwrst.

Note about PM QOS: the MPU and CORE power domains get the next power
state via cpuidle, which get the strongest wake-up latency constraint
by querying PM QOS. The usage of PM QOS is temporary, until a generic
solution is in place.

Based on Vibhore's original patch, adapted to omap_device, omap_hwmod
and PM QOS frameworks.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Vibhore Vardhan <vvardhan@ti.com>
---
Based on khilman's pm-core branch

 arch/arm/mach-omap2/omap_hwmod.c              |   62 ++++++++-
 arch/arm/mach-omap2/powerdomain.c             |  197 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |   39 +++++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |   60 ++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c      |  121 +++++++--------
 arch/arm/plat-omap/omap_device.c              |   28 ++++
 8 files changed, 446 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 028efda..bad8248 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -142,6 +142,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2267,10 +2268,69 @@ ohsps_unlock:
 }
 
 /**
+ * omap_hwmod_set_max_dev_wakeup_lat - set a device wake-up constraint
+ * @oh: the device of @oh to set a constraint on.
+ * @req_oh: the device of @req_oh is the requester of the constraint.
+ * @t: wakeup latency constraint (us). -1 removes the existing constraint.
+ *
+ * Query the powerdomain of @oh to set/release the wake-up constraint.
+ * @oh is used to determine which power domain to set a constraint on.
+ * @req_oh is used to record the requester for later update or removal
+ * of a constraint.
+ *
+ * Returns -EINVAL if @oh or @req_oh have no power domain, or the return
+ * code from the pwrdm function (pwrdm_wakeuplat_set/release_constraint)
+ * of the powerdomain assocated with @oh.
+ */
+int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod *req_oh,
+				      struct omap_hwmod *oh, long t)
+{
+	struct device *req_dev;
+	struct platform_device *req_pdev;
+	struct powerdomain *pwrdm;
+
+	pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	/* Catch devices with undefined powerdomains */
+	if (!PTR_ERR(pwrdm)) {
+		pr_err("omap_hwmod: Error: could not find parent "
+			"powerdomain for %s\n", oh->name);
+		return -EINVAL;
+	}
+
+	req_pdev = &(req_oh->od->pdev);
+	if (!PTR_ERR(req_pdev)) {
+		pr_err("omap_hwmod: Error: pdev not found for oh %s\n",
+		       oh->name);
+		return -EINVAL;
+	}
+
+	req_dev = &(req_pdev->dev);
+	if (!PTR_ERR(req_dev)) {
+		pr_err("omap_hwmod: Error: device not found for oh %s\n",
+		       oh->name);
+		return -EINVAL;
+	}
+
+	/* Call set/release_constraint for the given pwrdm */
+	if (t == -1) {
+		pr_debug("omap_hwmod: remove max device latency constraint: "
+			 "oh %s, pwrdm %s, req by oh %s\n",
+			 oh->name, pwrdm->name, req_oh->name);
+	} else {
+		pr_debug("omap_hwmod: add max device latency constraint: "
+			 "oh %s, t = %ld usec, pwrdm %s, req by oh %s\n",
+			 oh->name, t, pwrdm->name, req_oh->name);
+	}
+
+	return pwrdm_wakeuplat_set_constraint(pwrdm, req_dev, t);
+}
+
+/**
  * omap_hwmod_get_context_loss_count - get lost context count
  * @oh: struct omap_hwmod *
  *
- * Query the powerdomain of of @oh to get the context loss
+ * Query the powerdomain of @oh to get the context loss
  * count for this device.
  *
  * Returns the context loss count of the powerdomain assocated with @oh
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index eaed0df..6fb4741 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -19,6 +19,8 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/slab.h>
+
 #include "cm2xxx_3xxx.h"
 #include "prcm44xx.h"
 #include "cm44xx.h"
@@ -103,6 +105,13 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
 
+	/* Initialize priority ordered list for wakeup latency constraint */
+	spin_lock_init(&pwrdm->wakeuplat_lock);
+	plist_head_init(&pwrdm->wakeuplat_dev_list, &pwrdm->wakeuplat_lock);
+
+	/* res_mutex protects res_list add and del ops */
+	mutex_init(&pwrdm->wakeuplat_mutex);
+
 	pr_debug("powerdomain: registered %s\n", pwrdm->name);
 
 	return 0;
@@ -176,6 +185,74 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
+/**
+ * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
+ * @pwrdm: struct powerdomain * to which requesting device belongs to.
+ *
+ * Finds the minimum allowed wake-up latency value from all entries
+ * in the list and the power domain power state needing the constraint.
+ * Programs a new target state if it is different from current power state.
+ *
+ * Only OMAP3xxx is supported for now
+ *
+ * Returns 0 upon success.
+ */
+static int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm)
+{
+	struct plist_node *node;
+	int ret = 0, new_state;
+	long min_latency = -1;
+
+	/* Find the strongest constraint from the plist */
+	if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) {
+		node = plist_first(&pwrdm->wakeuplat_dev_list);
+		min_latency = node->prio;
+	}
+
+	/* Find power state with wakeup latency < minimum constraint. */
+	for (new_state = 0x0; new_state < PWRDM_MAX_PWRSTS; new_state++) {
+		if (min_latency == -1 ||
+		    pwrdm->wakeup_lat[new_state] <= min_latency)
+			break;
+	}
+
+	switch (new_state) {
+	case PWRDM_FUNC_PWRST_OFF:
+		new_state = PWRDM_POWER_OFF;
+		break;
+	case PWRDM_FUNC_PWRST_OSWR:
+		if (cpu_is_omap34xx())
+			pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
+		new_state = PWRDM_POWER_RET;
+		break;
+	case PWRDM_FUNC_PWRST_CSWR:
+		if (cpu_is_omap34xx())
+			pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
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
+	if (pwrdm_read_pwrst(pwrdm) != new_state) {
+		if (cpu_is_omap34xx())
+			ret = omap_set_pwrdm_state(pwrdm, new_state);
+	}
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
@@ -910,6 +987,126 @@ int pwrdm_post_transition(void)
 	return 0;
 }
 
+/*
+ * Test if the current powerdomain is MPU or CORE
+ *
+ * This function is only used by pwrdm_wakeuplat_set_constraint
+ * which applies the MPU and CORE power domains constraints using PM QOS.
+ *
+ * This will disappear when all power domains will be controlled directly
+ * from the wake-up latency constraints framework
+ */
+static inline int is_pwrdm_mpu_or_core(struct powerdomain *pwrdm)
+{
+	if ((strncmp(pwrdm->name, "mpu_pwrdm", 9) == 0) ||
+	    (strncmp(pwrdm->name, "core_pwrdm", 10) == 0))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * pwrdm_wakeuplat_set_constraint - Set/update/remove powerdomain wakeup
+ * latency constraint
+ * @pwrdm: struct powerdomain * to which requesting device belongs to
+ * @dev: struct device * of requesting device
+ * @t: wakeup latency constraint in microseconds. The value of -1 removes
+ * the constraint
+ *
+ * Constraint set/update: Adds new entry to powerdomain's wakeup latency
+ * constraint list.
+ * If the requesting device already exists in the list, old value is
+ * overwritten. Checks whether current power state is still adequate.
+ *
+ * Constraint removal: Removes device's entry from powerdomain's wakeup
+ * latency constraint list. Checks whether current power state is still
+ * adequate.
+ *
+ * Note about PM QOS: the MPU and CORE power domains get the next power
+ * state via cpuidle, which get the strongest wake-up latency constraint
+ * by querying PM QOS. The usage of PM QOS is temporary, until a generic
+ * solution is in place.
+ * The power domains other then MPU and CORE get the next power state
+ * programmed directly in the registers via pwrdm_wakeuplat_update_pwrst.
+ *
+ * Returns -EINVAL if the powerdomain or device pointer is NULL or
+ * no such entry exists in the list, or -ENOMEM if kmalloc fails, or
+ * returns 0 upon success.
+ */
+int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
+				   struct device *req_dev, long t)
+{
+	struct  wakeuplat_dev_list *user;
+	int found = 0, ret = 0;
+
+	if (!pwrdm || !req_dev) {
+		WARN(1, "powerdomain: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&pwrdm->wakeuplat_mutex);
+
+	plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, node) {
+		if (user->dev == req_dev) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (t >= 0) {
+		/* Add new entry to the list or update existing request */
+		if (found && user->constraint_us == t) {
+			goto exit_set;
+		} else if (!found) {
+			user = kzalloc(sizeof(struct wakeuplat_dev_list),
+				       GFP_KERNEL);
+			if (!user) {
+				pr_err("powerdomain: FATAL ERROR: kzalloc "
+				       "failed\n");
+				ret = -ENOMEM;
+				goto exit_set;
+			}
+			user->dev = req_dev;
+		} else {
+			plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
+			if (is_pwrdm_mpu_or_core(pwrdm))
+				pm_qos_remove_request(&(user->pm_qos_request));
+		}
+
+		plist_node_init(&user->node, t);
+		plist_add(&user->node, &pwrdm->wakeuplat_dev_list);
+		user->node.prio = user->constraint_us = t;
+		if (is_pwrdm_mpu_or_core(pwrdm))
+			pm_qos_add_request(&(user->pm_qos_request),
+					   PM_QOS_CPU_DMA_LATENCY, t);
+	} else {
+		/* Remove the constraint from the list */
+		if (!found) {
+			pr_err("OMAP PM: Error: no prior constraint to "
+			       "release\n");
+			ret = -EINVAL;
+			goto exit_set;
+		}
+
+		if (is_pwrdm_mpu_or_core(pwrdm))
+			pm_qos_remove_request(&(user->pm_qos_request));
+		plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
+		kfree(user);
+	}
+
+	/*
+	 * Constraints on MPU and CORE are passed to PM QOS while other power
+	 * domains get the next power state programmed directly
+	 */
+	if (!(is_pwrdm_mpu_or_core(pwrdm)))
+		ret = pwrdm_wakeuplat_update_pwrst(pwrdm);
+
+exit_set:
+	mutex_unlock(&pwrdm->wakeuplat_mutex);
+
+	return ret;
+}
+
 /**
  * pwrdm_get_context_loss_count - get powerdomain's context loss count
  * @pwrdm: struct powerdomain * to wait for
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0b7a357..98eea82 100644
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
@@ -96,6 +108,12 @@ struct powerdomain;
  * @state_counter:
  * @timer:
  * @state_timer:
+ * @wakeup_lat: wakeup latencies for possible powerdomain power states
+ * Note about the wakeup latencies ordering: the values must be sorted
+ *  in decremental order
+ * @wakeuplat_lock: spinlock for plist
+ * @wakeuplat_dev_list: plist_head linking all devices placing constraint
+ * @wakeuplat_mutex: mutex to protect per powerdomain list ops
  *
  * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
  */
@@ -121,6 +139,22 @@ struct powerdomain {
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
 #endif
+	const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
+	spinlock_t wakeuplat_lock;
+	struct plist_head wakeuplat_dev_list;
+	struct mutex wakeuplat_mutex;
+};
+
+/*
+ * Linked list for the power domains wakeup latencies constraints
+ * The PM QOS handle is only used to control the MPU and CORE power
+ * domains states; to be removed when a generic solution is in place.
+*/
+struct wakeuplat_dev_list {
+	struct device			*dev;
+	unsigned long			constraint_us;
+	struct plist_node		node;
+	struct pm_qos_request_list	pm_qos_request;
 };
 
 /**
@@ -210,6 +244,9 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
+
+int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
+				   struct device *req_dev, long t);
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 
 extern void omap2xxx_powerdomains_init(void);
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index e1bec56..4f7e44d 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -52,6 +52,12 @@ static struct powerdomain iva2_pwrdm = {
 		[2] = PWRSTS_OFF_ON,
 		[3] = PWRDM_POWER_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 350,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain mpu_3xxx_pwrdm = {
@@ -68,6 +74,12 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_OFF_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 95,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 45,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -98,6 +110,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 60,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
@@ -121,6 +139,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 60,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain dss_pwrdm = {
@@ -136,6 +160,12 @@ static struct powerdomain dss_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 70,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 20,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -157,6 +187,12 @@ static struct powerdomain sgx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain cam_pwrdm = {
@@ -172,6 +208,12 @@ static struct powerdomain cam_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 850,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain per_pwrdm = {
@@ -187,6 +229,12 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 200,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 110,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain emu_pwrdm = {
@@ -201,6 +249,12 @@ static struct powerdomain neon_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 200,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain usbhost_pwrdm = {
@@ -223,6 +277,12 @@ static struct powerdomain usbhost_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 800,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 150,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 static struct powerdomain dpll1_pwrdm = {
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..5da6b47 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -107,6 +107,8 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
 int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
+int omap_device_set_max_dev_wakeup_lat(struct platform_device *req_pdev,
+				       struct platform_device *pdev, long t);
 u32 omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 4f5b23e..7fcf168 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -595,6 +595,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
+int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod *req_oh,
+				      struct omap_hwmod *oh, long t);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 /*
diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-omap/omap-pm-constraints.c
index c8b4e4c..df24e5e 100644
--- a/arch/arm/plat-omap/omap-pm-constraints.c
+++ b/arch/arm/plat-omap/omap-pm-constraints.c
@@ -24,6 +24,7 @@
 /* Interface documentation is in mach/omap-pm.h */
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
+#include <plat/common.h>
 
 static bool off_mode_enabled;
 static u32 dummy_context_loss_counter;
@@ -32,34 +33,6 @@ static u32 dummy_context_loss_counter;
  * Device-driver-originated constraints (via board-*.c files)
  */
 
-int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
-{
-	if (!dev || t < -1) {
-		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
-		return -EINVAL;
-	};
-
-	if (t == -1)
-		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
-			 "dev %s\n", dev_name(dev));
-	else
-		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
-
-	/*
-	 * For current Linux, this needs to map the MPU to a
-	 * powerdomain, then go through the list of current max lat
-	 * constraints on the MPU and find the smallest.  If
-	 * the latency constraint has changed, the code should
-	 * recompute the state to enter for the next powerdomain
-	 * state.
-	 *
-	 * TI CDP code can call constraint_set here.
-	 */
-
-	return 0;
-}
-
 int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 {
 	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
@@ -87,64 +60,86 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
 	return 0;
 }
 
+/*
+ * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up latency
+ * constraints
+ */
 int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
 				   long t)
 {
+	struct platform_device *pdev, *req_pdev;
+	int ret = 0;
+
 	if (!req_dev || !dev || t < -1) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
+	}
+
+	/* Look for the platform devices */
+	pdev = to_platform_device(dev);
+	req_pdev = to_platform_device(req_dev);
+
+	/* Try to catch non platform devices. */
+	if ((pdev->name == NULL) || (req_pdev->name == NULL)) {
+		pr_err("OMAP-PM set_wakeup_lat: Error: platform devices "
+		       "not valid\n");
+		return -EINVAL;
+	} else {
+		/* Call the omap_device API */
+		ret = omap_device_set_max_dev_wakeup_lat(req_pdev, pdev, t);
+	}
+
+	return ret;
+}
+
+/*
+ * omap_pm_set_max_mpu_wakeup_lat - set/release MPU wake-up latency
+ * constraints
+ *
+ * Maps to omap_pm_set_max_dev_wakeup_lat with the MPU device as constraints
+ * target.
+ */
+int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev, long t)
+{
+	if (!req_dev || t < -1) {
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
 	};
 
 	if (t == -1)
-		pr_debug("OMAP PM: remove max device latency constraint: "
-			 "dev %s\n", dev_name(dev));
+		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
+			 "dev %s\n", dev_name(req_dev));
 	else
-		pr_debug("OMAP PM: add max device latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
-
-	/*
-	 * For current Linux, this needs to map the device to a
-	 * powerdomain, then go through the list of current max lat
-	 * constraints on that powerdomain and find the smallest.  If
-	 * the latency constraint has changed, the code should
-	 * recompute the state to enter for the next powerdomain
-	 * state.  Conceivably, this code should also determine
-	 * whether to actually disable the device clocks or not,
-	 * depending on how long it takes to re-enable the clocks.
-	 *
-	 * TI CDP code can call constraint_set here.
-	 */
+		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
+			 "dev %s, t = %ld usec\n", dev_name(req_dev), t);
 
-	return 0;
+	return omap_pm_set_max_dev_wakeup_lat(req_dev,
+					      omap2_get_mpuss_device(), t);
 }
 
-int omap_pm_set_max_sdma_lat(struct device *dev, long t)
+/*
+ * omap_pm_set_max_sdma_lat - set/release SDMA start latency
+ * constraints
+ *
+ * Currenlt maps to omap_pm_set_max_dev_wakeup_lat with the L3 device as
+ * constraints target.
+ */
+int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
 {
-	if (!dev || t < -1) {
+	if (!req_dev || t < -1) {
 		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
 		return -EINVAL;
 	};
 
 	if (t == -1)
 		pr_debug("OMAP PM: remove max DMA latency constraint: "
-			 "dev %s\n", dev_name(dev));
+			 "dev %s\n", dev_name(req_dev));
 	else
 		pr_debug("OMAP PM: add max DMA latency constraint: "
-			 "dev %s, t = %ld usec\n", dev_name(dev), t);
+			 "dev %s, t = %ld usec\n", dev_name(req_dev), t);
 
-	/*
-	 * For current Linux PM QOS params, this code should scan the
-	 * list of maximum CPU and DMA latencies and select the
-	 * smallest, then set cpu_dma_latency pm_qos_param
-	 * accordingly.
-	 *
-	 * For future Linux PM QOS params, with separate CPU and DMA
-	 * latency params, this code should just set the dma_latency param.
-	 *
-	 * TI CDP code can call constraint_set here.
-	 */
-
-	return 0;
+	return omap_pm_set_max_dev_wakeup_lat(req_dev,
+					      omap2_get_l3_device(), t);
 }
 
 int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9bbda9a..43dba02 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -296,6 +296,34 @@ static void _add_optional_clock_clkdev(struct omap_device *od,
 /* Public functions for use by core code */
 
 /**
+ * omap_device_set_max_dev_wakeup_lat - set/release a device constraint
+ * @od: struct omap_device *
+ * @req_od: struct omap_device *
+ *
+ * Using the primary hwmod, set/release a device constraint for the pdev
+ * device, requested by the req_pdev device.
+ *
+ * If any hwmods exist for the omap_device assoiated with @pdev and @req_pdev,
+ * set/release the constraint for the corresponding hwmods, otherwise return
+ * -EINVAL.
+ */
+int omap_device_set_max_dev_wakeup_lat(struct platform_device *req_pdev,
+				       struct platform_device *pdev, long t)
+{
+	struct omap_device *od, *req_od;
+	u32 ret = -EINVAL;
+
+	od = _find_by_pdev(pdev);
+	req_od = _find_by_pdev(req_pdev);
+
+	if ((od->hwmods_cnt) && (req_od->hwmods_cnt))
+		ret = omap_hwmod_set_max_dev_wakeup_lat(req_od->hwmods[0],
+							od->hwmods[0], t);
+
+	return ret;
+}
+
+/**
  * omap_device_get_context_loss_count - get lost context count
  * @od: struct omap_device *
  *
-- 
1.7.2.3

