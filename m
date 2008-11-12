From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 3/3] [OMAPZOOM] Fix persistent TWL4030 keypress in LDP board file.
Date: Wed, 12 Nov 2008 13:07:45 -0600
Message-ID: <200811121307.45678.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34519 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbYKLTHv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 14:07:51 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: stanley.miao@windriver.com

Removes ZOOM specific code from TWL4030 keypad driver.
Adds generic code to deal with persistent TWL4030 keypress.
Code originally submitted by Stanley Miao to linux-omap tree.

Signed-off-by: Dominic Curran <dcurran@ti.com>
cc: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-ldp.c             |    1 +
 arch/arm/plat-omap/include/mach/keypad.h    |    5 +++++
 drivers/input/keyboard/omap-twl4030keypad.c |   21 ++++++---------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b2e8c9c..6cdccf3 100755
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -263,6 +263,7 @@ static int ldp_twl4030_keymap[] = {
 	KEY(0, 3, KEY_F7),
 	KEY(1, 3, KEY_0),
 	KEY(2, 3, KEY_F8),
+	PERSISTENT_KEY(4, 5),
 	KEY(5, 4, KEY_MUTE),
 	KEY(4, 4, KEY_VOLUMEUP),
 	KEY(5, 5, KEY_VOLUMEDOWN),
diff --git a/arch/arm/plat-omap/include/mach/keypad.h b/arch/arm/plat-omap/include/mach/keypad.h
index ba1c95c..b7f270a 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -34,7 +34,12 @@ struct omap_kp_platform_data {
 #define GROUP_3		(3 << 16)
 #define GROUP_MASK	GROUP_3
 
+#define ROWCOL_MASK		0xFF000000
+#define KEY_PERSISTENT		0x00800000
+#define KEYNUM_MASK		0x00EFFFFF
 #define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
+#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
+						KEY_PERSISTENT)
 
 #endif
 
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c 
b/drivers/input/keyboard/omap-twl4030keypad.c
index e8fd21c..40ee869 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -40,14 +40,12 @@
 #include <linux/irq.h>
 #include <mach/gpio.h>
 #include <mach/keypad.h>
+
 #include "twl4030-keypad.h"
 
 #define PTV_PRESCALER		4
 
 #define MAX_ROWS		8 /* TWL4030 hardlimit */
-#define ROWCOL_MASK		0xFF000000
-#define KEYNUM_MASK		0x00FFFFFF
-#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
 
 /* Global variables */
 
@@ -103,7 +101,7 @@ static int omap_kp_find_key(struct omap_keypad *kp, int col, int row)
 	rc = KEY(col, row, 0);
 	for (i = 0; i < kp->keymapsize; i++)
 		if ((kp->keymap[i] & ROWCOL_MASK) == rc)
-			return kp->keymap[i] & KEYNUM_MASK;
+			return kp->keymap[i] & (KEYNUM_MASK | KEY_PERSISTENT);
 
 	return -EINVAL;
 }
@@ -187,20 +185,13 @@ static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
 				"press" : "release");
 
 			key = omap_kp_find_key(kp, col, row);
-			if (key < 0) {
-#if defined(CONFIG_MACH_OMAP_LDP) || defined(CONFIG_MACH_OMAP_ZOOM2)
-				/* OMAP LDP has a TWL4030 GPIO
-				 * (KBR5/KBC4) that is set to a persistent
-				 * state and should be ignored.
-				 */
-				if (row == 5 && col == 4)
-					continue;
-#endif
-
+			if (key < 0)
 				dev_warn(kp->dbg_dev,
 					"Spurious key event %d-%d\n",
 					 col, row);
-			} else
+			else if (key & KEY_PERSISTENT)
+				continue;
+			else
 				input_report_key(kp->omap_twl4030kp, key,
 						 new_state[row] & (1 << col));
 		}
-- 
1.5.4.1

