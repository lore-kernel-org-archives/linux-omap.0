From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/1] omap: fix section mismatch errors
Date: Mon, 16 Aug 2010 21:01:17 +0530
Message-ID: <1281972677-1636-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33835 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab0HPPbW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 11:31:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7GFVJHS006647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 10:31:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch fixes miltiple section mismatch errors
observed with the latest master.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c           |    8 ++++----
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |   18 +++++++++---------
 arch/arm/plat-omap/cpu-omap.c                |    2 +-
 drivers/mfd/twl-core.c                       |    2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8538e41..bca0236 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -134,7 +134,7 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static struct omap_board_config_kernel sdp2430_config[] = {
+static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index c6421a7..1401108 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -270,7 +270,7 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel apollon_config[] = {
+static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e10bc10..fc04062 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -606,7 +606,7 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
+static int __init cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 				 unsigned ngpio)
 {
 	int wlan_rst = gpio + 2;
@@ -640,14 +640,14 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	return 0;
 }
 
-static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
+static struct twl4030_gpio_platform_data cm_t35_gpio_data __initdata = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup          = cm_t35_twl_gpio_setup,
 };
 
-static struct twl4030_platform_data cm_t35_twldata = {
+static struct twl4030_platform_data cm_t35_twldata __initdata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
@@ -661,7 +661,7 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.vpll2		= &cm_t35_vpll2,
 };
 
-static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata cm_t35_i2c_boardinfo[] __initdata = {
 	{
 		I2C_BOARD_INFO("tps65930", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index e09bd68..7b6f9c1 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -283,7 +283,7 @@ static struct omap_usb_config h4_usb_config __initdata = {
 	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
 };
 
-static struct omap_board_config_kernel h4_config[] = {
+static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..d0f8057 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -171,7 +171,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}      /* Terminator */
 };
 
-static int zoom_twl_gpio_setup(struct device *dev,
+static int __init zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
@@ -209,27 +209,27 @@ static struct twl4030_usb_data zoom_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_gpio_platform_data zoom_gpio_data = {
+static struct twl4030_gpio_platform_data zoom_gpio_data __initdata = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.setup		= zoom_twl_gpio_setup,
 };
 
-static struct twl4030_madc_platform_data zoom_madc_data = {
+static struct twl4030_madc_platform_data zoom_madc_data __initdata = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_codec_audio_data zoom_audio_data = {
+static struct twl4030_codec_audio_data zoom_audio_data __initdata = {
 	.audio_mclk = 26000000,
 };
 
-static struct twl4030_codec_data zoom_codec_data = {
+static struct twl4030_codec_data zoom_codec_data __initdata = {
 	.audio_mclk = 26000000,
 	.audio = &zoom_audio_data,
 };
 
-static struct twl4030_platform_data zoom_twldata = {
+static struct twl4030_platform_data zoom_twldata __initdata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
@@ -246,7 +246,7 @@ static struct twl4030_platform_data zoom_twldata = {
 
 };
 
-static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
+static struct i2c_board_info __initdata zoom_i2c_boardinfo[] __initdata = {
 	{
 		I2C_BOARD_INFO("twl5030", 0x48),
 		.flags		= I2C_CLIENT_WAKE,
@@ -264,13 +264,13 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
-static struct omap_musb_board_data musb_board_data = {
+static struct omap_musb_board_data musb_board_data __initdata = {
 	.interface_type		= MUSB_INTERFACE_ULPI,
 	.mode			= MUSB_OTG,
 	.power			= 100,
 };
 
-static void enable_board_wakeup_source(void)
+static void __init enable_board_wakeup_source(void)
 {
 	/* T2 interrupt line (keypad) */
 	omap_mux_init_signal("sys_nirq",
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 6d3d333..e47a299 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -144,7 +144,7 @@ static struct freq_attr *omap_cpufreq_attr[] = {
 	NULL,
 };
 
-static struct cpufreq_driver omap_driver = {
+static struct cpufreq_driver omap_driver __refdata = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= omap_verify_speed,
 	.target		= omap_target,
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 720e099..36f4c48 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1061,7 +1061,7 @@ static const struct i2c_device_id twl_ids[] = {
 MODULE_DEVICE_TABLE(i2c, twl_ids);
 
 /* One Client Driver , 4 Clients */
-static struct i2c_driver twl_driver = {
+static struct i2c_driver twl_driver __refdata = {
 	.driver.name	= DRIVER_NAME,
 	.id_table	= twl_ids,
 	.probe		= twl_probe,
-- 
1.6.6.1

