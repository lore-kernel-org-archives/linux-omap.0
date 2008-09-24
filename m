From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] OMAP2EVM : Add touchscreen support
Date: Wed, 24 Sep 2008 19:44:12 +0530
Message-ID: <dfeb90390809240714l68debbct9fdc068cfc440f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:1284 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYIXOOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:14:12 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2725629rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 07:14:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch adds ads7846 touchscreen support to omap2evm board

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c             |   64 ++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c                        |   11 ++++
 arch/arm/plat-omap/include/mach/board-omap2evm.h |    2 +
 arch/arm/plat-omap/include/mach/mux.h            |    9 +++
 4 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index 6ce7740..2cf13b1 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -22,6 +22,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>

 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -36,6 +38,8 @@
 #include <mach/keypad.h>
 #include <mach/gpmc.h>
 #include <mach/nand.h>
+#include <mach/mcspi.h>
+#include <mach/mux.h>

 #define GPMC_OFF_CONFIG1_0 0x60

@@ -181,6 +185,62 @@ static struct omap_lcd_config
omap2_evm_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };

+static void ads7846_dev_init(void)
+{
+
+	/*Setting the MUX */
+	omap_cfg_reg(Y18_2430_MCSPI1_CLK);
+	omap_cfg_reg(AD15_2430_MCSPI1_SIMO);
+	omap_cfg_reg(AE17_2430_MCSPI1_SOMI);
+	omap_cfg_reg(U1_2430_MCSPI1_CS0);
+
+	omap_cfg_reg(AF19_2430_GPIO_85);
+
+	if (omap_request_gpio(OMAP2_EVM_TS_GPIO) < 0)
+		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
+
+	omap_set_gpio_direction(OMAP2_EVM_TS_GPIO, 1);
+
+	omap_set_gpio_debounce(OMAP2_EVM_TS_GPIO, 1);
+	omap_set_gpio_debounce_time(OMAP2_EVM_TS_GPIO, 0xa);
+}
+
+static int ads7846_get_pendown_state(void)
+{
+	return !omap_get_gpio_datain(OMAP2_EVM_TS_GPIO);
+}
+
+struct ads7846_platform_data ads7846_config = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 3,
+	.debounce_rep		= 1,
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+	.settle_delay_usecs	= 150,
+};
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,  /* 0: slave, 1: master */
+};
+
+struct spi_board_info omap2evm_spi_board_info[] = {
+	[0] = {
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OMAP2_EVM_TS_GPIO),
+		.platform_data		= &ads7846_config,
+	},
+};
+
+
 static int omap2evm_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -269,9 +329,13 @@ static void __init omap2_evm_init(void)
 	platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
 	omap_board_config = omap2_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
+
+	spi_register_board_info(omap2evm_spi_board_info,
+				ARRAY_SIZE(omap2evm_spi_board_info));
 	omap_serial_init();
 	hsmmc_init();
 	omap2evm_flash_init();
+	ads7846_dev_init();
 }

 static void __init omap2_evm_map_io(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 741ab18..7bbd87e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -210,6 +210,17 @@ MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
 MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
 MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
+
+/* 2430 MCSPI1 */
+MUX_CFG_24XX("SPI1_2430_MCSPI1_CLK",	0x010F,	0,	0,	0,	1)
+MUX_CFG_24XX("SPI1_2430_MCSPI1_SIMO",	0x0110,	0,	0,	0,	1)
+MUX_CFG_24XX("SPI1_2430_MCSPI1_SOMI",	0x0111,	0,	0,	0,	1)
+MUX_CFG_24XX("SPI1_2430_MCSPI1_CS0",	0x0112,	0,	0,	0,	1)
+MUX_CFG_24XX("SPI1_2430_GPIO_85",	0x0113,	3,	0,	0,	1)
+
+/* Touchscreen GPIO */
+MUX_CFG_24XX("AF19_2430_GPIO_85",	0x0113,	3,	0,	0,	1)
+
 };

 #define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/board-omap2evm.h
b/arch/arm/plat-omap/include/mach/board-omap2evm.h
index ec548d4..b46fba6 100644
--- a/arch/arm/plat-omap/include/mach/board-omap2evm.h
+++ b/arch/arm/plat-omap/include/mach/board-omap2evm.h
@@ -34,4 +34,6 @@
 #define OMAP2EVM_ETHR_SIZE			1024
 #define OMAP2EVM_ETHR_GPIO_IRQ		149

+#define OMAP2_EVM_TS_GPIO	85
+
 #endif /* __ASM_ARCH_OMAP2_EVM_H */
diff --git a/arch/arm/plat-omap/include/mach/mux.h
b/arch/arm/plat-omap/include/mach/mux.h
index 5670d56..683474f 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -641,6 +641,15 @@ enum omap24xx_index {
 	AE13_2430_MCBSP2_DX_OFF,
 	AD13_2430_MCBSP2_DR_OFF,

+	/* 2430 McSPI*/
+	Y18_2430_MCSPI1_CLK,
+	AD15_2430_MCSPI1_SIMO,
+	AE17_2430_MCSPI1_SOMI,
+	U1_2430_MCSPI1_CS0,
+
+	/* Touchscreen GPIO */
+	AF19_2430_GPIO_85,
+
 };

 enum omap34xx_index {
-- 
1.5.3.4
