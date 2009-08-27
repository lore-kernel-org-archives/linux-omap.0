From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/8] dspbridge: Remove useless check
Date: Thu, 27 Aug 2009 15:18:54 +0300
Message-ID: <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49281 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZH0MTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:50 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCJWde002532
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:19:43 +0300
In-Reply-To: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Before this check zlLib already dereferenced on one hand and DBC_Require()
checks for NULL on other hand.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/pmgr/dbll.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 7c3cd40..e655f89 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -909,26 +909,24 @@ void DBLL_unload(struct DBLL_LibraryObj *lib, struct DBLL_Attrs *attrs)
 		goto func_end;
 
 	zlLib->pTarget->attrs = *attrs;
-	if (zlLib != NULL) {
-		if (zlLib->mHandle) {
-			err = Dynamic_Unload_Module(zlLib->mHandle,
-				&zlLib->symbol.dlSymbol,
-				&zlLib->allocate.dlAlloc, &zlLib->init.dlInit);
-			if (err != 0) {
-				GT_1trace(DBLL_debugMask, GT_5CLASS,
-					 "Dynamic_Unload_Module "
-					 "failed: 0x%x\n", err);
-			}
-		}
-		/* remove symbols from symbol table */
-		if (zlLib->symTab != NULL) {
-			GH_delete(zlLib->symTab);
-			zlLib->symTab = NULL;
+	if (zlLib->mHandle) {
+		err = Dynamic_Unload_Module(zlLib->mHandle,
+			&zlLib->symbol.dlSymbol,
+			&zlLib->allocate.dlAlloc, &zlLib->init.dlInit);
+		if (err != 0) {
+			GT_1trace(DBLL_debugMask, GT_5CLASS,
+				 "Dynamic_Unload_Module "
+				 "failed: 0x%x\n", err);
 		}
-		/* delete DOFF desc since it holds *lots* of host OS
-		 * resources */
-		dofClose(zlLib);
 	}
+	/* remove symbols from symbol table */
+	if (zlLib->symTab != NULL) {
+		GH_delete(zlLib->symTab);
+		zlLib->symTab = NULL;
+	}
+	/* delete DOFF desc since it holds *lots* of host OS
+	 * resources */
+	dofClose(zlLib);
 func_end:
 	DBC_Ensure(zlLib->loadRef >= 0);
 }
-- 
1.5.6.5

