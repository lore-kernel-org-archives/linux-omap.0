From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: fix keypad keymap
Date: Sat,  7 Nov 2009 23:18:24 +0200
Message-ID: <1257628704-6147-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48456 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbZKGVSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Nov 2009 16:18:22 -0500
Received: by bwz27 with SMTP id 27so2280588bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 07 Nov 2009 13:18:27 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

The original TWL4030 keypad driver from linux-omap used KEY()
macro defined as (col, row), but while it was merged upstream
it was changed to use matrix keypad infrastructure, which uses
(row, col) format. Update the keymap in board file to match
layout of mainline driver.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   78 +++++++++++++++---------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 581a18d..d81d1a0 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -134,50 +134,50 @@ static void __init pandora_keys_gpio_init(void)
 }
 
 static int board_keymap[] = {
-	/* col, row, code */
+	/* row, col, code */
 	KEY(0, 0, KEY_9),
-	KEY(0, 1, KEY_0),
-	KEY(0, 2, KEY_BACKSPACE),
-	KEY(0, 3, KEY_O),
-	KEY(0, 4, KEY_P),
-	KEY(0, 5, KEY_K),
-	KEY(0, 6, KEY_L),
-	KEY(0, 7, KEY_ENTER),
-	KEY(1, 0, KEY_8),
+	KEY(0, 1, KEY_8),
+	KEY(0, 2, KEY_I),
+	KEY(0, 3, KEY_J),
+	KEY(0, 4, KEY_N),
+	KEY(0, 5, KEY_M),
+	KEY(1, 0, KEY_0),
 	KEY(1, 1, KEY_7),
-	KEY(1, 2, KEY_6),
-	KEY(1, 3, KEY_5),
-	KEY(1, 4, KEY_4),
-	KEY(1, 5, KEY_3),
-	KEY(1, 6, KEY_2),
-	KEY(1, 7, KEY_1),
-	KEY(2, 0, KEY_I),
-	KEY(2, 1, KEY_U),
+	KEY(1, 2, KEY_U),
+	KEY(1, 3, KEY_H),
+	KEY(1, 4, KEY_B),
+	KEY(1, 5, KEY_SPACE),
+	KEY(2, 0, KEY_BACKSPACE),
+	KEY(2, 1, KEY_6),
 	KEY(2, 2, KEY_Y),
-	KEY(2, 3, KEY_T),
-	KEY(2, 4, KEY_R),
-	KEY(2, 5, KEY_E),
-	KEY(2, 6, KEY_W),
-	KEY(2, 7, KEY_Q),
-	KEY(3, 0, KEY_J),
-	KEY(3, 1, KEY_H),
-	KEY(3, 2, KEY_G),
+	KEY(2, 3, KEY_G),
+	KEY(2, 4, KEY_V),
+	KEY(2, 5, KEY_FN),
+	KEY(3, 0, KEY_O),
+	KEY(3, 1, KEY_5),
+	KEY(3, 2, KEY_T),
 	KEY(3, 3, KEY_F),
-	KEY(3, 4, KEY_D),
-	KEY(3, 5, KEY_S),
-	KEY(3, 6, KEY_A),
-	KEY(3, 7, KEY_LEFTSHIFT),
-	KEY(4, 0, KEY_N),
-	KEY(4, 1, KEY_B),
-	KEY(4, 2, KEY_V),
-	KEY(4, 3, KEY_C),
+	KEY(3, 4, KEY_C),
+	KEY(4, 0, KEY_P),
+	KEY(4, 1, KEY_4),
+	KEY(4, 2, KEY_R),
+	KEY(4, 3, KEY_D),
 	KEY(4, 4, KEY_X),
-	KEY(4, 5, KEY_Z),
-	KEY(4, 6, KEY_DOT),
-	KEY(4, 7, KEY_COMMA),
-	KEY(5, 0, KEY_M),
-	KEY(5, 1, KEY_SPACE),
-	KEY(5, 2, KEY_FN),
+	KEY(5, 0, KEY_K),
+	KEY(5, 1, KEY_3),
+	KEY(5, 2, KEY_E),
+	KEY(5, 3, KEY_S),
+	KEY(5, 4, KEY_Z),
+	KEY(6, 0, KEY_L),
+	KEY(6, 1, KEY_2),
+	KEY(6, 2, KEY_W),
+	KEY(6, 3, KEY_A),
+	KEY(6, 4, KEY_DOT),
+	KEY(7, 0, KEY_ENTER),
+	KEY(7, 1, KEY_1),
+	KEY(7, 2, KEY_Q),
+	KEY(7, 3, KEY_LEFTSHIFT),
+	KEY(7, 4, KEY_COMMA),
 };
 
 static struct matrix_keymap_data board_map_data = {
-- 
1.5.6.3

