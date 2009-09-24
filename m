From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] omap: Fix matrix_keymap_data usage
Date: Thu, 24 Sep 2009 16:44:31 -0700
Message-ID: <20090924234430.6065.45543.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56207 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZIXXo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:44:28 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we'll get compile errors like:

arch/arm/plat-omap/include/mach/keypad.h:38:1: warning: "KEY" redefined
arch/arm/plat-omap/include/mach/keypad.h:39:1: warning: "PERSISTENT_KEY" redefined
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |   10 +++++++---
 arch/arm/mach-omap2/board-ldp.c              |   10 +++++++---
 arch/arm/mach-omap2/board-omap3evm.c         |   10 +++++++---
 arch/arm/mach-omap2/board-omap3pandora.c     |   10 +++++++---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   10 +++++++---
 arch/arm/mach-omap2/board-zoom2.c            |   10 +++++++---
 arch/arm/plat-omap/include/mach/keypad.h     |    5 ++---
 7 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index bd57ec7..efaf053 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -54,7 +54,7 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
-static int sdp3430_keymap[] = {
+static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_A),
@@ -88,11 +88,15 @@ static int sdp3430_keymap[] = {
 	0
 };
 
+static struct matrix_keymap_data board_map_data = {
+	.keymap			= board_keymap,
+	.keymap_size		= ARRAY_SIZE(board_keymap),
+};
+
 static struct twl4030_keypad_data sdp3430_kp_data = {
+	.keymap_data	= &board_map_data,
 	.rows		= 5,
 	.cols		= 6,
-	.keymap		= sdp3430_keymap,
-	.keymapsize	= ARRAY_SIZE(sdp3430_keymap),
 	.rep		= 1,
 };
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ec6854c..d110a7f 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -80,7 +80,7 @@ static struct platform_device ldp_smsc911x_device = {
 	},
 };
 
-static int ldp_twl4030_keymap[] = {
+static int board_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(1, 0, KEY_2),
 	KEY(2, 0, KEY_3),
@@ -101,11 +101,15 @@ static int ldp_twl4030_keymap[] = {
 	0
 };
 
+static struct matrix_keymap_data board_map_data = {
+	.keymap			= board_keymap,
+	.keymap_size		= ARRAY_SIZE(board_keymap),
+};
+
 static struct twl4030_keypad_data ldp_kp_twl4030_data = {
+	.keymap_data	= &board_map_data,
 	.rows		= 6,
 	.cols		= 6,
-	.keymap		= ldp_twl4030_keymap,
-	.keymapsize	= ARRAY_SIZE(ldp_twl4030_keymap),
 	.rep		= 1,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d50b9be..e4ec0c5 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -159,7 +159,7 @@ static struct twl4030_usb_data omap3evm_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static int omap3evm_keymap[] = {
+static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_A),
@@ -178,11 +178,15 @@ static int omap3evm_keymap[] = {
 	KEY(3, 3, KEY_P)
 };
 
+static struct matrix_keymap_data board_map_data = {
+	.keymap			= board_keymap,
+	.keymap_size		= ARRAY_SIZE(board_keymap),
+};
+
 static struct twl4030_keypad_data omap3evm_kp_data = {
+	.keymap_data	= &board_map_data,
 	.rows		= 4,
 	.cols		= 4,
-	.keymap		= omap3evm_keymap,
-	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
 	.rep		= 1,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index b43f6e3..7f6bf87 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -133,7 +133,7 @@ static void __init pandora_keys_gpio_init(void)
 	omap_set_gpio_debounce_time(32 * 5, GPIO_DEBOUNCE_TIME);
 }
 
-static int pandora_keypad_map[] = {
+static int board_keymap[] = {
 	/* col, row, code */
 	KEY(0, 0, KEY_9),
 	KEY(0, 1, KEY_0),
@@ -180,11 +180,15 @@ static int pandora_keypad_map[] = {
 	KEY(5, 2, KEY_FN),
 };
 
+static struct matrix_keymap_data board_map_data = {
+	.keymap			= board_keymap,
+	.keymap_size		= ARRAY_SIZE(board_keymap),
+};
+
 static struct twl4030_keypad_data pandora_kp_data = {
+	.keymap_data	= &board_map_data,
 	.rows		= 8,
 	.cols		= 6,
-	.keymap		= pandora_keypad_map,
-	.keymapsize	= ARRAY_SIZE(pandora_keypad_map),
 	.rep		= 1,
 };
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e6e8290..b45ad31 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -36,7 +36,7 @@
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
 
-static int rx51_keymap[] = {
+static int board_keymap[] = {
 	KEY(0, 0, KEY_Q),
 	KEY(0, 1, KEY_W),
 	KEY(0, 2, KEY_E),
@@ -83,11 +83,15 @@ static int rx51_keymap[] = {
 	KEY(0xff, 5, KEY_F10),
 };
 
+static struct matrix_keymap_data board_map_data = {
+	.keymap			= board_keymap,
+	.keymap_size		= ARRAY_SIZE(board_keymap),
+};
+
 static struct twl4030_keypad_data rx51_kp_data = {
+	.keymap_data	= &board_map_data,
 	.rows		= 8,
 	.cols		= 8,
-	.keymap		= rx51_keymap,
-	.keymapsize	= ARRAY_SIZE(rx51_keymap),
 	.rep		= 1,
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 324009e..b7b3220 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -27,7 +27,7 @@
 #include "mmc-twl4030.h"
 
 /* Zoom2 has Qwerty keyboard*/
-static int zoom2_twl4030_keymap[] = {
+static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(1, 0, KEY_R),
 	KEY(2, 0, KEY_T),
@@ -82,11 +82,15 @@ static int zoom2_twl4030_keymap[] = {
 	0
 };
 
+static struct matrix_keymap_data board_map_data = {
+	.keymap			= board_keymap,
+	.keymap_size		= ARRAY_SIZE(board_keymap),
+};
+
 static struct twl4030_keypad_data zoom2_kp_twl4030_data = {
+	.keymap_data	= &board_map_data,
 	.rows		= 8,
 	.cols		= 8,
-	.keymap		= zoom2_twl4030_keymap,
-	.keymapsize	= ARRAY_SIZE(zoom2_twl4030_keymap),
 	.rep		= 1,
 };
 
diff --git a/arch/arm/plat-omap/include/mach/keypad.h b/arch/arm/plat-omap/include/mach/keypad.h
index 45ea3ae..d91b9be 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -10,6 +10,8 @@
 #ifndef ASMARM_ARCH_KEYPAD_H
 #define ASMARM_ARCH_KEYPAD_H
 
+#include <linux/input/matrix_keypad.h>
+
 struct omap_kp_platform_data {
 	int rows;
 	int cols;
@@ -35,9 +37,6 @@ struct omap_kp_platform_data {
 
 #define KEY_PERSISTENT		0x00800000
 #define KEYNUM_MASK		0x00EFFFFF
-#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
-#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
-						KEY_PERSISTENT)
 
 #endif
 

