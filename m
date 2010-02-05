From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/3] omap3evm: Fixes after moving to matrix_keypad
Date: Fri,  5 Feb 2010 14:13:58 +0530
Message-ID: <1265359438-18677-1-git-send-email-premi@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>
List-Id: linux-omap@vger.kernel.org

The keypad was not working properly after migrating
to matrix_keypad.

Swapped the row, col fields of the KEY() macro in
the keymap definition to get it working again.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 19363bd..c8e1208 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -258,20 +258,23 @@ static struct twl4030_usb_data omap3evm_usb_data = {
 
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_A),
-	KEY(0, 3, KEY_B),
-	KEY(1, 0, KEY_DOWN),
+	KEY(0, 1, KEY_DOWN),
+	KEY(0, 2, KEY_ENTER),
+	KEY(0, 3, KEY_M),
+
+	KEY(1, 0, KEY_RIGHT),
 	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_E),
-	KEY(1, 3, KEY_F),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_I),
+	KEY(1, 2, KEY_I),
+	KEY(1, 3, KEY_N),
+
+	KEY(2, 0, KEY_A),
+	KEY(2, 1, KEY_E),
 	KEY(2, 2, KEY_J),
-	KEY(2, 3, KEY_K),
-	KEY(3, 0, KEY_M),
-	KEY(3, 1, KEY_N),
-	KEY(3, 2, KEY_O),
+	KEY(2, 3, KEY_O),
+
+	KEY(3, 0, KEY_B),
+	KEY(3, 1, KEY_F),
+	KEY(3, 2, KEY_K),
 	KEY(3, 3, KEY_P)
 };
 
-- 
1.6.2.2

