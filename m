From: jean.pihet@newoldbits.com
Subject: [PATCH 04/13] PM: QoS: implement the per-device latency constraints
Date: Thu, 28 Jul 2011 10:30:11 +0200
Message-ID: <1311841821-10252-5-git-send-email-j-pihet@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48760 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab1G1IbC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:31:02 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so2221867wwe.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:31:01 -0700 (PDT)
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Re-design the PM QoS implementation to support the per-device
constraints:

- Define a pm_qos_constraints struct for the storage of the constraints
list and associated values (target_value, default_value, type ...).

- Update the pm_qos_object struct with the information related to a
PM QoS class: ptr to constraints list, notifer ptr, name ...

- Each PM QoS class statically declare objects for pm_qos_object and
pm_qos_constraints. The only exception is the devices constraints, cf. below.

- The device constraints class is statically declaring a pm_qos_object. The
pm_qos_constraints are per-device and so are embedded into the device struct.

- The PM QoS internal functions are updated to operate on the pm_qos_constraints
structs for the constraints management, and on pm_qos_object for other the PM QoS
functionality (notifiers, export as misc devices...).

- The PM QoS events notification callbacks are passing the full constraint
request data in order for the callees to have access to it. The current use
is for the platform low-level code to access the target device of the constraint

- User space API: the PM QoS classes -excepted PM_QOS_DEV_LATENCY- are exporting
a MISC entry in /dev. PM_QOS_DEV_LATENCY shall export a per-device sysfs entry, this
support is coming as a subsequent patch.

- Misc fixes to improve code readability:
  . rename of fields names (request, list, constraints, class),
  . simplification of the in-kernel API implementation. The main logic part is
    now implemented in the update_target function.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/main.c |    7 +-
 include/linux/pm.h        |    3 +-
 include/linux/pm_qos.h    |   23 ++++-
 kernel/pm_qos.c           |  248 +++++++++++++++++++++++++-------------------
 4 files changed, 170 insertions(+), 111 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dad2eb9..360c2c0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -97,7 +97,12 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
-	plist_head_init(&dev->power.latency_constraints, &dev->power.lock);
+	plist_head_init(&dev->power.latency_constraints.list, &dev->power.lock);
+	dev->power.latency_constraints.target_value =
+					PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	dev->power.latency_constraints.default_value =
+					PM_QOS_DEV_LAT_DEFAULT_VALUE;
+	dev->power.latency_constraints.type = PM_QOS_MIN;
 }
 
 /**
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 23c85f1..35e48a3 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -28,6 +28,7 @@
 #include <linux/wait.h>
 #include <linux/timer.h>
 #include <linux/completion.h>
+#include <linux/pm_qos.h>
 
 /*
  * Callbacks for platform drivers to implement.
@@ -464,7 +465,7 @@ struct dev_pm_info {
 	unsigned long		accounting_timestamp;
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
-	struct plist_head	latency_constraints;
+	struct pm_qos_constraints	latency_constraints;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index a2e4409..d72b16b 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -6,7 +6,6 @@
  */
 #include <linux/plist.h>
 #include <linux/notifier.h>
-#include <linux/miscdevice.h>
 
 #define PM_QOS_RESERVED			0
 #define PM_QOS_CPU_DMA_LATENCY		1
@@ -22,8 +21,28 @@
 #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 
+enum pm_qos_type {
+	PM_QOS_MAX,		/* return the largest value */
+	PM_QOS_MIN		/* return the smallest value */
+};
+
+struct pm_qos_constraints {
+	struct plist_head list;
+	/*
+	 * Do not change target_value to 64 bit in order to guarantee
+	 * accesses atomicity
+	 */
+	s32 target_value;
+	s32 default_value;
+	enum pm_qos_type type;
+};
+
+/*
+ * Struct that is pre-allocated by the caller.
+ * The handle is kept for future use (update, removal)
+ */
 struct pm_qos_request {
-	struct plist_node list;
+	struct plist_node node;
 	int class;
 	struct device *dev;
 };
