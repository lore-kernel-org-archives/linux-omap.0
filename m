From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 2/4] omap: use common initialization for PMIC i2c bus
Date: Mon, 25 Apr 2011 01:09:06 +0300
Message-ID: <25a0570058487a07e86cc88486a0c975e7cc0c69.1303682352.git.mike@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43912
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757876Ab1DXWCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 24 Apr 2011 18:02:22 -0400
In-Reply-To: <cover.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

Introduce omap_pmic_init that registers i2c bus and PMIC device on that
bus and add omap2/3/4 wrappers for common cases.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-2430sdp.c          |   13 ++-----------
 arch/arm/mach-omap2/board-3430sdp.c          |   12 +-----------
 arch/arm/mach-omap2/board-4430sdp.c          |   16 ++--------------
 arch/arm/mach-omap2/board-cm-t35.c           |   12 +-----------
 arch/arm/mach-omap2/board-devkit8000.c       |   12 +-----------
 arch/arm/mach-omap2/board-igep0020.c         |   15 ++-------------
 arch/arm/mach-omap2/board-igep0030.c         |   13 ++-----------
 arch/arm/mach-omap2/board-ldp.c              |   12 +-----------
 arch/arm/mach-omap2/board-omap3beagle.c      |   13 ++-----------
 arch/arm/mach-omap2/board-omap3evm.c         |   21 +++------------------
 arch/arm/mach-omap2/board-omap3logic.c       |   13 ++-----------
 arch/arm/mach-omap2/board-omap3pandora.c     |   12 +-----------
 arch/arm/mach-omap2/board-omap3stalker.c     |   21 +++------------------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   12 +-----------
 arch/arm/mach-omap2/board-omap4panda.c       |   17 ++---------------
 arch/arm/mach-omap2/board-overo.c            |   12 +-----------
 arch/arm/mach-omap2/board-rm680.c            |   13 ++-----------
 arch/arm/mach-omap2/board-rx51-peripherals.c |   13 ++-----------
 arch/arm/mach-omap2/board-zoom-peripherals.c |   13 ++-----------
 arch/arm/mach-omap2/common-board-devices.c   |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h   |   24 ++++++++++++++++++++++++
 21 files changed, 78 insertions(+), 232 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 1fa6bb8..99b3f2d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -41,6 +41,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define SDP2430_CS0_BASE	0x04000000
 #define SECONDARY_LCD_GPIO		147
@@ -180,15 +181,6 @@ static struct twl4030_platform_data sdp2430_twldata = {
 	.vmmc1		= &sdp2430_vmmc1,
 };
 
-static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_24XX_SYS_NIRQ,
-		.platform_data = &sdp2430_twldata,
-	},
-};
-
 static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2D),
@@ -201,8 +193,7 @@ static int __init omap2430_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
-	omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
-			ARRAY_SIZE(sdp2430_i2c_boardinfo));
+	omap2_pmic_init("twl4030", &sdp2430_twldata);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 3726465..b12400e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -528,20 +528,10 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.vpll2		= &sdp3430_vpll2,
 };
 
-static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &sdp3430_twldata,
-	},
-};
-
 static int __init omap3430_i2c_init(void)
 {
 	/* i2c1 for PMIC only */
-	omap_register_i2c_bus(1, 2600, sdp3430_i2c_boardinfo,
-			ARRAY_SIZE(sdp3430_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &sdp3430_twldata);
 	/* i2c2 on camera connector (for sensor control) and optional isp1301 */
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/* i2c3 on display connector (for DVI, tfp410) */
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..7073542 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -42,6 +42,7 @@
 #include "hsmmc.h"
 #include "timer-gp.h"
 #include "control.h"
+#include "common-board-devices.h"
 
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
@@ -575,14 +576,6 @@ static struct twl4030_platform_data sdp4430_twldata = {
 	.usb		= &omap4_usbphy_data
 };
 
-static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl6030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = OMAP44XX_IRQ_SYS_1N,
-		.platform_data = &sdp4430_twldata,
-	},
-};
 static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tmp105", 0x48),
