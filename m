From: vvardhan@ti.com
Subject: [RFC] OMAP PM: Device wakeup latency constraint framework
Date: Wed, 11 Aug 2010 01:10:14 +0530
Message-ID: <1281469214-12176-1-git-send-email-vvardhan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46440 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0HJGHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 02:07:18 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7A67E95027030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 01:07:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vibhore Vardhan <vvardhan@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Vibhore Vardhan <vvardhan@ti.com>

This patch implements device wakeup latency constraint framework.
Using omap_pm_set_max_dev_wakeup_lat(), drivers can specify the
maximum amount of time for a device to become accessible after
its clocks are enabled. This is done by restricting the power
states that the parent powerdomain of a device can be put into.
Only power states with profiled wakeup latency value less than
the requested constraint get selected while the constraint is
active.

This patch is dependent on OMAP PM: MPU/DMA Latency constraints
patch (https://patchwork.kernel.org/patch/113855/)
Baseline used: linux-next
Tested on: Zoom 3630

Signed-off-by: Vibhore Vardhan <vvardhan@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c             |  164 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |   60 +++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |   32 +++++
 3 files changed, 256 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 6527ec3..16edec6 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -23,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 
 #include <asm/atomic.h>
 
@@ -133,6 +134,13 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
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
@@ -1075,3 +1083,159 @@ int pwrdm_post_transition(void)
 	return 0;
 }
 
