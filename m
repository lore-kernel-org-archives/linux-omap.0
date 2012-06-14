From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 04/10] ARM: OMAP: omap_device: register to the per-device PM QoS framework
Date: Thu, 14 Jun 2012 17:05:55 +0200
Message-ID: <1339686361-11526-5-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60855 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab2FNPGR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:06:17 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1326955wey.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 08:06:16 -0700 (PDT)
In-Reply-To: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Implement the devices wake-up latency constraints using the global
device PM QoS notification handler which applies the constraints to the
underlying layer by calling the corresponding function at hwmod level.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: modified to work with omap_devices with large numbers of
 hwmods; moved code to mach-omap2/omap_device.c; added documentation; use
 notifier return codes]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   81 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c490240..241705b 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -3,6 +3,7 @@
  * omap_device implementation
  *
  * Copyright (C) 2009-2010 Nokia Corporation
+ * Copyright (C) 2011 Texas Instruments, Inc.
  * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
@@ -89,6 +90,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
 
 #include <plat/omap_device.h>
 #include <plat/omap_hwmod.h>
@@ -401,6 +403,72 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+/**
+ * _omap_device_pm_qos_handler - interface to the per-device PM QoS framework
+ * @nb: pointer to omap_device_pm_qos_nb (not used)
+ * @new_value: new maximum wakeup latency constraint for @req->dev (in us)
+ * @req: struct dev_pm_qos_request * passed by the Linux PM QoS code
+ *
+ * Called by the Linux core device PM QoS code to alter the maximum
+ * wakeup latency constraint on a device.  If the underlying device is
+ * an omap_device, then this code will pass the constraint on to the
+ * underlying hwmods.  Returns -EINVAL if this code can't handle the
+ * constraint for some reason, or passes along the return code from the
+ * hwmod wakeup latency constraint functions.
+ */
+static int _omap_device_pm_qos_handler(struct notifier_block *nb,
+				       unsigned long new_value,
+				       void *req)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	struct dev_pm_qos_request *dev_pm_qos_req = req;
+	int ret = NOTIFY_OK;
+	int r, i;
+
+	pr_debug("OMAP PM constraints: req@0x%p, new_value=%lu\n",
+		 req, new_value);
+
+	/* Look for the platform device for the constraint target device */
+	pdev = to_platform_device(dev_pm_qos_req->dev);
+
+	/* Try to catch non platform devices */
+	if (pdev->name == NULL) {
+		pr_err("%s: Error: platform device for device %s not valid\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return NOTIFY_DONE;
+	}
+
+	/* Find the associated omap_device for dev */
+	od = to_omap_device(pdev);
+	if (od == NULL) {
+		pr_err("%s: Error: no omap_device for device %s\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return NOTIFY_DONE;
+	}
+
+	pr_debug("OMAP PM constraints: req@0x%p, dev=0x%p, new_value=%lu\n",
+		 req, dev_pm_qos_req->dev, new_value);
+
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		oh = od->hwmods[i];
+		if (new_value == PM_QOS_DEV_LAT_DEFAULT_VALUE)
+			r = omap_hwmod_remove_wakeuplat_constraint(
+							oh,
+							dev_pm_qos_req);
+		else
+			r = omap_hwmod_set_wakeuplat_constraint(
+							oh,
+							dev_pm_qos_req,
+							new_value);
+
+		if (!r)
+			ret = NOTIFY_BAD;
+	}
+
+	return ret;
+}
 
 /* Public functions for use by core code */
 
@@ -1115,13 +1183,24 @@ int omap_device_enable_clocks(struct omap_device *od)
 	return 0;
 }
 
+static struct notifier_block omap_device_pm_qos_nb = {
+	.notifier_call = _omap_device_pm_qos_handler,
+};
+
 static struct notifier_block platform_nb = {
 	.notifier_call = _omap_device_notifier_call,
 };
 
 static int __init omap_device_init(void)
 {
+	int ret;
+
 	bus_register_notifier(&platform_bus_type, &platform_nb);
-	return 0;
+
+	ret = dev_pm_qos_add_global_notifier(&omap_device_pm_qos_nb);
+	if (ret)
+		pr_err("omap_device: cannot add global notifier for dev PM QoS\n");
+
+	return ret;
 }
 core_initcall(omap_device_init);
-- 
1.7.7.6