@@ -598,12 +591,7 @@ static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
 };
 static int __init omap4_i2c_init(void)
 {
-	/*
-	 * Phoenix Audio IC needs I2C1 to
-	 * start with 400 KHz or less
-	 */
-	omap_register_i2c_bus(1, 400, sdp4430_i2c_boardinfo,
-			ARRAY_SIZE(sdp4430_i2c_boardinfo));
+	omap4_pmic_init("twl6030", &sdp4430_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
 				ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 9e5b8be..1a9e6be 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -539,19 +539,9 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.vpll2		= &cm_t35_vpll2,
 };
 
-static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("tps65930", 0x48),
-		.flags		= I2C_CLIENT_WAKE,
-		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &cm_t35_twldata,
-	},
-};
-
 static void __init cm_t35_init_i2c(void)
 {
-	omap_register_i2c_bus(1, 2600, cm_t35_i2c_boardinfo,
-			      ARRAY_SIZE(cm_t35_i2c_boardinfo));
+	omap3_pmic_init("tps65930", &cm_t35_twldata);
 }
 
 static void __init cm_t35_init_early(void)
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 9f8338d..983f44b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -366,19 +366,9 @@ static struct twl4030_platform_data devkit8000_twldata = {
 	.keypad		= &devkit8000_kp_data,
 };
 
-static struct i2c_board_info __initdata devkit8000_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("tps65930", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &devkit8000_twldata,
-	},
-};
-
 static int __init devkit8000_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, devkit8000_i2c_boardinfo,
-			ARRAY_SIZE(devkit8000_i2c_boardinfo));
+	omap3_pmic_init("tps65930", &devkit8000_twldata);
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 400, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5b9bde7..a0fd10e 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -38,6 +38,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "sdram-numonyx-m65kxxxxam.h"
+#include "common-board-devices.h"
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
@@ -536,15 +537,6 @@ static struct twl4030_platform_data igep2_twldata = {
 	.vio		= &igep2_vio,
 };
 
-static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags		= I2C_CLIENT_WAKE,
-		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &igep2_twldata,
-	},
-};
-
 static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("eeprom", 0x50),
@@ -555,10 +547,7 @@ static void __init igep2_i2c_init(void)
 {
 	int ret;
 
-	ret = omap_register_i2c_bus(1, 2600, igep2_i2c1_boardinfo,
-		ARRAY_SIZE(igep2_i2c1_boardinfo));
-	if (ret)
-		pr_warning("IGEP2: Could not register I2C1 bus (%d)\n", ret);
+	omap3_pmic_init("twl4030", &igep2_twldata);
 
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index 2cf86c3..a831e85 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -35,6 +35,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "sdram-numonyx-m65kxxxxam.h"
+#include "common-board-devices.h"
 
 #define IGEP3_GPIO_LED0_GREEN	54
 #define IGEP3_GPIO_LED0_RED	53
@@ -349,19 +350,9 @@ static struct twl4030_platform_data igep3_twl4030_pdata = {
 	.vio		= &igep3_vio,
 };
 
-static struct i2c_board_info __initdata igep3_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags		= I2C_CLIENT_WAKE,
-		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &igep3_twl4030_pdata,
-	},
-};
-
 static int __init igep3_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, igep3_i2c_boardinfo,
-			ARRAY_SIZE(igep3_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &igep3_twl4030_pdata);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 155b423..7482c75 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -265,19 +265,9 @@ static struct twl4030_platform_data ldp_twldata = {
 	.keypad		= &ldp_kp_twl4030_data,
 };
 
-static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &ldp_twldata,
-	},
-};
-
 static int __init omap_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, ldp_i2c_boardinfo,
