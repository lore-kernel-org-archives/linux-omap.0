From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v6 7/7] omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP board
Date: Tue, 18 May 2010 18:06:09 +0530
Message-ID: <1274186169-24056-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54208 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757556Ab0ERMga (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 08:36:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Adding the power script data for zoom board to TWL4030 platform data.
Updating the sleep/wakeup/warm_rest sequence & resource configuration
from generic script file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/Makefile                 |    9 ++++++---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f60dca3..ba3de05 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -137,14 +137,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
 					   hsmmc.o \
-					   board-zoom-debugboard.o
+					   board-zoom-debugboard.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
 					   hsmmc.o \
-					   board-zoom-debugboard.o
+					   board-zoom-debugboard.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..5c8a329 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "twl4030.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -94,6 +95,8 @@ static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.rep		= 1,
 };
 
+static struct twl4030_power_data zoom_t2scripts_data __initdata;
+
 static struct regulator_consumer_supply zoom_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -239,6 +242,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	.usb		= &zoom_usb_data,
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
+	.power		= &zoom_t2scripts_data,
 	.codec		= &zoom_codec_data,
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
@@ -279,6 +283,8 @@ static void enable_board_wakeup_source(void)
 
 void __init zoom_peripherals_init(void)
 {
+	twl4030_get_scripts(&zoom_t2scripts_data);
+
 	omap_i2c_init();
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
-- 
1.7.0.4

