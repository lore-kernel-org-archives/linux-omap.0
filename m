From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 12/12] omap3630: Updating the board file to use TWL4030 scripts
Date: Fri, 18 Feb 2011 22:38:58 +0530
Message-ID: <1298048938-1480-13-git-send-email-leslyam@ti.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37920 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab1BRRJY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 12:09:24 -0500
In-Reply-To: <1298048938-1480-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Using TWL4030 power scripts to control the LDOs and DCDC regulators
while going to low power mode.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/Makefile                 |    9 ++++++---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bb11329..e6d5d27 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -191,18 +191,21 @@ obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom.o \
 					   board-zoom-display.o \
 					   board-flash.o \
 					   hsmmc.o \
-					   board-zoom-debugboard.o
+					   board-zoom-debugboard.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom.o \
 					   board-zoom-peripherals.o \
 					   board-zoom-display.o \
 					   board-flash.o \
 					   hsmmc.o \
-					   board-zoom-debugboard.o
+					   board-zoom-debugboard.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
 					   board-zoom-display.o \
 					   board-flash.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index e0e040f..f978f73 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -31,6 +31,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "twl4030.h"
 
 #define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
 #define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
@@ -341,6 +342,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	.usb		= &zoom_usb_data,
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
+	.power		= &twl4030_generic_script,
 	.codec		= &zoom_codec_data,
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
-- 
1.7.1