-			ARRAY_SIZE(ldp_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &ldp_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 33007fd..13a1664 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -52,6 +52,7 @@
 #include "hsmmc.h"
 #include "timer-gp.h"
 #include "pm.h"
+#include "common-board-devices.h"
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
@@ -453,15 +454,6 @@ static struct twl4030_platform_data beagle_twldata = {
 	.vpll2		= &beagle_vpll2,
 };
 
-static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &beagle_twldata,
-	},
-};
-
 static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
        {
                I2C_BOARD_INFO("eeprom", 0x50),
@@ -470,8 +462,7 @@ static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
 
 static int __init omap3_beagle_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
-			ARRAY_SIZE(beagle_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &beagle_twldata);
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 376ea87..5066b0b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -604,28 +604,13 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.vdac		= &omap3_evm_vdac,
 	.vpll2		= &omap3_evm_vpll2,
 	.vio		= &omap3evm_vio,
-};
-
-static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &omap3evm_twldata,
-	},
+	.vmmc1		= &omap3evm_vmmc1,
+	.vsim		= &omap3evm_vsim,
 };
 
 static int __init omap3_evm_i2c_init(void)
 {
-	/*
-	 * REVISIT: These entries can be set in omap3evm_twl_data
-	 * after a merge with MFD tree
-	 */
-	omap3evm_twldata.vmmc1 = &omap3evm_vmmc1;
-	omap3evm_twldata.vsim = &omap3evm_vsim;
-
-	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
-			ARRAY_SIZE(omap3evm_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &omap3evm_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index a49e6cf..60d9be4 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -37,6 +37,7 @@
 #include "hsmmc.h"
 #include "timer-gp.h"
 #include "control.h"
+#include "common-board-devices.h"
 
 #include <plat/mux.h>
 #include <plat/board.h>
@@ -93,19 +94,9 @@ static struct twl4030_platform_data omap3logic_twldata = {
 	.vmmc1		= &omap3logic_vmmc1,
 };
 
-static struct i2c_board_info __initdata omap3logic_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &omap3logic_twldata,
-	},
-};
-
 static int __init omap3logic_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, omap3logic_i2c_boardinfo,
-				ARRAY_SIZE(omap3logic_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &omap3logic_twldata);
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 517701a..b99cc64 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -544,15 +544,6 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.bci		= &pandora_bci_data,
 };
 
-static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("tps65950", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &omap3pandora_twldata,
-	},
-};
-
 static struct i2c_board_info __initdata omap3pandora_i2c3_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("bq27500", 0x55),
