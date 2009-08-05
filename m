From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 1/3] DSPBRIDGE: Cleanup bridge_release and remove DSP_Close
Date: Wed,  5 Aug 2009 16:25:15 +0300
Message-ID: <1249478717-4446-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23562 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934349AbZHENZ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 09:25:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com, x0095840@ti.com, omar.ramirez@ti.com, roman.tereshonkov@nokia.com, suyog@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/dspdrv.h |   17 ----------------
 drivers/dsp/bridge/rmgr/drv_interface.c       |   19 ++---------------
 drivers/dsp/bridge/rmgr/dspdrv.c              |   26 -------------------------
 3 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dspdrv.h b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
index f500ffb..3d04967 100644
--- a/arch/arm/plat-omap/include/dspbridge/dspdrv.h
+++ b/arch/arm/plat-omap/include/dspbridge/dspdrv.h
@@ -50,23 +50,6 @@
 #define MAX_DEV     10		/* Max support of 10 devices */
 
 /*
- *  ======== DSP_Close ========
- *  Purpose:
- *      Called when the client application/driver unloads the DDSP DLL. Upon
- *      unloading, the DDSP DLL will call CloseFile().
- *  Parameters:
- *      dwDeviceContext:    Handle returned by XXX_Open used to identify
- *                          the open context of the device
- *  Returns:
- *      TRUE indicates the device is successfully closed. FALSE indicates
- *      otherwise.
- *  Requires:
- *      dwOpenContext!= NULL.
- *  Ensures:The Application instance owned objects are cleaned up.
- */
-extern bool DSP_Close(u32 dwDeviceContext);
-
-/*
  *  ======== DSP_Deinit ========
  *  Purpose:
  *      This function is called by Device Manager to de-initialize a device.
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 24f6336..8cbdeee 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -655,22 +655,9 @@ func_cont:
  * driver. */
 static int bridge_release(struct inode *ip, struct file *filp)
 {
-	int status;
-       u32 pid;
-
-	GT_0trace(driverTrace, GT_ENTER, "-> driver_release\n");
-
-       /* Return PID instead of process handle */
-       pid = current->pid;
-
-       status = DSP_Close(pid);
-
-
-	(status == true) ? (status = 0) : (status = -1);
-
-	GT_0trace(driverTrace, GT_ENTER, " <- driver_release\n");
-
-	return status;
+	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
+	GT_0trace(driverTrace, GT_ENTER, "<- bridge_release\n");
+	return 0;
 }
 
 /* This function provides IO interface to the bridge driver. */
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index a7a74fc..b5caf39 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -248,29 +248,3 @@ bool DSP_Deinit(u32 deviceContext)
 
 	return retVal;
 }
-
-/*
- *  ======== DSP_Close ========
- *  	The Calling Process handle is passed to DEV_CleanupProcesState
- *      for cleaning up of any resources used by the application
- */
-bool DSP_Close(u32 dwOpenContext)
-{
-	bool retVal = false;
-
-	DBC_Require(dwOpenContext != 0);
-
-	GT_0trace(curTrace, GT_ENTER, "Entering DSP_Close\n");
-
-#ifdef RES_CLEANUP_DISABLE
-
-	if (DSP_SUCCEEDED(DEV_CleanupProcessState((HANDLE) dwOpenContext))) {
-		GT_0trace(curTrace, GT_1CLASS, "DSP_Close Succeeded \r\n");
-		retVal = true;
-	} else {
-		GT_0trace(curTrace, GT_7CLASS, "DSP_Close failed \r\n");
-	}
-#endif
-
-	return retVal;
-}
-- 
1.6.2.4

