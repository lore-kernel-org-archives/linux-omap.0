From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH] OMAP: ZOOM2: Correcting key mapping for few keys
Date: Fri, 18 Dec 2009 13:03:11 +0530
Message-ID: <ce9ab5790912172333q77525952ndc6deb657cf12da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35857 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZLRHdc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 02:33:32 -0500
Received: by bwz27 with SMTP id 27so1977500bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 23:33:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From ab3239189c25a19d7764042cc3f05cce8a91f291 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Fri, 18 Dec 2009 12:09:10 +0530
Subject: [PATCH] OMAP: ZOOM2: Correcting key mapping for few keys

Keys: 'right arrow', 'up arrow' and 'select' were mapped
wrongly. This patch corrects them.
This patch also adds one missing key present in the board,
currently I added it as 'unknown' key, as I am not able to
find proper description for this key.
One key entry (r: 7, c: 5) is present in the keymap, which
is really not present in the board, removing it.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8dd277c..1e3dfb6 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -63,21 +63,21 @@ static int board_keymap[] = {
 	KEY(5, 1, KEY_H),
 	KEY(5, 2, KEY_J),
 	KEY(5, 3, KEY_F3),
+	KEY(5, 4, KEY_UNKNOWN),
 	KEY(5, 5, KEY_VOLUMEDOWN),
 	KEY(5, 6, KEY_M),
-	KEY(5, 7, KEY_ENTER),
+	KEY(5, 7, KEY_RIGHT),
 	KEY(6, 0, KEY_Q),
 	KEY(6, 1, KEY_A),
 	KEY(6, 2, KEY_N),
 	KEY(6, 3, KEY_BACKSPACE),
 	KEY(6, 6, KEY_P),
-	KEY(6, 7, KEY_SELECT),
+	KEY(6, 7, KEY_UP),
 	KEY(7, 0, KEY_PROG1),	/*MACRO 1 <User defined> */
 	KEY(7, 1, KEY_PROG2),	/*MACRO 2 <User defined> */
 	KEY(7, 2, KEY_PROG3),	/*MACRO 3 <User defined> */
 	KEY(7, 3, KEY_PROG4),	/*MACRO 4 <User defined> */
-	KEY(7, 5, KEY_RIGHT),
-	KEY(7, 6, KEY_UP),
+	KEY(7, 6, KEY_SELECT),
 	KEY(7, 7, KEY_DOWN)
 };

-- 
1.5.5
