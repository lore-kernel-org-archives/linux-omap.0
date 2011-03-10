From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 4/7] OMAP: PM CONSTRAINTS: implement the constraints management code
Date: Thu, 10 Mar 2011 18:47:24 +0100
Message-ID: <1299779247-20511-5-git-send-email-j-pihet@ti.com>
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55430 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab1CJRrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:48 -0500
Received: by mail-wy0-f174.google.com with SMTP id 21so1681959wya.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:48 -0800 (PST)
In-Reply-To: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

The code at omap device level manages the constraints: storage,
tracking of requesters and dispatching to the low level
code (e.g. powerdomain for the wake-up latency constraints).

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |   14 ++
 arch/arm/plat-omap/omap_device.c              |  202 +++++++++++++++++++++++++
 2 files changed, 216 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..d4766c4 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -32,9 +32,11 @@
 #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
 
 #include <linux/kernel.h>
+#include <linux/plist.h>
 #include <linux/platform_device.h>
 
 #include <plat/omap_hwmod.h>
+#include <plat/omap-pm.h>
 
 extern struct device omap_device_parent;
 
@@ -73,6 +75,15 @@ struct omap_device {
 	s8				pm_lat_level;
 	u8				hwmods_cnt;
 	u8				_state;
+
+};
+
+/* Linked list for the devices constraints entries */
+struct omap_device_constraints_entry {
+	struct device			*req_dev;
+	void				*target;
+	unsigned long			constraint_value;
+	struct plist_node		node;
 };
 
 /* Device driver interface (call via platform_data fn ptrs) */
@@ -107,6 +118,9 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
 int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
+int omap_device_set_dev_constraint(enum omap_pm_constraint_class class,
+				   struct device *req_dev,
+				   struct device *dev, long t);
 u32 omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9bbda9a..9199d3e 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -292,10 +292,205 @@ static void _add_optional_clock_clkdev(struct omap_device *od,
 	}
 }
 
