From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v5 5/5] omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP board
Date: Mon, 19 Apr 2010 17:13:45 +0530
Message-ID: <1271677425-2191-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40780 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab0DSLWt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 07:22:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Adding the power script data for zoom board to TWL4030 platform data.
Updating the sleep/wakeup/warm_rest sequence & voltsetup_time
from generic script file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/Makefile                 |    9 ++++--
 arch/arm/mach-omap2/board-zoom-peripherals.c |   36 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

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
index 6b39849..ce3ff8b 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "twl4030.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -94,6 +95,38 @@ static struct twl4030_keypad_data zoom_kp_twl4030_data = {
 	.rep		= 1,
 };
 
+static struct twl4030_resconfig twl4030_rconfig[] = {
+	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1, .type = 3,
+		.type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1,
+		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1,
+		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
+	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
+		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
+		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3,
+		.type = 0, .type2 = 2, .remap_sleep = RES_STATE_SLEEP },
+	{ 0, 0},
+};
+
+static struct twl4030_power_data zoom_t2scripts_data __initdata = {
+	.resource_config = twl4030_rconfig,
+};
+
 static struct regulator_consumer_supply zoom_vmmc1_supply = {
 	.supply		= "vmmc",
 };
@@ -239,6 +272,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	.usb		= &zoom_usb_data,
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
+	.power		= &zoom_t2scripts_data,
 	.codec		= &zoom_codec_data,
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
@@ -279,6 +313,8 @@ static void enable_board_wakeup_source(void)
 
 void __init zoom_peripherals_init(void)
 {
+	twl4030_get_scripts(&zoom_t2scripts_data);
+
 	omap_i2c_init();
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
-- 
1.6.0.4

