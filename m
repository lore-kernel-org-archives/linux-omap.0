From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/20] OMAP: PM: create omap_devices for MPU, DSP, L3
Date: Fri, 02 Jul 2010 09:29:32 -0600
Message-ID: <20100702152930.6221.32877.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45293 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758779Ab0GBPbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:05 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Create simple omap_devices for the main processors and busses.

This is required to support the forth-coming device-based OPP
approach, where OPPs are managed and tracked at the device level.

Also, move these common PM init functions into a common_pm_init call
that is called as a device_initcall().  The PM init is done at this level
to ensure that the driver core is initialized before initialized.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[paul@pwsan.com: sparse warnings cleaned up; newly-created functions moved
 from mach-omap2/io.c to mach-omap2/pm.c; newly-created functions renamed
 to start with "omap2" rather than "omap"]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile             |    2 -
 arch/arm/mach-omap2/io.c                 |    2 -
 arch/arm/mach-omap2/pm.c                 |   84 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    4 +
 4 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2fa3418..213f1df 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 05c9cdb..2b983ac 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -44,6 +44,7 @@
 
 #include <plat/clockdomain.h>
 #include "clockdomains.h"
+
 #include <plat/omap_hwmod.h>
 
 /*
@@ -346,7 +347,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
 		omap_hwmod_late_init(skip_setup_idle);
 
-	omap_pm_if_init();
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
new file mode 100644
index 0000000..68f9f2e
--- /dev/null
+++ b/arch/arm/mach-omap2/pm.c
@@ -0,0 +1,84 @@
+/*
+ * pm.c - Common OMAP2+ power management-related code
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+#include <plat/omap-pm.h>
+#include <plat/omap_device.h>
+#include <plat/common.h>
+
+static struct omap_device_pm_latency *pm_lats;
+
+static struct device *mpu_dev;
+static struct device *dsp_dev;
+static struct device *l3_dev;
+
+struct device *omap2_get_mpuss_device(void)
+{
+	WARN_ON_ONCE(!mpu_dev);
+	return mpu_dev;
+}
+
+struct device *omap2_get_dsp_device(void)
+{
+	WARN_ON_ONCE(!dsp_dev);
+	return dsp_dev;
+}
+
+struct device *omap2_get_l3_device(void)
+{
+	WARN_ON_ONCE(!l3_dev);
+	return l3_dev;
+}
+
+/* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
+static int _init_omap_device(char *name, struct device **new_dev)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+
+	oh = omap_hwmod_lookup(name);
+	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
+		 __func__, name))
+		return -ENODEV;
+
+	od = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
+	if (WARN(IS_ERR(od), "%s: could not build omap_device for %s\n",
+		 __func__, name))
+		return -ENODEV;
+
+	*new_dev = &od->pdev.dev;
+
+	return 0;
+}
+
+/*
+ * Build omap_devices for processors and bus.
+ */
+static void omap2_init_processor_devices(void)
+{
+	_init_omap_device("mpu", &mpu_dev);
+	_init_omap_device("iva", &dsp_dev);
+	_init_omap_device("l3_main", &l3_dev);
+}
+
+static int __init omap2_common_pm_init(void)
+{
+	omap2_init_processor_devices();
+	omap_pm_if_init();
+
+	return 0;
+}
+device_initcall(omap2_common_pm_init);
+
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 5e4afbe..5cf9509 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -89,4 +89,8 @@ void omap2_set_globals_uart(struct omap_globals *);
 	}							\
 })
 
+extern struct device *omap2_get_mpuss_device(void);
+extern struct device *omap2_get_dsp_device(void);
+extern struct device *omap2_get_l3_device(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */


