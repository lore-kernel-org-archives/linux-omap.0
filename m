From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: move platform_device_register under mach-omap2
Date: Wed, 25 Mar 2009 13:51:35 +0200
Message-ID: <1237981895-9269-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51508 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877AbZCYLvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 07:51:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 2ameya@gmail.com, h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

To pass some architecture specific info to drvier.

This can be used to pass the address of relatively bigger preallocated
bootmem to driver if its size is configured by kernel config.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile                   |    2 +
 arch/arm/mach-omap2/dspbridge.c                |   72 ++++++++++
 arch/arm/mach-omap2/io.c                       |    3 +
 arch/arm/plat-omap/devices.c                   |   28 ++++
 arch/arm/plat-omap/include/dspbridge/host_os.h |    7 +
 drivers/dsp/bridge/Kconfig                     |    8 +
 drivers/dsp/bridge/rmgr/drv_interface.c        |  170 ++++++++++--------------
 drivers/dsp/bridge/rmgr/node.c                 |    6 +-
 drivers/dsp/bridge/rmgr/proc.c                 |    6 +-
 drivers/dsp/bridge/wmd/io_sm.c                 |    4 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |    6 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c             |    6 +-
 12 files changed, 194 insertions(+), 124 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dspbridge.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c380094..1ed6621 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -35,6 +35,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 obj-$(CONFIG_OMAP_PM_SRF)		+=  resource34xx.o
 
+obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
+
 # DSP
 obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
new file mode 100644
index 0000000..43283c9
--- /dev/null
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -0,0 +1,72 @@
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
+#include <mach/omap-pm.h>
+
+#include <dspbridge/host_os.h>
+
+static struct platform_device *dspbridge_pdev;
+
+static struct dspbridge_platform_data dspbridge_pdata __initdata = {
+	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
+	.dsp_get_opp	 = omap_pm_dsp_get_opp,
+	.cpu_set_freq	 = omap_pm_cpu_set_freq,
+	.cpu_get_freq	 = omap_pm_cpu_get_freq,
+};
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
index f03af9d..88100d4 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -43,6 +43,8 @@
 
 #include <mach/omap-pm.h>
 
+#include <dspbridge/host_os.h>
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -197,6 +199,7 @@ void __init omap2_map_common_io(void)
 	omap2_check_revision();
 	omap_sram_init();
 	omapfb_reserve_sdram();
+	dspbridge_reserve_sdram();
 }
 
 /*
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 2c3c72f..a3992d8 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/i2c/menelaus.h>
+#include <linux/bootmem.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -84,7 +85,34 @@ int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
 	return 0;
 }
 EXPORT_SYMBOL(dsp_kfunc_device_register);
+#elif defined(CONFIG_MPU_BRIDGE) ||  defined(CONFIG_MPU_BRIDGE_MODULE)
 
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
 #else
 static inline void omap_init_dsp(void) { }
 #endif	/* CONFIG_OMAP_DSP */
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index c21ed87..e5e6bb2 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -76,8 +76,15 @@ struct dspbridge_platform_data {
 	void 	(*cpu_set_freq)(unsigned long f);
 	unsigned long (*cpu_get_freq)(void);
 	unsigned long mpu_speed[6];
+
+	u32 phys_mempool_base;
+	u32 phys_mempool_size;
 };
 
 #define PRCM_VDD1 1
 
+extern struct platform_device *omap_dspbridge_dev;
+
+extern void dspbridge_reserve_sdram(void);
+extern unsigned long dspbridge_get_mempool_base(void);
 #endif
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 52613c0..2fed82c 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -21,6 +21,14 @@ config BRIDGE_DVFS
 	  performance and power consumption to the current processing
 	  requirements.
 
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
index 80edc4d..d9504cc 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -110,6 +110,8 @@
 #define DRIVER_MINOR 0		/* Linux assigns our Major device number */
 s32 dsp_debug;
 
+struct platform_device *omap_dspbridge_dev;
+
 struct bridge_dev {
 	struct cdev cdev;
 };
