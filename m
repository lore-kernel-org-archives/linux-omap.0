From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 5/5] DSPBRIDGE: OSAL: Remove printS()
Date: Wed, 23 Sep 2009 19:03:23 +0300
Message-ID: <1253721804-22816-6-git-send-email-andy.shevchenko@gmail.com>
References: <1253721804-22816-1-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-2-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-3-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-4-git-send-email-andy.shevchenko@gmail.com>
 <1253721804-22816-5-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40771 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbZIWQEH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 12:04:07 -0400
In-Reply-To: <1253721804-22816-5-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@Nokia.com, Andy Shevchenko <ext-andriy.shevchenko@Nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Remove printS() debuggin method. It's mostly useless and at least dangerous
because of absence of boundary check.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/services/regsup.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 71651a8..bd45b56 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -60,26 +60,6 @@ static struct LST_LIST regKey, *pRegKey = &regKey;
 
 #if GT_TRACE
 extern struct GT_Mask REG_debugMask;	/* GT trace var. */
-/*
- *  ======== printS ========
- *  Purpose:
- *      Displays printable characters in pBuf, if any.
- */
-static inline void printS(void *pBuf)
-{
-	int pos = 0;
-	if (*(REG_debugMask).flags & (GT_2CLASS)) {
-		while (*(u8 *)((pBuf)+pos) >= ' ' &&
-		       *(u8 *)((pBuf)+pos) <= '~') {
-			GT_1trace(REG_debugMask, GT_2CLASS, "%c",
-					*(u8 *)((pBuf) + pos++));
-		}
-
-		GT_0trace(REG_debugMask, GT_2CLASS, "\n");
-	}
-}
-#else
-#define printS(pBuf)
 #endif
 
 /*
@@ -140,7 +120,6 @@ DSP_STATUS regsupGetValue(char *valName, void *pBuf, u32 *dataSize)
 	if (DSP_SUCCEEDED(retVal)) {
 		GT_2trace(REG_debugMask, GT_2CLASS, "G %s DATA %x ", valName,
 			  *(u32 *)pBuf);
-		printS((u8 *)pBuf);
 	} else {
 		GT_1trace(REG_debugMask, GT_3CLASS, "G %s FAILED\n", valName);
 	}
@@ -160,7 +139,6 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 
 	GT_2trace(REG_debugMask, GT_2CLASS, "S %s DATA %x ", valName,
 		  *(u32 *)pBuf);
-	printS((u8 *)pBuf);
 
 	/*  Need to search through the entries looking for the right one.  */
 	while (rv) {
@@ -245,7 +223,6 @@ DSP_STATUS regsupEnumValue(IN u32 dwIndex, IN CONST char *pstrKey,
 			GT_3trace(REG_debugMask, GT_2CLASS,
 				  "E Key %s, Value %s, Data %x ",
 				  pstrKey, pstrValue, *(u32 *)pstrData);
-			printS((u8 *)pstrData);
 
 			/*  Set our status to good and exit.  */
 			retVal = DSP_SOK;
-- 
1.5.6.5