+/**
+ * pwrdm_wakeuplat_set_constraint - Set powerdomain wakeup latency constraint
+ * @pwrdm: struct powerdomain * to which requesting device belongs to
+ * @dev: struct device * of requesting device
+ * @t: wakeup latency constraint in microseconds
+ *
+ * Adds new entry to powerdomain's wakeup latency constraint list.
+ * If the requesting device already exists in the list, old value is
+ * overwritten. Checks whether current power state is still adequate.
+ * Returns -EINVAL if the powerdomain or device pointer is NULL,
+ * or -ENOMEM if kmalloc fails, or -ERANGE if constraint can't be met,
+ * or returns 0 upon success.
+ */
+int pwrdm_wakeuplat_set_constraint (struct powerdomain *pwrdm,
+				    struct device *dev, unsigned long t)
+{
+	struct  wakeuplat_dev_list *user;
+	int found = 0, ret = 0;
+
+	if (!pwrdm || !dev) {
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&pwrdm->wakeuplat_mutex);
+
+	plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, node) {
+		if (user->dev == dev) {
+			found = 1;
+			break;
+		}
+	}
+
+	/* Add new entry to the list or update existing request */
+	if (found && user->constraint_us == t) {
+		goto exit_set;
+	} else if (!found) {
+		user = kzalloc(sizeof(struct wakeuplat_dev_list), GFP_KERNEL);
+		if (!user) {
+			pr_err("OMAP PM: FATAL ERROR: kzalloc failed\n");
+			ret = -ENOMEM;
+			goto exit_set;
+		}
+		user->dev = dev;
+	} else {
+		plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
+	}
+
+	plist_node_init(&user->node, t);
+	plist_add(&user->node, &pwrdm->wakeuplat_dev_list);
+	user->node.prio = user->constraint_us = t;
+
+	ret = pwrdm_wakeuplat_update_pwrst(pwrdm);
+
+exit_set:
+	mutex_unlock(&pwrdm->wakeuplat_mutex);
+
+	return ret;
+}
+
+/**
+ * pwrdm_wakeuplat_release_constraint - Release powerdomain wkuplat constraint
+ * @pwrdm: struct powerdomain * to which requesting device belongs to
+ * @dev: struct device * of requesting device
+ *
+ * Removes device's entry from powerdomain's wakeup latency constraint list.
+ * Checks whether current power state is still adequate.
+ * Returns -EINVAL if the powerdomain or device pointer is NULL or
+ * no such entry exists in the list, or returns 0 upon success.
+ */
+int pwrdm_wakeuplat_release_constraint (struct powerdomain *pwrdm,
+					struct device *dev)
+{
+	struct wakeuplat_dev_list *user;
+	int found = 0, ret = 0;
+
+	if (!pwrdm || !dev) {
+		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&pwrdm->wakeuplat_mutex);
+
+	plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, node) {
+		if (user->dev == dev) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_err("OMAP PM: Error: no prior constraint to release\n");
+		ret = -EINVAL;
+		goto exit_rls;
+	}
+
+	plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
+	kfree(user);
+
+	ret = pwrdm_wakeuplat_update_pwrst(pwrdm);
+
+exit_rls:
+	mutex_unlock(&pwrdm->wakeuplat_mutex);
+
+	return ret;
+}
+
+/**
+ * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
+ * @pwrdm: struct powerdomain * to which requesting device belongs to
+ *
+ * Finds minimum latency value from all entries in the list and
+ * the power domain power state neeting the constraint. Programs
+ * new state if it is different from current power state.
+ * Returns -EINVAL if the powerdomain or device pointer is NULL or
+ * no such entry exists in the list, or -ERANGE if constraint can't be met,
+ * or returns 0 upon success.
+ */
+int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm)
+{
+	struct plist_node *node;
+	int ret = 0, new_state;
+	unsigned long min_latency = -1;
+
+	if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) {
+		node = plist_last(&pwrdm->wakeuplat_dev_list);
+		min_latency = node->prio;
+	}
+
+	/* Find power state with wakeup latency < minimum constraint. */
+	for (new_state = 0x0; new_state < PWRDM_MAX_PWRSTS; new_state++) {
+		if (min_latency == -1 ||
+			pwrdm->wakeup_lat[new_state] < min_latency)
+			break;
+	}
+
+	/* No power state wkuplat met constraint. Keep power domain ON. */
+	if (new_state == PWRDM_MAX_PWRSTS) {
+		new_state = PWRDM_FUNC_PWRST_ON;
+		ret = -ERANGE;
+	}
+
+	/* OSWR is not supported, set CSWR instead. TODO: add OSWR support */
+	if (new_state == PWRDM_FUNC_PWRST_OSWR)
+		new_state = PWRDM_FUNC_PWRST_CSWR;
+
+	if (pwrdm->state != new_state)
+		set_pwrdm_state(pwrdm, new_state);
+
+	pr_debug("OMAP PM: %s pwrst: curr= %d, prev= %d next= %d "
+			"wkuplat_min= %lu, state= %d\n", pwrdm->name,
+		pwrdm_read_pwrst(pwrdm), pwrdm_read_prev_pwrst(pwrdm),
+		pwrdm_read_next_pwrst(pwrdm), min_latency, new_state);
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index fa90486..7be94ea 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -57,6 +57,12 @@ static struct powerdomain iva2_pwrdm = {
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
@@ -73,6 +79,12 @@ static struct powerdomain mpu_3xxx_pwrdm = {
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
@@ -99,6 +111,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
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
@@ -118,6 +136,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
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
@@ -133,6 +157,12 @@ static struct powerdomain dss_pwrdm = {
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
@@ -154,6 +184,12 @@ static struct powerdomain sgx_pwrdm = {
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
@@ -169,6 +205,12 @@ static struct powerdomain cam_pwrdm = {
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
@@ -184,6 +226,12 @@ static struct powerdomain per_pwrdm = {
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
@@ -198,6 +246,12 @@ static struct powerdomain neon_pwrdm = {
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
@@ -220,6 +274,12 @@ static struct powerdomain usbhost_pwrdm = {
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
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index fb6ec74..6ae5499 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -16,6 +16,9 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/plist.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
 
 #include <asm/atomic.h>
 
@@ -72,6 +75,16 @@
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
 
+/* Powerdomain functional power states */
+#define PWRDM_FUNC_PWRST_OFF	0x0
+#define PWRDM_FUNC_PWRST_OSWR	0x1
+#define PWRDM_FUNC_PWRST_CSWR	0x2
+#define PWRDM_FUNC_PWRST_ON	0x3
+
+#define PWRDM_MAX_FUNC_PWRSTS	4
+
+#define UNSUP_STATE -1
+
 struct clockdomain;
 struct powerdomain;
 
@@ -92,6 +105,10 @@ struct powerdomain;
  * @state_counter:
  * @timer:
  * @state_timer:
+ * @wakeup_lat: Wakeup latencies for possible powerdomain power states
+ * @wakeuplat_lock: spinlock for plist
+ * @wakeuplat_dev_list: plist_head linking all devices placing constraint
+ * @wakeuplat_mutex: mutex to protect per powerdomain list ops
  */
 struct powerdomain {
 	const char *name;
@@ -114,8 +131,17 @@ struct powerdomain {
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
 #endif
+	const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
+	spinlock_t wakeuplat_lock;
+	struct plist_head wakeuplat_dev_list;
+	struct mutex wakeuplat_mutex;
 };
 
+struct wakeuplat_dev_list {
+	struct device *dev;
+	unsigned long constraint_us;
+	struct plist_node node;
+};
 
 void pwrdm_init(struct powerdomain **pwrdm_list);
 
@@ -162,4 +188,10 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 
+int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
+				   struct device *dev, unsigned long t);
+int pwrdm_wakeuplat_release_constraint(struct powerdomain *pwrdm,
+				       struct device *dev);
+int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm);
+
 #endif
-- 
1.7.2

