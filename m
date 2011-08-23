From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 02/13] dt: Add pd_size to AUXDATA structure
Date: Tue, 23 Aug 2011 10:03:30 +0500
Message-ID: <1314074021-25186-3-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:40902 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750945Ab1HWEpw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:45:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


Add pd_size in the AUXDATA structure so that omap HWMOD which require
platform_data size can pass along with AUXDATA.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 drivers/of/platform.c       |    2 ++
 include/linux/of_platform.h |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b030fd5..e50ffcb 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -565,6 +565,7 @@ static int of_platform_bus_create(struct device_node *bus,
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
+	int pd_size;
 	int id = -1;
 	int rc = 0;
 
@@ -588,6 +589,7 @@ static int of_platform_bus_create(struct device_node *bus,
 		bus_id = auxdata->name;
 		id = auxdata->id;
 		platform_data = auxdata->platform_data;
+		pd_size = auxdata->pd_size;
 	}
 
 	if (of_device_is_compatible(bus, "arm,primecell")) {
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 252246c..a3be980 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -47,6 +47,7 @@ struct of_dev_auxdata {
 	char *name;
 	int id;
 	void *platform_data;
+	int pd_size;
 };
 
 /* Macro to simplify populating a lookup table */
@@ -58,6 +59,10 @@ struct of_dev_auxdata {
 	{ .compatible = _compat, .phys_addr = _phys, .name = _name, \
 	  .id = _id, .platform_data = _pdata }
 
+#define OF_DEV_AUXDATA_ID_PDSIZE(_compat,_phys,_name,_id,_pdata,_pd_size) \
+	{ .compatible = _compat, .phys_addr = _phys, .name = _name, \
+	  .id = _id, .platform_data = _pdata, .pd_size = _pd_size }
+
 /**
  * of_platform_driver - Legacy of-aware driver for platform devices.
  *
-- 
1.7.4.1

