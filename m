From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: Simplify Atoi() method
Date: Wed,  3 Feb 2010 12:14:46 +0200
Message-ID: <1265192086-15633-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56557 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab0BCKRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 05:17:07 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o13AGkGv014060
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 04:17:04 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Try to use simple_strtol() kernel native method instead.

However, there are opened questions:
 - why type of Atoi() is s32 if the sign is used only to detect base?
 - should we really to check hex integers like DEAD0123h?
 - how many spaces could lead token?

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |   42 +++++---------------------------------
 1 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index caa57f1..fe2ed57 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -1002,50 +1002,20 @@ DSP_STATUS DCD_UnregisterObject(IN struct DSP_UUID *pUuid,
  */
 static s32 Atoi(char *pszBuf)
 {
-	s32 result = 0;
 	char *pch = pszBuf;
-	char c;
-	char first;
-	s32 base = 10;
-	s32 len;
+	s32 base = 0;
 
 	while (isspace(*pch))
 		pch++;
 
-	first = *pch;
-	if (first == '-' || first == '+') {
+	if (*pch == '-' || *pch == '+') {
+		base = 10;
 		pch++;
-	} else {
-		/* Determine if base 10 or base 16 */
-		len = strlen(pch);
-		if (len  > 1) {
-			c = pch[1];
-			if ((*pch == '0' && (c == 'x' || c == 'X'))) {
-				base = 16;
-				pch += 2;
-			}
-			c = pch[len - 1];
-			if (c == 'h' || c == 'H')
-				base = 16;
-
-		}
-	}
-
-	while (isdigit(c = *pch) || ((base == 16) && isxdigit(c))) {
-		result *= base;
-		if ('A' <= c && c <= 'F') {
-			c = c - 'A' + 10;
-		} else {
-			if ('a' <= c && c <= 'f')
-				c = c - 'a' + 10;
-			else
-				c -= '0';
-		}
-		result += c;
-		++pch;
+	} else if (*pch && (pch[strlen(pch) - 1] | 0x20 == 'h')) {
+		base = 16;
 	}
 
-	return result;
+	return simple_strtoul(pch, NULL, base);
 }
 
 /*
-- 
1.5.6.5

