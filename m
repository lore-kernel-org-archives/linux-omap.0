From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] omap2/3: ZOOM: Correcting key mapping for few keys
Date: Wed, 06 Jan 2010 16:20:09 -0800
Message-ID: <20100107002009.21352.8368.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54262 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab0AGAUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:20:08 -0500
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Vimal Singh <vimalsingh@ti.com>

From: Vimal Singh <vimalsingh@ti.com>

Keys: 'right arrow', 'up arrow' and 'select' were mapped
wrongly. This patch corrects them.
This patch also adds one missing key present in the board,
currently I added it as 'unknown' key, as I am not able to
find proper description for this key.
One key entry (r: 7, c: 5) is present in the keymap, which
is really not present in the board, removing it.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
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
 

