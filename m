From: jean.pihet@newoldbits.com
Subject: [PATCH 03/13] PM: QoS: extend the in-kernel API with per-device latency constraints
Date: Thu, 28 Jul 2011 10:30:10 +0200
Message-ID: <1311841821-10252-4-git-send-email-j-pihet@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55560 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab1G1IbA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 04:31:00 -0400
Received: by mail-ww0-f42.google.com with SMTP id 11so3768336wwg.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 01:30:59 -0700 (PDT)
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Extend the PM QoS kernel API:
- add a new PM QoS class PM_QOS_DEV_LATENCY for device wake-up latency
constraints
- make the pm_qos_add_request API more generic by using a parameter of
type struct pm_qos_parameters
- minor clean-ups and rename of struct fields:
  . rename pm_qos_class to class and pm_qos_req to req in internal code
  . consistenly use req and params as the API parameters
  . rename struct pm_qos_request_list to struct pm_qos_request
- update the in-kernel API callers to the new API

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/plat-omap/i2c.c               |   20 -----
 drivers/i2c/busses/i2c-omap.c          |   35 ++++++---
 drivers/media/video/via-camera.c       |    7 +-
 drivers/net/e1000e/netdev.c            |    9 ++-
 drivers/net/wireless/ipw2x00/ipw2100.c |    8 +-
 include/linux/netdevice.h              |    2 +-
 include/linux/pm_qos.h                 |   39 ++++++----
 include/sound/pcm.h                    |    2 +-
 kernel/pm_qos.c                        |  130 +++++++++++++++++--------------
 sound/core/pcm_native.c                |    8 ++-
 10 files changed, 141 insertions(+), 119 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 2388b8e..98f7ea5 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -34,7 +34,6 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
-#include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 
 #define OMAP_I2C_SIZE		0x3f
@@ -129,16 +128,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
 
 
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
@@ -178,15 +167,6 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
 	pdata->flags = dev_attr->flags;
 
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
index d53cd61..b7d3f0d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -180,8 +181,7 @@ struct omap_i2c_dev {
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
 	u32			latency;	/* maximum mpu wkup latency */
-	void			(*set_mpu_wkup_lat)(struct device *dev,
-						    long latency);
+	struct pm_qos_request	pm_qos_request;
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -648,6 +648,7 @@ static int
 omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	struct pm_qos_parameters pm_qos_params;
 	int i;
 	int r;
 
@@ -657,8 +658,19 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r < 0)
 		goto out;
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 * Used on OMAP3 Only
+	 */
+	if (cpu_is_omap34xx()) {
+		pm_qos_params.dev = dev->dev;
+		pm_qos_params.class = PM_QOS_CPU_DMA_LATENCY;
+		pm_qos_params.value = dev->latency;
+		pm_qos_add_request(&dev->pm_qos_request, &pm_qos_params);
+	}
 
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
@@ -666,8 +678,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
+	if (cpu_is_omap34xx())
+		pm_qos_remove_request(&dev->pm_qos_request);
 
 	if (r == 0)
 		r = num;
@@ -1021,13 +1033,10 @@ omap_i2c_probe(struct platform_device *pdev)
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
@@ -1075,8 +1084,8 @@ omap_i2c_probe(struct platform_device *pdev)
 			dev->fifo_size = (dev->fifo_size / 2);
 			dev->b_hw = 1; /* Enable hardware fixes */
 		}
-		/* calculate wakeup latency constraint for MPU */
-		if (dev->set_mpu_wkup_lat != NULL)
+		/* calculate wakeup latency constraint */
+		if (cpu_is_omap34xx())
 			dev->latency = (1000000 * dev->fifo_size) /
 				       (1000 * speed / 8);
 	}