@@ -562,8 +553,7 @@ static struct i2c_board_info __initdata omap3pandora_i2c3_boardinfo[] = {
 
 static int __init omap3pandora_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
-			ARRAY_SIZE(omap3pandora_i2c_boardinfo));
+	omap3_pmic_init("tps65950", &omap3pandora_twldata);
 	/* i2c2 pins are not connected */
 	omap_register_i2c_bus(3, 100, omap3pandora_i2c3_boardinfo,
 			ARRAY_SIZE(omap3pandora_i2c3_boardinfo));
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 671ceb0..a1d550f 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -455,15 +455,8 @@ static struct twl4030_platform_data omap3stalker_twldata = {
 	.codec		= &omap3stalker_codec_data,
 	.vdac		= &omap3_stalker_vdac,
 	.vpll2		= &omap3_stalker_vpll2,
-};
-
-static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo[] = {
-	{
-	 I2C_BOARD_INFO("twl4030", 0x48),
-	 .flags		= I2C_CLIENT_WAKE,
-	 .irq		= INT_34XX_SYS_NIRQ,
-	 .platform_data	= &omap3stalker_twldata,
-	 },
+	.vmmc1		= &omap3stalker_vmmc1,
+	.vsim		= &omap3stalker_vsim,
 };
 
 static struct at24_platform_data fram_info = {
@@ -482,15 +475,7 @@ static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo3[] = {
 
 static int __init omap3_stalker_i2c_init(void)
 {
-	/*
-	 * REVISIT: These entries can be set in omap3evm_twl_data
-	 * after a merge with MFD tree
-	 */
-	omap3stalker_twldata.vmmc1 = &omap3stalker_vmmc1;
-	omap3stalker_twldata.vsim = &omap3stalker_vsim;
-
-	omap_register_i2c_bus(1, 2600, omap3stalker_i2c_boardinfo,
-			      ARRAY_SIZE(omap3stalker_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &omap3stalker_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, omap3stalker_i2c_boardinfo3,
 			      ARRAY_SIZE(omap3stalker_i2c_boardinfo3));
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 15f9d7d..0a9b329 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -274,15 +274,6 @@ static struct twl4030_platform_data touchbook_twldata = {
 	.vpll2		= &touchbook_vpll2,
 };
 
-static struct i2c_board_info __initdata touchbook_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl4030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &touchbook_twldata,
-	},
-};
-
 static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("bq27200", 0x55),
@@ -292,8 +283,7 @@ static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] = {
 static int __init omap3_touchbook_i2c_init(void)
 {
 	/* Standard TouchBook bus */
-	omap_register_i2c_bus(1, 2600, touchbook_i2c_boardinfo,
-			ARRAY_SIZE(touchbook_i2c_boardinfo));
+	omap3_pmic_init("twl4030", &touchbook_twldata);
 
 	/* Additional TouchBook bus */
 	omap_register_i2c_bus(3, 100, touchBook_i2c_boardinfo,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index f3a7b10..7eaad62 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -46,6 +46,7 @@
 #include "hsmmc.h"
 #include "control.h"
 #include "mux.h"
+#include "common-board-devices.h"
 
 #define GPIO_HUB_POWER		1
 #define GPIO_HUB_NRESET		62
@@ -408,15 +409,6 @@ static struct twl4030_platform_data omap4_panda_twldata = {
 	.usb		= &omap4_usbphy_data,
 };
 
-static struct i2c_board_info __initdata omap4_panda_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl6030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = OMAP44XX_IRQ_SYS_1N,
-		.platform_data = &omap4_panda_twldata,
-	},
-};
-
 /*
  * Display monitor features are burnt in their EEPROM as EDID data. The EEPROM
  * is connected as I2C slave device, and can be accessed at address 0x50
@@ -429,12 +421,7 @@ static struct i2c_board_info __initdata panda_i2c_eeprom[] = {
 
 static int __init omap4_panda_i2c_init(void)
 {
-	/*
-	 * Phoenix Audio IC needs I2C1 to
-	 * start with 400 KHz or less
-	 */
-	omap_register_i2c_bus(1, 400, omap4_panda_i2c_boardinfo,
-			ARRAY_SIZE(omap4_panda_i2c_boardinfo));
+	omap4_pmic_init("twl6030", &omap4_panda_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index abe4f14..d0621dc 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -538,19 +538,9 @@ static struct twl4030_platform_data overo_twldata = {
 	.vpll2		= &overo_vpll2,
 };
 
-static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("tps65950", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &overo_twldata,
-	},
-};
-
 static int __init overo_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2600, overo_i2c_boardinfo,
-			ARRAY_SIZE(overo_i2c_boardinfo));
+	omap3_pmic_init("tps65950", &overo_twldata);
 	/* i2c2 pins are used for gpio */
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 2af8b05..8e710ff 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -31,6 +31,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "sdram-nokia.h"
+#include "common-board-devices.h"
 
 static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
@@ -90,19 +91,9 @@ static struct twl4030_platform_data rm680_twl_data = {
 	/* add rest of the children here */
 };
 
-static struct i2c_board_info __initdata rm680_twl_i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("twl5031", 0x48),
-		.flags		= I2C_CLIENT_WAKE,
-		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &rm680_twl_data,
-	},
-};
-
 static void __init rm680_i2c_init(void)
 {
-	omap_register_i2c_bus(1, 2900, rm680_twl_i2c_board_info,
-				ARRAY_SIZE(rm680_twl_i2c_board_info));
+	omap_pmic_init(1, 2900, "twl5031", INT_34XX_SYS_NIRQ, &rm680_twl_data);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 }
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bbcb677..a5bf5e9 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -43,6 +43,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define SYSTEM_REV_B_USES_VAUX3	0x1699
 #define SYSTEM_REV_S_USES_VAUX3 0x8
