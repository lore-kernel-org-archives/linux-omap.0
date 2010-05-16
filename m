From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] dspbridge: rename BRIDGE to OMAP_DSP
Date: Sun, 16 May 2010 18:46:58 +0300
Message-ID: <1274024821-21178-3-git-send-email-felipe.contreras@gmail.com>
References: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:65511 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab0EPPrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:47:12 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178779fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:47:10 -0700 (PDT)
In-Reply-To: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/Makefile                    |    2 +-
 arch/arm/mach-omap2/dspbridge.c                 |    6 ++--
 arch/arm/mach-omap2/omap3-iommu.c               |    2 +-
 arch/arm/plat-omap/devices.c                    |    4 +-
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbc.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/host_os.h  |    6 +--
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    2 +-
 drivers/Makefile                                |    2 +-
 drivers/dsp/bridge/Kconfig                      |   36 +++++++++++-----------
 drivers/dsp/bridge/Makefile                     |    2 +-
 drivers/dsp/bridge/core/io_sm.c                 |    2 +-
 drivers/dsp/bridge/core/tiomap3430_pwr.c        |   30 +++++++++---------
 drivers/dsp/bridge/core/tiomap_io.c             |    4 +-
 drivers/dsp/bridge/core/ue_deh.c                |    2 +-
 drivers/dsp/bridge/core/wdt.c                   |    7 ++--
 drivers/dsp/bridge/rmgr/drv.c                   |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |   30 +++++++++---------
 drivers/dsp/bridge/rmgr/node.c                  |    6 ++--
 drivers/dsp/bridge/rmgr/proc.c                  |    8 ++--
 21 files changed, 78 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 307f8b0..ac1e4ec 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 
-ifneq ($(CONFIG_MPU_BRIDGE),)
+ifneq ($(CONFIG_OMAP_DSP),)
 obj-y					+= dspbridge.o
 endif
 
diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 8d6c122..2be88a7 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include "prm.h"
 #include "cm.h"
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 #include <plat/omap-pm.h>
 #endif
 
@@ -23,7 +23,7 @@
 static struct platform_device *dspbridge_pdev;
 
 static struct dspbridge_platform_data dspbridge_pdata __initdata = {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
 	.dsp_get_opp	 = omap_pm_dsp_get_opp,
 	.cpu_set_freq	 = omap_pm_cpu_set_freq,
@@ -46,7 +46,7 @@ static int __init dspbridge_init(void)
 	pdata->phys_mempool_base = dspbridge_get_mempool_base();
 
 	if (pdata->phys_mempool_base) {
-		pdata->phys_mempool_size = CONFIG_BRIDGE_MEMPOOL_SIZE;
+		pdata->phys_mempool_size = CONFIG_OMAP_DSP_MEMPOOL_SIZE;
 		pr_info("%s: %x bytes @ %x\n", __func__,
 			pdata->phys_mempool_size, pdata->phys_mempool_base);
 	}
diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
index fbbcb5c..0ab3b86 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -31,7 +31,7 @@ static struct iommu_device devices[] = {
 			.clk_name = "cam_ick",
 		},
 	},