diff --git a/kernel/pm_qos.c b/kernel/pm_qos.c
index 4ede3cd..7edc6d0 100644
--- a/kernel/pm_qos.c
+++ b/kernel/pm_qos.c
@@ -49,71 +49,81 @@
  * or pm_qos_object list and pm_qos_objects need to happen with pm_qos_lock
  * held, taken with _irqsave.  One lock to rule them all
  */
-enum pm_qos_type {
-	PM_QOS_MAX,		/* return the largest value */
-	PM_QOS_MIN		/* return the smallest value */
+
+enum pm_qos_req_action {
+	PM_QOS_ADD_REQ,
+	PM_QOS_UPDATE_REQ,
+	PM_QOS_REMOVE_REQ
 };
 
-/*
- * Note: The lockless read path depends on the CPU accessing
- * target_value atomically.  Atomic access is only guaranteed on all CPU
- * types linux supports for 32 bit quantites
- */
 struct pm_qos_object {
-	struct plist_head requests;
+	struct pm_qos_constraints *constraints;
 	struct blocking_notifier_head *notifiers;
 	struct miscdevice pm_qos_power_miscdev;
 	char *name;
-	s32 target_value;	/* Do not change to 64 bit */
-	s32 default_value;
-	enum pm_qos_type type;
 };
 
 static DEFINE_SPINLOCK(pm_qos_lock);
 
 static struct pm_qos_object null_pm_qos;
+
+/* CPU/DMA latency constraints PM QoS object */
+static struct pm_qos_constraints cpu_dma_constraints = {
+	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list, pm_qos_lock),
+	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
+	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
+	.type = PM_QOS_MIN,
+};
 static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
 static struct pm_qos_object cpu_dma_pm_qos = {
-	.requests = PLIST_HEAD_INIT(cpu_dma_pm_qos.requests, pm_qos_lock),
+	.constraints = &cpu_dma_constraints,
 	.notifiers = &cpu_dma_lat_notifier,
 	.name = "cpu_dma_latency",
-	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
-	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
-	.type = PM_QOS_MIN,
 };
 
+/*
+ * Per-device latency constraints PM QoS object
+ *
+ * The constraints are stored in the device struct data.
+ * No misc device is exported to /dev, instead the user space API
+ * shall use a per-device /sysfs entry.
+ */
 static BLOCKING_NOTIFIER_HEAD(dev_lat_notifier);
 static struct pm_qos_object dev_pm_qos = {
-	.requests = PLIST_HEAD_INIT(dev_pm_qos.requests, pm_qos_lock),
+	.constraints = NULL,
 	.notifiers = &dev_lat_notifier,
+	.pm_qos_power_miscdev = { .minor = -1 },
 	.name = "dev_latency",
-	.target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
-	.default_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
-	.type = PM_QOS_MIN,
 };
 
+/* Network latency constraints PM QoS object */
+static struct pm_qos_constraints network_lat_constraints = {
+	.list = PLIST_HEAD_INIT(network_lat_constraints.list, pm_qos_lock),
+	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
+	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
+	.type = PM_QOS_MIN
+};
 static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
-	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
+	.constraints = &network_lat_constraints,
 	.notifiers = &network_lat_notifier,
 	.name = "network_latency",
-	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
-	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
-	.type = PM_QOS_MIN
 };
 
-
+/* Network throughput constraints PM QoS object */
+static struct pm_qos_constraints network_tput_constraints = {
+	.list = PLIST_HEAD_INIT(network_tput_constraints.list, pm_qos_lock),
+	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
+	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
+	.type = PM_QOS_MAX,
+};
 static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
 static struct pm_qos_object network_throughput_pm_qos = {
-	.requests = PLIST_HEAD_INIT(network_throughput_pm_qos.requests, pm_qos_lock),
+	.constraints = &network_tput_constraints,
 	.notifiers = &network_throughput_notifier,
 	.name = "network_throughput",
-	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
-	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
-	.type = PM_QOS_MAX,
 };
 
-
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
@@ -138,17 +148,17 @@ static const struct file_operations pm_qos_power_fops = {
 };
 
 /* unlocked internal variant */
