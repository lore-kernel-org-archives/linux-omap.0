From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 07/13] dt: omap: create platform bus for omap devices
Date: Tue, 23 Aug 2011 10:03:35 +0500
Message-ID: <1314074021-25186-8-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:48815 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751927Ab1HWEqr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:46:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


The omap devices will use HWMOD for fetching device information
hence it needs to be handled seperately during platform bus
creation during dt build.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 drivers/of/platform.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e50ffcb..bd2c089 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -24,6 +24,10 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
+#include <plat/omap_device.h>
+#endif
+
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
 #ifdef CONFIG_ARM_AMBA
@@ -544,6 +548,36 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
 	return NULL;
 }
 
+static struct omap_device_pm_latency omap_device_latency[] = {
+	[0] = {
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int of_omap_device_create(struct device_node *np, const char *name, int id,
+							void *platform_data,
+							int pd_size)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+
+	oh = omap_hwmod_lookup(name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", name);
+		return -EEXIST;
+	}
+
+	pdev = omap_device_build_dt(np, name, id, oh, platform_data,
+				sizeof(platform_data), omap_device_latency,
+				ARRAY_SIZE(omap_device_latency), 0);
+	WARN(IS_ERR(pdev), "Could not build omap_device for %s\n", name);
+
+	pr_info("DT: omap_device build for %s is successful\n", name);
+	return PTR_ERR(pdev);
+}
+
 /**
  * of_platform_bus_create() - Create a device for a node and its children.
  * @bus: device node of the bus to instantiate
@@ -565,7 +599,7 @@ static int of_platform_bus_create(struct device_node *bus,
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
-	int pd_size;
+	int pd_size = 0;
 	int id = -1;
 	int rc = 0;
 
@@ -597,6 +631,11 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
+	if (of_device_is_compatible(bus, "ti,omap-device")) {
+		of_omap_device_create(bus, bus_id, id, platform_data, pd_size);
+		return 0;
+	}
+
 	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
 
 	/* override the id if auxdata gives an id */
-- 
1.7.4.1

