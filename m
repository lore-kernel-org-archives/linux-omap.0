From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 2/4] OMAP: MENELAUS: Move menelaus header to include/linux/i2c
Date: Tue, 29 Jul 2008 12:44:27 -0400
Message-ID: <488F48EB.5080407@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25234 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbYG2Qoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 12:44:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch moves menelaus header from include/asm-arm/arch-omap/
to include/linux/i2c/

It also includes menelaus' headers to include/linux/i2c

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/mach-omap2/board-h4-mmc.c                 |    2 +-
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-n800-camera.c            |    2 +-
 arch/arm/mach-omap2/board-n800-mmc.c               |    2 +-
 arch/arm/mach-omap2/board-n800.c                   |    2 +-
 arch/arm/plat-omap/devices.c                       |    2 +-
 drivers/i2c/chips/menelaus.c                       |    2 +-
 drivers/input/keyboard/omap-keypad.c               |    2 +-
 .../{asm-arm/arch-omap => linux/i2c}/menelaus.h    |    0 
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename include/{asm-arm/arch-omap => linux/i2c}/menelaus.h (100%)

diff --git a/arch/arm/mach-omap2/board-h4-mmc.c b/arch/arm/mach-omap2/board-h4-mmc.c
index 9cdb00f..84b3f4e 100644
--- a/arch/arm/mach-omap2/board-h4-mmc.c
+++ b/arch/arm/mach-omap2/board-h4-mmc.c
@@ -15,10 +15,10 @@
  */
 
 #include <asm/arch/mmc.h>
-#include <asm/arch/menelaus.h>
 
 #include <asm/mach-types.h>
 #include <linux/delay.h>
+#include <linux/i2c/menelaus.h>
 
 #ifdef CONFIG_MMC_OMAP
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 101b455..c174467 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
+#include <linux/i2c/menelaus.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc210x.h>
 
@@ -42,7 +43,6 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/menelaus.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/gpmc.h>
 
diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
index aafa547..9414882 100644
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -25,12 +25,12 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/videodev2.h>
+#include <linux/i2c/menelaus.h>
 
 #include <media/v4l2-int-device.h>
 
 #include <asm/mach-types.h>
 
-#include <asm/arch/menelaus.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/board.h>
 
diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index 26f3709..2028710 100644
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -10,11 +10,11 @@
  */
 
 #include <asm/arch/mmc.h>
-#include <asm/arch/menelaus.h>
 #include <asm/arch/gpio.h>
 
 #include <asm/mach-types.h>
 #include <linux/delay.h>
+#include <linux/i2c/menelaus.h>
 
 #ifdef CONFIG_MMC_OMAP
 
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index ae85c2c..46a83c1 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/i2c/lm8323.h>
+#include <linux/i2c/menelaus.h>
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -34,7 +35,6 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/mcspi.h>
-#include <asm/arch/menelaus.h>
 #include <asm/arch/lcd_mipid.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/gpio-switch.h>
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index b83f9a6..57df724 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/i2c/menelaus.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -25,7 +26,6 @@
 #include <asm/arch/mmc.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
-#include <asm/arch/menelaus.h>
 #include <asm/arch/dsp_common.h>
 #include <asm/arch/mcbsp.h>
 
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index b7a7f01..e65245e 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -41,12 +41,12 @@
 #include <linux/delay.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/i2c/menelaus.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 
 #include <asm/arch/gpio.h>
-#include <asm/arch/menelaus.h>
 
 #define DRIVER_NAME			"menelaus"
 
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 0eba78e..90c092f 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -35,9 +35,9 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/i2c/menelaus.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/menelaus.h>
 #include <asm/irq.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
diff --git a/include/asm-arm/arch-omap/menelaus.h b/include/linux/i2c/menelaus.h
similarity index 100%
rename from include/asm-arm/arch-omap/menelaus.h
rename to include/linux/i2c/menelaus.h
-- 1.5.5.1

