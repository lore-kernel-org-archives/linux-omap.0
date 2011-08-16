From: jean.pihet@newoldbits.com
Subject: [PATCH 07/15] PM QoS: add a global notification mechanism for the device constraints
Date: Tue, 16 Aug 2011 15:43:10 +0200
Message-ID: <1313502198-9298-8-git-send-email-j-pihet@ti.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44958 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab1HPNn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 09:43:57 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so81627wyg.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 06:43:57 -0700 (PDT)
In-Reply-To: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Add a global notification chain that gets called upon changes to the
aggregated constraint value for any device.
The notification callbacks are passing the full constraint request data
in order for the callees to have access to it. The current use is for the
platform low-level code to access the target device of the constraint.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/qos.c |   84 ++++++++++++++++++++++++++++++++++++----------
 include/linux/pm_qos.h   |   11 ++++++
 kernel/power/qos.c       |    2 +-
 3 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 304d68d..b52b3e8 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -8,6 +8,12 @@
  *
  * This QoS design is best effort based. Dependents register their QoS needs.
  * Watchers register to keep track of the current QoS needs of the system.
+ * Watchers can register different types of notification callbacks:
+ *  . a per-device notification callback using the dev_pm_qos_*_notifier API.
+ *    The notification chain data is stored in the per-device constraint
+ *    data struct.
+ *  . a system-wide notification callback using the dev_pm_qos_*_global_notifier
+ *    API. The notification chain data is stored in a static variable.
  *
  * Note about the per-device constraint data struct allocation:
  * . The per-device constraints data struct ptr is tored into the device
@@ -36,8 +42,32 @@
 
 
 static DEFINE_MUTEX(dev_pm_qos_mtx);
+static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
 static void dev_pm_qos_constraints_allocate(struct device *dev);
 
+/*
+ * Update the constraints list using the PM QoS core code and
+ * if needed call the per-device and the global notification callbacks
+ */
+static int _apply_constraint(struct dev_pm_qos_request *req,
+			     enum pm_qos_req_action action, int value)
+{
+	int ret, curr_value;
+
+	ret = pm_qos_update_target(req->dev->power.constraints,
+				   &req->node, action, value);
+
+	if (ret) {
+		/* Call the global callbacks if needed */
+		curr_value = pm_qos_read_value(req->dev->power.constraints);
+		blocking_notifier_call_chain(&dev_pm_notifiers,
+					     (unsigned long)curr_value,
+					     req);
+	}
+
+	return ret;
+}
+
 /**
  * dev_pm_qos_add_request - inserts new qos request into the list
  * @dev: target device for the constraint
@@ -66,16 +96,13 @@ void dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 	dev_pm_qos_constraints_allocate(dev);
 
 	mutex_lock(&dev_pm_qos_mtx);
-
 	req->dev = dev;
 
 	/* Silently return if the device has been removed */
 	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
 		goto out;
 
-	pm_qos_update_target(dev->power.constraints,
-			     &req->node, PM_QOS_ADD_REQ, value);
-
+	_apply_constraint(req, PM_QOS_ADD_REQ, value);
 out:
 	mutex_unlock(&dev_pm_qos_mtx);
 }
@@ -92,7 +119,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
  * Attempts are made to make this code callable on hot code paths.
  */
 void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
