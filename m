From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 2/3] DSPBRIDGE: Implement sysfs entry to enable/disable wdt3
Date: Wed, 11 Nov 2009 00:57:03 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6A218FA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60650 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbZKKG5A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 01:57:00 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAB6v6VF020354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:57:06 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAB6v5oi016511
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:57:05 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAB6v5Rc013711
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:57:05 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 538a9876a6a1568a0c63679cab0f1ce787aedef9 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 11 Nov 2009 00:31:48 -0600
Subject: [PATCH] DSPBRIDGE: Implement sysfs entry to enable/disable wdt3

This patch implements new sysfs entry to enable or disable
wdt3 at run time:
echo 1 > /sys/devices/platform/C6410/wdt3_enable //to enable
echo 0 > /sys/devices/platform/C6410/wdt3_enable //to disable

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Armando Uribe <x0095078@ti.com>
Signed-off-by: Somashekar Chandrappa <somashekar.c@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   63 +++++++++++++++++++++++++++++--
 1 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 65ac1e7..e9cd647 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -130,6 +130,9 @@ static s32 shm_size = 0x500000;	/* 5 MB */
 static u32 phys_mempool_base;
 static u32 phys_mempool_size;
 static int tc_wordswapon;	/* Default value is always false */
+#ifdef CONFIG_BRIDGE_WDT3
+extern u32 wtd3_enable;
+#endif
 
 /* Minimum ACTIVE VDD1 OPP level for reliable DSP operation */
 unsigned short min_active_opp = 3;
@@ -680,7 +683,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 /*
  * sysfs
  */
-static ssize_t drv_state_show(struct kobject *kobj, struct kobj_attribute *attr,
+static ssize_t drv_state_show(struct device *dev, struct device_attribute *attr,
                         char *buf)
 {
 	struct WMD_DEV_CONTEXT *dwContext;
@@ -701,11 +704,63 @@ static ssize_t drv_state_show(struct kobject *kobj, struct kobj_attribute *attr,
         return sprintf(buf, "%d\n", drv_state);
 }
 
-static struct kobj_attribute drv_state_attr = __ATTR_RO(drv_state);
+static DEVICE_ATTR(drv_state, S_IRUGO, drv_state_show, NULL);
+
+#ifdef CONFIG_BRIDGE_WDT3
+static ssize_t wdt3_show(struct device *dev, struct device_attribute *attr,
+							char *buf)
+{
+	return sprintf(buf, "%d\n", wtd3_enable);
+}
+
+static ssize_t wdt3_store(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t n)
+{
+	u32 wdt3;
+	struct DEV_OBJECT *dev_object;
+	struct WMD_DEV_CONTEXT *dev_ctxt;
+
+	if (sscanf(buf, "%d", &wdt3) != 1)
+		return -EINVAL;
+
+	dev_object = DEV_GetFirst();
+	if (!dev_object)
+		goto func_end;
+	DEV_GetWMDContext(dev_object, &dev_ctxt);
+	if (!dev_ctxt)
+		goto func_end;
+
+	/* enable WDT */
+	if (wdt3 == 1) {
+		if (wtd3_enable)
+			goto func_end;
+		if (!CLK_Get_UseCnt(SERVICESCLK_wdt3_fck) &&
+				dev_ctxt->dwBrdState != BRD_DSP_HIBERNATION &&
+				DSP_FAILED(dsp_wdt_config(WDT3_ENABLE))) {
+			pr_err("Error enabling WDT3\n");
+			goto func_end;
+		}
+		wtd3_enable = 1;
+	} else if (!wdt3) {
+		if (!wtd3_enable)
+			goto func_end;
+		if (CLK_Get_UseCnt(SERVICESCLK_wdt3_fck))
+			dsp_wdt_config(WDT3_DISABLE);
+		wtd3_enable = 0;
+	}
+func_end:
+	return n;
+}
+
+static DEVICE_ATTR(wdt3_enable, S_IWUSR | S_IRUGO, wdt3_show, wdt3_store);
+#endif
 
 static struct attribute *attrs[] = {
-        &drv_state_attr.attr,
-        NULL,
+	&dev_attr_drv_state.attr,
+#ifdef CONFIG_BRIDGE_WDT3
+	&dev_attr_wdt3_enable.attr,
+#endif
+	NULL,
 };
 
 static struct attribute_group attr_group = {
-- 
1.6.0.4

