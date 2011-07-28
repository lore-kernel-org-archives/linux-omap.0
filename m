From: jean.pihet@newoldbits.com
Subject: [PATCH 05/13] PM: QoS: support the dynamic insertion and removal of devices
Date: Thu, 28 Jul 2011 10:30:12 +0200
Message-ID: <1311841821-10252-6-git-send-email-j-pihet@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38934 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab1G1IbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:31:04 -0400
Received: by wwe5 with SMTP id 5so2221922wwe.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:31:03 -0700 (PDT)
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The devices latency constraints class of PM QoS is storing the
constraints list in the device dev_pm_info struct.

This patch adds the init and de-init of the per-device constraints
list in order to support the dynamic insertion and removal
of the devices in the system.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/main.c |   10 ++++------
 include/linux/pm.h        |    1 +
 include/linux/pm_qos.h    |    2 ++
 kernel/pm_qos.c           |   30 ++++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 360c2c0..c86f97c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -97,12 +97,8 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
-	plist_head_init(&dev->power.latency_constraints.list, &dev->power.lock);
-	dev->power.latency_constraints.target_value =
-					PM_QOS_DEV_LAT_DEFAULT_VALUE;
-	dev->power.latency_constraints.default_value =
-					PM_QOS_DEV_LAT_DEFAULT_VALUE;
-	dev->power.latency_constraints.type = PM_QOS_MIN;
+	/* Call PM QoS to init the per-device latency constraints */
+	pm_qos_dev_constraints_init(dev);
 }
 
 /**
@@ -113,6 +109,8 @@ void device_pm_remove(struct device *dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
+	/* Call PM QoS to de-init the per-device latency constraints */
+	pm_qos_dev_constraints_deinit(dev);
 	complete_all(&dev->power.completion);
 	mutex_lock(&dpm_list_mtx);
 	list_del_init(&dev->power.entry);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 35e48a3..3ed53be 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -466,6 +466,7 @@ struct dev_pm_info {
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
 	struct pm_qos_constraints	latency_constraints;
+	int			latency_constraints_init;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index d72b16b..4d36537 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -63,4 +63,6 @@ int pm_qos_add_notifier(int class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request *req);
 
+void pm_qos_dev_constraints_init(struct device *dev);
+void pm_qos_dev_constraints_deinit(struct device *dev);
 #endif
diff --git a/kernel/pm_qos.c b/kernel/pm_qos.c
index 7edc6d0..361fc3f 100644
--- a/kernel/pm_qos.c
+++ b/kernel/pm_qos.c
@@ -202,6 +202,9 @@ static void update_target(struct pm_qos_request *req,
 			WARN(1, KERN_ERR "PM QoS API called with NULL dev\n");
 			return;
 		}
+		/* Silently return if the device is being released */
+		if (!req->dev->power.latency_constraints_init)
+			return;
 		c = &req->dev->power.latency_constraints;
 		break;
 	case PM_QOS_CPU_DMA_LATENCY:
@@ -387,6 +390,33 @@ int pm_qos_remove_notifier(int class, struct notifier_block *notifier)
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
+/* Called from the device PM subsystem at device init */
+void pm_qos_dev_constraints_init(struct device *dev)
+{
+	plist_head_init(&dev->power.latency_constraints.list, &dev->power.lock);
+	dev->power.latency_constraints.target_value =
+					PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	dev->power.latency_constraints.default_value =
+					PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	dev->power.latency_constraints.type = PM_QOS_MIN;
+	dev->power.latency_constraints_init = 1;
+}
+
+/* Called from the device PM subsystem at device release */
+void pm_qos_dev_constraints_deinit(struct device *dev)
+{
+	struct pm_qos_request *req, *tmp;
+
+	dev->power.latency_constraints_init = 0;
+
+	/* Flush the constraints list for the device */
+	plist_for_each_entry_safe(req, tmp,
+				  &dev->power.latency_constraints.list,
+				  node)
+		update_target(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+	plist_head_init(&dev->power.latency_constraints.list, &dev->power.lock);
+}
+
 static int register_pm_qos_misc(struct pm_qos_object *qos)
 {
 	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-- 
1.7.2.5