@@ -206,9 +208,6 @@ static struct clk *clk_handle;
 s32 dsp_max_opps = VDD1_OPP3;
 #endif
 
-static int bridge_suspend(struct platform_device *pdev, pm_message_t state);
-static int bridge_resume(struct platform_device *pdev);
-
 /* Maximum Opps that can be requested by IVA*/
 /*vdd1 rate table*/
 #ifdef CONFIG_BRIDGE_DVFS
@@ -228,36 +227,7 @@ const struct omap_opp  vdd1_rate_table_bridge[] = {
 #endif
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
-#ifdef CONFIG_BRIDGE_DVFS
-static struct dspbridge_platform_data dspbridge_pdata = {
-	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
-	.dsp_get_opp = omap_pm_dsp_get_opp,
-	.cpu_set_freq = omap_pm_cpu_set_freq,
-	.cpu_get_freq = omap_pm_cpu_get_freq,
-};
-#else
-static struct dspbridge_platform_data dspbridge_pdata;
-
-#endif
-struct platform_device omap_dspbridge_dev = {
-		.name = BRIDGE_NAME,
-		.id = -1,
-		.num_resources = 0,
-		.dev = {
-		.release = bridge_free,
-		.platform_data = &dspbridge_pdata,
-		},
-		.resource = NULL,
-};
+struct dspbridge_platform_data *omap_dspbridge_pdata;
 
 u32 vdd1_dsp_freq[6][4] = {
 	{0, 0, 0, 0},
@@ -287,29 +257,7 @@ static struct notifier_block iva_clk_notifier = {
 };
 #endif
 
-static struct platform_driver bridge_driver_ldm = {
-      .driver = {
-	      .owner	= THIS_MODULE,
-	      .name     = BRIDGE_NAME,
-	 },
-      .probe = omap34xx_bridge_probe,
-#ifdef CONFIG_PM
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
@@ -318,9 +266,10 @@ static int __init bridge_init(void)
 	int     result;
 #ifdef CONFIG_BRIDGE_DVFS
 	int i = 0;
-	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev.dev.platform_data;
 #endif
+	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
+
+	omap_dspbridge_dev = pdev;
 
 	/* use 2.6 device model */
 	if (driver_major) {
@@ -378,9 +327,6 @@ static int __init bridge_init(void)
 #endif
 
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_init\n");
-	status = platform_driver_register(&bridge_driver_ldm);
-	if (!status)
-		status = platform_device_register(&omap_dspbridge_dev);
 
 #ifdef CONFIG_PM
 	/* Initialize the wait queue */
@@ -417,11 +363,16 @@ static int __init bridge_init(void)
 		initStatus = DSP_EINVALIDARG;
 		status = -1;
 		GT_0trace(driverTrace, GT_7CLASS,
-			 "SHM size must be atleast 64 KB\n");
+			  "SHM size must be at least 64 KB\n");
 	}
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
@@ -435,7 +386,7 @@ static int __init bridge_init(void)
 					 REG_DWORD, (u8 *)&phys_mempool_size,
 					 sizeof(phys_mempool_size));
 	}
-	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_size = 0x%x \n",
+	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_size = 0x%x\n",
 		 phys_mempool_base);
 	if ((phys_mempool_base > 0x0) && (phys_mempool_size > 0x0))
 		MEM_ExtPhysPoolInit(phys_mempool_base, phys_mempool_size);
@@ -487,9 +438,7 @@ static int __init bridge_init(void)
 	return status;
 }
 
-/*  This function is invoked during unlinking of the bridge module from the
- *  kernel. Bridge resources are freed in this function. */
-static void __exit bridge_exit(void)
+static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
 {
 	dev_t devno;
 	bool ret;
@@ -549,10 +498,6 @@ func_cont:
 	clk_handle = NULL;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
 
-	/* unregister bridge driver */
-	platform_device_unregister(&omap_dspbridge_dev);
-	platform_driver_unregister(&bridge_driver_ldm);
-
 	if (driverContext) {
 		ret = DSP_Deinit(driverContext);
 		driverContext = 0;
@@ -574,6 +519,59 @@ func_cont:
 		class_destroy(bridge_class);
 
 	}
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
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
@@ -779,38 +777,6 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 }
 #endif
 
