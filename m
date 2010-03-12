From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v3 4/5] omap3: pm: Use generic TRITON power scripts for 3430SDP board
Date: Fri, 12 Mar 2010 21:01:55 +0530
Message-ID: <1268407915-22607-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49220 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934030Ab0CLPLx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:11:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Removed the sleep/wakeup/warm_rest sequence from the board file.
Modified the resource config structure in the board file.
Updating the sleep/wakeup/warm_rest sequence & voltsetup_time
in the board file from generic script file.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c |  112 +++++++++--------------------------
 include/linux/i2c/twl.h             |    4 +
 3 files changed, 35 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a58a1a7..94d862a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -117,7 +117,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
-					   board-sdp-flash.o
+					   board-sdp-flash.o \
+					   twl4030-script.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 23403f0..4f94b6f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -49,6 +49,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "voltage.h"
+#include "twl4030-script.h"
 #include "omap3-opp.h"
 
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
@@ -350,7 +351,6 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap_voltage_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
 	omap_init_irq();
@@ -447,93 +447,35 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
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
 static struct twl4030_resconfig twl4030_rconfig[] = {
-	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
-		.type2 = -1 },
-	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
-		.type2 = -1 },
-	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
-		.type2 = -1 },
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
 	{ 0, 0},
 };
 
 static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
-	.scripts	= twl4030_scripts,
-	.num		= ARRAY_SIZE(twl4030_scripts),
 	.resource_config = twl4030_rconfig,
 };
 
@@ -900,6 +842,10 @@ static struct omap_musb_board_data musb_board_data = {
 
 static void __init omap_3430sdp_init(void)
 {
+	twl4030_get_scripts(&sdp3430_t2scripts_data);
+	twl4030_get_vc_timings(&omap3_setuptime_table);
+	omap_voltage_init_vc(&omap3_setuptime_table);
+
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
1.6.0.4

