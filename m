From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 08/08] OMAP3 SRF: Adds sysfs control for VDD1/VDD2 OPP's
Date: Mon, 10 Nov 2008 16:59:10 +0530
Message-ID: <00c601c94327$8d6398f0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48273 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754500AbYKJL3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:29:18 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAABTBdb003657
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 05:29:17 -0600
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAABTBJq013133
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 16:59:11 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds sysfs hooks to control VDD1 and VDD2 OPP's
in the absense of a CPUFreq driver/governor

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.c	2008-11-10 15:44:19.000000000 +0530
@@ -24,6 +24,7 @@
 #include <linux/suspend.h>
 #include <linux/time.h>
 #include <linux/platform_device.h>
+#include <linux/device.h>
 
 #include <mach/cpu.h>
 #include <asm/mach/time.h>
@@ -32,6 +33,7 @@
 #include <mach/pm.h>
 #include <mach/powerdomain.h>
 #include <mach/omapdev.h>
+#include <mach/resource.h>
 
 #include "prm-regbits-34xx.h"
 #include "pm.h"
@@ -58,6 +60,18 @@ static struct kobj_attribute enable_off_
 static struct kobj_attribute voltage_off_while_idle_attr =
 	__ATTR(voltage_off_while_idle, 0644, idle_show, idle_store);
 
+#ifdef CONFIG_OMAP_PM_SRF
+static struct device dummy_sysfs_dev;
+static ssize_t vdd_opp_show(struct kobject *, struct kobj_attribute *, char *);
+static ssize_t vdd_opp_store(struct kobject *k, struct kobj_attribute *,
+			  const char *buf, size_t n);
+static struct kobj_attribute vdd1_opp_attr =
+	__ATTR(vdd1_opp, 0644, vdd_opp_show, vdd_opp_store);
+
+static struct kobj_attribute vdd2_opp_attr =
+	__ATTR(vdd2_opp, 0644, vdd_opp_show, vdd_opp_store);
+#endif
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -106,6 +120,45 @@ static ssize_t idle_store(struct kobject
 	return n;
 }
 
+#ifdef CONFIG_OMAP_PM_SRF
+static ssize_t vdd_opp_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	if (attr == &vdd1_opp_attr)
+		return sprintf(buf, "%hu\n", resource_get_level("vdd1_opp"));
+	else if (attr == &vdd2_opp_attr)
+		return sprintf(buf, "%hu\n", resource_get_level("vdd2_opp"));
+	else
+		return -EINVAL;
+}
+
+static ssize_t vdd_opp_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t n)
+{
+	unsigned short value;
+
+	if (sscanf(buf, "%hu", &value) != 1)
+		return -EINVAL;
+
+	if (attr == &vdd1_opp_attr) {
+		if (value < 1 || value > 5) {
+			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
+			return -EINVAL;
+		}
+		resource_request("vdd1_opp", &dummy_sysfs_dev, value);
+	} else if (attr == &vdd2_opp_attr) {
+		if (value < 2 || value > 3) {
+			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
+			return -EINVAL;
+		}
+		resource_request("vdd2_opp", &dummy_sysfs_dev, value);
+	} else {
+		return -EINVAL;
+	}
+	return n;
+}
+#endif
+
 void omap2_block_sleep(void)
 {
 	atomic_inc(&sleep_block);
@@ -162,7 +215,20 @@ static int __init omap_pm_init(void)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 		return error;
 	}
-
+#ifdef CONFIG_OMAP_PM_SRF
+	error = sysfs_create_file(power_kobj,
+				  &vdd1_opp_attr.attr);
+	if (error) {
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		return error;
+	}
+	error = sysfs_create_file(power_kobj,
+				  &vdd2_opp_attr.attr);
+	if (error) {
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		return error;
+	}
+#endif
 	voltage_off_while_idle = 0;
 	/* Going to 0V on anything under ES2.1 will eventually cause a crash */
 	if (system_rev > OMAP3430_REV_ES2_0) {

