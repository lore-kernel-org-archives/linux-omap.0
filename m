From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] Remove double MODULE_ALIAS declaration.
Date: Thu, 26 Jun 2008 17:17:58 +0300
Message-ID: <1214489878-20272-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52393 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbYFZOSE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 10:18:04 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5QEEo3q032466
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 09:18:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>

Only once MODULE_ALIAS declaration is enough.
Columns are counted from 0 to n_cols - 1.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 20aeb3c..68c5b8e 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -158,7 +158,7 @@ static void twl4030_kp_scan(int release_all)
 		if (!changed)
 			continue;
 
-		for (col = 0; col < n_cols + 1; col++) {
+		for (col = 0; col < n_cols; col++) {
 			int key;
 
 			if (!(changed & (1 << col)))
@@ -373,4 +373,3 @@ MODULE_ALIAS("platform:omap_twl4030keypad");
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:omap_twl4030keypad");
-- 
1.5.5.1

