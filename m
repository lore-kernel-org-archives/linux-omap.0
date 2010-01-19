From: x0080970@ti.com
Subject: [PATCH v2 6/6] omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP board
Date: Tue, 19 Jan 2010 23:06:35 +0530
Message-ID: <1263922595-13878-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51372 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab0ASRY3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 12:24:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Lesly A M <x0080970@ti.com>

omap3: pm: Use generic TRITON power scripts for ZOOM[2,3], 3630SDP board

Removed the sleep/wakeup/warm_rest sequence from the board file.
Using the api(use_generic_twl4030_script) to update
the sleep/wakeup/warm_rest sequence & voltsetup_time in the board file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

---
 arch/arm/mach-omap2/Makefile                 |    9 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |   82 ++-------------------------
 2 files changed, 13 insertions(+), 78 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/Makefile	2010-01-19 21:00:26.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/Makefile	2010-01-19 21:00:26.000000000 +0530
@@ -99,14 +99,17 @@
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
-					   board-zoom-debugboard.o
+					   board-zoom-debugboard.o \
+					   twl4030-script.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
-					   board-zoom-debugboard.o
+					   board-zoom-debugboard.o \
+					   twl4030-script.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
-					   mmc-twl4030.o
+					   mmc-twl4030.o \
+					   twl4030-script.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom-peripherals.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom-peripherals.c	2010-01-19 21:00:25.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-zoom-peripherals.c	2010-01-19 21:11:01.000000000 +0530
@@ -26,6 +26,7 @@
 
 #include "mux.h"
 #include "mmc-twl4030.h"
+#include "twl4030-script.h"
 #include "pm.h"
 
 /* Zoom2 has Qwerty keyboard*/
@@ -95,78 +96,6 @@
 	.rep		= 1,
 };
 
-static struct twl4030_ins __initdata sleep_on_seq[] = {
-	/* Broadcast message to put res to sleep */
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
-							RES_STATE_SLEEP), 2},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
-							RES_STATE_SLEEP), 2},
-};
-
-static struct twl4030_script sleep_on_script __initdata = {
-	.script	= sleep_on_seq,
-	.size	= ARRAY_SIZE(sleep_on_seq),
-	.flags	= TWL4030_SLEEP_SCRIPT,
-};
-
-static struct twl4030_ins wakeup_p12_seq[] __initdata = {
-	/* Broadcast message to put res to active */
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
-							RES_STATE_ACTIVE), 2},
-};
-
-static struct twl4030_script wakeup_p12_script __initdata = {
-	.script	= wakeup_p12_seq,
-	.size	= ARRAY_SIZE(wakeup_p12_seq),
-	.flags	= TWL4030_WAKEUP12_SCRIPT,
-};
-
-static struct twl4030_ins wakeup_p3_seq[] __initdata = {
-	/* Broadcast message to put res to active */
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
-							RES_STATE_ACTIVE), 2},
-};
-
-static struct twl4030_script wakeup_p3_script __initdata = {
-	.script = wakeup_p3_seq,
-	.size   = ARRAY_SIZE(wakeup_p3_seq),
-	.flags  = TWL4030_WAKEUP3_SCRIPT,
-};
-
-static struct twl4030_ins wrst_seq[] __initdata = {
-/*
- * Reset twl4030.
- * Reset Main_Ref.
- * Reset All type2_group2.
- * Reset VUSB_3v1.
- * Reset All type2_group1.
- * Reset RC.
- * Reenable twl4030.
- */
-	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), 2},
-	{MSG_SINGULAR(DEV_GRP_NULL, RES_Main_Ref, RES_STATE_WRST), 2},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
-							RES_STATE_WRST), 2},
-	{MSG_SINGULAR(DEV_GRP_NULL, RES_VUSB_3V1, RES_STATE_WRST), 2},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
-							RES_STATE_WRST), 2},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
-							RES_STATE_WRST), 2},
-	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE), 2},
-};
-static struct twl4030_script wrst_script __initdata = {
-	.script = wrst_seq,
-	.size   = ARRAY_SIZE(wrst_seq),
-	.flags  = TWL4030_WRST_SCRIPT,
-};
-
-static struct twl4030_script *twl4030_scripts[] __initdata = {
-	&sleep_on_script,
-	&wakeup_p12_script,
-	&wakeup_p3_script,
-	&wrst_script,
-};
-
 static struct twl4030_resconfig twl4030_rconfig[] = {
 	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1, .type = 3,
 		.type2 = 1, .remap_sleep = RES_STATE_OFF },
@@ -196,8 +125,6 @@
 };
 
 static struct twl4030_power_data zoom_t2scripts_data __initdata = {
-	.scripts	= twl4030_scripts,
-	.num		= ARRAY_SIZE(twl4030_scripts),
 	.resource_config = twl4030_rconfig,
 };
 
@@ -381,9 +308,14 @@
 
 void __init zoom_peripherals_init(void *peripheral_data)
 {
+	struct prm_setup_vc *omap3_setuptime =
+				(struct prm_setup_vc *)peripheral_data;
+
+	use_generic_twl4030_script(&zoom_t2scripts_data , omap3_setuptime);
+
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
 	enable_board_wakeup_source();
-	omap3_pm_init_vc((struct prm_setup_vc *)peripheral_data);
+	omap3_pm_init_vc(omap3_setuptime);
 }