@@ -777,15 +778,6 @@ static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata_or_module =
 	.power_gpio		= 98,
 };
 
-static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
-	{
-		I2C_BOARD_INFO("twl5030", 0x48),
-		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
-		.platform_data = &rx51_twldata,
-	},
-};
-
 /* Audio setup data */
 static struct aic3x_setup_data rx51_aic34_setup = {
 	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
@@ -833,8 +825,7 @@ static int __init rx51_i2c_init(void)
 		rx51_twldata.vaux3 = &rx51_vaux3_cam;
 	}
 	rx51_twldata.vmmc2 = &rx51_vmmc2;
-	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
-			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
+	omap_pmic_init(1, 2200, "twl5030", INT_34XX_SYS_NIRQ, &rx51_twldata);
 	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
 			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_2));
 	omap_register_i2c_bus(3, 400, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 8dee754..e4870c2 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -31,6 +31,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
 #define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
@@ -349,15 +350,6 @@ static struct twl4030_platform_data zoom_twldata = {
 	.vdac		= &zoom_vdac,
 };
 
-static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("twl5030", 0x48),
-		.flags		= I2C_CLIENT_WAKE,
-		.irq		= INT_34XX_SYS_NIRQ,
-		.platform_data	= &zoom_twldata,
-	},
-};
-
 static int __init omap_i2c_init(void)
 {
 	if (machine_is_omap_zoom2()) {
@@ -365,8 +357,7 @@ static int __init omap_i2c_init(void)
 		zoom_audio_data.hs_extmute = 1;
 		zoom_audio_data.set_hs_extmute = zoom2_set_hs_extmute;
 	}
-	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
-			ARRAY_SIZE(zoom_i2c_boardinfo));
+	omap_pmic_init(1, 2400, "twl5030", INT_34XX_SYS_NIRQ, &zoom_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index fad41ec..cea31dd 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -20,14 +20,35 @@
  *
  */
 
+#include <linux/i2c.h>
+#include <linux/i2c/twl.h>
+
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
+#include <plat/i2c.h>
 #include <plat/mcspi.h>
 
 #include "common-board-devices.h"
 
+static struct i2c_board_info __initdata pmic_i2c_board_info = {
+	.addr		= 0x48,
+	.flags		= I2C_CLIENT_WAKE,
+};
+
+void __init omap_pmic_init(int bus, u32 clkrate,
+			   const char *pmic_type, int pmic_irq,
+			   struct twl4030_platform_data *pmic_data)
+{
+	strncpy(pmic_i2c_board_info.type, pmic_type,
+		sizeof(pmic_i2c_board_info.type));
+	pmic_i2c_board_info.irq = pmic_irq;
+	pmic_i2c_board_info.platform_data = pmic_data;
+
+	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
+}
+
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index 75f9248d..0ec3e07 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -1,6 +1,30 @@
 #ifndef __OMAP_COMMON_BOARD_DEVICES__
 #define __OMAP_COMMON_BOARD_DEVICES__
 
+struct twl4030_platform_data;
+
+void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
+		    struct twl4030_platform_data *pmic_data);
+
+static inline void omap2_pmic_init(const char *pmic_type,
+				   struct twl4030_platform_data *pmic_data)
+{
+	omap_pmic_init(2, 2600, pmic_type, INT_24XX_SYS_NIRQ, pmic_data);
+}
+
+static inline void omap3_pmic_init(const char *pmic_type,
+				   struct twl4030_platform_data *pmic_data)
+{
+	omap_pmic_init(1, 2600, pmic_type, INT_34XX_SYS_NIRQ, pmic_data);
+}
+
+static inline void omap4_pmic_init(const char *pmic_type,
+				   struct twl4030_platform_data *pmic_data)
+{
+	/* Phoenix Audio IC needs I2C1 to start with 400 KHz or less */
+	omap_pmic_init(1, 400, pmic_type, OMAP44XX_IRQ_SYS_1N, pmic_data);
+}
+
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 struct ads7846_platform_data;
-- 
1.7.3.1

