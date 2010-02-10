From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: Simplify Atoi() method (v2)
Date: Wed, 10 Feb 2010 09:58:58 +0200
Message-ID: <1265788738-27123-1-git-send-email-andy.shevchenko@gmail.com>
References: <4B7213C1.1040300@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32620 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab0BJIAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 03:00:37 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1A80Xe1012492
	for <linux-omap@vger.kernel.org>; Wed, 10 Feb 2010 10:00:34 +0200
In-Reply-To: <4B7213C1.1040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Try to use simple_strtoul() kernel native method instead.

However, there are opened questions:
 - why type of Atoi() is s32 if the sign is used only to detect base?
 - should we really to check hex integers like DEAD0123h?
 - how many spaces could lead token?

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |   42 +++++---------------------------------
 1 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 9efb7dc..a460d1a 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -1001,50 +1001,20 @@ DSP_STATUS DCD_UnregisterObject(IN struct DSP_UUID *pUuid,
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
+	} else if (*pch && tolower(pch[strlen(pch) - 1]) == 'h') {
+		base = 16;
 	}
 
-	return result;
+	return simple_strtoul(pch, NULL, base);
 }
 
 /*
-- 
1.5.6.5

