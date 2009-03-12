From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 1/1] DSPBRIDGE Fix for image autoload
Date: Thu, 12 Mar 2009 11:02:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2BED3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44865 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbZCLFc7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 01:32:59 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C5Wpgl031734
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 00:32:57 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C5WpuB021332
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:02:51 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

>From fbbf5c9c308c2e1e90e70c57a48798c5d05a6b1d Mon Sep 17 00:00:00 2001
From: Ramesh Gupta <x0023949@ti.com>
Date: Thu, 12 Mar 2009 10:48:08 +0530
Subject: [PATCH 1/1] DSPBRIDGE Fix for image autoload.

This fixes the issue with the image autoloading while
installing the bridgedriver with install param base_img

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 9c82ef4..c5c9ee5 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -405,7 +405,7 @@ static int __init bridge_init(void)
 		REG_SetValue(NULL, NULL, AUTOSTART, REG_DWORD, (u8 *)&temp,
 			    sizeof(temp));
 		REG_SetValue(NULL, NULL, DEFEXEC, REG_SZ, (u8 *)base_img,
-                           strlen(base_img) + 1);
+						strlen(base_img) + 1);
 	} else {
 		temp = false;
 		REG_SetValue(NULL, NULL, AUTOSTART, REG_DWORD, (u8 *)&temp,
@@ -413,7 +413,7 @@ static int __init bridge_init(void)
 		REG_SetValue(NULL, NULL, DEFEXEC, REG_SZ, (u8 *) "\0", (u32)2);
 	}
 	REG_SetValue(NULL, NULL, NUMPROCS, REG_SZ, (u8 *) num_procs,
-                   strlen(num_procs) + 1);
+						strlen(num_procs) + 1);
 
 	if (shm_size >= 0x10000) {	/* 64 KB */
 		initStatus = REG_SetValue(NULL, NULL, SHMSIZE, REG_DWORD,
@@ -455,15 +455,6 @@ static int __init bridge_init(void)
 			    sizeof(tc_wordswapon));
 	}
 	if (DSP_SUCCEEDED(initStatus)) {
-		driverContext = DSP_Init(&initStatus);
-		if (DSP_FAILED(initStatus)) {
-			status = -1;
-			GT_0trace(driverTrace, GT_7CLASS,
-				 "DSP/BIOS Bridge initialization Failed\n");
-		} else {
-			GT_0trace(driverTrace, GT_5CLASS,
-					"DSP/BIOS Bridge driver loaded\n");
-		}
 #ifdef CONFIG_BRIDGE_DVFS
 		for (i = 0; i < 5; i++)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
@@ -484,6 +475,15 @@ static int __init bridge_init(void)
 			"clk_notifier_register FAIL for iva2_ck \n");
 		}
 #endif
+		driverContext = DSP_Init(&initStatus);
+		if (DSP_FAILED(initStatus)) {
+			status = -1;
+			GT_0trace(driverTrace, GT_7CLASS,
+				 "DSP/BIOS Bridge initialization Failed\n");
+		} else {
+			GT_0trace(driverTrace, GT_5CLASS,
+					"DSP/BIOS Bridge driver loaded\n");
+		}
 	}
 
 	DBC_Assert(status == 0);
@@ -660,11 +660,11 @@ func_cont:
 				(struct DRV_OBJECT *)hDrvObject, &pPctxt);
 
 	if (pPctxt != NULL) {
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
+			/* Return PID instead of process handle */
+			hProcess = current->pid;
 
 		DRV_ProcUpdatestate(pPctxt, PROC_RES_ALLOCATED);
-               DRV_ProcSetPID(pPctxt, hProcess);
+			DRV_ProcSetPID(pPctxt, hProcess);
 	}
 #endif
 
-- 
1.5.3.2