-static inline int pm_qos_get_value(struct pm_qos_object *o)
+static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 {
-	if (plist_head_empty(&o->requests))
-		return o->default_value;
+	if (plist_head_empty(&c->list))
+		return c->default_value;
 
-	switch (o->type) {
+	switch (c->type) {
 	case PM_QOS_MIN:
-		return plist_first(&o->requests)->prio;
+		return plist_first(&c->list)->prio;
 
 	case PM_QOS_MAX:
-		return plist_last(&o->requests)->prio;
+		return plist_last(&c->list)->prio;
 
 	default:
 		/* runtime check for not using enum */
@@ -156,69 +166,92 @@ static inline int pm_qos_get_value(struct pm_qos_object *o)
 	}
 }
 
-static inline s32 pm_qos_read_value(struct pm_qos_object *o)
+/*
+ * pm_qos_read_value atomically reads and returns target_value.
+ * target_value is updated upon update of the constraints list, using
+ * pm_qos_set_value.
+ *
+ * Note: The lockless read path depends on the CPU accessing
+ * target_value atomically.  Atomic access is only guaranteed on all CPU
+ * types linux supports for 32 bit quantites
+ */
+static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
 {
-	return o->target_value;
+	if (c)
+		return c->target_value;
+	else
+		return 0;
 }
 
-static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
+static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 {
-	o->target_value = value;
+	c->target_value = value;
 }
 
-static void update_target(struct pm_qos_object *o, struct plist_node *node,
-			  int del, int value)
+static void update_target(struct pm_qos_request *req,
+			  enum pm_qos_req_action action, int value)
 {
 	unsigned long flags;
-	int prev_value, curr_value;
+	int prev_value, curr_value, new_value;
+	struct pm_qos_object *o = pm_qos_array[req->class];
+	struct pm_qos_constraints *c;
+
+	switch (req->class) {
+	case PM_QOS_DEV_LATENCY:
+		if (!req->dev) {
+			WARN(1, KERN_ERR "PM QoS API called with NULL dev\n");
+			return;
+		}
+		c = &req->dev->power.latency_constraints;
+		break;
+	case PM_QOS_CPU_DMA_LATENCY:
+	case PM_QOS_NETWORK_LATENCY:
+	case PM_QOS_NETWORK_THROUGHPUT:
+		c = o->constraints;
+		break;
+	case PM_QOS_RESERVED:
+	default:
+		WARN(1, KERN_ERR "PM QoS API called with wrong class %d, "
+			"req 0x%p\n", req->class, req);
+		return;
+	}
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
-	prev_value = pm_qos_get_value(o);
-	/* PM_QOS_DEFAULT_VALUE is a signal that the value is unchanged */
-	if (value != PM_QOS_DEFAULT_VALUE) {
+
+	prev_value = pm_qos_get_value(c);
+	if (value == PM_QOS_DEFAULT_VALUE)
+		new_value = c->default_value;
+	else
+		new_value = value;
+
+	switch (action) {
+	case PM_QOS_REMOVE_REQ:
+		plist_del(&req->node, &c->list);
+		break;
+	case PM_QOS_UPDATE_REQ:
 		/*
 		 * to change the list, we atomically remove, reinit
 		 * with new value and add, then see if the extremal
 		 * changed
 		 */
-		plist_del(node, &o->requests);
-		plist_node_init(node, value);
-		plist_add(node, &o->requests);
-	} else if (del) {
-		plist_del(node, &o->requests);
-	} else {
-		plist_add(node, &o->requests);
+		plist_del(&req->node, &c->list);
+	case PM_QOS_ADD_REQ:
+		plist_node_init(&req->node, new_value);
+		plist_add(&req->node, &c->list);
+		break;
+	default:
+		/* no action */
+		;
 	}
-	curr_value = pm_qos_get_value(o);
-	pm_qos_set_value(o, curr_value);
+
+	curr_value = pm_qos_get_value(c);
+	pm_qos_set_value(c, curr_value);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
 	if (prev_value != curr_value)
 		blocking_notifier_call_chain(o->notifiers,
 					     (unsigned long)curr_value,
-					     NULL);
-}
-
-static int register_pm_qos_misc(struct pm_qos_object *qos)
-{
-	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-	qos->pm_qos_power_miscdev.name = qos->name;
-	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
-	return misc_register(&qos->pm_qos_power_miscdev);
-}
-
-static int find_pm_qos_object_by_minor(int minor)
-{
-	int pm_qos_class;
-
-	for (pm_qos_class = 0;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
-		if (minor ==
-			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
-			return pm_qos_class;
-	}
-	return -1;
+					     req);
 }
 
 /**
@@ -229,7 +262,7 @@ static int find_pm_qos_object_by_minor(int minor)
  */
 int pm_qos_request(int class)
 {
-	return pm_qos_read_value(pm_qos_array[class]);
+	return pm_qos_read_value(pm_qos_array[class]->constraints);
 }
 EXPORT_SYMBOL_GPL(pm_qos_request);
 
@@ -254,22 +287,15 @@ EXPORT_SYMBOL_GPL(pm_qos_request_active);
 void pm_qos_add_request(struct pm_qos_request *req,
 			struct pm_qos_parameters *params)
 {
-	struct pm_qos_object *o =  pm_qos_array[params->class];
-	int new_value;
-
 	if (pm_qos_request_active(req)) {
 		WARN(1, KERN_ERR "pm_qos_add_request() called for already "
 			"added request\n");
 		return;
 	}
-	if (params->value == PM_QOS_DEFAULT_VALUE)
-		new_value = o->default_value;
-	else
-		new_value = params->value;
-	plist_node_init(&req->list, new_value);
+
 	req->class = params->class;
 	req->dev = params->dev;
-	update_target(o, &req->list, 0, PM_QOS_DEFAULT_VALUE);
+	update_target(req, PM_QOS_ADD_REQ, params->value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
@@ -285,9 +311,6 @@ EXPORT_SYMBOL_GPL(pm_qos_add_request);
  */
 void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 {
-	s32 temp;
-	struct pm_qos_object *o;
-
 	if (!req) /*guard against callers passing in null */
 		return;
 
@@ -296,15 +319,8 @@ void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 		return;
 	}
 
-	o = pm_qos_array[req->class];
-
-	if (new_value == PM_QOS_DEFAULT_VALUE)
-		temp = o->default_value;
-	else
-		temp = new_value;
-
-	if (temp != req->list.prio)
-		update_target(o, &req->list, 0, temp);
+	if (new_value != req->node.prio)
+		update_target(req, PM_QOS_UPDATE_REQ, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
@@ -318,8 +334,6 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
  */
 void pm_qos_remove_request(struct pm_qos_request *req)
 {
-	struct pm_qos_object *o;
-
 	if (req == NULL)
 		return;
 		/* silent return to keep pcm code cleaner */
@@ -329,8 +343,8 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 		return;
 	}
 
-	o = pm_qos_array[req->class];
-	update_target(o, &req->list, 1, PM_QOS_DEFAULT_VALUE);
+	update_target(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+
 	memset(req, 0, sizeof(*req));
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_request);
@@ -373,6 +387,28 @@ int pm_qos_remove_notifier(int class, struct notifier_block *notifier)
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
+static int register_pm_qos_misc(struct pm_qos_object *qos)
+{
+	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
+	qos->pm_qos_power_miscdev.name = qos->name;
+	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
+
+	return misc_register(&qos->pm_qos_power_miscdev);
+}
+
+static int find_pm_qos_object_by_minor(int minor)
+{
+	int pm_qos_class;
+
+	for (pm_qos_class = 0;
+		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
+		if (minor ==
+			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
+			return pm_qos_class;
+	}
+	return -1;
+}
+
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
 	struct pm_qos_parameters pm_qos_params;
@@ -410,7 +446,6 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 {
 	s32 value;
 	unsigned long flags;
-	struct pm_qos_object *o;
 	struct pm_qos_request *req = filp->private_data;
 
 	if (!req)
@@ -418,9 +453,8 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 	if (!pm_qos_request_active(req))
 		return -EINVAL;
 
-	o = pm_qos_array[req->class];
 	spin_lock_irqsave(&pm_qos_lock, flags);
-	value = pm_qos_get_value(o);
+	value = pm_qos_get_value(pm_qos_array[req->class]->constraints);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
 	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
-- 
1.7.2.5