-#if defined(CONFIG_MPU_BRIDGE_IOMMU)
+#if defined(CONFIG_OMAP_DSP_IOMMU)
 	{
 		.base = 0x5d000000,
 		.irq = 28,
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index b552976..95380cc 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -30,14 +30,14 @@
 #include <plat/mcbsp.h>
 #include <plat/dsp_common.h>
 
-#if defined(CONFIG_MPU_BRIDGE) ||  defined(CONFIG_MPU_BRIDGE_MODULE)
+#if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
 static unsigned long dspbridge_phys_mempool_base;
 
 void dspbridge_reserve_sdram(void)
 {
 	void *va;
-	unsigned long size = CONFIG_BRIDGE_MEMPOOL_SIZE;
+	unsigned long size = CONFIG_OMAP_DSP_MEMPOOL_SIZE;
 
 	if (!size)
 		return;
diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 7a728b1..ddd4f43 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -99,7 +99,7 @@ struct shm {
 	struct opp_rqst_struct opp_request;
 	/* load monitor information structure */
 	struct load_mon_struct load_mon_info;
-#ifdef CONFIG_BRIDGE_WDT3
+#ifdef CONFIG_OMAP_DSP_WDT3
 	/* Flag for WDT enable/disable F/I clocks */
 	u32 wdt_setclocks;
 	u32 wdt_overflow;	/* WDT overflow time */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index 76f049e..6277b03 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -26,7 +26,7 @@
 #define DBC_
 
 /* Assertion Macros: */
-#ifdef CONFIG_BRIDGE_DEBUG
+#ifdef CONFIG_OMAP_DSP_DEBUG
 
 #define DBC_ASSERT(exp) \
     if (!(exp)) \
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 7de3323..1d1ba98 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -402,7 +402,7 @@ extern dsp_status drv_release_resources(IN u32 dw_context,
  */
 dsp_status drv_request_bridge_res_dsp(void **phost_resources);
 
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 void bridge_recover_schedule(void);
 #endif
 
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 2834304..22886a3 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -77,12 +77,10 @@ struct dspbridge_platform_data {
 extern struct platform_device *omap_dspbridge_dev;
 extern struct device *bridge;
 
-#if defined(CONFIG_MPU_BRIDGE) || defined(CONFIG_MPU_BRIDGE_MODULE)
+#if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 extern void dspbridge_reserve_sdram(void);
 #else
-static inline void dspbridge_reserve_sdram(void)
-{
-}
+static inline void dspbridge_reserve_sdram(void) { }
 #endif
 
 extern unsigned long dspbridge_get_mempool_base(void);
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index ce87eb3..732aa4f 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -41,7 +41,7 @@
 #define IO_SET_LONG(pContext, type, base, field, value)  (base->field = value)
 #define IO_GET_LONG(pContext, type, base, field)         (base->field)
 
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 /* The maximum number of OPPs that are supported */
 extern s32 dsp_max_opps;
 /* The Vdd1 opp table information */
diff --git a/drivers/Makefile b/drivers/Makefile
index 1a40bfe..7074b57 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_CONNECTOR)		+= connector/
 obj-$(CONFIG_FB_I810)           += video/i810/
 obj-$(CONFIG_FB_INTEL)          += video/intelfb/
 
-obj-$(CONFIG_MPU_BRIDGE)	+= dsp/bridge/
+obj-$(CONFIG_OMAP_DSP)		+= dsp/bridge/
 
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 6268f44..75c1a1c 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -2,7 +2,7 @@
 # DSP Bridge Driver Support
 #
 
-menuconfig MPU_BRIDGE
+menuconfig OMAP_DSP
 	tristate "DSP Bridge driver"
 	default n
 	select OMAP_MBOX_FWK
@@ -14,9 +14,9 @@ menuconfig MPU_BRIDGE
 
 	  This driver depends on OMAP Mailbox (OMAP_MBOX_FWK).
 
-config BRIDGE_DVFS
+config OMAP_DSP_DVFS
 	bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
-	depends on MPU_BRIDGE && OMAP_PM_SRF && CPU_FREQ
+	depends on OMAP_DSP && OMAP_PM_SRF && CPU_FREQ
 	default n
 	help
 	  DVFS allows DSP Bridge to initiate the operating point change to
@@ -24,30 +24,30 @@ config BRIDGE_DVFS
 	  performance and power consumption to the current processing
 	  requirements.
 
-config BRIDGE_MEMPOOL_SIZE
+config OMAP_DSP_MEMPOOL_SIZE
 	hex "Physical memory pool size (Byte)"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 	default 0x600000
 	help
 	  Allocate specified size of memory at booting time to avoid allocation
 	  failure under heavy memory fragmentation after some use time.
 
-config BRIDGE_DEBUG
+config OMAP_DSP_DEBUG
 	bool "DSP Bridge Debug Support"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 	help
 	  Say Y to enable Bridge debugging capabilities
 
-config BRIDGE_RECOVERY
+config OMAP_DSP_RECOVERY
 	bool "DSP Recovery Support"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 	help
 	  In case of DSP fatal error, BRIDGE driver will try to
 	  recover itself.
 
-config BRIDGE_CACHE_LINE_CHECK
+config OMAP_DSP_CACHE_LINE_CHECK
 	bool "Check buffers to be 128 byte aligned"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 	default n
 	help
 	  When the DSP processes data, the DSP cache controller loads 128-Byte
@@ -59,29 +59,29 @@ config BRIDGE_CACHE_LINE_CHECK
 	  This can lead to heap corruption. Say Y, to enforce the check for 128
 	  byte alignment, buffers failing this check will be rejected.
 
-config BRIDGE_WDT3
+config OMAP_DSP_WDT3
 	bool "Enable WDT3 interruptions"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 	default n
 	help
 	  WTD3 is managed by DSP and once it is enabled, DSP side bridge is in
 	  charge of refreshing the timer before overflow, if the DSP hangs MPU
 	  will caught the interrupt and try to recover DSP.
 
-config WDT_TIMEOUT
+config OMAP_DSP_WDT_TIMEOUT
 	int "DSP watchdog timer timeout (in secs)"
-	depends on BRIDGE_WDT3
+	depends on OMAP_DSP_WDT3
 	default 5
 	help
 	   Watchdog timer timeout value, after that time if the watchdog timer
 	   counter is not reset the wdt overflow interrupt will be triggered
 
 comment "Bridge Notifications"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 
-config BRIDGE_NTFY_PWRERR
+config OMAP_DSP_NTFY_PWRERR
 	bool "Notify DSP Power Error"
-	depends on MPU_BRIDGE
+	depends on OMAP_DSP
 	help
 	  Enable notifications to registered clients on the event of power errror
 	  trying to suspend bridge driver. Say Y, to signal this event as a fatal
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 39624d4..1a2b86f 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_MPU_BRIDGE)	+= bridgedriver.o
+obj-$(CONFIG_OMAP_DSP) += bridgedriver.o
 
 libgen = gen/gb.o gen/gs.o gen/gh.o gen/uuidutil.o
 libservices = services/sync.o services/cfg.o \
diff --git a/drivers/dsp/bridge/core/io_sm.c b/drivers/dsp/bridge/core/io_sm.c
index d6c1a98..161b598 100644
--- a/drivers/dsp/bridge/core/io_sm.c
+++ b/drivers/dsp/bridge/core/io_sm.c
@@ -1725,7 +1725,7 @@ void io_intr_dsp2(IN struct io_mgr *pio_mgr, IN u16 mb_val)
  */
 dsp_status io_sh_msetting(struct io_mgr *hio_mgr, u8 desc, void *pargs)
 {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	u32 i;
 	struct dspbridge_platform_data *pdata =
 	    omap_dspbridge_dev->dev.platform_data;
diff --git a/drivers/dsp/bridge/core/tiomap3430_pwr.c b/drivers/dsp/bridge/core/tiomap3430_pwr.c
index 1897c50..5c5565a 100644
--- a/drivers/dsp/bridge/core/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/core/tiomap3430_pwr.c
@@ -52,7 +52,7 @@
 dsp_status handle_constraints_set(struct bridge_dev_context *dev_context,
 				  IN void *pargs)
 {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	u32 *constraint_val;
 	struct dspbridge_platform_data *pdata =
 	    omap_dspbridge_dev->dev.platform_data;
@@ -65,7 +65,7 @@ dsp_status handle_constraints_set(struct bridge_dev_context *dev_context,
 	/* Set the new opp value */
 	if (pdata->dsp_set_min_opp)
 		(*pdata->dsp_set_min_opp) ((u32) *(constraint_val + 1));
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+#endif /* #ifdef CONFIG_OMAP_DSP_DVFS */
 	return DSP_SOK;
 }
 
@@ -79,7 +79,7 @@ dsp_status handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 #ifdef CONFIG_PM
 	u16 timeout = PWRSTST_TIMEOUT / 10;
 	u32 pwr_state;
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	u32 opplevel;
 	struct io_mgr *hio_mgr;
 #endif
@@ -115,7 +115,7 @@ dsp_status handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 		if (DSP_SUCCEEDED(status)) {
 			/* Update the Bridger Driver state */
 			dev_context->dw_brd_state = BRD_DSP_HIBERNATION;
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 			status =
 			    dev_get_io_mgr(dev_context->hdev_obj, &hio_mgr);
 			if (DSP_FAILED(status))
@@ -129,7 +129,7 @@ dsp_status handle_hibernation_from_dsp(struct bridge_dev_context *dev_context)
 			if (pdata->dsp_set_min_opp)
 				(*pdata->dsp_set_min_opp) (VDD1_OPP1);
 			status = DSP_SOK;
-#endif /* CONFIG_BRIDGE_DVFS */
+#endif /* CONFIG_OMAP_DSP_DVFS */
 		}
 	}
 #endif
@@ -145,9 +145,9 @@ dsp_status sleep_dsp(struct bridge_dev_context *dev_context, IN u32 dw_cmd,
 {
 	dsp_status status = DSP_SOK;
 #ifdef CONFIG_PM
-#ifdef CONFIG_BRIDGE_NTFY_PWRERR
+#ifdef CONFIG_OMAP_DSP_NTFY_PWRERR
 	struct deh_mgr *hdeh_mgr;
-#endif /* CONFIG_BRIDGE_NTFY_PWRERR */
+#endif /* CONFIG_OMAP_DSP_NTFY_PWRERR */
 	u16 timeout = PWRSTST_TIMEOUT / 10;
 	u32 pwr_state, target_pwr_state;
 	struct dspbridge_platform_data *pdata =
@@ -209,10 +209,10 @@ dsp_status sleep_dsp(struct bridge_dev_context *dev_context, IN u32 dw_cmd,
 	if (!timeout) {
 		pr_err("%s: Timed out waiting for DSP off mode, state %x\n",
 		       __func__, pwr_state);
-#ifdef CONFIG_BRIDGE_NTFY_PWRERR
+#ifdef CONFIG_OMAP_DSP_NTFY_PWRERR
 		dev_get_deh_mgr(dev_context->hdev_obj, &hdeh_mgr);
 		bridge_deh_notify(hdeh_mgr, DSP_PWRERROR, 0);
-#endif /* CONFIG_BRIDGE_NTFY_PWRERR */
+#endif /* CONFIG_OMAP_DSP_NTFY_PWRERR */
 		return -ETIMEDOUT;
 	} else {
 		/* Update the Bridger Driver state */
@@ -228,7 +228,7 @@ dsp_status sleep_dsp(struct bridge_dev_context *dev_context, IN u32 dw_cmd,
 		status = dsp_clock_disable_all(dev_context->dsp_per_clks);
 		if (DSP_FAILED(status))
 			return status;
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 		else if (target_pwr_state == PWRDM_POWER_OFF) {
 			/*
 			 * Set the OPP to low level before moving to OFF mode
@@ -236,7 +236,7 @@ dsp_status sleep_dsp(struct bridge_dev_context *dev_context, IN u32 dw_cmd,
 			if (pdata->dsp_set_min_opp)
 				(*pdata->dsp_set_min_opp) (VDD1_OPP1);
 		}
-#endif /* CONFIG_BRIDGE_DVFS */
+#endif /* CONFIG_OMAP_DSP_DVFS */
 	}
 #endif /* CONFIG_PM */
 	return status;
@@ -336,7 +336,7 @@ dsp_status dsp_peripheral_clk_ctrl(struct bridge_dev_context *dev_context,
  */
 dsp_status pre_scale_dsp(struct bridge_dev_context *dev_context, IN void *pargs)
 {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	u32 level;
 	u32 voltage_domain;
 
@@ -358,7 +358,7 @@ dsp_status pre_scale_dsp(struct bridge_dev_context *dev_context, IN void *pargs)
 	} else {
 		return -EPERM;
 	}
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+#endif /* #ifdef CONFIG_OMAP_DSP_DVFS */
 	return DSP_SOK;
 }
 
@@ -371,7 +371,7 @@ dsp_status post_scale_dsp(struct bridge_dev_context *dev_context,
 							IN void *pargs)
 {
 	dsp_status status = DSP_SOK;
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	u32 level;
 	u32 voltage_domain;
 	struct io_mgr *hio_mgr;
@@ -401,7 +401,7 @@ dsp_status post_scale_dsp(struct bridge_dev_context *dev_context,
 	} else {
 		status = -EPERM;
 	}
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+#endif /* #ifdef CONFIG_OMAP_DSP_DVFS */
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/core/tiomap_io.c b/drivers/dsp/bridge/core/tiomap_io.c
index 00610df..1665003 100644
--- a/drivers/dsp/bridge/core/tiomap_io.c
+++ b/drivers/dsp/bridge/core/tiomap_io.c
@@ -389,7 +389,7 @@ dsp_status write_ext_dsp_data(struct bridge_dev_context *dev_context,
 
 dsp_status sm_interrupt_dsp(struct bridge_dev_context *dev_context, u16 mb_val)
 {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	u32 opplevel = 0;
 #endif
 	struct dspbridge_platform_data *pdata =
@@ -406,7 +406,7 @@ dsp_status sm_interrupt_dsp(struct bridge_dev_context *dev_context, u16 mb_val)
 
 	if (dev_context->dw_brd_state == BRD_DSP_HIBERNATION ||
 	    dev_context->dw_brd_state == BRD_HIBERNATION) {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 		if (pdata->dsp_get_opp)
 			opplevel = (*pdata->dsp_get_opp) ();
 		if (opplevel == VDD1_OPP1) {
diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 315672b..6611929 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -293,7 +293,7 @@ void bridge_deh_notify(struct deh_mgr *deh, int event, int info)
 	/* Filter subsequent notifications when an error occurs */
 	if (dev_context->dw_brd_state != BRD_ERROR) {
 		ntfy_notify(deh->ntfy_obj, event);
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 		bridge_recover_schedule();
 #endif
 	}
diff --git a/drivers/dsp/bridge/core/wdt.c b/drivers/dsp/bridge/core/wdt.c
index 4637afb..d1c8105 100644
--- a/drivers/dsp/bridge/core/wdt.c
+++ b/drivers/dsp/bridge/core/wdt.c
@@ -25,8 +25,7 @@
 #include <dspbridge/wdt.h>
 #include <dspbridge/host_os.h>
 
-
-#ifdef CONFIG_BRIDGE_WDT3
+#ifdef CONFIG_OMAP_DSP_WDT3
 static struct dsp_wdt_setting dsp_wdt;
 
 void dsp_wdt_dpc(unsigned long data)
@@ -82,7 +81,7 @@ int dsp_wdt_init(void)
 void dsp_wdt_sm_set(void *data)
 {
 	dsp_wdt.sm_wdt = data;
-	dsp_wdt.sm_wdt->wdt_overflow = CONFIG_WDT_TIMEOUT;
+	dsp_wdt.sm_wdt->wdt_overflow = CONFIG_OMAP_DSP_WDT_TIMEOUT;
 }
 
 
@@ -128,6 +127,7 @@ void dsp_wdt_enable(bool enable)
 }
 
 #else
+
 void dsp_wdt_enable(bool enable)
 {
 }
@@ -145,4 +145,3 @@ void dsp_wdt_exit(void)
 {
 }
 #endif
-
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index a8e711a..2ea8e91 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -524,7 +524,7 @@ dsp_status drv_get_dev_object(u32 index, struct drv_object *hdrv_obj,
 			      struct dev_object **phDevObject)
 {
 	dsp_status status = DSP_SOK;
-#ifdef CONFIG_BRIDGE_DEBUG
+#ifdef CONFIG_OMAP_DSP_DEBUG
 	/* used only for Assertions and debug messages */
 	struct drv_object *pdrv_obj = (struct drv_object *)hdrv_obj;
 #endif
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 00134e1..22ecfb3 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -63,7 +63,7 @@
 #include <dspbridge/drvdefs.h>
 #include <dspbridge/drv.h>
 
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 #include <mach-omap2/omap3-opp.h>
 #endif
 
@@ -89,7 +89,7 @@ static char *base_img;
 char *iva_img;
 static s32 shm_size = 0x500000;	/* 5 MB */
 static int tc_wordswapon;	/* Default value is always false */
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 #define REC_TIMEOUT 5000	/*recovery timeout in msecs */
 static atomic_t bridge_cref;	/* number of bridge open handles */
 static struct workqueue_struct *bridge_rec_queue;
@@ -149,13 +149,13 @@ static const struct file_operations bridge_fops = {
 
 #ifdef CONFIG_PM
 static u32 time_out = 1000;
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 s32 dsp_max_opps = VDD1_OPP5;
 #endif
 
 /* Maximum Opps that can be requested by IVA */
 /*vdd1 rate table */
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 const struct omap_opp vdd1_rate_table_bridge[] = {
 	{0, 0, 0},
 	/*OPP1 */
@@ -188,7 +188,7 @@ u32 vdd1_dsp_freq[6][4] = {
 	{0, 430000, 355000, 430000},
 };
 
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 static void bridge_recover(struct work_struct *work)
 {
 	struct dev_object *dev;
@@ -215,7 +215,7 @@ void bridge_recover_schedule(void)
 	queue_work(bridge_rec_queue, &bridge_recovery_work);
 }
 #endif
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 static int dspbridge_scale_notification(struct notifier_block *op,
 		unsigned long val, void *ptr)
 {
@@ -240,7 +240,7 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 	u32 init_status = DSP_SOK;
 	dev_t dev = 0;
 	int result;
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	int i = 0;
 #endif
 	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
@@ -321,7 +321,7 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		dev_dbg(bridge, "%s: TC Word Swap is enabled\n", __func__);
 
 	if (DSP_SUCCEEDED(init_status)) {
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 		for (i = 0; i < 6; i++)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
 
@@ -340,7 +340,7 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		}
 	}
 
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 	bridge_rec_queue = create_workqueue("bridge_rec_queue");
 	INIT_WORK(&bridge_recovery_work, bridge_recover);
 	INIT_COMPLETION(bridge_comp);
@@ -367,12 +367,12 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-#ifdef CONFIG_BRIDGE_DVFS
+#ifdef CONFIG_OMAP_DSP_DVFS
 	if (!cpufreq_unregister_notifier(&iva_clk_notifier,
 						CPUFREQ_TRANSITION_NOTIFIER))
 		pr_err("%s: clk_notifier_unregister failed for iva2_ck\n",
 		       __func__);
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+#endif /* #ifdef CONFIG_OMAP_DSP_DVFS */
 
 	if (driver_context) {
 		/* Put the DSP in reset state */
@@ -464,7 +464,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	 * process context list.
 	 */
 
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 	if (recover) {
 		if (filp->f_flags & O_NONBLOCK ||
 			wait_for_completion_interruptible(&bridge_open_comp))
@@ -485,7 +485,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	}
 
 	filp->private_data = pr_ctxt;
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 	if (!status)
 		atomic_inc(&bridge_cref);
 #endif
@@ -515,7 +515,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	filp->private_data = NULL;
 
 err:
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 	if (!atomic_dec_return(&bridge_cref))
 		complete(&bridge_comp);
 #endif
@@ -531,7 +531,7 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 	union Trapped_Args buf_in;
 
 	DBC_REQUIRE(filp != NULL);
-#ifdef CONFIG_BRIDGE_RECOVERY
+#ifdef CONFIG_OMAP_DSP_RECOVERY
 	if (recover) {
 		status = -EIO;
 		goto err;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 23aed68..43f3890 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1154,7 +1154,7 @@ dsp_status node_create(struct node_object *hnode)
 	u32 proc_id = 255;
 	struct dsp_processorstate proc_state;
 	struct proc_object *hprocessor;
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_OMAP_DSP_DVFS) && !defined(CONFIG_CPU_FREQ)
 	struct dspbridge_platform_data *pdata =
 	    omap_dspbridge_dev->dev.platform_data;
 #endif
@@ -1206,7 +1206,7 @@ dsp_status node_create(struct node_object *hnode)
 	if (DSP_SUCCEEDED(status)) {
 		/* If node's create function is not loaded, load it */
 		/* Boost the OPP level to max level that DSP can be requested */
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_OMAP_DSP_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
 			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP3]);
 #endif
@@ -1224,7 +1224,7 @@ dsp_status node_create(struct node_object *hnode)
 			       __func__, status);
 		}
 		/* Request the lowest OPP level */
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_OMAP_DSP_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
 			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP1]);
 #endif
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1cccc89..7920f22 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -817,7 +817,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 	struct timeval tv2;
 #endif
 
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_OMAP_DSP_DVFS) && !defined(CONFIG_CPU_FREQ)
 	struct dspbridge_platform_data *pdata =
 	    omap_dspbridge_dev->dev.platform_data;
 #endif
@@ -952,7 +952,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 		/* Now, attempt to load an exec: */
 
 		/* Boost the OPP level to Maximum level supported by baseport */
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_OMAP_DSP_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
 			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP5]);
 #endif
@@ -970,7 +970,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 			}
 		}
 		/* Requesting the lowest opp supported */
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_OMAP_DSP_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
 			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP1]);
 #endif
@@ -1069,7 +1069,7 @@ dsp_status proc_map(void *hprocessor, void *pmpu_addr, u32 ul_size,
 	struct proc_object *p_proc_object = (struct proc_object *)hprocessor;
 	struct dmm_map_object *map_obj;
 
-#ifdef CONFIG_BRIDGE_CACHE_LINE_CHECK
+#ifdef CONFIG_OMAP_DSP_CACHE_LINE_CHECK
 	if ((ul_map_attr & BUFMODE_MASK) != RBUF) {
 		if (!IS_ALIGNED((u32)pmpu_addr, DSP_CACHE_LINE) ||
 		    !IS_ALIGNED(ul_size, DSP_CACHE_LINE)) {
-- 
1.7.1

