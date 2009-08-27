From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 8/8] dspbridge: Check pointer before usage
Date: Thu, 27 Aug 2009 15:19:01 +0300
Message-ID: <1251375541-1866-9-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-4-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-5-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-6-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-7-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-8-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49288 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZH0MTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:51 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCJWdg002532
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:19:44 +0300
In-Reply-To: <1251375541-1866-8-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index d21071c..491dd39 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1545,6 +1545,10 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 	for (pszdevNode = (struct DRV_EXT *)DRV_GetFirstDevExtension();
 	    pszdevNode != NULL; pszdevNode = (struct DRV_EXT *)
 	    DRV_GetNextDevExtension((u32)pszdevNode)) {
+		if (!pDRVObject->devNodeString) {
+			/* When this could happen? */
+			continue;
+		}
 		if ((u32)pszdevNode == dwContext) {
 			/* Found it */
 			/* Delete from the Driver object list */
-- 
1.5.6.5