+/* plist that stores the devices wake-up latency constraints */
+static struct plist_head _wkup_lat_constraints_list;
+/* Spinlock that protects the constraints lists */
+static spinlock_t _constraints_lock;
+/* Mutex that protects the constraints lists ops */
+static struct mutex _constraints_mutex;
+
+/*
+ * _store_constraint: add/update/remove a constraint from a plist
+ *
+ * @constraints_list: plist to use
+ * @req_dev: constraint requester, used to track the requests
+ * @target: target which the constraint applies to (e.g. power domain ID or
+ *  ptr for wake-up latency constraints)
+ * @value: constraint value. The plist is sorted by the value. -1 remove the
+ *  constraint from the list
+ * @ascending: return the lowest constraint value if set to 1, return the
+ *  highest value if not.
+ *
+ * Returns the strongest constraint value for the given target, 0 in the
+ * case there is no constraint on the given target or a negative value in
+ * case of error.
+ * The caller must check the validity of the parameters.
+ */
+static long _store_constraint(struct plist_head *constraints_list,
+			      struct device *req_dev, void *target,
+			      long value, int ascending)
+{
+	struct omap_device_constraints_entry *user;
+	int found = 0, ret = 0;
+
+	mutex_lock(&_constraints_mutex);
+
+	/* Check if the constraint requester is already in the list */
+	plist_for_each_entry(user, constraints_list, node) {
+		if (user->req_dev == req_dev) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (value >= 0) {
+		/* Add new entry to the list or update existing request */
+		if (found &&
+		    user->constraint_value == value &&
+		    user->target == target) {
+			goto exit_ok;
+		} else if (!found) {
+			user = kzalloc(
+				sizeof(struct omap_device_constraints_entry),
+				GFP_KERNEL);
+			if (!user) {
+				pr_err("%s: FATAL ERROR: kzalloc failed\n",
+				       __func__);
+				ret = -ENOMEM;
+				goto exit_error;
+			}
+			user->req_dev = req_dev;
+		} else {
+			plist_del(&user->node, constraints_list);
+		}
+
+		plist_node_init(&user->node, value);
+		plist_add(&user->node, constraints_list);
+		user->node.prio = user->constraint_value = value;
+		user->target = target;
+	} else {
+		/* Remove the constraint from the list */
+		if (!found) {
+			pr_err("%s: Error: no prior constraint to release\n",
+			       __func__);
+			ret = -EINVAL;
+			goto exit_error;
+		}
+
+		plist_del(&user->node, constraints_list);
+		kfree(user);
+	}
+
+exit_ok:
+	/* Find the strongest constraint for the given target */
+	ret = 0;
+	if (ascending) {
+		list_for_each_entry(user, &(constraints_list)->node_list,
+				    node.plist.node_list) {
+			/* Find the lowest (i.e. first) value for the target */
+			if (user->target == target) {
+				ret = user->constraint_value;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry_reverse(user,
+					    &(constraints_list)->node_list,
+					    node.plist.node_list) {
+			/* Find the highest (i.e. last) value for the target */
+			if (user->target == target) {
+				ret = user->constraint_value;
+				break;
+			}
+		}
+	}
+
+exit_error:
+	mutex_unlock(&_constraints_mutex);
+
+	return ret;
+}
 
 /* Public functions for use by core code */
 
 /**
+ * omap_device_set_dev_constraint - set/release a device constraint
+ * @class: constraint class
+ * @req_dev: constraint requester, used for tracking the constraints
+ * @dev: device to apply the constraint to. Must have an associated omap_device
+ * @t: constraint value. A value of -1 removes the constraint.
+ *
+ * Using the primary hwmod, set/release a device constraint for the dev
+ * device, requested by the req_dev device. Depending of the constraint class
+ * this code calls the appropriate low level code, e.g. power domain for
+ * the wake-up latency constraints.
+ *
+ * If any hwmods exist for the omap_device assoiated with @dev,
+ * set/release the constraint for the corresponding hwmods, otherwise return
+ * -EINVAL.
+ */
+int omap_device_set_dev_constraint(enum omap_pm_constraint_class class,
+				   struct device *req_dev,
+				   struct device *dev, long t)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	struct powerdomain *pwrdm = NULL;
+	u32 ret = -EINVAL;
+
+	/* Look for the platform device for dev */
+	pdev = to_platform_device(dev);
+
+	/* Try to catch non platform devices. */
+	if (pdev->name == NULL) {
+		pr_err("%s: Error: platform device for device %s not valid\n",
+		       __func__, dev_name(dev));
+		return -EINVAL;
+	}
+
+	/* Find the associated omap_device for dev */
+	od = _find_by_pdev(pdev);
+	if (!(od->hwmods_cnt)) {
+		pr_err("%s: Error: No hwmod for device %s\n",
+		       __func__, dev_name(dev));
+		return -EINVAL;
+	}
+
+	/* Find the associated omap_hwmod for dev */
+	oh = od->hwmods[0];
+
+	switch (class) {
+	case OMAP_PM_CONSTRAINT_WKUP_LAT:
+		/* Find the pwrdm associated to dev */
+		pwrdm = omap_device_get_pwrdm(od);
+		if (!pwrdm) {
+			pr_err("%s: Error: No pwrdm for device %s\n",
+			       __func__, dev_name(dev));
+			ret = -EINVAL;
+			break;
+		}
+
+		/*
+		 * Store the constraint in the appropriate list and find the
+		 * strongest constraint for the given pwrdm
+		 */
+		ret = _store_constraint(&_wkup_lat_constraints_list,
+					req_dev, (void *) pwrdm, t, 1);
+
+		/* Apply the constraint to the corresponding pwrdm */
+		if (ret >= 0) {
+			ret = omap_hwmod_update_power_state(oh, ret);
+		} else {
+			pr_err("%s: Error storing the constraint for device "
+			       "%s\n", __func__, dev_name(dev));
+		}
+
+		break;
+	case OMAP_PM_CONSTRAINT_THROUGHPUT:
+		WARN(1, "OMAP PM: %s: Bus throughput constraint class \
+		     not implemented\n", __func__);
+		ret = -EINVAL;
+		break;
+	default:
+		WARN(1, "OMAP PM: %s: invalid constraint class %d",
+		     __func__, class);
+	}
+
+	return ret;
+}
+
+/**
  * omap_device_get_context_loss_count - get lost context count
  * @od: struct omap_device *
  *
@@ -824,6 +1019,13 @@ struct device omap_device_parent = {
 
 static int __init omap_device_init(void)
 {
+	/* Initialize priority ordered list for wakeup latency constraint */
+	spin_lock_init(&_constraints_lock);
+	plist_head_init(&_wkup_lat_constraints_list, &_constraints_lock);
+
+	/* res_mutex protects res_list add and del ops */
+	mutex_init(&_constraints_mutex);
+
 	return device_register(&omap_device_parent);
 }
 core_initcall(omap_device_init);
-- 
1.7.2.3

