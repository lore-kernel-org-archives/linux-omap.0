From: jean.pihet@newoldbits.com
Subject: [PATCH 07/15] PM QoS: add a global notification mechanism for the device constraints
Date: Thu, 11 Aug 2011 17:06:44 +0200
Message-ID: <1313075212-8366-8-git-send-email-j-pihet@ti.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1HKPHq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:07:46 -0400
Received: by wyg24 with SMTP id 24so1487733wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:07:44 -0700 (PDT)
In-Reply-To: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
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
 drivers/base/power/qos.c |  114 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/pm_qos.h   |   11 ++++
 kernel/power/qos.c       |    2 +-
 3 files changed, 113 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 465e419..4b0b316 100644
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
@@ -41,6 +47,7 @@
 #include <linux/kernel.h>
 
 
+static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
 static void dev_pm_qos_constraints_allocate(struct device *dev);
 
 int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
@@ -64,6 +71,8 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_request_active);
 void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
 			    s32 value)
 {
+	int ret, curr_value;
+
 	if (!req) /*guard against callers passing in null */
 		return;
 
@@ -82,8 +91,19 @@ void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
 	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
 		return;
 
-	pm_qos_update_target(dev->power.constraints,
-			     &req->node, PM_QOS_ADD_REQ, value);
+	/*
+	 * Update constraints list and call the per-device callbacks if needed
+	 */
+	ret = pm_qos_update_target(dev->power.constraints,
+				   &req->node, PM_QOS_ADD_REQ, value);
+
+	if (ret) {
+		/* Call the global callbacks if needed */
+		curr_value = pm_qos_read_value(req->dev->power.constraints);
+		blocking_notifier_call_chain(&dev_pm_notifiers,
+					     (unsigned long)curr_value,
+					     req);
+	}
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
 
@@ -98,8 +118,10 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
  * Attempts are made to make this code callable on hot code paths.
  */
 void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
-			   s32 new_value)
+			       s32 new_value)
 {
+	int ret, curr_value;
+
 	if (!req) /*guard against callers passing in null */
 		return;
 
@@ -113,10 +135,23 @@ void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
 		return;
 
-	if (new_value != req->node.prio)
-		pm_qos_update_target(
-			req->dev->power.constraints,
-			&req->node, PM_QOS_UPDATE_REQ, new_value);
+	if (new_value != req->node.prio) {
+		/*
+		 * Update constraints list and call the per-device callbacks
+		 * if needed
+		 */
+		ret = pm_qos_update_target(req->dev->power.constraints,
+					   &req->node, PM_QOS_UPDATE_REQ,
+					   new_value);
+		if (ret) {
+			/* Call the global callbacks if needed */
+			curr_value = pm_qos_read_value(
+						req->dev->power.constraints);
+			blocking_notifier_call_chain(&dev_pm_notifiers,
+						     (unsigned long)curr_value,
+						     req);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
 
@@ -129,6 +164,8 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
  */
 void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 {
+	int ret, curr_value;
+
 	if (!req) /*guard against callers passing in null */
 		return;
 
@@ -142,9 +179,20 @@ void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
 		return;
 
-	pm_qos_update_target(req->dev->power.constraints,
-			     &req->node, PM_QOS_REMOVE_REQ,
-			     PM_QOS_DEFAULT_VALUE);
+	/*
+	 * Update constraints list and call the per-device callbacks if needed
+	 */
+	ret = pm_qos_update_target(req->dev->power.constraints,
+				   &req->node, PM_QOS_REMOVE_REQ,
+				   PM_QOS_DEFAULT_VALUE);
+
+	if (ret) {
+		/* Call the global callbacks if needed */
+		curr_value = pm_qos_read_value(req->dev->power.constraints);
+		blocking_notifier_call_chain(&dev_pm_notifiers,
+					     (unsigned long)curr_value,
+					     req);
+	}
 	memset(req, 0, sizeof(*req));
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
@@ -202,6 +250,36 @@ int dev_pm_qos_remove_notifier(struct device *dev,
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
@@ -239,6 +317,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 {
 	struct dev_pm_qos_request *req, *tmp;
 	enum dev_pm_qos_state constraints_state = dev->power.constraints_state;
+	int ret = 0, curr_value;
 
 	dev->power.constraints_state = DEV_PM_QOS_NO_DEVICE;
 	if (constraints_state == DEV_PM_QOS_ALLOCATED) {
@@ -250,9 +329,18 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 			 * Update constraints list and call the per-device
 			 * callbacks if needed
 			 */
-			pm_qos_update_target(req->dev->power.constraints,
-					     &req->node, PM_QOS_REMOVE_REQ,
-					     PM_QOS_DEFAULT_VALUE);
+			ret |= pm_qos_update_target(req->dev->power.constraints,
+						    &req->node,
+						    PM_QOS_REMOVE_REQ,
+						    PM_QOS_DEFAULT_VALUE);
+
+		if (ret) {
+			/* Call the global callbacks if needed */
+			curr_value = dev->power.constraints->default_value;
+			blocking_notifier_call_chain(&dev_pm_notifiers,
+						     (unsigned long)curr_value,
+						     req);
+		}
 
 		kfree(dev->power.constraints->notifiers);
 		kfree(dev->power.constraints);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 178eaa1..69ccd3d 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -70,6 +70,7 @@ int pm_qos_request(int pm_qos_class);
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request *req);
+s32 pm_qos_read_value(struct pm_qos_constraints *c);
 
 int dev_pm_qos_request_active(struct dev_pm_qos_request *req);
 void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
@@ -80,6 +81,8 @@ int dev_pm_qos_add_notifier(struct device *dev,
 			    struct notifier_block *notifier);
 int dev_pm_qos_remove_notifier(struct device *dev,
 			       struct notifier_block *notifier);
+int dev_pm_qos_add_global_notifier(struct notifier_block *notifier);
+int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier);
 void dev_pm_qos_constraints_init(struct device *dev);
 void dev_pm_qos_constraints_destroy(struct device *dev);
 #else
@@ -107,6 +110,8 @@ static inline int pm_qos_remove_notifier(int pm_qos_class,
 			{ return 0; }
 static inline int pm_qos_request_active(struct pm_qos_request *req)
 			{ return 0; }
+static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
+			{ return 0; }
 
 static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
 			{ return 0; }
@@ -124,6 +129,12 @@ static inline int dev_pm_qos_add_notifier(struct device *dev,
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
index fc60f96..5607acb 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -139,7 +139,7 @@ static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 	}
 }
 
-static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
+s32 pm_qos_read_value(struct pm_qos_constraints *c)
 {
 	return c->target_value;
 }
-- 
1.7.2.5