-#ifdef CONFIG_PM
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
-#endif
-
 /* Bridge driver initialization and de-initialization functions */
 module_init(bridge_init);
 module_exit(bridge_exit);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 357d1cf..eb77c3c 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -364,10 +364,6 @@ static struct NLDR_FXNS nldrFxns = {
 	NLDR_Unload,
 };
 
-#ifdef CONFIG_BRIDGE_DVFS
-extern struct platform_device omap_dspbridge_dev;
-#endif
-
 enum NODE_STATE NODE_GetState(HANDLE hNode)
 {
    struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
@@ -1300,7 +1296,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	struct PROC_OBJECT *hProcessor;
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev.dev.platform_data;
+				omap_dspbridge_dev->dev.platform_data;
 #endif
 
 	DBC_Require(cRefs > 0);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index edbf773..59073dd 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -191,10 +191,6 @@ static u32 cRefs;
 
 struct SYNC_CSOBJECT *hProcLock;	/* For critical sections */
 
-#ifdef CONFIG_BRIDGE_DVFS
-extern struct platform_device omap_dspbridge_dev;
-#endif
-
 /*  ----------------------------------- Function Prototypes */
 static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcessor);
 static s32 GetEnvpCount(char **envp);
@@ -1053,7 +1049,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 #endif
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev.dev.platform_data;
+				omap_dspbridge_dev->dev.platform_data;
 #endif
 	GT_2trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Load, args:\n\t"
 		 "hProcessor:  0x%x\taArgv: 0x%x\n", hProcessor, aArgv[0]);
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 41d69bb..d7506f1 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -183,8 +183,6 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 extern s32 dsp_max_opps;
 /* The Vdd1 opp table information */
 extern u32 vdd1_dsp_freq[6][4] ;
-
-extern struct platform_device omap_dspbridge_dev;
 #endif
 
 #if GT_TRACE
@@ -1665,7 +1663,7 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
 #ifdef CONFIG_BRIDGE_DVFS
 	u32 i;
 	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev.dev.platform_data;
+				omap_dspbridge_dev->dev.platform_data;
 
 	switch (desc) {
 	case SHM_CURROPP:
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9a05264..488a512 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -66,8 +66,6 @@
 
 #ifdef CONFIG_PM
 #include <mach/board-3430sdp.h>
-
-extern struct platform_device omap_dspbridge_dev;
 #endif
 extern struct MAILBOX_CONTEXT mboxsetting;
 extern unsigned short enable_off_mode;
@@ -83,7 +81,7 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
        DSP_STATUS status = DSP_SOK;
        struct CFG_HOSTRES resources;
        struct dspbridge_platform_data *pdata =
-	       omap_dspbridge_dev.dev.platform_data;
+	       omap_dspbridge_dev->dev.platform_data;
        status = CFG_GetHostResources(
                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
 
@@ -116,7 +114,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 	u32 opplevel;
 	struct IO_MGR *hIOMgr;
 	struct dspbridge_platform_data *pdata =
-				omap_dspbridge_dev.dev.platform_data;
+				omap_dspbridge_dev->dev.platform_data;
 #endif
 
 	status = CFG_GetHostResources(
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index cfda6da..a6d5d62 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -26,10 +26,6 @@
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
 
-#ifdef CONFIG_BRIDGE_DVFS
-extern struct platform_device omap_dspbridge_dev;
-#endif
-
 #define MAILBOX_FIFOSTATUS(m) (0x80 + 4 * (m))
 
 static inline unsigned int fifo_full(void __iomem *mbox_base, int mbox_id)
@@ -104,7 +100,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 {
 #ifdef CONFIG_BRIDGE_DVFS
 	struct dspbridge_platform_data *pdata =
-		omap_dspbridge_dev.dev.platform_data;
+		omap_dspbridge_dev->dev.platform_data;
 	u32 opplevel = 0;
 #endif
 	struct CFG_HOSTRES resources;
-- 
1.5.6.3

