From: jean.pihet@newoldbits.com
Subject: [PATCH 06/15] PM QoS: implement the per-device PM QoS constraints
Date: Thu, 11 Aug 2011 17:06:43 +0200
Message-ID: <1313075212-8366-7-git-send-email-j-pihet@ti.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1HKPHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:07:44 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1487550wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:07:43 -0700 (PDT)
In-Reply-To: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implement the per-device PM QoS constraints by creating a device
PM QoS API, which calls the PM QoS constraints management core code.

The per-device latency constraints data strctures are stored
in the device dev_pm_info struct.

The device PM code calls the init and destroy of the per-device constraints
data struct in order to support the dynamic insertion and removal of the
devices in the system.

To minimize the data usage by the per-device constraints, the data struct
is only allocated at the first call to dev_pm_qos_add_request.
The data is later free'd when the device is removed from the system.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/Makefile |    4 +-
 drivers/base/power/main.c   |    3 +
 drivers/base/power/qos.c    |  262 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h          |    9 ++
 include/linux/pm_qos.h      |   39 +++++++
 5 files changed, 315 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/power/qos.c

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 3647e11..1a61f89 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,8 +1,8 @@
-obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o
+obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o qos.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
-ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
\ No newline at end of file
+ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 06f09bf..f5c0e0e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 #include <linux/resume-trace.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
@@ -97,6 +98,7 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+	dev_pm_qos_constraints_init(dev);
 }
 
 /**
@@ -107,6 +109,7 @@ void device_pm_remove(struct device *dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
+	dev_pm_qos_constraints_destroy(dev);
 	complete_all(&dev->power.completion);
 	mutex_lock(&dpm_list_mtx);
 	list_del_init(&dev->power.entry);
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
new file mode 100644
index 0000000..465e419
--- /dev/null
+++ b/drivers/base/power/qos.c
@@ -0,0 +1,262 @@
+/*
+ * This module exposes the interface to kernel space for specifying
+ * per-device PM QoS dependencies. It provides infrastructure for registration
+ * of:
+ *
+ * Dependents on a QoS value : register requests
+ * Watchers of QoS value : get notified when target QoS value changes
+ *
+ * This QoS design is best effort based. Dependents register their QoS needs.
+ * Watchers register to keep track of the current QoS needs of the system.
+ *
+ * Note about the per-device constraint data struct allocation:
+ * . The per-device constraints data struct ptr is tored into the device
+ *    dev_pm_info.
+ * . To minimize the data usage by the per-device constraints, the data struct
+ *   is only allocated at the first call to dev_pm_qos_add_request.
+ * . The data is later free'd when the device is removed from the system.
+ * . The constraints_state variable from dev_pm_info tracks the data struct
+ *    allocation state:
+ *    DEV_PM_QOS_NO_DEVICE: No device present or device removed, no data
+ *     allocated,
+ *    DEV_PM_QOS_DEVICE_PRESENT: Device present, data not allocated and will be
+ *     allocated at the first call to dev_pm_qos_add_request,
+ *    DEV_PM_QOS_ALLOCATED: Device present, data allocated. The per-device
+ *     PM QoS constraints framework is operational and constraints can be
+ *     added, updated or removed using the dev_pm_qos_* API.
+ */
+
+/*#define DEBUG*/
+
+#include <linux/pm_qos.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+
+static void dev_pm_qos_constraints_allocate(struct device *dev);
+
+int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
+{
+	return req->dev != 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_request_active);
+
+/**
+ * dev_pm_qos_add_request - inserts new qos request into the list
+ * @req: pointer to a preallocated handle
+ * @dev: target device for the constraint
+ * @value: defines the qos request
+ *
+ * This function inserts a new entry in the device constraints list of
+ * requested qos performance characteristics. It recomputes the aggregate
+ * QoS expectations of parameters and initializes the dev_pm_qos_request
+ * handle.  Caller needs to save this handle for later use in updates and
+ * removal.
+ */
+void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
+			    s32 value)
+{
+	if (!req) /*guard against callers passing in null */
+		return;
+
+	if (dev_pm_qos_request_active(req)) {
+		WARN(1, KERN_ERR "dev_pm_qos_add_request() called for already "
+			"added request\n");
+		return;
+	}
+	req->dev = dev;
+
+	/* Allocate the constraints struct on the first call to add_request */
+	if (req->dev->power.constraints_state == DEV_PM_QOS_DEVICE_PRESENT)
+		dev_pm_qos_constraints_allocate(dev);
+
+	/* Silently return if the device has been removed */
+	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
+		return;
+
+	pm_qos_update_target(dev->power.constraints,
+			     &req->node, PM_QOS_ADD_REQ, value);
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
+
+/**
+ * dev_pm_qos_update_request - modifies an existing qos request
+ * @req : handle to list element holding a dev_pm_qos request to use
+ * @value: defines the qos request
+ *
+ * Updates an existing dev PM qos request along with updating the
+ * target value.
+ *
+ * Attempts are made to make this code callable on hot code paths.
+ */
+void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
+			   s32 new_value)
+{
+	if (!req) /*guard against callers passing in null */
+		return;
+
+	if (!dev_pm_qos_request_active(req)) {
+		WARN(1, KERN_ERR "dev_pm_qos_update_request() called for "
+			"unknown object\n");
+		return;
+	}
+
+	/* Silently return if the device has been removed */
+	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
+		return;
+
+	if (new_value != req->node.prio)
+		pm_qos_update_target(
+			req->dev->power.constraints,
+			&req->node, PM_QOS_UPDATE_REQ, new_value);
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
+
+/**
+ * dev_pm_qos_remove_request - modifies an existing qos request
+ * @req: handle to request list element
+ *
+ * Will remove pm qos request from the list of constraints and
+ * recompute the current target value. Call this on slow code paths.
+ */
+void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
+{
+	if (!req) /*guard against callers passing in null */
+		return;
+
+	if (!dev_pm_qos_request_active(req)) {
+		WARN(1, KERN_ERR "dev_pm_qos_remove_request() called for "
+			"unknown object\n");
+		return;
+	}
+
+	/* Silently return if the device has been removed */
+	if (req->dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
+		return;
+
+	pm_qos_update_target(req->dev->power.constraints,
+			     &req->node, PM_QOS_REMOVE_REQ,
+			     PM_QOS_DEFAULT_VALUE);
+	memset(req, 0, sizeof(*req));
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
+
+/**
+ * dev_pm_qos_add_notifier - sets notification entry for changes to target value
+ * of per-device PM QoS constraints
+ *
+ * @dev: target device for the constraint
+ * @notifier: notifier block managed by caller.
+ *
+ * Will register the notifier into a notification chain that gets called
+ * upon changes to the target value for the device.
+ */
+int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
+{
+	int retval = 0;
+
+	/* Silently return if the device has been removed */
+	if (dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
+		return retval;
+
+	retval = blocking_notifier_chain_register(
+			dev->power.constraints->notifiers,
+			notifier);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
+
+/**
+ * dev_pm_qos_remove_notifier - deletes notification for changes to target value
+ * of per-device PM QoS constraints
+ *
+ * @dev: target device for the constraint
+ * @notifier: notifier block to be removed.
+ *
+ * Will remove the notifier from the notification chain that gets called
+ * upon changes to the target value.
+ */
+int dev_pm_qos_remove_notifier(struct device *dev,
+			       struct notifier_block *notifier)
+{
+	int retval = 0;
+
+	/* Silently return if the device has been removed */
+	if (dev->power.constraints_state != DEV_PM_QOS_ALLOCATED)
+		return retval;
+
+	retval = blocking_notifier_chain_unregister(
+			dev->power.constraints->notifiers,
+			notifier);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
+
+/* Called at the first call to add_request, for constraint data allocation */
+static void dev_pm_qos_constraints_allocate(struct device *dev)
+{
+	struct pm_qos_constraints *c;
+	struct blocking_notifier_head *n;
+
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return;
+
+	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	if (!n) {
+		kfree(c);
+		return;
+	}
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
+	dev->power.constraints = c;
+	plist_head_init(&dev->power.constraints->list, &dev->power.lock);
+	dev->power.constraints->target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	dev->power.constraints->default_value =	PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	dev->power.constraints->type = PM_QOS_MIN;
+	dev->power.constraints->notifiers = n;
+	dev->power.constraints_state = DEV_PM_QOS_ALLOCATED;
+}
+
+/* Called from the device PM subsystem at device insertion */
+void dev_pm_qos_constraints_init(struct device *dev)
+{
+	dev->power.constraints_state = DEV_PM_QOS_DEVICE_PRESENT;
+}
+
+/* Called from the device PM subsystem at device removal */
+void dev_pm_qos_constraints_destroy(struct device *dev)
+{
+	struct dev_pm_qos_request *req, *tmp;
+	enum dev_pm_qos_state constraints_state = dev->power.constraints_state;
+
+	dev->power.constraints_state = DEV_PM_QOS_NO_DEVICE;
+	if (constraints_state == DEV_PM_QOS_ALLOCATED) {
+		/* Flush the constraints list for the device */
+		plist_for_each_entry_safe(req, tmp,
+					  &dev->power.constraints->list,
+					  node)
+			/*
+			 * Update constraints list and call the per-device
+			 * callbacks if needed
+			 */
+			pm_qos_update_target(req->dev->power.constraints,
+					     &req->node, PM_QOS_REMOVE_REQ,
+					     PM_QOS_DEFAULT_VALUE);
+
+		kfree(dev->power.constraints->notifiers);
+		kfree(dev->power.constraints);
+		dev->power.constraints = NULL;
+	}
+}
+
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 411e4f4..aa6dc53 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -421,6 +421,13 @@ enum rpm_request {
 
 struct wakeup_source;
 
+/* Per-device PM QoS constraints data struct state */
+enum dev_pm_qos_state {
+	DEV_PM_QOS_NO_DEVICE,		/* No device present */
+	DEV_PM_QOS_DEVICE_PRESENT,	/* Device present, data not allocated */
+	DEV_PM_QOS_ALLOCATED,		/* Device present, data allocated */
+};
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -463,6 +470,8 @@ struct dev_pm_info {
 	unsigned long		accounting_timestamp;
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	struct pm_qos_constraints *constraints;
+	enum dev_pm_qos_state	constraints_state;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 84aa150..178eaa1 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -19,12 +19,18 @@
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
+#define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
 
 struct pm_qos_request {
 	struct plist_node node;
 	int pm_qos_class;
 };
 
+struct dev_pm_qos_request {
+	struct plist_node node;
+	struct device *dev;
+};
+
 enum pm_qos_type {
 	PM_QOS_UNITIALIZED,
 	PM_QOS_MAX,		/* return the largest value */
@@ -64,6 +70,18 @@ int pm_qos_request(int pm_qos_class);
 int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request *req);
+
+int dev_pm_qos_request_active(struct dev_pm_qos_request *req);
+void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct device *dev,
+			    s32 value);
+void dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
+void dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
+int dev_pm_qos_add_notifier(struct device *dev,
+			    struct notifier_block *notifier);
+int dev_pm_qos_remove_notifier(struct device *dev,
+			       struct notifier_block *notifier);
+void dev_pm_qos_constraints_init(struct device *dev);
+void dev_pm_qos_constraints_destroy(struct device *dev);
 #else
 static inline int pm_qos_update_target(struct pm_qos_constraints *c,
 				       struct plist_node *node,
@@ -89,6 +107,27 @@ static inline int pm_qos_remove_notifier(int pm_qos_class,
 			{ return 0; }
 static inline int pm_qos_request_active(struct pm_qos_request *req)
 			{ return 0; }
+
+static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
+			{ return 0; }
+static inline void dev_pm_qos_add_request(struct dev_pm_qos_request *req,
+					  struct device *dev, s32 value)
+			{ return; }
+static inline void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
+					     s32 new_value)
+			{ return; }
+static inline void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
+			{ return; }
+static inline int dev_pm_qos_add_notifier(struct device *dev,
+					  struct notifier_block *notifier)
+			{ return 0; }
+static inline int dev_pm_qos_remove_notifier(struct device *dev,
+					     struct notifier_block *notifier)
+			{ return 0; }
+static inline void dev_pm_qos_constraints_init(struct device *dev)
+			{ return; }
+static inline void dev_pm_qos_constraints_destroy(struct device *dev)
+			{ return; }
 #endif
 
 #endif
-- 
1.7.2.5

