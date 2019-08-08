From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/22] input: omap: void using mach/*.h headers
Date: Thu,  8 Aug 2019 23:22:22 +0200
Message-ID: <20190808212234.2213262-14-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

By using the new linux/soc/ti/omap1-io.h header instead,
compile-testing can be enabled, and a CONFIG_ARCH_MULTIPLATFORM
conversion of omap1 may eventually be possible.

The warning in the header file gets removed in order to
allow CONFIG_COMPILE_TEST.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/Kconfig            | 2 +-
 drivers/input/keyboard/omap-keypad.c      | 1 +
 include/linux/platform_data/keypad-omap.h | 5 -----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 5f1a3b3ee0fb..b454d262906b 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -658,7 +658,7 @@ config KEYBOARD_IPAQ_MICRO
 
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP1 || COMPILE_TEST
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use the OMAP keypad.
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 5fe7a5633e33..31da8e878535 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/keypad-omap.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #undef NEW_BOARD_LEARNING_MODE
 
diff --git a/include/linux/platform_data/keypad-omap.h b/include/linux/platform_data/keypad-omap.h
index 3e7c64c854f4..6f058eb188c4 100644
--- a/include/linux/platform_data/keypad-omap.h
+++ b/include/linux/platform_data/keypad-omap.h
@@ -5,11 +5,6 @@
 #ifndef __KEYPAD_OMAP_H
 #define __KEYPAD_OMAP_H
 
-#ifndef CONFIG_ARCH_OMAP1
-#warning Please update the board to use matrix-keypad driver
-#define omap_readw(reg)		0
-#define omap_writew(val, reg)	do {} while (0)
-#endif
 #include <linux/input/matrix_keypad.h>
 
 struct omap_kp_platform_data {
-- 
2.20.0
