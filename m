From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix keymap for zoom2 according to matrix keypad
 framwork
Date: Mon, 16 Nov 2009 15:40:52 -0800
Message-ID: <20091116234052.GV3684@atomide.com>
References: <20091116232435.24892.81547.stgit@localhost>
 <20091116232820.24892.52305.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57104 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbZKPXkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:40:51 -0500
Content-Disposition: inline
In-Reply-To: <20091116232820.24892.52305.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [091116 15:32]:
> From: vikram pandita <vikram.pandita@ti.com>
> 
> Split zoom2 board file into a base board file and a board-zoom-peripherals.c
> file. That way the same peripherals file can be reused for zoom3 and sdp3630
> in addition to zoom2.
> 
> Also remove unused struct omap_board_config_kernel entry.
> 
> NOTE: Keep the twl4030_madc_platform_data and twl4030_platform_data
> entries in board-zoom2.c to avoid merge conflicts with the pending
> patches in MFD tree. These entries will be removed later as a fix.

<snip>

This patch originally had the following matrix keyboard fix in the series,
but I'll try to send it in as a fix.

Regards,

Tony


--IpbVkmxF4tDyP/Kb
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="zoom-fix-keypad.patch"

>From 8fb13be584f7d488ad063693ee828424ad97a1af Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Fri, 13 Nov 2009 17:37:33 -0800
Subject: [PATCH] omap: Fix keymap for zoom2 according to matrix keypad framwork

Interpretation of 'row' and 'col' got reversed in matrix keymap
framework. Also last element '0', present in keymap array, is no
more needed.
Correcting zoom2 keyboard keymap accordingly.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 4bdc27c..67abebc 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -30,57 +30,56 @@
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

--IpbVkmxF4tDyP/Kb--
