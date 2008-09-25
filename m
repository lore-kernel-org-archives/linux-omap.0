From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [Resend] [PATCH 2/3] OMAP2EVM : Add touchscreen support
Date: Thu, 25 Sep 2008 11:06:03 +0530
Message-ID: <dfeb90390809242236k39541e1ex8ed65482c3dbdd42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:21251 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbYIYFgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 01:36:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so290921rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 22:36:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Adding ads7846 touchscreen support to omap2evm board

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c             |   67 ++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/board-omap2evm.h |    5 +-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index 6ce7740..5bbf36f 100644
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

@@ -181,6 +185,66 @@ static struct omap_lcd_config
omap2_evm_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };

+static void ads7846_dev_init(void)
+{
+	int gpio = OMAP2_EVM_TS_GPIO;
+	int ret;
+
+	ret = gpio_request(gpio, "ads7846_pen_down");
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to request GPIO %d for ads7846 pen down IRQ\n",
+				gpio);
+		return;
+	}
+
+	gpio_direction_input(gpio);
+
+	/*Setting the MUX */
+	omap_cfg_reg(Y18_2430_MCSPI1_CLK);
+	omap_cfg_reg(AD15_2430_MCSPI1_SIMO);
+	omap_cfg_reg(AE17_2430_MCSPI1_SOMI);
+	omap_cfg_reg(U1_2430_MCSPI1_CS0);
+
+	omap_cfg_reg(AF19_2430_GPIO_85);
+
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
@@ -269,9 +333,12 @@ static void __init omap2_evm_init(void)
 	platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
 	omap_board_config = omap2_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
+	spi_register_board_info(omap2evm_spi_board_info,
+				ARRAY_SIZE(omap2evm_spi_board_info));
 	omap_serial_init();
 	hsmmc_init();
 	omap2evm_flash_init();
+	ads7846_dev_init();
 }

 static void __init omap2_evm_map_io(void)
diff --git a/arch/arm/plat-omap/include/mach/board-omap2evm.h
b/arch/arm/plat-omap/include/mach/board-omap2evm.h
index ec548d4..c6ba428 100644
--- a/arch/arm/plat-omap/include/mach/board-omap2evm.h
+++ b/arch/arm/plat-omap/include/mach/board-omap2evm.h
@@ -30,8 +30,9 @@
 #define __ASM_ARCH_OMAP2_EVM_H

 /* Placeholder for OMAP2EVM specific defines */
-#define OMAP2EVM_ETHR_START			0x2c000000
-#define OMAP2EVM_ETHR_SIZE			1024
+#define OMAP2EVM_ETHR_START		0x2c000000
+#define OMAP2EVM_ETHR_SIZE		1024
 #define OMAP2EVM_ETHR_GPIO_IRQ		149
+#define	OMAP2_EVM_TS_GPIO		85

 #endif /* __ASM_ARCH_OMAP2_EVM_H */
-- 
1.5.3.4
