From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/12] OMAP: create omap_devices for MPU, DSP, L3
Date: Wed, 16 Jun 2010 17:17:06 -0700
Message-ID: <1276733833-18510-6-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49651 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758043Ab0FQAR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:29 -0400
Received: by mail-pw0-f46.google.com with SMTP id 1so3974097pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:28 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Create simple omap_devices for the main processors and busses.

This is required to support the forth-coming device-based OPP
approach, where OPPs are managed and tracked at the omap_device and
hwmod level.

Because these omap_devices are based on platform_devices, they cannot
be created until the driver core has been initialized.  Therefore, move
the init of these into a device_initcall().  Also, OMAP PM init cannot
be done until after this step as it depends on the OPP layer.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/devices.c            |    2 +
 arch/arm/mach-omap2/io.c                 |   68 ++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/common.h |    4 ++
 3 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 03e6c9e..62920ac 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -29,6 +30,7 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/omap_device.h>
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 78d37c0..12a2836 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -44,7 +44,7 @@
 
 #include <plat/clockdomain.h>
 #include "clockdomains.h"
-#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 #include "omap3-opp.h"
 /*
@@ -311,12 +311,71 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
 
-void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
-				 struct omap_sdrc_params *sdrc_cs1)
+static struct omap_device_pm_latency *pm_lats;
+
+static struct device *mpu_dev;  /* FIXME: needs clean SMP support */
+static struct device *dsp_dev;
+static struct device *l3_dev;
+
+struct device *omap_get_mpu_device(void)
+{
+	WARN_ON_ONCE(!mpu_dev);
+	return mpu_dev;
+}
+
+struct device *omap_get_dsp_device(void)
+{
+	WARN_ON_ONCE(!dsp_dev);
+	return dsp_dev;
+}
+
+struct device *omap_get_l3_device(void)
 {
+	WARN_ON_ONCE(!l3_dev);
+	return l3_dev;
+}
+
+static int _init_omap_device(struct omap_hwmod *oh, void *user)
+{
+	struct omap_device *od;
+	const char *name = oh->name;
+	struct device **new_dev = (struct device **)user;
+
+	od = omap_device_build(name, 0, oh, NULL, 0, pm_lats, 0, false);
+	if (WARN(IS_ERR(od), "Could not build omap_device for %s\n", name))
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
+static void omap_init_processor_devices(void)
+{
+	omap_hwmod_for_each_by_class("mpu", _init_omap_device, &mpu_dev);
+	omap_hwmod_for_each_by_class("dsp", _init_omap_device, &dsp_dev);
+	omap_hwmod_for_each_by_class("l3", _init_omap_device, &l3_dev);
+}
+
+static int __init omap2_late_common_init(void)
+{
+	omap_init_processor_devices();
+
 	/* initialize the opp table if board file has not done so */
 	omap3_pm_init_opp_table();
 
+	omap_pm_if_init();
+
+	return 0;
+}
+device_initcall(omap2_late_common_init);
+
+void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
+				 struct omap_sdrc_params *sdrc_cs1)
+{
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_autodeps);
 	if (cpu_is_omap242x())
@@ -325,6 +384,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		omap2430_hwmod_init();
 	else if (cpu_is_omap34xx())
 		omap3xxx_hwmod_init();
+
 	omap2_mux_init();
 	omap_pm_if_early_init();
 
@@ -342,7 +402,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap_serial_early_init();
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
 		omap_hwmod_late_init();
-	omap_pm_if_init();
+
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 5e4afbe..4ac08ca 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -89,4 +89,8 @@ void omap2_set_globals_uart(struct omap_globals *);
 	}							\
 })
 
+struct device *omap_get_mpu_device(void);
+struct device *omap_get_dsp_device(void);
+struct device *omap_get_l3_device(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.7.0.2