diff --git a/drivers/media/video/via-camera.c b/drivers/media/video/via-camera.c
index b3ca389..037c02c 100644
--- a/drivers/media/video/via-camera.c
+++ b/drivers/media/video/via-camera.c
@@ -69,7 +69,7 @@ struct via_camera {
 	struct mutex lock;
 	enum viacam_opstate opstate;
 	unsigned long flags;
-	struct pm_qos_request_list qos_request;
+	struct pm_qos_request qos_request;
 	/*
 	 * GPIO info for power/reset management
 	 */
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
index a8a18e1..33f55f3 100644
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
index d9df575..6a41efc 100644
--- a/drivers/net/wireless/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/ipw2x00/ipw2100.c
@@ -174,7 +174,7 @@ that only one external action is invoked at a time.
 #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2100 Network Driver"
 #define DRV_COPYRIGHT	"Copyright(c) 2003-2006 Intel Corporation"
 
-static struct pm_qos_request_list ipw2100_pm_qos_req;
+static struct pm_qos_request ipw2100_pm_qos_req;
 
 /* Debugging stuff */
 #ifdef CONFIG_IPW2100_DEBUG
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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cc1eb9e..82f01d9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -999,7 +999,7 @@ struct net_device {
 	 */
 	char			name[IFNAMSIZ];
 
-	struct pm_qos_request_list pm_qos_req;
+	struct pm_qos_request pm_qos_req;
 
 	/* device name hash chain */
 	struct hlist_node	name_hlist;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 9cc0224..a2e4409 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -8,31 +8,40 @@
 #include <linux/notifier.h>
 #include <linux/miscdevice.h>
 
-#define PM_QOS_RESERVED 0
-#define PM_QOS_CPU_DMA_LATENCY 1
-#define PM_QOS_NETWORK_LATENCY 2
-#define PM_QOS_NETWORK_THROUGHPUT 3
+#define PM_QOS_RESERVED			0
+#define PM_QOS_CPU_DMA_LATENCY		1
+#define PM_QOS_DEV_LATENCY		2
+#define PM_QOS_NETWORK_LATENCY		3
+#define PM_QOS_NETWORK_THROUGHPUT	4
 
-#define PM_QOS_NUM_CLASSES 4
+#define PM_QOS_NUM_CLASSES 5
 #define PM_QOS_DEFAULT_VALUE -1
 
 #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
+#define PM_QOS_DEV_LAT_DEFAULT_VALUE		0
 #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
 #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
 
-struct pm_qos_request_list {
+struct pm_qos_request {
 	struct plist_node list;
-	int pm_qos_class;
+	int class;
+	struct device *dev;
 };
 
-void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class, s32 value);
-void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
-		s32 new_value);
-void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
+struct pm_qos_parameters {
+	int class;
+	struct device *dev;
+	s32 value;
+};
+
+void pm_qos_add_request(struct pm_qos_request *req,
+			struct pm_qos_parameters *params);
+void pm_qos_update_request(struct pm_qos_request *req, s32 new_value);
+void pm_qos_remove_request(struct pm_qos_request *req);
 
-int pm_qos_request(int pm_qos_class);
-int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifier);
-int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier);
-int pm_qos_request_active(struct pm_qos_request_list *req);
+int pm_qos_request(int class);
+int pm_qos_add_notifier(int class, struct notifier_block *notifier);
+int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
+int pm_qos_request_active(struct pm_qos_request *req);
 
 #endif
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1204f17..d3b068f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -373,7 +373,7 @@ struct snd_pcm_substream {
 	int number;
 	char name[32];			/* substream name */
 	int stream;			/* stream (direction) */
-	struct pm_qos_request_list latency_pm_qos_req; /* pm_qos request */
+	struct pm_qos_request latency_pm_qos_req; /* pm_qos request */
 	size_t buffer_bytes_max;	/* limit ring buffer size */
 	struct snd_dma_buffer dma_buffer;
 	unsigned int dma_buf_id;
diff --git a/kernel/pm_qos.c b/kernel/pm_qos.c
index 3bf69f1..4ede3cd 100644
--- a/kernel/pm_qos.c
+++ b/kernel/pm_qos.c
@@ -82,6 +82,16 @@ static struct pm_qos_object cpu_dma_pm_qos = {
 	.type = PM_QOS_MIN,
 };
 
+static BLOCKING_NOTIFIER_HEAD(dev_lat_notifier);
+static struct pm_qos_object dev_pm_qos = {
+	.requests = PLIST_HEAD_INIT(dev_pm_qos.requests, pm_qos_lock),
+	.notifiers = &dev_lat_notifier,
+	.name = "dev_latency",
+	.target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
+	.default_value = PM_QOS_DEV_LAT_DEFAULT_VALUE,
+	.type = PM_QOS_MIN,
+};
+
 static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
 static struct pm_qos_object network_lat_pm_qos = {
 	.requests = PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_qos_lock),
@@ -107,6 +117,7 @@ static struct pm_qos_object network_throughput_pm_qos = {
 static struct pm_qos_object *pm_qos_array[] = {
 	&null_pm_qos,
 	&cpu_dma_pm_qos,
+	&dev_pm_qos,
 	&network_lat_pm_qos,
 	&network_throughput_pm_qos
 };
@@ -212,132 +223,132 @@ static int find_pm_qos_object_by_minor(int minor)
 
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
+	return pm_qos_read_value(pm_qos_array[class]);
 }
 EXPORT_SYMBOL_GPL(pm_qos_request);
 
-int pm_qos_request_active(struct pm_qos_request_list *req)
+int pm_qos_request_active(struct pm_qos_request *req)
 {
-	return req->pm_qos_class != 0;
+	return req->class != 0;
 }
 EXPORT_SYMBOL_GPL(pm_qos_request_active);
 
 /**
  * pm_qos_add_request - inserts new qos request into the list
- * @dep: pointer to a preallocated handle
- * @pm_qos_class: identifies which list of qos request to use
- * @value: defines the qos request
+ * @req: pointer to a preallocated handle
+ * @params: request parameters
  *
- * This function inserts a new entry in the pm_qos_class list of requested qos
+ * This function inserts a new entry in the class list of requested qos
  * performance characteristics.  It recomputes the aggregate QoS expectations
- * for the pm_qos_class of parameters and initializes the pm_qos_request_list
+ * for the class of parameters and initializes the pm_qos_request
  * handle.  Caller needs to save this handle for later use in updates and
  * removal.
  */
 
-void pm_qos_add_request(struct pm_qos_request_list *dep,
-			int pm_qos_class, s32 value)
+void pm_qos_add_request(struct pm_qos_request *req,
+			struct pm_qos_parameters *params)
 {
-	struct pm_qos_object *o =  pm_qos_array[pm_qos_class];
+	struct pm_qos_object *o =  pm_qos_array[params->class];
 	int new_value;
 
-	if (pm_qos_request_active(dep)) {
-		WARN(1, KERN_ERR "pm_qos_add_request() called for already added request\n");
+	if (pm_qos_request_active(req)) {
+		WARN(1, KERN_ERR "pm_qos_add_request() called for already "
+			"added request\n");
 		return;
 	}
-	if (value == PM_QOS_DEFAULT_VALUE)
+	if (params->value == PM_QOS_DEFAULT_VALUE)
 		new_value = o->default_value;
 	else
-		new_value = value;
-	plist_node_init(&dep->list, new_value);
-	dep->pm_qos_class = pm_qos_class;
-	update_target(o, &dep->list, 0, PM_QOS_DEFAULT_VALUE);
+		new_value = params->value;
+	plist_node_init(&req->list, new_value);
+	req->class = params->class;
+	req->dev = params->dev;
+	update_target(o, &req->list, 0, PM_QOS_DEFAULT_VALUE);
 }
 EXPORT_SYMBOL_GPL(pm_qos_add_request);
 
 /**
  * pm_qos_update_request - modifies an existing qos request
- * @pm_qos_req : handle to list element holding a pm_qos request to use
+ * @req : handle to list element holding a pm_qos request to use
  * @value: defines the qos request
  *
- * Updates an existing qos request for the pm_qos_class of parameters along
- * with updating the target pm_qos_class value.
+ * Updates an existing qos request for the class of parameters along
+ * with updating the target class value.
  *
  * Attempts are made to make this code callable on hot code paths.
  */
-void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
-			   s32 new_value)
+void pm_qos_update_request(struct pm_qos_request *req, s32 new_value)
 {
 	s32 temp;
 	struct pm_qos_object *o;
 
-	if (!pm_qos_req) /*guard against callers passing in null */
+	if (!req) /*guard against callers passing in null */
 		return;
 
-	if (!pm_qos_request_active(pm_qos_req)) {
+	if (!pm_qos_request_active(req)) {
 		WARN(1, KERN_ERR "pm_qos_update_request() called for unknown object\n");
 		return;
 	}
 
-	o = pm_qos_array[pm_qos_req->pm_qos_class];
+	o = pm_qos_array[req->class];
 
 	if (new_value == PM_QOS_DEFAULT_VALUE)
 		temp = o->default_value;
 	else
 		temp = new_value;
 
-	if (temp != pm_qos_req->list.prio)
-		update_target(o, &pm_qos_req->list, 0, temp);
+	if (temp != req->list.prio)
+		update_target(o, &req->list, 0, temp);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
 
 /**
  * pm_qos_remove_request - modifies an existing qos request
- * @pm_qos_req: handle to request list element
+ * @req: handle to request list element
  *
  * Will remove pm qos request from the list of requests and
- * recompute the current target value for the pm_qos_class.  Call this
+ * recompute the current target value for the class.  Call this
  * on slow code paths.
  */
-void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req)
+void pm_qos_remove_request(struct pm_qos_request *req)
 {
 	struct pm_qos_object *o;
 
-	if (pm_qos_req == NULL)
+	if (req == NULL)
 		return;
 		/* silent return to keep pcm code cleaner */
 
-	if (!pm_qos_request_active(pm_qos_req)) {
+	if (!pm_qos_request_active(req)) {
 		WARN(1, KERN_ERR "pm_qos_remove_request() called for unknown object\n");
 		return;
 	}
 
-	o = pm_qos_array[pm_qos_req->pm_qos_class];
-	update_target(o, &pm_qos_req->list, 1, PM_QOS_DEFAULT_VALUE);
-	memset(pm_qos_req, 0, sizeof(*pm_qos_req));
+	o = pm_qos_array[req->class];
+	update_target(o, &req->list, 1, PM_QOS_DEFAULT_VALUE);
+	memset(req, 0, sizeof(*req));
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
@@ -345,18 +356,18 @@ EXPORT_SYMBOL_GPL(pm_qos_add_notifier);
 
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
@@ -364,15 +375,16 @@ EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
-	long pm_qos_class;
+	struct pm_qos_parameters pm_qos_params;
 
-	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
-	if (pm_qos_class >= 0) {
-               struct pm_qos_request_list *req = kzalloc(sizeof(*req), GFP_KERNEL);
+	pm_qos_params.class = find_pm_qos_object_by_minor(iminor(inode));
+	if (pm_qos_params.class >= 0) {
+		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req)
 			return -ENOMEM;
 
-		pm_qos_add_request(req, pm_qos_class, PM_QOS_DEFAULT_VALUE);
+		pm_qos_params.value = PM_QOS_DEFAULT_VALUE;
+		pm_qos_add_request(req, &pm_qos_params);
 		filp->private_data = req;
 
 		if (filp->private_data)
@@ -383,7 +395,7 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
 
 static int pm_qos_power_release(struct inode *inode, struct file *filp)
 {
-	struct pm_qos_request_list *req;
+	struct pm_qos_request *req;
 
 	req = filp->private_data;
 	pm_qos_remove_request(req);
@@ -399,14 +411,14 @@ static ssize_t pm_qos_power_read(struct file *filp, char __user *buf,
 	s32 value;
 	unsigned long flags;
 	struct pm_qos_object *o;
-	struct pm_qos_request_list *pm_qos_req = filp->private_data;
+	struct pm_qos_request *req = filp->private_data;
 
-	if (!pm_qos_req)
+	if (!req)
 		return -EINVAL;
-	if (!pm_qos_request_active(pm_qos_req))
+	if (!pm_qos_request_active(req))
 		return -EINVAL;
 
-	o = pm_qos_array[pm_qos_req->pm_qos_class];
+	o = pm_qos_array[req->class];
 	spin_lock_irqsave(&pm_qos_lock, flags);
 	value = pm_qos_get_value(o);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
@@ -418,7 +430,7 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	s32 value;
-	struct pm_qos_request_list *pm_qos_req;
+	struct pm_qos_request *req;
 
 	if (count == sizeof(s32)) {
 		if (copy_from_user(&value, buf, sizeof(s32)))
@@ -449,8 +461,8 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 		return -EINVAL;
 	}
 
-	pm_qos_req = filp->private_data;
-	pm_qos_update_request(pm_qos_req, value);
+	req = filp->private_data;
+	pm_qos_update_request(req, value);
 
 	return count;
 }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c74e228..fb05f37 100644
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
1.7.2.5

