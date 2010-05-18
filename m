From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v6 6/7] omap3: pm: Use generic TRITON power scripts for 3430SDP board
Date: Tue, 18 May 2010 18:06:00 +0530
Message-ID: <1274186160-24024-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757539Ab0ERMgX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 08:36:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch will removed the sleep/wakeup/warm_rest sequence & resource configuration
from the 3430SDP board file and use the generic script.

Updating the sleep/wakeup/warm_rest sequence & resource configuration in the
board file from generic script file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c |   92 +---------------------------------
 include/linux/i2c/twl.h             |    4 ++
 3 files changed, 9 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 184badd..f60dca3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -127,7 +127,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
-					   board-sdp-flash.o
+					   board-sdp-flash.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c7f0fa8..91d8cc6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
+#include "twl4030.h"
 #include "pm.h"
 #include "omap3-opp.h"
 #include "smartreflex-class3.h"
@@ -424,95 +425,7 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 	.irq_line	= 1,
 };
 
-
-static struct twl4030_ins __initdata sleep_on_seq[] = {
-	/* Turn off HFCLKOUT */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 2},
-	/* Turn OFF VDD1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 2},
-	/* Turn OFF VDD2 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
-	/* Turn OFF VPLL1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 2},
-};
-
-static struct twl4030_script sleep_on_script __initdata = {
-	.script	= sleep_on_seq,
-	.size	= ARRAY_SIZE(sleep_on_seq),
-	.flags	= TWL4030_SLEEP_SCRIPT,
-};
-
-static struct twl4030_ins wakeup_p12_seq[] __initdata = {
-	/* Turn on HFCLKOUT */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
-	/* Turn ON VDD1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 2},
-	/* Turn ON VDD2 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
-	/* Turn ON VPLL1 */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 2},
-};
-
-static struct twl4030_script wakeup_p12_script __initdata = {
-	.script	= wakeup_p12_seq,
-	.size	= ARRAY_SIZE(wakeup_p12_seq),
-	.flags	= TWL4030_WAKEUP12_SCRIPT,
-};
-
-static struct twl4030_ins wakeup_p3_seq[] __initdata = {
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
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
- * Reset VDD1 regulator.
- * Reset VDD2 regulator.
- * Reset VPLL1 regulator.
- * Enable sysclk output.
- * Reenable twl4030.
- */
-	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
-	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
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
-static struct twl4030_resconfig twl4030_rconfig[] = {
-	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
-		.type2 = -1 },
-	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
-		.type2 = -1 },
-	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
-		.type2 = -1 },
-	{ 0, 0},
-};
-
-static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
-	.scripts	= twl4030_scripts,
-	.num		= ARRAY_SIZE(twl4030_scripts),
-	.resource_config = twl4030_rconfig,
-};
+static struct twl4030_power_data sdp3430_t2scripts_data __initdata;
 
 /*
  * Apply all the fixed voltages since most versions of U-Boot
@@ -877,6 +790,7 @@ static struct omap_musb_board_data musb_board_data = {
 
 static void __init omap_3430sdp_init(void)
 {
+	twl4030_get_scripts(&sdp3430_t2scripts_data);
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3430_i2c_init();
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index fb6784e..2e00e83 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -371,6 +371,7 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 #define DEV_GRP_P1		0x1	/* P1: all OMAP devices */
 #define DEV_GRP_P2		0x2	/* P2: all Modem devices */
 #define DEV_GRP_P3		0x4	/* P3: all peripheral devices */
+#define DEV_GRP_ALL		0x7	/* P1/P2/P3: all devices */
 
 /* Resource groups */
 #define RES_GRP_RES		0x0	/* Reserved */
@@ -383,7 +384,10 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 #define RES_GRP_ALL		0x7	/* All resource groups */
 
 #define RES_TYPE2_R0		0x0
+#define RES_TYPE2_R1		0x1
+#define RES_TYPE2_R2		0x2
 
+#define RES_TYPE_R0		0x0
 #define RES_TYPE_ALL		0x7
 
 /* Resource states */
-- 
1.7.0.4

