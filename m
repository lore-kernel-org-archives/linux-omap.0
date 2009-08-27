From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4/8] dspbridge: Check pointer returned by MEM_Calloc()
Date: Thu, 27 Aug 2009 15:18:57 +0300
Message-ID: <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17388 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZH0MTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:11 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCIXD9016597
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:18:58 +0300
In-Reply-To: <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

In case of NULL return DSP_EMEMORY status instead of DSP_SOK.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 691c727..bedc34c 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1571,17 +1571,18 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		/* Releasing resources by deleting the registry key  */
 		dwBuffSize = sizeof(struct CFG_HOSTRES);
 		pResources = MEM_Calloc(dwBuffSize, MEM_NONPAGED);
-		if (DSP_FAILED(REG_GetValue(NULL, (char *)driverExt->szString,
-		   CURRENTCONFIG, (u8 *)pResources, &dwBuffSize))) {
-			status = CFG_E_RESOURCENOTAVAIL;
-			GT_0trace(curTrace, GT_1CLASS,
-				 "REG_GetValue Failed \n");
-		} else {
-			GT_0trace(curTrace, GT_1CLASS,
-				 "REG_GetValue Succeeded \n");
-		}
-
 		if (pResources != NULL) {
+			if (DSP_FAILED(REG_GetValue(NULL,
+			    (char *) driverExt->szString,
+			    CURRENTCONFIG, (u8 *) pResources, &dwBuffSize))) {
+				status = CFG_E_RESOURCENOTAVAIL;
+				GT_0trace(curTrace, GT_1CLASS,
+					 "REG_GetValue Failed \n");
+			} else {
+				GT_0trace(curTrace, GT_1CLASS,
+					 "REG_GetValue Succeeded \n");
+			}
+
 			dwBuffSize = sizeof(shm_size);
 			status = REG_GetValue(NULL, CURRENTCONFIG, SHMSIZE,
 				(u8 *)&shm_size, &dwBuffSize);
@@ -1646,6 +1647,8 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 				 (u32)dwBuffSize);
 			/*  Set all the other entries to NULL */
 			MEM_Free(pResources);
+		} else {
+			status = DSP_EMEMORY;
 		}
 		GT_0trace(curTrace, GT_ENTER, " <- RequestBridgeResources \n");
 		return status;
-- 
1.5.6.5

