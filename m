From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATH] [OMAPZOOM] DSPBRIDGE: move platform_device_register under
 mach-omap2
Date: Wed, 1 Apr 2009 15:42:30 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287EF2BC1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50348 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760529AbZDAUmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 16:42:44 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n31KgXXM030457
	for <linux-omap@vger.kernel.org>; Wed, 1 Apr 2009 15:42:40 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n31KgXiL014166
	for <linux-omap@vger.kernel.org>; Wed, 1 Apr 2009 15:42:33 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>


This is the previous patch from Hiroshi (http://marc.info/?l=linux-omap&m=123798191710417&w=2) rebase to apply on top of the previous patches for OMAPZOOM.

>From 18cf4f8463013936fda13434ef65beba8df62487 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Tue, 31 Mar 2009 16:21:18 -0500
Subject: [PATCH] DSPBRIDGE: move platform_device_register under mach-omap2

To pass some architecture specific info to drvier.

This can be used to pass the address of relatively bigger
preallocated bootmem to driver if its size is configured by kernel config.

This patch is rebasing a previous Hiroshi's patch, here is the link to the patch
http://marc.info/?l=linux-omap&m=123798191710417&w=2

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile                   |    2 +
 arch/arm/mach-omap2/dspbridge.c                |   65 ++++++++++
 arch/arm/mach-omap2/io.c                       |    3 +
 arch/arm/plat-omap/devices.c                   |   30 +++++
 arch/arm/plat-omap/include/dspbridge/host_os.h |   12 ++
 drivers/dsp/bridge/Kconfig                     |    8 ++
 drivers/dsp/bridge/rmgr/drv_interface.c        |  160 ++++++++++--------------
 7 files changed, 186 insertions(+), 94 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dspbridge.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9d4236f..91685dc
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -45,6 +45,8 @@ else
        # Power Management
 endif
 
+dspbridge-$(CONFIG_MPU_BRIDGE)		:= dspbridge.o
+obj-y					+= $(dspbridge-m) $(dspbridge-y)
 
 # DSP
 obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o
diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
new file mode
index 0000000..16c0937
--- /dev/null
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -0,0 +1,65 @@
+/*
+ * TI's dspbridge platform device registration
+ *
+ * Copyright (C) 2005-2006 Texas Instruments, Inc.
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+
+#include <dspbridge/host_os.h>
+
+static struct platform_device *dspbridge_pdev;
+
+static struct dspbridge_platform_data dspbridge_pdata;
+
+static int __init dspbridge_init(void)
+{
+	struct platform_device *pdev;
+	int err = -ENOMEM;
+	struct dspbridge_platform_data *pdata = &dspbridge_pdata;
+
+	pdata->phys_mempool_base = dspbridge_get_mempool_base();
+
+	if (pdata->phys_mempool_base) {
+		pdata->phys_mempool_size = CONFIG_BRIDGE_MEMPOOL_SIZE;
+		pr_info("%s: %x bytes @ %x\n", __func__,
+			pdata->phys_mempool_size, pdata->phys_mempool_base);
+	}
+
+	pdev = platform_device_alloc("C6410", -1);
+	if (!pdev)
+		goto err_out;
+
+	err = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+	if (err)
+		goto err_out;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_out;
+
+	dspbridge_pdev = pdev;
+	return 0;
+
+err_out:
+	platform_device_put(pdev);
+	return err;
+}
+module_init(dspbridge_init);
+
+static void __exit dspbridge_exit(void)
+{
+	platform_device_unregister(dspbridge_pdev);
+}
+module_exit(dspbridge_exit);
+
+MODULE_AUTHOR("Hiroshi DOYU");
+MODULE_DESCRIPTION("TI's dspbridge platform device registration");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b051ce3..95c106d
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -29,6 +29,8 @@
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
 
+#include <dspbridge/host_os.h>
+
 #include "clock.h"
 
 #include <mach/powerdomain.h>
@@ -202,6 +204,7 @@ void __init omap2_map_common_io(void)
 	omap2_check_revision();
 	omap_sram_init();
 	omapfb_reserve_sdram();
+	dspbridge_reserve_sdram();
 }
 
 void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index c22bd5f..72dd34e
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c/menelaus.h>
+#include <linux/bootmem.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -85,6 +86,35 @@ int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
 }
 EXPORT_SYMBOL(dsp_kfunc_device_register);
 
+#elif defined(CONFIG_MPU_BRIDGE) ||  defined(CONFIG_MPU_BRIDGE_MODULE)
+
+static unsigned long dspbridge_phys_mempool_base;
+
+void dspbridge_reserve_sdram(void)
+{
+	void *va;
+	unsigned long size = CONFIG_BRIDGE_MEMPOOL_SIZE;
+
+	if (!size)
+		return;
+
+	va = __alloc_bootmem_nopanic(size, SZ_1M, 0);
+	if (!va) {
+		pr_err("%s: Failed to bootmem allocation(%lu bytes)\n",
+		       __func__, size);
+		return;
+	}
+	dspbridge_phys_mempool_base = virt_to_phys(va);
+}
+
+unsigned long dspbridge_get_mempool_base(void)
+{
+	return dspbridge_phys_mempool_base;
+}
+EXPORT_SYMBOL(dspbridge_get_mempool_base);
+
+static inline void omap_init_dsp(void) { }
+
 #else
 static inline void omap_init_dsp(void) { }
 #endif	/* CONFIG_OMAP_DSP */
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 9245eea..ffdb7b4
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -64,4 +64,16 @@
 #define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28
 
+struct dspbridge_platform_data {
+	u32 phys_mempool_base;
+	u32 phys_mempool_size;
+};
+
+#define PRCM_VDD1 1
+
+extern struct platform_device *omap_dspbridge_dev;
+
+extern void dspbridge_reserve_sdram(void);
+extern unsigned long dspbridge_get_mempool_base(void);
+
 #endif
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 727f268..6669993
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -29,6 +29,14 @@ config DISABLE_BRIDGE_PM
 	  DSP Bridge employs power management techniques to save dynamic and
 	  static power consumption of the IVA sub system.
 
+config BRIDGE_MEMPOOL_SIZE
+	hex "Physical memory pool size (Byte)"
+	depends on MPU_BRIDGE
+	default 0x600000
+	help
+	  Allocate specified size of memory at booting time to avoid allocation
+	  failure under heavy memory fragmentation after some use time.
+
 config BRIDGE_DEBUG
 	bool "DSP Bridge Debug Support"
 	depends on MPU_BRIDGE
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 21e9757..60d4b46
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -125,6 +125,7 @@ struct clk *clk_handle;
 #define DRIVER_MINOR 0		/* Linux assigns our Major device number */
 s32 dsp_debug;
 
+struct platform_device *omap_dspbridge_dev;
 /* This is a test variable used by Bridge to test different sleep states */
 s32 dsp_test_sleepstate;
 struct bridge_dev {
@@ -221,30 +222,9 @@ static struct file_operations bridge_fops = {
 
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 static u32 timeOut = 1000;
-
-static int bridge_suspend(struct platform_device *pdev, pm_message_t state);
-static int bridge_resume(struct platform_device *pdev);
 #endif
 
-static void bridge_free(struct device *dev);
-
-static int omap34xx_bridge_probe(struct platform_device *dev);
-
-static int omap34xx_bridge_probe(struct platform_device *dev)
-{
-	return 0;
-}
-
-static struct platform_device omap_dspbridge_dev = {
-		.name = BRIDGE_NAME,
-		.id = -1,
-		.num_resources = 0,
-		.dev = {
-		.release = bridge_free,
-		},
-		.resource = NULL,
-};
-
+struct dspbridge_platform_data *omap_dspbridge_pdata;
 
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
@@ -315,29 +295,7 @@ static struct constraint_id cnstr_id_vdd1 = {
 #endif
 #endif
 
-static struct platform_driver bridge_driver_ldm = {
-      .driver = {
-	      .owner	= THIS_MODULE,
-	      .name     = BRIDGE_NAME,
-	 },
-      .probe = omap34xx_bridge_probe,
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-      .suspend = bridge_suspend,
-      .resume = bridge_resume,
-#endif
-      .shutdown = NULL,
-      .remove = NULL,
-
-};
-
-struct device dspbridge_device = {
-	.driver = &bridge_driver_ldm.driver,
-};
-
-/* Initialization routine. Executed when the driver is loaded (as a kernel
- * module), or when the system is booted (when included as part of the kernel
- * image). */
-static int __init bridge_init(void)
+static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 {
 	int status;
 	u32 initStatus;
@@ -345,6 +303,10 @@ static int __init bridge_init(void)
 	dev_t   dev = 0 ;
 	int     result;
 
+	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
+
+	omap_dspbridge_dev = pdev;
+
 	/* use 2.6 device model */
 	if (driver_major) {
 		dev = MKDEV(driver_major, driver_minor);
@@ -405,9 +367,6 @@ static int __init bridge_init(void)
 
 
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_init\n");
-	status = platform_driver_register(&bridge_driver_ldm);
-	if (!status)
-		status = platform_device_register(&omap_dspbridge_dev);
 
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 	/* Initialize the wait queue */
@@ -449,12 +408,17 @@ static int __init bridge_init(void)
 	GT_1trace(driverTrace, GT_7CLASS,
 		 "requested shm_size = 0x%x\n", shm_size);
 
+	if (pdata->phys_mempool_base && pdata->phys_mempool_size) {
+		phys_mempool_base = pdata->phys_mempool_base;
+		phys_mempool_size = pdata->phys_mempool_size;
+	}
+
 	if (phys_mempool_base > 0x0) {
 		initStatus = REG_SetValue(NULL, NULL, PHYSMEMPOOLBASE,
 					 REG_DWORD, (u8 *)&phys_mempool_base,
 					 sizeof(phys_mempool_base));
 	}
-	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_base = 0x%x \n",
+	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_base = 0x%x\n",
 		 phys_mempool_base);
 
 	if (phys_mempool_size > 0x0) {
@@ -528,9 +492,7 @@ static int __init bridge_init(void)
 	return status;
 }
 
-/*  This function is invoked during unlinking of the bridge module from the
- *  kernel. Bridge resources are freed in this function. */
-static void __exit bridge_exit(void)
+static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 {
 	dev_t devno;
 	bool ret;
@@ -601,9 +563,6 @@ func_cont:
 #endif /*#ifndef CONFIG_OMAP3_PM*/
 #endif /*#ifndef CONFIG_DISABLE_BRIDGE_DVFS*/
 #endif /*#ifndef CONFIG_DISABLE_BRIDGE_PM*/
-	/* unregister bridge driver */
-	platform_device_unregister(&omap_dspbridge_dev);
-	platform_driver_unregister(&bridge_driver_ldm);
 
 	if (driverContext) {
 		ret = DSP_Deinit(driverContext);
@@ -626,6 +585,58 @@ func_cont:
 		class_destroy(bridge_class);
 
 	}
+	return 0;
+}
+
+#ifndef CONFIG_DISABLE_BRIDGE_PM
+static int bridge_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	u32 status;
+	u32 command = PWR_EMERGENCYDEEPSLEEP;
+
+	status = PWR_SleepDSP(command, timeOut);
+	if (DSP_FAILED(status))
+		return -1;
+
+	bridge_suspend_data.suspended = 1;
+	return 0;
+}
+
+static int bridge_resume(struct platform_device *pdev)
+{
+	u32 status;
+
+	status = PWR_WakeDSP(timeOut);
+	if (DSP_FAILED(status))
+		return -1;
+
+	bridge_suspend_data.suspended = 0;
+	wake_up(&bridge_suspend_data.suspend_wq);
+	return 0;
+}
+#else
+#define bridge_suspend NULL
+#define bridge_resume NULL
+#endif
+
+static struct platform_driver bridge_driver_ldm = {
+	.driver = {
+		.name = BRIDGE_NAME,
+	},
+	.probe	 = omap34xx_bridge_probe,
+	.remove	 = omap34xx_bridge_remove,
+	.suspend = bridge_suspend,
+	.resume	 = bridge_resume,
+};
+
+static int __init bridge_init(void)
+{
+	return platform_driver_register(&bridge_driver_ldm);
+}
+
+static void __exit bridge_exit(void)
+{
+	platform_driver_unregister(&bridge_driver_ldm);
 }
 
 /* This function is called when an application opens handle to the
@@ -741,12 +752,6 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	return status;
 }
 
-static void bridge_free(struct device *dev)
-{
-	/* nothing to Free */
-}
-
-
 /* This function provides IO interface to the bridge driver. */
 static int bridge_ioctl(struct inode *ip, struct file *filp, unsigned int code,
 		unsigned long args)
@@ -832,39 +837,6 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 }
 #endif
 
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-
-static int bridge_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	u32 status = DSP_EFAIL;
-	u32 command = PWR_EMERGENCYDEEPSLEEP;
-
-	status = PWR_SleepDSP(command, timeOut);
-	if (DSP_SUCCEEDED(status)) {
-		bridge_suspend_data.suspended = 1;
-		return 0;
-	} else {
-		return -1;
-	}
-}
-
-static int bridge_resume(struct platform_device *pdev)
-{
-	u32 status = DSP_EFAIL;
-
-	status = PWR_WakeDSP(timeOut);
-
-	if (DSP_SUCCEEDED(status)) {
-		bridge_suspend_data.suspended = 0;
-		wake_up(&bridge_suspend_data.suspend_wq);
-
-		return 0;
-	} else {
-		return -1;
-	}
-}
-
-#endif
 /* Bridge driver initialization and de-initialization functions */
 module_init(bridge_init);
 module_exit(bridge_exit);
-- 
1.5.6.4

