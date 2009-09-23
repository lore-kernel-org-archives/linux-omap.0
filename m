From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 2/5] DSPBRIDGE: OSAL: Remove unused registry variables
Date: Wed, 23 Sep 2009 19:03:20 +0300
Message-ID: <1253721804-22816-3-git-send-email-andy.shevchenko@gmail.com>
References: <1253721804-22816-1-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-2-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40767 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbZIWQEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 12:04:05 -0400
In-Reply-To: <1253721804-22816-2-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@Nokia.com, Andy Shevchenko <ext-andriy.shevchenko@Nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/dbreg.h |    3 ---
 drivers/dsp/bridge/rmgr/drv_interface.c      |   12 ------------
 drivers/dsp/bridge/services/cfg.c            |    5 -----
 3 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbreg.h b/arch/arm/plat-omap/include/dspbridge/dbreg.h
index d311b88..59b6496 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbreg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbreg.h
@@ -88,7 +88,6 @@
 #define WMDFILENAME      "MiniDriver"	/* WMD entry name */
 #define CHIPTYPE         "ChipType"	/* Chip type */
 #define CHIPNUM          "NumChips"	/* Number of chips */
-#define NUMPROCS         "NumOfProcessors"	/* Number of processors */
 #define DEFEXEC          "DefaultExecutable"	/* Default executable */
 #define AUTOSTART        "AutoStart"	/* Statically load flag */
 #define IVAAUTOSTART     "IvaAutoStart"	/* Statically load flag */
@@ -107,7 +106,5 @@
 #define TCWORDSWAP       "TCWordSwap"	/* Traffic Contoller Word Swap */
 #define DSPRESOURCES     "DspTMSResources"	/* C55 DSP resurces on OMAP */
 #define IVA1RESOURCES    "ARM7IvaResources"	/* ARM7 IVA resurces on OMAP */
-#define PHYSMEMPOOLBASE  "PhysicalMemBase"   /* Physical mem passed to driver */
-#define PHYSMEMPOOLSIZE  "PhysicalMemSize"   /* Physical mem passed to driver */
 
 #endif				/* DBREG_ */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index b5503c0..152b6fc 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -129,7 +129,6 @@ static s32 driver_major = DRIVER_MAJOR;
 static s32 driver_minor = DRIVER_MINOR;
 static char *base_img;
 char *iva_img;
-static char *num_procs = "C55=1";
 static s32 shm_size = 0x500000;	/* 5 MB */
 static u32 phys_mempool_base;
 static u32 phys_mempool_size;
@@ -362,7 +361,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		REG_SetValue(AUTOSTART, (u8 *)&temp, sizeof(temp));
 		REG_SetValue(DEFEXEC, (u8 *) "\0", (u32)2);
 	}
-	REG_SetValue(NUMPROCS, (u8 *) num_procs, strlen(num_procs) + 1);
 
 	if (shm_size >= 0x10000) {	/* 64 KB */
 		initStatus = REG_SetValue(SHMSIZE, (u8 *)&shm_size,
@@ -381,19 +379,9 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 		phys_mempool_size = pdata->phys_mempool_size;
 	}
 
-	if (phys_mempool_base > 0x0) {
-		initStatus = REG_SetValue(PHYSMEMPOOLBASE,
-					 (u8 *)&phys_mempool_base,
-					 sizeof(phys_mempool_base));
-	}
 	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_base = 0x%x \n",
 		 phys_mempool_base);
 
-	if (phys_mempool_size > 0x0) {
-		initStatus = REG_SetValue(PHYSMEMPOOLSIZE,
-					 (u8 *)&phys_mempool_size,
-					 sizeof(phys_mempool_size));
-	}
 	GT_1trace(driverTrace, GT_7CLASS, "phys_mempool_size = 0x%x\n",
 		 phys_mempool_base);
 	if ((phys_mempool_base > 0x0) && (phys_mempool_size > 0x0))
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index cb4ffea..e3cdda3 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -413,11 +413,6 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 				  "Registering the DSP Device \n");
 			status = REG_SetValue("DEVICE_DSP", (u8 *)&dwValue,
 					      dwBuffSize);
-			if (DSP_SUCCEEDED(status)) {
-				dwBuffSize = sizeof(hDevNode);
-				status = REG_SetValue("DEVNODESTRING_DSP",
-						(u8 *)&hDevNode, dwBuffSize);
-			}
 		} else {
 			GT_0trace(CFG_debugMask, GT_6CLASS,
 				  "Failed to Register Device \n");
-- 
1.5.6.5

