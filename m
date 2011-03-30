From: jean.pihet@newoldbits.com
Subject: [PATCH 6/8] OMAP2+: omap_device: implement the constraints management code
Date: Wed, 30 Mar 2011 17:19:22 +0200
Message-ID: <1301498364-726-7-git-send-email-j-pihet@ti.com>
References: <1301498364-726-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46038 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab1C3PTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 11:19:42 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so1176228wya.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 08:19:41 -0700 (PDT)
In-Reply-To: <1301498364-726-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The code at omap device level manages the constraints: storage,
tracking of requesters and dispatching to the low level
code (e.g. powerdomain for the wake-up latency constraints).

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |   15 ++-
 arch/arm/plat-omap/omap_device.c              |  189 +++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..9a47b47 100644
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
 
@@ -54,8 +56,8 @@ extern struct device omap_device_parent;
  * @pm_lat_level: array index of the last odpl entry executed - -1 if never
  * @dev_wakeup_lat: dev wakeup latency in nanoseconds
  * @_dev_wakeup_lat_limit: dev wakeup latency limit in nsec - set by OMAP PM
+ * @wkup_lat_plist_head: devices wake-up latency constraints list
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
- * @flags: device flags
  *
  * Integrates omap_hwmod data into Linux platform_device.
  *
@@ -67,6 +69,7 @@ struct omap_device {
 	struct platform_device		pdev;
 	struct omap_hwmod		**hwmods;
 	struct omap_device_pm_latency	*pm_lats;
+	struct plist_head		wkup_lat_plist_head;
 	u32				dev_wakeup_lat;
 	u32				_dev_wakeup_lat_limit;
 	u8				pm_lats_cnt;
@@ -75,6 +78,13 @@ struct omap_device {
 	u8				_state;
 };
 
+/* Linked list for the devices constraints entries */
+struct omap_device_constraints_entry {
+	struct device			*dev;
+	struct device			*req_dev;
+	struct plist_node		node;
+};
+
 /* Device driver interface (call via platform_data fn ptrs) */
 
 int omap_device_enable(struct platform_device *pdev);
@@ -107,6 +117,9 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
 int omap_device_align_pm_lat(struct platform_device *pdev,
 			     u32 new_wakeup_lat_limit);
 struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
+int omap_device_set_dev_constraint(enum omap_pm_constraint_class class,
+				   struct device *req_dev,
+				   struct device *dev, long t);
 u32 omap_device_get_context_loss_count(struct platform_device *pdev);
 
 /* Other */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9bbda9a..eff577f 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -292,10 +292,194 @@ static void _add_optional_clock_clkdev(struct omap_device *od,
 	}
 }
 
+/* Spinlock that protects the constraints lists */
+static spinlock_t _constraints_lock;
+
+/*
+ * _store_constraint: add/update/remove a constraint from a plist. There is
+ *  one plist per omap_device.
+ *
+ * @constraints_list: plist to use
+ * @req_dev: constraint requester, used to track the requests
+ * @dev: device constraint target, used to track the requests
+ * @value: constraint value. The plist is sorted by the value. -1 remove the
+ *  constraint from the list
+ * @ascending: return the lowest constraint value if set to 1, return the
+ *  highest value if not.
+ *
+ * Tracks the constraints by req_dev and dev.
+ * Returns the strongest constraint value for the given device, 0 in the
+ * case there is no constraint or a negative value in case of error.
+ *
+ * The caller must check the validity of the parameters.
+ */
+static long _store_constraint(struct plist_head *constraints_list,
+			      struct device *req_dev, struct device *dev,
+			      long value, int ascending)
+{
+	struct omap_device_constraints_entry *user = NULL, *tmp_user;
+	int ret = 0;
+	unsigned long flags;
+
+	/* Check if there already is a constraint for dev and req_dev */
+	spin_lock_irqsave(&_constraints_lock, flags);
+	plist_for_each_entry(tmp_user, constraints_list, node) {
+		if ((tmp_user->req_dev == req_dev) && (tmp_user->dev == dev)) {
+			user = tmp_user;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&_constraints_lock, flags);
+
+	if (value >= 0) {
+		/* Nothing to update, job done */
+		if (user && (user->node.prio == value))
+			goto exit_ok;
+
+		/* Add new entry to the list or update existing request */
+		if (!user) {
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
+			user->dev = dev;
+		} else {
+			spin_lock_irqsave(&_constraints_lock, flags);
+			plist_del(&user->node, constraints_list);
+			spin_unlock_irqrestore(&_constraints_lock, flags);
+		}
+
+		spin_lock_irqsave(&_constraints_lock, flags);
+		plist_node_init(&user->node, value);
+		plist_add(&user->node, constraints_list);
+		spin_unlock_irqrestore(&_constraints_lock, flags);
+	} else {
+		/* Remove the constraint from the list */
+		if (!user) {
+			pr_err("%s: Error: no prior constraint to release\n",
+			       __func__);
+			ret = -EINVAL;
+			goto exit_error;
+		}
+
+		spin_lock_irqsave(&_constraints_lock, flags);
+		plist_del(&user->node, constraints_list);
+		spin_unlock_irqrestore(&_constraints_lock, flags);
+		kfree(user);
+	}
+
+exit_ok:
+	/* Find the strongest constraint for the given device */
+	spin_lock_irqsave(&_constraints_lock, flags);
+	if (ascending) {
+		/* Find the lowest (i.e. first) value */
+		ret = plist_first(constraints_list)->prio;
+	} else {
+		/* Find the highest (i.e. last) value */
+		ret = plist_last(constraints_list)->prio;
+	}
+	spin_unlock_irqrestore(&_constraints_lock, flags);
+
+exit_error:
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
+	void *cookie = NULL;
+	u32 ret = -EINVAL;
+
+	/* Only valid for omap_devices */
+	if (dev->parent != &omap_device_parent) {
+		pr_err("%s: Error: not an omap_device %s\n",
+		       __func__, dev_name(dev));
+		return -EINVAL;
+	}
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
+	if (!od || (od->hwmods_cnt != 1)) {
+		pr_err("%s: Error: No unique hwmod for device %s\n",
+		       __func__, dev_name(dev));
+		return -EINVAL;
+	}
+
+	/* Find the primary omap_hwmod for dev */
+	oh = od->hwmods[0];
+
+	switch (class) {
+	case OMAP_PM_CONSTRAINT_WKUP_LAT:
+		/*
+		 * Store the constraint in the appropriate list and find the
+		 * strongest constraint
+		 */
+		ret = _store_constraint(&od->wkup_lat_plist_head,
+					req_dev, dev, t, 1);
+
+		/* Apply the constraint by calling the low level code */
+		cookie = (void *) &od->wkup_lat_plist_head;
+		if (ret >= 0) {
+			ret = omap_hwmod_set_wkup_lat_constraint(oh, cookie,
+								 ret);
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
@@ -489,6 +673,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	od->pm_lats = pm_lats;
 	od->pm_lats_cnt = pm_lats_cnt;
 
+	plist_head_init(&od->wkup_lat_plist_head, &_constraints_lock);
+
 	if (is_early_device)
 		ret = omap_early_device_register(od);
 	else
@@ -824,6 +1010,9 @@ struct device omap_device_parent = {
 
 static int __init omap_device_init(void)
 {
+	/* Initialize priority ordered list for wakeup latency constraint */
+	spin_lock_init(&_constraints_lock);
+
 	return device_register(&omap_device_parent);
 }
 core_initcall(omap_device_init);
-- 
1.7.2.5

