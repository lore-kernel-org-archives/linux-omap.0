From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 2/9] PM: extend PM QoS with per-device wake-up constraints
Date: Fri, 24 Jun 2011 16:37:59 +0200
Message-ID: <1308926286-30445-3-git-send-email-j-pihet@ti.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60408 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759147Ab1FXOi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 10:38:29 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so2945107wwe.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 07:38:28 -0700 (PDT)
In-Reply-To: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

- add a new PM QoS class PM_QOS_DEV_WAKEUP_LATENCY for device wake-up
constraints. Due to the per-device nature of the new class the constraints
list is stored inside the device dev_pm_info struct instead of the internal
per-class constraints lists.
The new class is only available from kernel drivers and so is not exported
to user space.
The new class is used to put constraints on given devices in the system
while the existing PM_QOS_CPU_DMA_LATENCY class is used by cpuidle to
determine the next MPU subsystem state.

- make the pm_qos_add_request API more generic by using a struct
pm_qos_parameters parameter

- the notification mechanism now passes the constraint request struct ptr
in order for the notifier callback to have access to the full set of
constraint data, e.g. the struct device ptr

- update the pm_qos_add_request callers to the generic API

- minor clean-ups and rename of struct fields

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/i2c.c               |   20 -----
 drivers/i2c/busses/i2c-omap.c          |   35 +++++---
 drivers/media/video/via-camera.c       |    5 +-
 drivers/net/e1000e/netdev.c            |    9 ++-
 drivers/net/wireless/ipw2x00/ipw2100.c |    6 +-
 include/linux/pm_qos_params.h          |   40 ++++++----
 kernel/pm_qos_params.c                 |  142 ++++++++++++++++++-------------
 sound/core/pcm_native.c                |    8 ++-
 8 files changed, 149 insertions(+), 116 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..e1e2502 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -34,7 +34,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
-#include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -113,16 +112,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
 
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
-/*
- * XXX This function is a temporary compatibility wrapper - only
- * needed until the I2C driver can be converted to call
- * omap_pm_set_max_dev_wakeup_lat() and handle a return code.
- */
-static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
-{
-	omap_pm_set_max_mpu_wakeup_lat(dev, t);
-}
-
 static struct omap_device_pm_latency omap_i2c_latency[] = {
 	[0] = {
 		.deactivate_func	= omap_device_idle_hwmods,
@@ -151,15 +140,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	}
 
 	pdata = &i2c_pdata[bus_id - 1];
-	/*
-	 * When waiting for completion of a i2c transfer, we need to
-	 * set a wake up latency constraint for the MPU. This is to
-	 * ensure quick enough wakeup from idle, when transfer
-	 * completes.
-	 * Only omap3 has support for constraints
-	 */
-	if (cpu_is_omap34xx())
-		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
 	od = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 58a58c7..7b53a91 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos_params.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
@@ -179,8 +180,7 @@ struct omap_i2c_dev {
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
-	void			(*set_mpu_wkup_lat)(struct device *dev,
-						    long latency);
+	struct pm_qos_request_list pm_qos_request;
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -641,6 +641,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
 	int i;
 	int r;
+	struct pm_qos_parameters pm_qos_params;
 
 	omap_i2c_unidle(dev);
 
@@ -648,8 +649,19 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r < 0)
 		goto out;
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 * Only OMAP3 has support for constraints
+	 */
+	if (cpu_is_omap34xx()) {
+		pm_qos_params.dev = dev->dev;
+		pm_qos_params.class = PM_QOS_DEV_WAKEUP_LATENCY;
+		pm_qos_params.value = dev->latency;
+		pm_qos_add_request(&dev->pm_qos_request, &pm_qos_params);
+	}
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -657,8 +669,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	if (cpu_is_omap34xx())
+		pm_qos_remove_request(&dev->pm_qos_request);
 
 	if (r == 0)
 		r = num;
@@ -1007,13 +1019,10 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	if (pdata != NULL) {
+	if (pdata != NULL)
 		speed = pdata->clkrate;
-		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
-	} else {
+	else
 		speed = 100;	/* Default speed */
-		dev->set_mpu_wkup_lat = NULL;
-	}
 
 	dev->speed = speed;
 	dev->idle = 1;
@@ -1066,8 +1075,8 @@ omap_i2c_probe(struct platform_device *pdev)
 			dev->fifo_size = (dev->fifo_size / 2);
 			dev->b_hw = 1; /* Enable hardware fixes */
 		}
