From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 3/6] Regulator: Use common regulator supplies and init data structs
Date: Fri,  8 Jan 2010 23:27:59 +0530
Message-ID: <1262973479-32570-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36101 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0AHR6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:58:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Common TWL4030 specific regulator supplies and init data structs are
used instead of platform specific ones. Only one copy of the common
structs will be included in the image, built for multiple OMAP3 based
platforms.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |   32 +++++++++++++++++--------
 arch/arm/mach-omap2/board-cm-t35.c           |   14 ++++++++---
 arch/arm/mach-omap2/board-igep0020.c         |    7 ++++-
 arch/arm/mach-omap2/board-ldp.c              |    7 ++++-
 arch/arm/mach-omap2/board-omap3beagle.c      |   14 ++++++++---
 arch/arm/mach-omap2/board-omap3evm.c         |   25 +++++++++++++-------
 arch/arm/mach-omap2/board-omap3pandora.c     |   14 ++++++++---
 arch/arm/mach-omap2/board-omap3touchbook.c   |   14 ++++++++---
 arch/arm/mach-omap2/board-overo.c            |    8 +++++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |   21 +++++++++++-----
 10 files changed, 108 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2951029..b1267eb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -55,6 +55,18 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vmmc2_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+
+extern struct regulator_init_data vaux1_data;
+extern struct regulator_init_data vaux2_data;
+extern struct regulator_init_data vaux3_data;
+extern struct regulator_init_data vaux4_data;
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vmmc2_data;
+extern struct regulator_init_data vsim_data;
+
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -356,9 +368,9 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	 */
-	sdp3430_vmmc1_supply.dev = mmc[0].dev;
-	sdp3430_vsim_supply.dev = mmc[0].dev;
-	sdp3430_vmmc2_supply.dev = mmc[1].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc2_supply.dev = mmc[1].dev;
 
 	/* gpio + 7 is "sub_lcd_en_bkl" (output/PWM1) */
 	gpio_request(gpio + 7, "sub_lcd_en_bkl");
@@ -451,13 +463,13 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.usb		= &sdp3430_usb_data,
 	.codec		= &sdp3430_codec,
 
-	.vaux1		= &sdp3430_vaux1,
-	.vaux2		= &sdp3430_vaux2,
-	.vaux3		= &sdp3430_vaux3,
-	.vaux4		= &sdp3430_vaux4,
-	.vmmc1		= &sdp3430_vmmc1,
-	.vmmc2		= &sdp3430_vmmc2,
-	.vsim		= &sdp3430_vsim,
+	.vaux1		= &vaux1_data,
+	.vaux2		= &vaux2_data,
+	.vaux3		= &vaux3_data,
+	.vaux4		= &vaux4_data,
+	.vmmc1		= &vmmc1_data,
+	.vmmc2		= &vmmc2_data,
+	.vsim		= &vsim_data,
 	.vdac		= &sdp3430_vdac,
 	.vpll2		= &sdp3430_vpll2,
 };
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index b0a5a68..282d188 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -59,6 +59,12 @@
 #define GPMC_CS0_BASE		0x60
 #define GPMC_CS0_BASE_ADDR	(OMAP34XX_GPMC_VIRT + GPMC_CS0_BASE)
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vsim_data;
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <linux/smsc911x.h>
 
@@ -378,8 +384,8 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	cm_t35_vmmc1_supply.dev = mmc[0].dev;
-	cm_t35_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/* setup USB with proper PHY reset GPIOs */
 	ehci_pdata.reset_gpio_port[0] = gpio + 6;
@@ -405,8 +411,8 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.keypad		= &cm_t35_kp_data,
 	.usb		= &cm_t35_usb_data,
 	.gpio		= &cm_t35_gpio_data,
-	.vmmc1		= &cm_t35_vmmc1,
-	.vsim		= &cm_t35_vsim,
+	.vmmc1		= &vmmc1_data,
+	.vsim		= &vsim_data,
 };
 
 static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 631b179..155a17f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -39,6 +39,9 @@
 #define IGEP2_GPIO_LED0_GREEN 	27
 #define IGEP2_GPIO_LED1_RED   	28
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_init_data vmmc1_data;
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
 #include <linux/smsc911x.h>
