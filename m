From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 3/8] DSPBRIDGE: Check input value
Date: Thu, 27 Aug 2009 15:18:56 +0300
Message-ID: <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40979 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbZH0MT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:28 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCIO9d026950
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 07:18:59 -0500
In-Reply-To: <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Check input value before dereferencing it.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index db48c49..4cb78c7 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1266,11 +1266,16 @@ static DSP_STATUS WMD_DEV_Destroy(struct WMD_DEV_CONTEXT *hDevContext)
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *pDevContext = (struct WMD_DEV_CONTEXT *)
 						hDevContext;
+
+	/* It should never happen */
+	if (!hDevContext)
+		return DSP_EHANDLE;
+
 	DBG_Trace(DBG_ENTER, "Entering WMD_DEV_Destroy:n hDevContext ::0x%x\n",
 		  hDevContext);
 	/* first put the device to stop state */
 	WMD_BRD_Delete(pDevContext);
-	if (pDevContext && pDevContext->pPtAttrs) {
+	if (pDevContext->pPtAttrs) {
 		pPtAttrs = pDevContext->pPtAttrs;
 		if (pPtAttrs->hCSObj)
 			SYNC_DeleteCS(pPtAttrs->hCSObj);
-- 
1.5.6.5

