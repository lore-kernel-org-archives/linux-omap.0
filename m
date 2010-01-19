From: x0080970@ti.com
Subject: [PATCH v2 5/6] omap3: pm: Use generic TRITON power scripts for OMAP3430 board
Date: Tue, 19 Jan 2010 23:06:25 +0530
Message-ID: <1263922585-13854-1-git-send-email-x0080970@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51362 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab0ASRYQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 12:24:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Lesly A M <x0080970@ti.com>

omap3: pm: Use generic TRITON power scripts for OMAP3430 board

Removed the sleep/wakeup/warm_rest sequence from the board file.
Using the api(use_generic_twl4030_script) to update
the sleep/wakeup/warm_rest sequence & voltsetup_time in the board file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>

---
 arch/arm/mach-omap2/Makefile        |    3 -
 arch/arm/mach-omap2/board-3430sdp.c |   79 +-----------------------------------
 2 files changed, 6 insertions(+), 76 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/Makefile	2010-01-19 20:59:58.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/Makefile	2010-01-19 21:14:14.000000000 +0530
@@ -89,7 +89,8 @@
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
-					   mmc-twl4030.o
+					   mmc-twl4030.o \
+					   twl4030-script.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
Index: linux-omap-pm/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/board-3430sdp.c	2010-01-19 21:00:25.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/board-3430sdp.c	2010-01-19 21:15:38.000000000 +0530
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
+#include "twl4030-script.h"
 #include "pm.h"
 #include "omap3-opp.h"
 
@@ -446,79 +447,6 @@
 	.irq_line	= 1,
 };
 
-
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
@@ -548,8 +476,6 @@
 };
 
 static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
-	.scripts	= twl4030_scripts,
-	.num		= ARRAY_SIZE(twl4030_scripts),
 	.resource_config = twl4030_rconfig,
 };
 
@@ -806,6 +732,9 @@
 
 static void __init omap_3430sdp_init(void)
 {
+	use_generic_twl4030_script(&sdp3430_t2scripts_data,
+				&omap3_setuptime_table);
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
