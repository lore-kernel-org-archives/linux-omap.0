From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/16] omap: mux: Convert 2420 platform init code to use new
	mux code
Date: Wed, 30 Jun 2010 15:07:27 +0300
Message-ID: <20100630120727.2637.12658.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52450 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab0F3MHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:07:16 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Convert 2420 platform init code to use new mux code

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-apollon.c |   13 ++++++-------
 arch/arm/mach-omap2/board-h4.c      |    7 +++----
 arch/arm/mach-omap2/devices.c       |   25 ++++++++++++-------------
 arch/arm/mach-omap2/i2c.c           |   27 +++++++--------------------
 arch/arm/mach-omap2/mcbsp.c         |   13 +++++++------
 arch/arm/mach-omap2/usb-tusb6010.c  |   14 +++++++-------
 6 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index bc67026..8cea623 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -35,7 +35,6 @@
 
 #include <mach/gpio.h>
 #include <plat/led.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
@@ -246,7 +245,7 @@ static inline void __init apollon_init_smc91x(void)
 	apollon_smc91x_resources[0].end   = base + 0x30f;
 	udelay(100);
 
-	omap_cfg_reg(W4__24XX_GPIO74);
+	omap_mux_init_gpio(74, 0);
 	if (gpio_request(APOLLON_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			APOLLON_ETHR_GPIO_IRQ);
@@ -288,15 +287,15 @@ static void __init omap_apollon_init_irq(void)
 static void __init apollon_led_init(void)
 {
 	/* LED0 - AA10 */
-	omap_cfg_reg(AA10_242X_GPIO13);
+	omap_mux_init_signal("vlynq_clk.gpio_13", 0);
 	gpio_request(LED0_GPIO13, "LED0");
 	gpio_direction_output(LED0_GPIO13, 0);
 	/* LED1  - AA6 */
-	omap_cfg_reg(AA6_242X_GPIO14);
+	omap_mux_init_signal("vlynq_rx1.gpio_14", 0);
 	gpio_request(LED1_GPIO14, "LED1");
 	gpio_direction_output(LED1_GPIO14, 0);
 	/* LED2  - AA4 */
-	omap_cfg_reg(AA4_242X_GPIO15);
+	omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
 	gpio_request(LED2_GPIO15, "LED2");
 	gpio_direction_output(LED2_GPIO15, 0);
 }
@@ -305,7 +304,7 @@ static void __init apollon_usb_init(void)
 {
 	/* USB device */
 	/* DEVICE_SUSPEND */
-	omap_cfg_reg(P21_242X_GPIO12);
+	omap_mux_init_signal("mcbsp2_clkx.gpio_12", 0);
 	gpio_request(12, "USB suspend");
 	gpio_direction_output(12, 0);
 	omap2_usbfs_init(&apollon_usb_config);
@@ -330,7 +329,7 @@ static void __init omap_apollon_init(void)
 	apollon_usb_init();
 
 	/* REVISIT: where's the correct place */
-	omap_cfg_reg(W19_24XX_SYS_NIRQ);
+	omap_mux_init_signal("sys_nirq", OMAP_PULL_ENA | OMAP_PULL_UP);
 
 	/* LCD PWR_EN */
 	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index cdcd4fb..2d9ff0f 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -33,7 +33,6 @@
 
 #include <plat/control.h>
 #include <mach/gpio.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
@@ -248,7 +247,7 @@ static inline void __init h4_init_debug(void)
 
 	udelay(100);
 
-	omap_cfg_reg(M15_24XX_GPIO92);
+	omap_mux_init_gpio(92, 0);
 	if (debug_card_init(cs_mem_base, H4_ETHR_GPIO_IRQ) < 0)
 		gpmc_cs_free(eth_cs);
 
@@ -358,8 +357,8 @@ static void __init omap_h4_init(void)
 	 * if not needed.
 	 */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
-	omap_cfg_reg(K15_24XX_UART3_TX);
-	omap_cfg_reg(K14_24XX_UART3_RX);
+	omap_mux_init_signal("uart3_tx_irtx.uart3_tx_irtx", 0);
+	omap_mux_init_signal("uart3_rx_irrx.uart3_rx_irrx", 0);
 #endif
 
 #if defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 03e6c9e..3ae9d0a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,7 +25,6 @@
 #include <plat/control.h>
 #include <plat/tc.h>
 #include <plat/board.h>
-#include <plat/mux.h>
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
@@ -672,19 +671,19 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 					OMAP_PIN_INPUT_PULLUP);
 
 	if (cpu_is_omap2420() && controller_nr == 0) {
-		omap_cfg_reg(H18_24XX_MMC_CMD);
-		omap_cfg_reg(H15_24XX_MMC_CLKI);
-		omap_cfg_reg(G19_24XX_MMC_CLKO);
-		omap_cfg_reg(F20_24XX_MMC_DAT0);
-		omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
-		omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
+		omap_mux_init_signal("sdmmc_cmd", 0);
+		omap_mux_init_signal("sdmmc_clki", 0);
+		omap_mux_init_signal("sdmmc_clko", 0);
+		omap_mux_init_signal("sdmmc_dat0", 0);
+		omap_mux_init_signal("sdmmc_dat_dir0", 0);
+		omap_mux_init_signal("sdmmc_cmd_dir", 0);
 		if (mmc_controller->slots[0].wires == 4) {
-			omap_cfg_reg(H14_24XX_MMC_DAT1);
-			omap_cfg_reg(E19_24XX_MMC_DAT2);
-			omap_cfg_reg(D19_24XX_MMC_DAT3);
-			omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
-			omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
-			omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
+			omap_mux_init_signal("sdmmc_dat1", 0);
+			omap_mux_init_signal("sdmmc_dat2", 0);
+			omap_mux_init_signal("sdmmc_dat3", 0);
+			omap_mux_init_signal("sdmmc_dat_dir1", 0);
+			omap_mux_init_signal("sdmmc_dat_dir2", 0);
+			omap_mux_init_signal("sdmmc_dat_dir3", 0);
 		}
 
 		/*
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 7951ae1..79c478c 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -21,32 +21,19 @@
 
 #include <plat/cpu.h>
 #include <plat/i2c.h>
-#include <plat/mux.h>
 
 #include "mux.h"
 
 void __init omap2_i2c_mux_pins(int bus_id)
 {
-	if (cpu_is_omap24xx()) {
-		const int omap24xx_pins[][2] = {
-			{ M19_24XX_I2C1_SCL, L15_24XX_I2C1_SDA },
-			{ J15_24XX_I2C2_SCL, H19_24XX_I2C2_SDA },
-		};
-		int scl, sda;
-
-		scl = omap24xx_pins[bus_id - 1][0];
-		sda = omap24xx_pins[bus_id - 1][1];
-		omap_cfg_reg(sda);
-		omap_cfg_reg(scl);
-	}
+	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
 
 	/* First I2C bus is not muxable */
-	if (cpu_is_omap34xx() && bus_id > 1) {
-		char mux_name[sizeof("i2c2_scl.i2c2_scl")];
+	if (bus_id == 1)
+		return;
 
-		sprintf(mux_name, "i2c%i_scl.i2c%i_scl", bus_id, bus_id);
-		omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
-		sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
-		omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
-	}
+	sprintf(mux_name, "i2c%i_scl.i2c%i_scl", bus_id, bus_id);
+	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
+	sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
+	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
 }
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index c293370..87aa4c9 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -20,17 +20,18 @@
 
 #include <mach/irqs.h>
 #include <plat/dma.h>
-#include <plat/mux.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
 
+#include "mux.h"
+
 static void omap2_mcbsp2_mux_setup(void)
 {
-	omap_cfg_reg(Y15_24XX_MCBSP2_CLKX);
-	omap_cfg_reg(R14_24XX_MCBSP2_FSX);
-	omap_cfg_reg(W15_24XX_MCBSP2_DR);
-	omap_cfg_reg(V15_24XX_MCBSP2_DX);
-	omap_cfg_reg(V14_24XX_GPIO117);
+	omap_mux_init_signal("eac_ac_sclk.mcbsp2_clkx", OMAP_PULL_ENA);
+	omap_mux_init_signal("eac_ac_fs.mcbsp2_fsx", OMAP_PULL_ENA);
+	omap_mux_init_signal("eac_ac_din.mcbsp2_dr", OMAP_PULL_ENA);
+	omap_mux_init_signal("eac_ac_dout.mcbsp2_dx", OMAP_PULL_ENA);
+	omap_mux_init_gpio(117, OMAP_PULL_ENA);
 	/*
 	 * TODO: Need to add MUX settings for OMAP 2430 SDP
 	 */
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 10a2013..64a0112 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -17,8 +17,8 @@
 #include <linux/usb/musb.h>
 
 #include <plat/gpmc.h>
-#include <plat/mux.h>
 
+#include "mux.h"
 
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
@@ -325,17 +325,17 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 	else {
 		/* assume OMAP 2420 ES2.0 and later */
 		if (dmachan & (1 << 0))
-			omap_cfg_reg(AA10_242X_DMAREQ0);
+			omap_mux_init_signal("sys_ndmareq0", 0);
 		if (dmachan & (1 << 1))
-			omap_cfg_reg(AA6_242X_DMAREQ1);
+			omap_mux_init_signal("sys_ndmareq1", 0);
 		if (dmachan & (1 << 2))
-			omap_cfg_reg(E4_242X_DMAREQ2);
+			omap_mux_init_signal("sys_ndmareq2", 0);
 		if (dmachan & (1 << 3))
-			omap_cfg_reg(G4_242X_DMAREQ3);
+			omap_mux_init_signal("sys_ndmareq3", 0);
 		if (dmachan & (1 << 4))
-			omap_cfg_reg(D3_242X_DMAREQ4);
+			omap_mux_init_signal("sys_ndmareq4", 0);
 		if (dmachan & (1 << 5))
-			omap_cfg_reg(E3_242X_DMAREQ5);
+			omap_mux_init_signal("sys_ndmareq5", 0);
 	}
 
 	/* so far so good ... register the device */