-		/* calculate wakeup latency constraint for MPU */
-		if (dev->set_mpu_wkup_lat != NULL)
+		/* calculate device wakeup latency constraint */
+		if (cpu_is_omap34xx())
 			dev->latency = (1000000 * dev->fifo_size) /
 				       (1000 * speed / 8);
 	}
diff --git a/drivers/media/video/via-camera.c b/drivers/media/video/via-camera.c
index 85d3048..5ca12e2 100644
--- a/drivers/media/video/via-camera.c
+++ b/drivers/media/video/via-camera.c
@@ -1086,6 +1086,7 @@ static int viacam_streamon(struct file *filp, void *priv, enum v4l2_buf_type t)
 {
 	struct via_camera *cam = priv;
 	int ret = 0;
+	struct pm_qos_parameters pm_qos_params;
 
 	if (t != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
@@ -1120,7 +1121,9 @@ static int viacam_streamon(struct file *filp, void *priv, enum v4l2_buf_type t)
 	 * requirement which will keep the CPU out of the deeper sleep
 	 * states.
 	 */
-	pm_qos_add_request(&cam->qos_request, PM_QOS_CPU_DMA_LATENCY, 50);
+	pm_qos_params.class = PM_QOS_CPU_DMA_LATENCY;
+	pm_qos_params.value = 50;
+	pm_qos_add_request(&cam->qos_request, &pm_qos_params);
 	/*
 	 * Fire things up.
 	 */
diff --git a/drivers/net/e1000e/netdev.c b/drivers/net/e1000e/netdev.c
index 3310c3d..c4cce8a 100644
--- a/drivers/net/e1000e/netdev.c
+++ b/drivers/net/e1000e/netdev.c
@@ -3604,6 +3604,7 @@ static int e1000_open(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
 	int err;
+	struct pm_qos_parameters pm_qos_params;
 
 	/* disallow open during test */
 	if (test_bit(__E1000_TESTING, &adapter->state))
@@ -3641,10 +3642,12 @@ static int e1000_open(struct net_device *netdev)
 
 	/* DMA latency requirement to workaround early-receive/jumbo issue */
 	if ((adapter->flags & FLAG_HAS_ERT) ||
-	    (adapter->hw.mac.type == e1000_pch2lan))
+	    (adapter->hw.mac.type == e1000_pch2lan)) {
+		pm_qos_params.class = PM_QOS_CPU_DMA_LATENCY;
+		pm_qos_params.value = PM_QOS_DEFAULT_VALUE;
 		pm_qos_add_request(&adapter->netdev->pm_qos_req,
-				   PM_QOS_CPU_DMA_LATENCY,
-				   PM_QOS_DEFAULT_VALUE);
+				   &pm_qos_params);
+	}
 
 	/*
 	 * before we allocate an interrupt, we must be ready to handle it.
diff --git a/drivers/net/wireless/ipw2x00/ipw2100.c b/drivers/net/wireless/ipw2x00/ipw2100.c
index 4430775..585ad04 100644
--- a/drivers/net/wireless/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/ipw2x00/ipw2100.c
@@ -6643,12 +6643,14 @@ static struct pci_driver ipw2100_pci_driver = {
 static int __init ipw2100_init(void)
 {
 	int ret;
+	struct pm_qos_parameters pm_qos_params;
 
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);
 
-	pm_qos_add_request(&ipw2100_pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
-			   PM_QOS_DEFAULT_VALUE);
+	pm_qos_params.class = PM_QOS_CPU_DMA_LATENCY;
+	pm_qos_params.value = PM_QOS_DEFAULT_VALUE;
+	pm_qos_add_request(&ipw2100_pm_qos_req, &pm_qos_params);
 
 	ret = pci_register_driver(&ipw2100_pci_driver);
 	if (ret)
diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params.h
index a7d87f9..e6e16cb 100644
--- a/include/linux/pm_qos_params.h
+++ b/include/linux/pm_qos_params.h
@@ -8,31 +8,41 @@
 #include <linux/notifier.h>
 #include <linux/miscdevice.h>
 
-#define PM_QOS_RESERVED 0
-#define PM_QOS_CPU_DMA_LATENCY 1
-#define PM_QOS_NETWORK_LATENCY 2
-#define PM_QOS_NETWORK_THROUGHPUT 3
+#define	PM_QOS_RESERVED			0
+#define	PM_QOS_CPU_DMA_LATENCY		1
+#define	PM_QOS_DEV_WAKEUP_LATENCY	2
+#define	PM_QOS_NETWORK_LATENCY		3
+#define	PM_QOS_NETWORK_THROUGHPUT	4
 
-#define PM_QOS_NUM_CLASSES 4
-#define PM_QOS_DEFAULT_VALUE -1
+#define PM_QOS_NUM_CLASSES		5
+#define PM_QOS_DEFAULT_VALUE		-1
 
-#define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
-#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
-#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
+#define	PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
+#define	PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE	0
+#define	PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
+#define	PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 
 struct pm_qos_request_list {
 	struct plist_node list;
-	int pm_qos_class;
+	int class;
+	struct device *dev;
 };
 
-void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class, s32 value);
+struct pm_qos_parameters {
+	int class;
+	struct device *dev;
+	s32 value;
+};
+
+void pm_qos_add_request(struct pm_qos_request_list *l,
+			struct pm_qos_parameters *params);
 void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
-		s32 new_value);
+			   s32 new_value);
 void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
 
-int pm_qos_request(int pm_qos_class);
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
+int pm_qos_request(int class);
+int pm_qos_add_notifier(int class, struct notifier_block *notifier);
+int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
 int pm_qos_request_active(struct pm_qos_request_list *req);
 
 #endif
diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index 6824ca7..3d43d63 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -82,6 +82,15 @@ static struct pm_qos_object cpu_dma_pm_qos = {
 	.type = PM_QOS_MIN,
 };
 
+static BLOCKING_NOTIFIER_HEAD(dev_wakeup_lat_notifier);
+static struct pm_qos_object dev_wakeup_lat_pm_qos = {
+	.notifiers = &dev_wakeup_lat_notifier,
+	.name = "dev_wakeup_latency",
+	.target_value = PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE,
+	.default_value = PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE,
+	.type = PM_QOS_MIN,
+};
+
 static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
 	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
@@ -107,6 +116,7 @@ static struct pm_qos_object network_throughput_pm_qos = {
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
+	&dev_wakeup_lat_pm_qos,
 	&network_lat_pm_qos,
 	&network_throughput_pm_qos
 };
@@ -155,11 +165,12 @@ static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
 	o->target_value = value;
 }
 
-static void update_target(struct pm_qos_object *o, struct plist_node *node,
-			  int del, int value)
+static void update_target(struct pm_qos_request_list *req, int del, int value)
 {
 	unsigned long flags;
 	int prev_value, curr_value;
+	struct pm_qos_object *o = pm_qos_array[req->class];
+	struct plist_node *node = &req->list;
 
 	spin_lock_irqsave(&pm_qos_lock, flags);
 	prev_value = pm_qos_get_value(o);
@@ -179,13 +190,14 @@ static void update_target(struct pm_qos_object *o, struct plist_node *node,
 		plist_add(node, &o->requests);
 	}
 	curr_value = pm_qos_get_value(o);
-	pm_qos_set_value(o, curr_value);
+	if (req->class != PM_QOS_DEV_WAKEUP_LATENCY)
+		pm_qos_set_value(o, curr_value);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
 	if (prev_value != curr_value)
 		blocking_notifier_call_chain(o->notifiers,
 					     (unsigned long)curr_value,
-					     NULL);
+					     req);
 }
 
 static int register_pm_qos_misc(struct pm_qos_object *qos)
@@ -199,65 +211,72 @@ static int register_pm_qos_misc(struct pm_qos_object *qos)
 
 static int find_pm_qos_object_by_minor(int minor)
 {
-	int pm_qos_class;
+	int class;
 
-	for (pm_qos_class = 0;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
+	for (class = 0;
+		class < PM_QOS_NUM_CLASSES; class++) {
 		if (minor ==
-			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
-			return pm_qos_class;
+			pm_qos_array[class]->pm_qos_power_miscdev.minor)
+			return class;
 	}
 	return -1;
 }
 
 /**
  * pm_qos_request - returns current system wide qos expectation
- * @pm_qos_class: identification of which qos value is requested
+ * @class: identification of which qos value is requested
  *
  * This function returns the current target value.
  */
-int pm_qos_request(int pm_qos_class)
+int pm_qos_request(int class)
 {
-	return pm_qos_read_value(pm_qos_array[pm_qos_class]);
+	if (class == PM_QOS_DEV_WAKEUP_LATENCY)
+		return pm_qos_get_value(pm_qos_array[class]);
+	else
+		return pm_qos_read_value(pm_qos_array[class]);
 }
 EXPORT_SYMBOL_GPL(pm_qos_request);
 
 int pm_qos_request_active(struct pm_qos_request_list *req)
 {
-	return req->pm_qos_class != 0;
+	return req->class != 0;
 }
 EXPORT_SYMBOL_GPL(pm_qos_request_active);
 
 /**
  * pm_qos_add_request - inserts new qos request into the list
  * @dep: pointer to a preallocated handle
- * @pm_qos_class: identifies which list of qos request to use
- * @value: defines the qos request
+ * @params: request parameters
  *
- * This function inserts a new entry in the pm_qos_class list of requested qos
+ * This function inserts a new entry in the class list of requested qos
  * performance characteristics.  It recomputes the aggregate QoS expectations
- * for the pm_qos_class of parameters and initializes the pm_qos_request_list
- * handle.  Caller needs to save this handle for later use in updates and
+ * for the class of parameters and initializes the pm_qos_request_list
+ * handle. Caller needs to save this handle for later use in updates and
  * removal.
  */
 
-void pm_qos_add_request(struct pm_qos_request_list *dep,
-			int pm_qos_class, s32 value)
+void pm_qos_add_request(struct pm_qos_request_list *pm_qos_req,
+			struct pm_qos_parameters *pm_qos_params)
 {
-	struct pm_qos_object *o =  pm_qos_array[pm_qos_class];
+	struct pm_qos_object *o =  pm_qos_array[pm_qos_params->class];
 	int new_value;
 
-	if (pm_qos_request_active(dep)) {
-		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
+	if (pm_qos_params->class == PM_QOS_DEV_WAKEUP_LATENCY) {
+		o->requests = pm_qos_req->dev->power.wakeup_lat_plist_head;
+	} else if (pm_qos_request_active(pm_qos_req)) {
+		WARN(1, KERN_ERR "pm_qos_add_request() called for already "
+		     "added request\n");
 		return;
 	}
-	if (value == PM_QOS_DEFAULT_VALUE)
+
+	if (pm_qos_params->value == PM_QOS_DEFAULT_VALUE)
 		new_value = o->default_value;
 	else
-		new_value = value;
-	plist_node_init(&dep->list, new_value);
-	dep->pm_qos_class = pm_qos_class;
-	update_target(o, &dep->list, 0, PM_QOS_DEFAULT_VALUE);
+		new_value = pm_qos_params->value;
+	plist_node_init(&pm_qos_req->list, new_value);
+	pm_qos_req->class = pm_qos_params->class;
+	pm_qos_req->dev = pm_qos_params->dev;
+	update_target(pm_qos_req, 0, PM_QOS_DEFAULT_VALUE);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
@@ -266,8 +285,8 @@ EXPORT_SYMBOL_GPL(pm_qos_add_request);
  * @pm_qos_req : handle to list element holding a pm_qos request to use
  * @value: defines the qos request
  *
- * Updates an existing qos request for the pm_qos_class of parameters along
- * with updating the target pm_qos_class value.
+ * Updates an existing qos request for the class of parameters along
+ * with updating the target class value.
  *
  * Attempts are made to make this code callable on hot code paths.
  */
@@ -275,25 +294,25 @@ void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
 			   s32 new_value)
 {
 	s32 temp;
-	struct pm_qos_object *o;
+	struct pm_qos_object *o = pm_qos_array[pm_qos_req->class];
 
 	if (!pm_qos_req) /*guard against callers passing in null */
 		return;
 
-	if (!pm_qos_request_active(pm_qos_req)) {
-		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown object\n");
+	if ((pm_qos_req->class != PM_QOS_DEV_WAKEUP_LATENCY) &&
+	    (!pm_qos_request_active(pm_qos_req))) {
+		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown "
+		     "object\n");
 		return;
 	}
 
-	o = pm_qos_array[pm_qos_req->pm_qos_class];
-
 	if (new_value == PM_QOS_DEFAULT_VALUE)
 		temp = o->default_value;
 	else
 		temp = new_value;
 
 	if (temp != pm_qos_req->list.prio)
-		update_target(o, &pm_qos_req->list, 0, temp);
+		update_target(pm_qos_req, 0, temp);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
@@ -302,42 +321,41 @@ EXPORT_SYMBOL_GPL(pm_qos_update_request);
  * @pm_qos_req: handle to request list element
  *
  * Will remove pm qos request from the list of requests and
- * recompute the current target value for the pm_qos_class.  Call this
+ * recompute the current target value for the class.  Call this
  * on slow code paths.
  */
 void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
 {
-	struct pm_qos_object *o;
-
 	if (pm_qos_req == NULL)
 		return;
 		/* silent return to keep pcm code cleaner */
 
-	if (!pm_qos_request_active(pm_qos_req)) {
-		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown object\n");
+	if ((pm_qos_req->class != PM_QOS_DEV_WAKEUP_LATENCY) &&
+	    (!pm_qos_request_active(pm_qos_req))) {
+		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown "
+		     "object\n");
 		return;
 	}
 
-	o = pm_qos_array[pm_qos_req->pm_qos_class];
-	update_target(o, &pm_qos_req->list, 1, PM_QOS_DEFAULT_VALUE);
+	update_target(pm_qos_req, 1, PM_QOS_DEFAULT_VALUE);
 	memset(pm_qos_req, 0, sizeof(*pm_qos_req));
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_request);
 
 /**
  * pm_qos_add_notifier - sets notification entry for changes to target value
- * @pm_qos_class: identifies which qos target changes should be notified.
+ * @class: identifies which qos target changes should be notified.
  * @notifier: notifier block managed by caller.
  *
  * will register the notifier into a notification chain that gets called
- * upon changes to the pm_qos_class target value.
+ * upon changes to the class target value.
  */
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier)
+int pm_qos_add_notifier(int class, struct notifier_block *notifier)
 {
 	int retval;
 
 	retval = blocking_notifier_chain_register(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+			pm_qos_array[class]->notifiers, notifier);
 
 	return retval;
 }
@@ -345,18 +363,18 @@ EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
 
 /**
  * pm_qos_remove_notifier - deletes notification entry from chain.
- * @pm_qos_class: identifies which qos target changes are notified.
+ * @class: identifies which qos target changes are notified.
  * @notifier: notifier block to be removed.
  *
  * will remove the notifier from the notification chain that gets called
- * upon changes to the pm_qos_class target value.
+ * upon changes to the class target value.
  */
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
+int pm_qos_remove_notifier(int class, struct notifier_block *notifier)
 {
 	int retval;
 
 	retval = blocking_notifier_chain_unregister(
-			pm_qos_array[pm_qos_class]->notifiers, notifier);
+			pm_qos_array[class]->notifiers, notifier);
 
 	return retval;
 }
@@ -364,15 +382,17 @@ EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
-	long pm_qos_class;
+	struct pm_qos_parameters pm_qos_params;
 
-	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
-	if (pm_qos_class >= 0) {
-               struct pm_qos_request_list *req = kzalloc(sizeof(*req), GFP_KERNEL);
+	pm_qos_params.class = find_pm_qos_object_by_minor(iminor(inode));
+	if (pm_qos_params.class >= 0) {
+		struct pm_qos_request_list *req = kzalloc(sizeof(*req),
+							  GFP_KERNEL);
 		if (!req)
 			return -ENOMEM;
 
-		pm_qos_add_request(req, pm_qos_class, PM_QOS_DEFAULT_VALUE);
+		pm_qos_params.value = PM_QOS_DEFAULT_VALUE;
+		pm_qos_add_request(req, &pm_qos_params);
 		filp->private_data = req;
 
 		if (filp->private_data)
@@ -406,7 +426,7 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 	if (!pm_qos_request_active(pm_qos_req))
 		return -EINVAL;
 
-	o = pm_qos_array[pm_qos_req->pm_qos_class];
+	o = pm_qos_array[pm_qos_req->class];
 	spin_lock_irqsave(&pm_qos_lock, flags);
 	value = pm_qos_get_value(o);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
@@ -462,18 +482,20 @@ static int __init pm_qos_power_init(void)
 
 	ret = register_pm_qos_misc(&cpu_dma_pm_qos);
 	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: cpu_dma_latency setup failed\n");
+		printk(KERN_ERR
+		       "pm_qos_param: cpu_dma_latency setup failed\n");
 		return ret;
 	}
 	ret = register_pm_qos_misc(&network_lat_pm_qos);
 	if (ret < 0) {
-		printk(KERN_ERR "pm_qos_param: network_latency setup failed\n");
+		printk(KERN_ERR
+		       "pm_qos_param: network_latency setup failed\n");
 		return ret;
 	}
 	ret = register_pm_qos_misc(&network_throughput_pm_qos);
 	if (ret < 0)
 		printk(KERN_ERR
-			"pm_qos_param: network_throughput setup failed\n");
+		       "pm_qos_param: network_throughput setup failed\n");
 
 	return ret;
 }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1c6be91..a19605c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -375,6 +375,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	int err, usecs;
 	unsigned int bits;
 	snd_pcm_uframes_t frames;
+	struct pm_qos_parameters pm_qos_params;
 
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
@@ -455,9 +456,12 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	if (pm_qos_request_active(&substream->latency_pm_qos_req))
 		pm_qos_remove_request(&substream->latency_pm_qos_req);
-	if ((usecs = period_to_usecs(runtime)) >= 0)
+	if ((usecs = period_to_usecs(runtime)) >= 0) {
+		pm_qos_params.class = PM_QOS_CPU_DMA_LATENCY;
+		pm_qos_params.value = usecs;
 		pm_qos_add_request(&substream->latency_pm_qos_req,
-				   PM_QOS_CPU_DMA_LATENCY, usecs);
+				   &pm_qos_params);
+	}
 	return 0;
  _error:
 	/* hardware might be unusable from this time,
-- 
1.7.4.1

