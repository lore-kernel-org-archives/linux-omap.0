From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/29] ARM: OMAP1: Move keypad.h from plat to mach
Date: Wed, 19 Sep 2012 14:05:49 -0700
Message-ID: <20120919210549.28074.7146.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-input-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is only used by omap1.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c     |    2 +-
 arch/arm/mach-omap1/board-fsample.c       |    2 +-
 arch/arm/mach-omap1/board-h2.c            |    2 +-
 arch/arm/mach-omap1/board-h3.c            |    2 +-
 arch/arm/mach-omap1/board-htcherald.c     |    2 +-
 arch/arm/mach-omap1/board-innovator.c     |    2 +-
 arch/arm/mach-omap1/board-nokia770.c      |    2 +-
 arch/arm/mach-omap1/board-osk.c           |    2 +-
 arch/arm/mach-omap1/board-palmte.c        |    2 +-
 arch/arm/mach-omap1/board-palmtt.c        |    2 +-
 arch/arm/mach-omap1/board-palmz71.c       |    2 +-
 arch/arm/mach-omap1/board-perseus2.c      |    2 +-
 arch/arm/mach-omap1/board-sx1.c           |    2 +-
 arch/arm/mach-omap1/include/mach/keypad.h |    0 
 drivers/input/keyboard/omap-keypad.c      |    2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename arch/arm/{plat-omap/include/plat/keypad.h => mach-omap1/include/mach/keypad.h} (100%)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index b9929cb..384f77a 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -36,7 +36,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/board-ams-delta.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <mach/mux.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 4b784f2..81c41cc 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -31,7 +31,7 @@
 #include <mach/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 124db5c..ce99021 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -42,7 +42,7 @@
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <plat/flash.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index a6f28a6..76411dd 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -42,7 +42,7 @@
 
 #include <mach/mux.h>
 #include <plat/tc.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <plat/dma.h>
 #include <plat/flash.h>
 
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 1dcb751..521a909 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -42,7 +42,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/omap7xx.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <plat/mmc.h>
 
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 0eb9881..2469811 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -35,7 +35,7 @@
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/tc.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <plat/mmc.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index fb3a6e9..bfc2b06 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -26,7 +26,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index eb108d5..eda3890 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -304,7 +304,7 @@ static struct omap_lcd_config osk_lcd_config __initdata = {
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 static struct at24_platform_data at24c04 = {
 	.byte_len	= SZ_4K / 8,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index bd27646..58ef785 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -39,7 +39,7 @@
 #include <plat/tc.h>
 #include <plat/dma.h>
 #include <plat/irda.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 8128eab..7ab487c 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -39,7 +39,7 @@
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 2367c0d..4ce3278 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -41,7 +41,7 @@
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 0d9b836..deb0b00 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -31,7 +31,7 @@
 #include <mach/mux.h>
 #include <plat/fpga.h>
 #include <plat/flash.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 1f43fe9..2f136ea 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -38,7 +38,7 @@
 #include <plat/dma.h>
 #include <plat/irda.h>
 #include <plat/tc.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 #include <plat/board-sx1.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/plat-omap/include/plat/keypad.h b/arch/arm/mach-omap1/include/mach/keypad.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/keypad.h
rename to arch/arm/mach-omap1/include/mach/keypad.h
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 8d8d45f..bee4576 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -37,7 +37,7 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
-#include <plat/keypad.h>
+#include <mach/keypad.h>
 
 #undef NEW_BOARD_LEARNING_MODE
 