@@ -128,7 +131,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	*/
-	igep2_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
 
 	return 0;
 };
@@ -161,7 +164,7 @@ static struct twl4030_platform_data igep2_twldata = {
 	/* platform_data for children goes here */
 	.usb		= &igep2_usb_data,
 	.gpio		= &igep2_gpio_data,
-	.vmmc1          = &igep2_vmmc1,
+	.vmmc1          = &vmmc1_data,
 
 };
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 6740d79..d69b3d0 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -51,6 +51,9 @@
 #define DEBUG_BASE		0x08000000
 #define LDP_ETHR_START		DEBUG_BASE
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_init_data vmmc1_data;
+
 static struct resource ldp_smsc911x_resources[] = {
 	[0] = {
 		.start	= LDP_ETHR_START,
@@ -317,7 +320,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	/* platform_data for children goes here */
 	.madc		= &ldp_madc_data,
 	.usb		= &ldp_usb_data,
-	.vmmc1		= &ldp_vmmc1,
+	.vmmc1		= &vmmc1_data,
 	.gpio		= &ldp_gpio_data,
 	.keypad		= &ldp_kp_twl4030_data,
 };
@@ -379,7 +382,7 @@ static void __init omap_ldp_init(void)
 
 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
-	ldp_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ebbacf8..c7610cb 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -52,6 +52,12 @@
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vsim_data;
+
 static struct mtd_partition omap3beagle_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -142,8 +148,8 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	beagle_vmmc1_supply.dev = mmc[0].dev;
-	beagle_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -233,8 +239,8 @@ static struct twl4030_platform_data beagle_twldata = {
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
 	.codec		= &beagle_codec_data,
-	.vmmc1		= &beagle_vmmc1,
-	.vsim		= &beagle_vsim,
+	.vmmc1		= &vmmc1_data,
+	.vsim		= &vsim_data,
 	.vdac		= &beagle_vdac,
 	.vpll2		= &beagle_vpll2,
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 93db546..573d8c7 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -58,6 +58,16 @@
 
 static u8 omap3_evm_version;
 
+extern struct regulator_consumer_supply twl4030_vdac_supply;
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+extern struct regulator_consumer_supply twl4030_vpll2_supply;
+
+extern struct regulator_init_data vdac_data;
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vsim_data;
+extern struct regulator_init_data vpll2_data;
+
 u8 get_omap3_evm_rev(void)
 {
 	return omap3_evm_version;
@@ -190,8 +200,8 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	omap3evm_vmmc1_supply.dev = mmc[0].dev;
-	omap3evm_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/*
 	 * Most GPIOs are for USB OTG.  Some are mostly sent to
@@ -271,6 +281,10 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
+	.vmmc1		= &vmmc1_data,
+	.vsim		= &vsim_data,
+	.vdac		= &vdac_data,
+	.vpll2		= &vpll2_data,
 	.codec		= &omap3evm_codec_data,
 };
 
@@ -285,13 +299,6 @@ static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
 
 static int __init omap3_evm_i2c_init(void)
 {
-	/*
-	 * REVISIT: These entries can be set in omap3evm_twl_data
-	 * after a merge with MFD tree
-	 */
-	omap3evm_twldata.vmmc1 = &omap3evm_vmmc1;
-	omap3evm_twldata.vsim = &omap3evm_vsim;
-
 	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
 			ARRAY_SIZE(omap3evm_i2c_boardinfo));
 	omap_register_i2c_bus(2, 400, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 4a24d94..98b46ef 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -50,6 +50,12 @@
 /* hardware debounce: (value + 1) * 31us */
 #define GPIO_DEBOUNCE_TIME		127
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vmmc2_supply;
+
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vmmc2_data;
+
 static struct gpio_led pandora_gpio_leds[] = {
 	{
 		.name			= "pandora::sd1",
@@ -226,8 +232,8 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(omap3pandora_mmc);
 
 	/* link regulators to MMC adapters */
-	pandora_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
-	pandora_vmmc2_supply.dev = omap3pandora_mmc[1].dev;
+	twl4030_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
+	twl4030_vmmc2_supply.dev = omap3pandora_mmc[1].dev;
 
 	return 0;
 }
@@ -258,8 +264,8 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.gpio		= &omap3pandora_gpio_data,
 	.usb		= &omap3pandora_usb_data,
 	.codec		= &omap3pandora_codec_data,
-	.vmmc1		= &pandora_vmmc1,
-	.vmmc2		= &pandora_vmmc2,
+	.vmmc1		= &vmmc1_data,
+	.vmmc2		= &vmmc2_data,
 	.keypad		= &pandora_kp_data,
 };
 
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 441d61e..34b61f4 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -64,6 +64,12 @@
 #define TB_BL_PWM_TIMER		9
 #define TB_KILL_POWER_GPIO	168
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vsim_data;
+
 unsigned long touchbook_revision;
 
 static struct mtd_partition omap3touchbook_nand_partitions[] = {
@@ -156,8 +162,8 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	twl4030_mmc_init(mmc);
 
 	/* link regulators to MMC adapters */
-	touchbook_vmmc1_supply.dev = mmc[0].dev;
-	touchbook_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
 
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
@@ -247,8 +253,8 @@ static struct twl4030_platform_data touchbook_twldata = {
 	.usb		= &touchbook_usb_data,
 	.gpio		= &touchbook_gpio_data,
 	.codec		= &touchbook_codec_data,
-	.vmmc1		= &touchbook_vmmc1,
-	.vsim		= &touchbook_vsim,
+	.vmmc1		= &vmmc1_data,
+	.vsim		= &vsim_data,
 	.vdac		= &touchbook_vdac,
 	.vpll2		= &touchbook_vpll2,
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 5054296..9328391 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -64,6 +64,10 @@
 #define OVERO_SMSC911X_CS      5
 #define OVERO_SMSC911X_GPIO    176
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_init_data vmmc1_data;
+
+
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 
@@ -295,7 +299,7 @@ static int overo_twl_gpio_setup(struct device *dev,
 {
 	twl4030_mmc_init(mmc);
 
-	overo_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
 
 	return 0;
 }
@@ -328,7 +332,7 @@ static struct twl4030_platform_data overo_twldata = {
 	.gpio		= &overo_gpio_data,
 	.usb		= &overo_usb_data,
 	.codec		= &overo_codec_data,
-	.vmmc1		= &overo_vmmc1,
+	.vmmc1		= &vmmc1_data,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index d7d718b..5587f38 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,14 @@
 
 #include "mmc-twl4030.h"
 
+extern struct regulator_consumer_supply twl4030_vmmc1_supply;
+extern struct regulator_consumer_supply twl4030_vmmc2_supply;
+extern struct regulator_consumer_supply twl4030_vsim_supply;
+
+extern struct regulator_init_data vmmc1_data;
+extern struct regulator_init_data vmmc2_data;
+extern struct regulator_init_data vsim_data;
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -123,9 +131,9 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
 	*/
-	zoom_vmmc1_supply.dev = mmc[0].dev;
-	zoom_vsim_supply.dev = mmc[0].dev;
-	zoom_vmmc2_supply.dev = mmc[1].dev;
+	twl4030_vmmc1_supply.dev = mmc[0].dev;
+	twl4030_vsim_supply.dev = mmc[0].dev;
+	twl4030_vmmc2_supply.dev = mmc[1].dev;
 
 	return 0;
 }
@@ -182,10 +190,9 @@ static struct twl4030_platform_data zoom_twldata = {
 	.gpio		= &zoom_gpio_data,
 	.keypad		= &zoom_kp_twl4030_data,
 	.codec		= &zoom_codec_data,
-	.vmmc1          = &zoom_vmmc1,
-	.vmmc2          = &zoom_vmmc2,
-	.vsim           = &zoom_vsim,
-
+	.vmmc1		= &vmmc1_data,
+	.vmmc2		= &vmmc2_data,
+	.vsim		= &vsim_data,
 };
 
 static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
-- 
1.6.2.4

