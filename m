From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: MEM_VFree() cleanup
Date: Mon,  1 Feb 2010 19:56:34 +0200
Message-ID: <48172f2f93a66f4d34c79aa6164236b01e706e3e.1265046944.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53998 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab0BAR5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 12:57:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, deepak.chitriki@ti.com

Since vfree() checks for null pointer, there is no need to check is again in
MEM_VFree(). This patch also reorganizes the function to make it more readable.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/services/mem.c |   42 +++++++++++++++----------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index dfe352d..c2887b3 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -456,35 +456,27 @@ void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType)
 void MEM_VFree(IN void *pMemBuf)
 {
 #ifdef MEM_CHECK
-	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
+	struct memInfo *pMem;
 #endif
-
-	DBC_Require(pMemBuf != NULL);
-
 	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_VFree: pMemBufs 0x%x\n",
-		  pMemBuf);
-
-	if (pMemBuf) {
-#ifndef MEM_CHECK
-		vfree(pMemBuf);
+			pMemBuf);
+#ifdef MEM_CHECK
+	if (!pMemBuf) {
+		GT_1trace(MEM_debugMask, GT_7CLASS,
+			"Invalid allocation or Buffer underflow\n");
+		return;
+	}
+	pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
+	if (pMem && pMem->dwSignature == memInfoSign) {
+		spin_lock(&mMan.lock);
+		MLST_RemoveElem(&mMan.lst, (struct list_head *)pMem);
+		spin_unlock(&mMan.lock);
+		pMem->dwSignature = 0;
+		vfree(pMem);
+	}
 #else
-		if (pMem) {
-			if (pMem->dwSignature == memInfoSign) {
-				spin_lock(&mMan.lock);
-				MLST_RemoveElem(&mMan.lst,
-						(struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-				pMem->dwSignature = 0;
-				vfree(pMem);
-			} else {
-				GT_1trace(MEM_debugMask, GT_7CLASS,
-					"Invalid allocation or "
-					"Buffer underflow at %x\n",
-					(u32) pMem + sizeof(struct memInfo));
-			}
-		}
+	vfree(pMemBuf);
 #endif
-	}
 }
 
 /*
-- 
1.6.3.3

