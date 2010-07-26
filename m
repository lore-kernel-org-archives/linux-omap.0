From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] Input: OMAP: RX51: fix 'KEY_10' compile breakage
Date: Mon, 26 Jul 2010 16:28:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007261625470.1906@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51148 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab0GZW2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jul 2010 18:28:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, stable@kernel.org


Commit 3fea60261e73dbf4a51130d40cafcc8465b0f2c3 replaces KEY_F10 and 
KEY_F11 macro references with 'KEY_10' and 'KEY_11'.  This breaks 
v2.6.35-rc6 compiles with omap3_defconfig:

  CC      arch/arm/mach-omap2/board-rx51-peripherals.o
arch/arm/mach-omap2/board-rx51-peripherals.c:223: error: 'KEY_10' undeclared here (not in a function)
arch/arm/mach-omap2/board-rx51-peripherals.c:226: error: 'KEY_11' undeclared here (not in a function)

Fix by renaming the macro references back to KEY_F10 and KEY_F11.

Compile-tested only.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: stable@kernel.org
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index c5555ca..0348392 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -220,10 +220,10 @@ static int board_keymap[] = {
 	KEY(4, 4, KEY_LEFTCTRL),
 	KEY(4, 5, KEY_RIGHTALT),
 	KEY(4, 6, KEY_LEFTSHIFT),
-	KEY(4, 8, KEY_10),
+	KEY(4, 8, KEY_F10),
 
 	KEY(5, 0, KEY_Y),
-	KEY(5, 8, KEY_11),
+	KEY(5, 8, KEY_F11),
 
 	KEY(6, 0, KEY_U),
 
-- 
1.7.1

