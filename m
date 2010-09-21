From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 10/10] OMAP3: Keypad: Fix incorrect type initializer
Date: Tue, 21 Sep 2010 15:31:20 +0530
Message-ID: <1285063280-4057-11-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

The keypad matrix variable declaration is not matching
with structure variable keymap declared in keypad_matrix.h.

Due to this, following sparse warnings are generated with omap3_defconfig.

arch/arm/mach-omap2/board-devkit8000.c:223:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-devkit8000.c:223:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-devkit8000.c:223:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-ldp.c:107:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-ldp.c:107:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-ldp.c:107:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-omap3evm.c:472:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-omap3evm.c:472:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-omap3evm.c:472:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-3430sdp.c:114:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-3430sdp.c:114:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-3430sdp.c:114:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-rx51-peripherals.c:248:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-rx51-peripherals.c:248:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-rx51-peripherals.c:248:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-zoom-peripherals.c:88:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-zoom-peripherals.c:88:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-zoom-peripherals.c:88:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-cm-t35.c:568:14: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-cm-t35.c:568:14:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-cm-t35.c:568:14:    got int static [toplevel] *<noident>

arch/arm/mach-omap2/board-omap3stalker.c:415:13: warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-omap3stalker.c:415:13:    expected unsigned int const [usertype] *keymap
arch/arm/mach-omap2/board-omap3stalker.c:415:13:    got int static [toplevel] *<noident>

This patch modifies the variable keymap declaration as per declaration in matrix_keymap structure.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>

---
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-ldp.c              |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 67b95b5..41b42f7 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -76,7 +76,7 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	{1, 10000, 30000, 300000},
 };
 
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_A),
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e10bc10..a022089 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -558,7 +558,7 @@ static struct twl4030_usb_data cm_t35_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static int cm_t35_keymap[] = {
+static uint32_t cm_t35_keymap[] = {
 	KEY(0, 0, KEY_A),	KEY(0, 1, KEY_B),	KEY(0, 2, KEY_LEFT),
 	KEY(1, 0, KEY_UP),	KEY(1, 1, KEY_ENTER),	KEY(1, 2, KEY_DOWN),
 	KEY(2, 0, KEY_RIGHT),	KEY(2, 1, KEY_C),	KEY(2, 2, KEY_D),
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index a07086d..49b442b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -198,7 +198,7 @@ static struct platform_device devkit8000_dss_device = {
 static struct regulator_consumer_supply devkit8000_vdda_dac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(1, 0, KEY_2),
 	KEY(2, 0, KEY_3),
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 00d9b13..9ad0720 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -82,7 +82,7 @@ static struct platform_device ldp_smsc911x_device = {
 	},
 };
 
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_1),
 	KEY(1, 0, KEY_2),
 	KEY(2, 0, KEY_3),
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 738d832..1d3085f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -446,7 +446,7 @@ static struct twl4030_usb_data omap3evm_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_DOWN),
 	KEY(0, 2, KEY_ENTER),
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 70067d6..4f1a4b8 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -389,7 +389,7 @@ static struct twl4030_usb_data omap3stalker_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_DOWN),
 	KEY(0, 2, KEY_ENTER),
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 83d4efd..04f6455 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -186,7 +186,7 @@ static void __init rx51_add_gpio_keys(void)
 }
 #endif /* CONFIG_KEYBOARD_GPIO || CONFIG_KEYBOARD_GPIO_MODULE */
 
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	/*
 	 * Note that KEY(x, 8, KEY_XXX) entries represent "entrire row
 	 * connected to the ground" matrix state.
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index e2e7353..650e33b 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -30,7 +30,7 @@
 #include "hsmmc.h"
 
 /* Zoom2 has Qwerty keyboard*/
-static int board_keymap[] = {
+static uint32_t board_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_R),
 	KEY(0, 2, KEY_T),
-- 
1.7.0.4

