From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH] Keymap fix for palmte and palmz71.
Date: Thu, 27 Mar 2008 11:09:42 -0400
Message-ID: <1206630582-12074-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27605 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbYC0PJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 11:09:46 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RFBbxn027192
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 10:11:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/board-palmte.c  |    2 +-
 arch/arm/mach-omap1/board-palmz71.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 63c3131..f4860b0 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -64,7 +64,7 @@ static const int palmte_keymap[] = {
 	KEY(1, 1, KEY_DOWN),
 	KEY(1, 2, KEY_UP),
 	KEY(1, 3, KEY_RIGHT),
-	KEY(1, 4, KEY_CENTER),
+	KEY(1, 4, KEY_ENTER),
 	0,
 };
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 1565107..e020c27 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -65,7 +65,7 @@ static int palmz71_keymap[] = {
 	KEY(1, 1, KEY_DOWN),
 	KEY(1, 2, KEY_UP),
 	KEY(1, 3, KEY_RIGHT),
-	KEY(1, 4, KEY_CENTER),
+	KEY(1, 4, KEY_ENTER),
 	KEY(2, 0, KEY_CAMERA),
 	0,
 };
-- 
1.5.4.2

