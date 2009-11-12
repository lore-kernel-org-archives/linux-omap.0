From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH] Fixing keymap for zoom2 according to matrix keypad framwork
Date: Thu, 12 Nov 2009 14:53:58 +0530
Message-ID: <ce9ab5790911120123o5b43b63cu5a9af3281df6d902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39031 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbZKLJYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 04:24:14 -0500
Received: by bwz27 with SMTP id 27so1965349bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 01:24:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From fa0ed0d00ee835d70cd4b1d32f89d4e845e0fff8 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 12 Nov 2009 14:46:00 +0530
Subject: [PATCH] Fixing keymap for zoom2 according to matrix keypad framwork

Interpretation of 'row' and 'col' got reversed in matrix keymap
framework. Also last element '0', present in keymap array, is no
more needed.
Correcting zoom2 keyboard keymap accordingly.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   87 +++++++++++++-------------
 1 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 54619d5..efb7794 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -29,57 +29,56 @@
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
-	KEY(1, 0, KEY_R),
-	KEY(2, 0, KEY_T),
-	KEY(3, 0, KEY_HOME),
-	KEY(6, 0, KEY_I),
-	KEY(7, 0, KEY_LEFTSHIFT),
-	KEY(0, 1, KEY_D),
+	KEY(0, 1, KEY_R),
+	KEY(0, 2, KEY_T),
+	KEY(0, 3, KEY_HOME),
+	KEY(0, 6, KEY_I),
+	KEY(0, 7, KEY_LEFTSHIFT),
+	KEY(1, 0, KEY_D),
 	KEY(1, 1, KEY_F),
-	KEY(2, 1, KEY_G),
-	KEY(3, 1, KEY_SEND),
-	KEY(6, 1, KEY_K),
-	KEY(7, 1, KEY_ENTER),
-	KEY(0, 2, KEY_X),
-	KEY(1, 2, KEY_C),
+	KEY(1, 2, KEY_G),
+	KEY(1, 3, KEY_SEND),
+	KEY(1, 6, KEY_K),
+	KEY(1, 7, KEY_ENTER),
+	KEY(2, 0, KEY_X),
+	KEY(2, 1, KEY_C),
 	KEY(2, 2, KEY_V),
-	KEY(3, 2, KEY_END),
-	KEY(6, 2, KEY_DOT),
-	KEY(7, 2, KEY_CAPSLOCK),
-	KEY(0, 3, KEY_Z),
-	KEY(1, 3, KEY_KPPLUS),
-	KEY(2, 3, KEY_B),
+	KEY(2, 3, KEY_END),
+	KEY(2, 6, KEY_DOT),
+	KEY(2, 7, KEY_CAPSLOCK),
+	KEY(3, 0, KEY_Z),
+	KEY(3, 1, KEY_KPPLUS),
+	KEY(3, 2, KEY_B),
 	KEY(3, 3, KEY_F1),
-	KEY(6, 3, KEY_O),
-	KEY(7, 3, KEY_SPACE),
-	KEY(0, 4, KEY_W),
-	KEY(1, 4, KEY_Y),
-	KEY(2, 4, KEY_U),
-	KEY(3, 4, KEY_F2),
+	KEY(3, 6, KEY_O),
+	KEY(3, 7, KEY_SPACE),
+	KEY(4, 0, KEY_W),
+	KEY(4, 1, KEY_Y),
+	KEY(4, 2, KEY_U),
+	KEY(4, 3, KEY_F2),
 	KEY(4, 4, KEY_VOLUMEUP),
-	KEY(6, 4, KEY_L),
-	KEY(7, 4, KEY_LEFT),
-	KEY(0, 5, KEY_S),
-	KEY(1, 5, KEY_H),
-	KEY(2, 5, KEY_J),
-	KEY(3, 5, KEY_F3),
+	KEY(4, 6, KEY_L),
+	KEY(4, 7, KEY_LEFT),
+	KEY(5, 0, KEY_S),
+	KEY(5, 1, KEY_H),
+	KEY(5, 2, KEY_J),
+	KEY(5, 3, KEY_F3),
 	KEY(5, 5, KEY_VOLUMEDOWN),
-	KEY(6, 5, KEY_M),
-	KEY(4, 5, KEY_ENTER),
-	KEY(7, 5, KEY_RIGHT),
-	KEY(0, 6, KEY_Q),
-	KEY(1, 6, KEY_A),
-	KEY(2, 6, KEY_N),
-	KEY(3, 6, KEY_BACKSPACE),
+	KEY(5, 6, KEY_M),
+	KEY(5, 7, KEY_ENTER),
+	KEY(6, 0, KEY_Q),
+	KEY(6, 1, KEY_A),
+	KEY(6, 2, KEY_N),
+	KEY(6, 3, KEY_BACKSPACE),
 	KEY(6, 6, KEY_P),
-	KEY(7, 6, KEY_UP),
 	KEY(6, 7, KEY_SELECT),
-	KEY(7, 7, KEY_DOWN),
-	KEY(0, 7, KEY_PROG1),	/*MACRO 1 <User defined> */
-	KEY(1, 7, KEY_PROG2),	/*MACRO 2 <User defined> */
-	KEY(2, 7, KEY_PROG3),	/*MACRO 3 <User defined> */
-	KEY(3, 7, KEY_PROG4),	/*MACRO 4 <User defined> */
-	0
+	KEY(7, 0, KEY_PROG1),	/*MACRO 1 <User defined> */
+	KEY(7, 1, KEY_PROG2),	/*MACRO 2 <User defined> */
+	KEY(7, 2, KEY_PROG3),	/*MACRO 3 <User defined> */
+	KEY(7, 3, KEY_PROG4),	/*MACRO 4 <User defined> */
+	KEY(7, 5, KEY_RIGHT),
+	KEY(7, 6, KEY_UP),
+	KEY(7, 7, KEY_DOWN)
 };

 static struct matrix_keymap_data board_map_data = {
-- 
1.5.5
