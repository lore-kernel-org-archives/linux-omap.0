From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 5/5] dspbridge: static code analysis issues - don't dereference NULL
Date: Fri, 31 Jul 2009 13:39:28 +0300
Message-ID: <1249036768-754-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1249036768-754-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1249036768-754-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1249036768-754-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1249036768-754-4-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49324 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZGaKju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Jul 2009 06:39:50 -0400
In-Reply-To: <1249036768-754-4-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Phil Carmody <ext-phil.2.carmody@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

There's no point checking if a pointer's null if you're going to
dereference it anyway.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/pmgr/dbll.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index c57f557..7c3cd40 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1481,6 +1481,7 @@ static int writeMem(struct Dynamic_Loader_Initialize *this, void *buf,
 {
 	struct DBLLInit *pInit = (struct DBLLInit *)this;
 	struct DBLL_LibraryObj *lib;
+	struct DBLL_TarObj *pTarget;
 	struct DBLL_SectInfo sectInfo;
 	u32 memType;
 	bool retVal = true;
@@ -1491,20 +1492,24 @@ static int writeMem(struct Dynamic_Loader_Initialize *this, void *buf,
 
 	memType = (DLOAD_SECTION_TYPE(info->type) == DLOAD_TEXT) ? DBLL_CODE :
 		  DBLL_DATA;
-	if (lib != NULL) {
-		retVal = (*lib->pTarget->attrs.write)(lib->pTarget->
-			attrs.wHandle, addr, buf, nBytes, memType);
-	}
-	if (lib->pTarget->attrs.logWrite) {
-		sectInfo.name = info->name;
-		sectInfo.runAddr = info->run_addr;
-		sectInfo.loadAddr = info->load_addr;
-		sectInfo.size = info->size;
-		sectInfo.type = memType;
-		/* Pass the information about what we've written to
-		 * another module */
-		(*lib->pTarget->attrs.logWrite)(lib->pTarget->
-			attrs.logWriteHandle, &sectInfo, addr, nBytes);
+	if ((lib != NULL) &&
+	    ((pTarget = lib->pTarget) != NULL) &&
+	    (pTarget->attrs.write != NULL)) {
+		retVal = (*pTarget->attrs.write)(pTarget->attrs.wHandle,
+						 addr, buf, nBytes, memType);
+
+		if (pTarget->attrs.logWrite) {
+			sectInfo.name = info->name;
+			sectInfo.runAddr = info->run_addr;
+			sectInfo.loadAddr = info->load_addr;
+			sectInfo.size = info->size;
+			sectInfo.type = memType;
+			/* Pass the information about what we've written to
+			 * another module */
+			(*pTarget->attrs.logWrite)(
+				pTarget->attrs.logWriteHandle,
+				&sectInfo, addr, nBytes);
+		}
 	}
 	return retVal;
 }
-- 
1.6.0.4

