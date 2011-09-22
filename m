From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/6] OMAP4: System control module device support
Date: Thu, 22 Sep 2011 20:59:20 +0530
Message-ID: <1316705361-12175-6-git-send-email-j-keerthy@ti.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49377 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1IVP32 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:29:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8MFTOZC022865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 10:29:26 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8MFTNZL025732
	for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 20:59:23 +0530 (IST)
In-Reply-To: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com

The device file adds the device support for OMAP4 system control module.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com
---
 arch/arm/mach-omap2/Makefile     |    1 +
 arch/arm/mach-omap2/scm_device.c |  125 ++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig       |   12 ++++
 3 files changed, 138 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/scm_device.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e6f8d36..3332693 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+obj-$(CONFIG_OMAP_SCM_DEV)          += scm_device.o
 
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
diff --git a/arch/arm/mach-omap2/scm_device.c b/arch/arm/mach-omap2/scm_device.c
new file mode 100644
index 0000000..d942f28
--- /dev/null
+++ b/arch/arm/mach-omap2/scm_device.c
@@ -0,0 +1,125 @@
+/*
+ * OMAP4460+ SCM device file
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: J Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/idr.h>
+#include <plat/omap_device.h>
+#include "pm.h"
+#include <plat/scm.h>
+
+static struct omap_device_pm_latency scm_latency[] = {
+	{
+		.deactivate_func = NULL,
+		.activate_func =  NULL,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	}
+};
+
+static DEFINE_IDR(scm_device_idr);
+
+static int scm_dev_init(struct omap_hwmod *oh, void *user)
+{
+	struct	omap4460plus_scm_pdata		*scm_pdata;
+	struct	omap_device			*od;
+	struct	omap4460plus_scm_dev_attr	*scm_dev_attr;
+	struct	omap_temp_sensor_registers	*reg_ptr;
+	const	char				*name_ptr;
+	int					ret = 0;
+	int					num, i;
+
+	scm_pdata =
+	    kzalloc(sizeof(*scm_pdata), GFP_KERNEL);
+	if (!scm_pdata) {
+		dev_err(&oh->od->pdev.dev,
+			"Unable to allocate memory for scm pdata\n");
+		return -ENOMEM;
+	}
+
+	ret = idr_pre_get(&scm_device_idr, GFP_KERNEL);
+	if (ret < 0)
+		goto fail_id;
+	ret = idr_get_new(&scm_device_idr, scm_pdata, &num);
+	if (ret < 0)
+		goto fail_id;
+	scm_dev_attr = oh->dev_attr;
+	scm_pdata->cnt = scm_dev_attr->cnt;
+
+	if (scm_dev_attr->cnt > 0) {
+		scm_pdata->name = kzalloc(sizeof(name_ptr) *
+						scm_dev_attr->cnt, GFP_KERNEL);
+		if (!scm_pdata->name) {
+			dev_err(&oh->od->pdev.dev,
+				"Unable to allocate memory for scm name\n");
+			ret = -ENOMEM;
+			goto fail_id;
+		}
+
+		scm_pdata->registers = kzalloc(sizeof(reg_ptr) *
+						scm_dev_attr->cnt, GFP_KERNEL);
+		if (!scm_pdata->name) {
+			dev_err(&oh->od->pdev.dev,
+				"Unable to allocate mem for scm registers\n");
+			ret = -ENOMEM;
+			kfree(scm_pdata->name);
+			goto fail_id;
+		}
+
+		for (i = 0; i < scm_dev_attr->cnt; i++) {
+			scm_pdata->registers[i] = scm_dev_attr->list[i];
+			scm_pdata->name[i] = scm_dev_attr->name[i];
+		}
+	} else {
+		dev_warn(&oh->od->pdev.dev, "Invalid device count\n");
+		ret = -EINVAL;
+		goto fail_id;
+	}
+
+	od = omap_device_build("omap4460plus_scm", num,
+		oh, scm_pdata, sizeof(*scm_pdata),
+		scm_latency,
+		ARRAY_SIZE(scm_latency), 0);
+
+	if (IS_ERR(od)) {
+		dev_warn(&oh->od->pdev.dev,
+			"Could not build omap_device for %s\n", oh->name);
+		ret = PTR_ERR(od);
+	}
+
+fail_id:
+	kfree(scm_pdata);
+
+	return ret;
+}
+
+int __init omap4460plus_devinit_scm(void)
+{
+	if (!cpu_is_omap446x())
+		return 0;
+
+	return omap_hwmod_for_each_by_class("ctrl_module",
+			scm_dev_init, NULL);
+}
+
+arch_initcall(omap4460plus_devinit_scm);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index bb8f4a6..f1f572b 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -116,6 +116,18 @@ config OMAP_MCBSP
 	  Say Y here if you want support for the OMAP Multichannel
 	  Buffered Serial Port.
 
+config OMAP_SCM_DEV
+	bool "OMAP4 System control module Support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want support for the system control
+	  module on OMAP4.
+
+	  This provides the basic support of system control module
+	  subsystem. SCM also includes instance/instances of on die
+	  temperature sensor.
+
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
-- 
1.7.0.4

