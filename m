From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v8 6/7] omap3430: Updating the board file to use TWL4030 scripts
Date: Wed,  2 Mar 2011 19:00:52 +0530
Message-ID: <1299072653-13414-7-git-send-email-leslyam@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46330 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1CBNbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 08:31:10 -0500
In-Reply-To: <1299072653-13414-1-git-send-email-leslyam@ti.com>
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
 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c |   93 +----------------------------------
 2 files changed, 4 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 742ca67..bb11329 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -175,7 +175,8 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
-					   board-flash.o
+					   board-flash.o \
+					   twl4030.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
 					   sdram-nokia.o \
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 813893b..a0bb530 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
+#include "twl4030.h"
 #include "pm.h"
 #include "control.h"
 
@@ -425,96 +426,6 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
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
-
 /*
  * Apply all the fixed voltages since most versions of U-Boot
  * don't bother with that initialization.
@@ -673,8 +584,8 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.gpio		= &sdp3430_gpio_data,
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
-	.power		= &sdp3430_t2scripts_data,
 	.usb		= &sdp3430_usb_data,
+	.power		= &twl4030_generic_script,
 	.codec		= &sdp3430_codec,
 
 	.vaux1		= &sdp3430_vaux1,
-- 
1.7.1

