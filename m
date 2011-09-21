From: jean.pihet@newoldbits.com
Subject: [PATCH 5/8] OMAP: PM: register to the per-device PM QoS framework
Date: Wed, 21 Sep 2011 18:24:15 +0200
Message-ID: <1316622258-3892-6-git-send-email-j-pihet@ti.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
 <1316622258-3892-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38909 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab1IUQ0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 12:26:00 -0400
Received: by eya28 with SMTP id 28so1090457eya.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 09:25:59 -0700 (PDT)
In-Reply-To: <1316622258-3892-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implement the devices wake-up latency constraints using the global
device PM QoS notification handler which applies the constraints to the
underlying layer by calling the corresponding function at hwmod level.

Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wake-up
latency constraints on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3feb359..58b4b76 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -11,13 +11,16 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/opp.h>
+#include <linux/pm_qos.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include <plat/common.h>
+#include <plat/omap_hwmod.h>
 
 #include "voltage.h"
 #include "powerdomain.h"
@@ -242,11 +245,71 @@ static void __init omap4_init_voltages(void)
 	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
 }
 
+/* Interface to the per-device PM QoS framework */
+static int omap2_dev_pm_qos_handler(struct notifier_block *nb,
+				    unsigned long new_value,
+				    void *req)
+{
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	struct dev_pm_qos_request *dev_pm_qos_req = req;
+
+	pr_debug("OMAP PM CONSTRAINTS: req@0x%p, new_value=%lu\n",
+		 req, new_value);
+
+	/* Look for the platform device for the constraint target device */
+	pdev = to_platform_device(dev_pm_qos_req->dev);
+
+	/* Try to catch non platform devices */
+	if (pdev->name == NULL) {
+		pr_err("%s: Error: platform device for device %s not valid\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return -EINVAL;
+	}
+
+	/* Find the associated omap_device for dev */
+	od = container_of(pdev, struct omap_device, pdev);
+	if (od->hwmods_cnt != 1) {
+		pr_err("%s: Error: No unique hwmod for device %s\n",
+		       __func__, dev_name(dev_pm_qos_req->dev));
+		return -EINVAL;
+	}
+
+	/* Find the primary omap_hwmod for dev */
+	oh = od->hwmods[0];
+
+	pr_debug("OMAP PM CONSTRAINTS: req@0x%p, dev=0x%p, new_value=%lu\n",
+		 req, dev_pm_qos_req->dev, new_value);
+
+	/* Apply the constraint */
+	return omap_hwmod_set_wkup_lat_constraint(oh, dev_pm_qos_req,
+						  new_value);
+}
+
+static struct notifier_block omap2_dev_pm_qos_notifier = {
+	.notifier_call	= omap2_dev_pm_qos_handler,
+};
+
+static int __init omap2_dev_pm_qos_init(void)
+{
+	int ret;
+
+	ret = dev_pm_qos_add_global_notifier(&omap2_dev_pm_qos_notifier);
+	if (ret)
+		WARN(1, KERN_ERR "Cannot add global notifier for dev PM QoS\n");
+
+	return ret;
+}
+
 static int __init omap2_common_pm_init(void)
 {
 	omap2_init_processor_devices();
 	omap_pm_if_init();
 
+	/* Register to the per-device PM QoS framework */
+	omap2_dev_pm_qos_init();
+
 	return 0;
 }
 postcore_initcall(omap2_common_pm_init);
-- 
1.7.4.1