-			   s32 new_value)
+			       s32 new_value)
 {
 	if (!req) /*guard against callers passing in null */
 		return;
@@ -110,9 +137,7 @@ void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 		goto out;
 
 	if (new_value != req->node.prio)
-		pm_qos_update_target(
-			req->dev->power.constraints,
-			&req->node, PM_QOS_UPDATE_REQ, new_value);
+		_apply_constraint(req, PM_QOS_UPDATE_REQ, new_value);
 
 out:
 	mutex_unlock(&dev_pm_qos_mtx);
@@ -143,9 +168,7 @@ void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
 		goto out;
 
-	pm_qos_update_target(req->dev->power.constraints,
-			     &req->node, PM_QOS_REMOVE_REQ,
-			     PM_QOS_DEFAULT_VALUE);
+	_apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 	memset(req, 0, sizeof(*req));
 
 out:
@@ -214,6 +237,36 @@ out:
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
 
+/**
+ * dev_pm_qos_add_global_notifier - sets notification entry for changes to
+ * target value of the PM QoS constraints for any device
+ *
+ * @notifier: notifier block managed by caller.
+ *
+ * Will register the notifier into a notification chain that gets called
+ * upon changes to the target value for any device.
+ */
+int dev_pm_qos_add_global_notifier(struct notifier_block *notifier)
+{
+	return blocking_notifier_chain_register(&dev_pm_notifiers, notifier);
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_add_global_notifier);
+
+/**
+ * dev_pm_qos_remove_global_notifier - deletes notification for changes to
+ * target value of PM QoS constraints for any device
+ *
+ * @notifier: notifier block to be removed.
+ *
+ * Will remove the notifier from the notification chain that gets called
+ * upon changes to the target value for any device.
+ */
+int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier)
+{
+	return blocking_notifier_chain_unregister(&dev_pm_notifiers, notifier);
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_remove_global_notifier);
+
 /* Called at the first call to add_request, for constraint data allocation */
 static void dev_pm_qos_constraints_allocate(struct device *dev)
 {
@@ -272,13 +325,8 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		plist_for_each_entry_safe(req, tmp,
 					  &dev->power.constraints->list,
 					  node)
-			/*
-			 * Update constraints list and call the per-device
-			 * callbacks if needed
-			 */
-			pm_qos_update_target(req->dev->power.constraints,
-					     &req->node, PM_QOS_REMOVE_REQ,
-					     PM_QOS_DEFAULT_VALUE);
+			_apply_constraint(req, PM_QOS_REMOVE_REQ,
+					  PM_QOS_DEFAULT_VALUE);
 
 		kfree(dev->power.constraints->notifiers);
 		kfree(dev->power.constraints);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index d3e2d80..950c1b2 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -75,6 +75,7 @@ int pm_qos_request(int pm_qos_class);
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request *req);
+s32 pm_qos_read_value(struct pm_qos_constraints *c);
 
 void dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			    s32 value);
@@ -84,6 +85,8 @@ int dev_pm_qos_add_notifier(struct device *dev,
 			    struct notifier_block *notifier);
 int dev_pm_qos_remove_notifier(struct device *dev,
 			       struct notifier_block *notifier);
+int dev_pm_qos_add_global_notifier(struct notifier_block *notifier);
+int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier);
 void dev_pm_qos_constraints_init(struct device *dev);
 void dev_pm_qos_constraints_destroy(struct device *dev);
 #else
@@ -111,6 +114,8 @@ static inline int pm_qos_remove_notifier(int pm_qos_class,
 			{ return 0; }
 static inline int pm_qos_request_active(struct pm_qos_request *req)
 			{ return 0; }
+static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
+			{ return 0; }
 
 static inline void dev_pm_qos_add_request(struct device *dev,
 					  struct dev_pm_qos_request *req,
@@ -127,6 +132,12 @@ static inline int dev_pm_qos_add_notifier(struct device *dev,
 static inline int dev_pm_qos_remove_notifier(struct device *dev,
 					     struct notifier_block *notifier)
 			{ return 0; }
+static inline int dev_pm_qos_add_global_notifier(
+					struct notifier_block *notifier)
+			{ return 0; }
+static inline int dev_pm_qos_remove_global_notifier(
+					struct notifier_block *notifier)
+			{ return 0; }
 static inline void dev_pm_qos_constraints_init(struct device *dev)
 			{ return; }
 static inline void dev_pm_qos_constraints_destroy(struct device *dev)
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 7c7cd18..1c1797d 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -140,7 +140,7 @@ static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 	}
 }
 
-static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
+s32 pm_qos_read_value(struct pm_qos_constraints *c)
 {
 	return c->target_value;
 }
-- 
1.7.4.1

