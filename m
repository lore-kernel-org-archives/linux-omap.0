From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 6/8] dspbridge: Check status before use return value
Date: Thu, 27 Aug 2009 15:18:59 +0300
Message-ID: <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17384 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZH0MTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:08 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCIXD5016597
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:18:56 +0300
In-Reply-To: <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index bedc34c..44d7f2d 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -825,7 +825,13 @@ DSP_STATUS DRV_ProcDisplayResInfo(u8 *pBuf1, u32 *pSize)
 	u32 tempStrLen = 0, tempStrLen2 = 0;
 	DSP_STATUS status = DSP_SOK;
 
-	CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
+	if (DSP_FAILED(CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT))) {
+		/* Should we print something? */
+		*pBuf1 = 0;
+		*pSize = 0;
+		return DSP_EHANDLE;
+	}
+
 	DRV_GetProcCtxtList(&pCtxt, (struct DRV_OBJECT *)hDrvObject);
 	GT_0trace(curTrace, GT_ENTER, "*********************"
 		 "DRV_ProcDisplayResourceInfo:*\n");
@@ -954,8 +960,12 @@ static DSP_STATUS PrintProcessInformation(void)
 	u32 tempCount;
 	u32  procID;
 
+	if (DSP_FAILED(CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT))) {
+		/* Should we print something? */
+		return DSP_EHANDLE;
+	}
+
 	/* Get the Process context list */
-	CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	DRV_GetProcCtxtList(&pCtxtList, hDrvObject);
 	GT_0trace(curTrace, GT_4CLASS, "\n### Debug information"
 			" for DSP bridge ##\n");
-- 
1.5.6.5

