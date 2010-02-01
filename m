From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: MEM_Free() cleanup
Date: Mon,  1 Feb 2010 18:57:45 +0200
Message-ID: <577decfb1227d1772fb5a92f796a101464be2b50.1265038929.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37877 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab0BAQ6N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 11:58:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, deepak.chitriki@ti.com

Since kfree() checks for null pointer, there is no need to check is again in
MEM_Free(). This patch also reorganizes the function to make it more readable.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/services/mem.c |   40 ++++++++++++++----------------------
 1 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index cee646a..dfe352d 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -495,35 +495,27 @@ void MEM_VFree(IN void *pMemBuf)
 void MEM_Free(IN void *pMemBuf)
 {
 #ifdef MEM_CHECK
-	struct memInfo *pMem = (void *)((u32)pMemBuf - sizeof(struct memInfo));
+	struct memInfo *pMem;
 #endif
-
-	DBC_Require(pMemBuf != NULL);
-
 	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_Free: pMemBufs 0x%x\n",
 		  pMemBuf);
-
-	if (pMemBuf) {
-#ifndef MEM_CHECK
-		kfree(pMemBuf);
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
+		kfree(pMem);
+	}
 #else
-		if (pMem) {
-			if (pMem->dwSignature == memInfoSign) {
-				spin_lock(&mMan.lock);
-				MLST_RemoveElem(&mMan.lst,
-						(struct list_head *)pMem);
-				spin_unlock(&mMan.lock);
-				pMem->dwSignature = 0;
-				kfree(pMem);
-			} else {
-				GT_1trace(MEM_debugMask, GT_7CLASS,
-					"Invalid allocation or "
-					"Buffer underflow at %x\n",
-					(u32) pMem + sizeof(struct memInfo));
-			}
-		}
+	kfree(pMemBuf);
 #endif
-	}
 }
 
 /*
-- 
1.6.3.3

