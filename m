From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: OMAP1: Use generic map_io, init_early and init_irq
Date: Fri, 07 Oct 2011 12:45:46 -0700
Message-ID: <20111007194546.18205.17303.stgit@kaulin.local>
References: <20111007194242.18205.64009.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25859 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab1JGTps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 15:45:48 -0400
In-Reply-To: <20111007194242.18205.64009.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This allows removing omap hacks for map_io allowing generic
map_io.

Note that in the future we can't do cpu_is_omapxxxx detection
until in init_early. This means that board-innovator.c now
assumes 15xx only, and board-generic.c assumes 16xx only.
This is best fixed later on by passing the SoC type from
device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |   16 +------
 arch/arm/mach-omap1/board-fsample.c   |   76 ++++++++++++++++-----------------
 arch/arm/mach-omap1/board-generic.c   |   16 +------
 arch/arm/mach-omap1/board-h2.c        |   16 +------
 arch/arm/mach-omap1/board-h3.c        |   16 +------
 arch/arm/mach-omap1/board-htcherald.c |   12 +----
 arch/arm/mach-omap1/board-innovator.c |   36 +++++++---------
 arch/arm/mach-omap1/board-nokia770.c  |   34 +++++----------
 arch/arm/mach-omap1/board-osk.c       |   16 +------
 arch/arm/mach-omap1/board-palmte.c    |   16 +------
 arch/arm/mach-omap1/board-palmtt.c    |   16 +------
 arch/arm/mach-omap1/board-palmz71.c   |   18 +-------
 arch/arm/mach-omap1/board-perseus2.c  |   75 ++++++++++++++++-----------------
 arch/arm/mach-omap1/board-sx1.c       |   17 +------
 arch/arm/mach-omap1/board-voiceblue.c |   16 +------
 arch/arm/mach-omap1/io.c              |   56 +++++++++++-------------
 arch/arm/plat-omap/include/plat/io.h  |   27 +++++++++++-
 17 files changed, 183 insertions(+), 296 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 312ea6b..4427737 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -135,12 +135,6 @@ void ams_delta_latch2_write(u16 mask, u16 value)
 	*(volatile __u16 *) AMS_DELTA_LATCH2_VIRT = ams_delta_latch2_reg;
 }
 
-static void __init ams_delta_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static struct map_desc ams_delta_io_desc[] __initdata = {
 	/* AMS_DELTA_LATCH1 */
 	{
@@ -379,17 +373,13 @@ static int __init ams_delta_modem_init(void)
 }
 arch_initcall(ams_delta_modem_init);
 
-static void __init ams_delta_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
 	.boot_params	= 0x10000100,
-	.map_io		= ams_delta_map_io,
+	.map_io		= omap15xx_map_io,
+	.init_early	= omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= ams_delta_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= ams_delta_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index a6b1bea..b09dfe6 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -297,6 +297,39 @@ static struct omap_board_config_kernel fsample_config[] __initdata = {
 
 static void __init omap_fsample_init(void)
 {
+	/* Early, board-dependent init */
+
+	/*
+	 * Hold GSM Reset until needed
+	 */
+	omap_writew(omap_readw(OMAP7XX_DSP_M_CTL) & ~1, OMAP7XX_DSP_M_CTL);
+
+	/*
+	 * UARTs -> done automagically by 8250 driver
+	 */
+
+	/*
+	 * CSx timings, GPIO Mux ... setup
+	 */
+
+	/* Flash: CS0 timings setup */
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_0);
+	omap_writel(0x00000088, OMAP7XX_FLASH_ACFG_0);
+
+	/*
+	 * Ethernet support through the debug board
+	 * CS1 timings setup
+	 */
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_1);
+	omap_writel(0x00000000, OMAP7XX_FLASH_ACFG_1);
+
+	/*
+	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
+	 * It is used as the Ethernet controller interrupt
+	 */
+	omap_writel(omap_readl(OMAP7XX_IO_CONF_9) & 0x1FFFFFFF,
+			OMAP7XX_IO_CONF_9);
+
 	fsample_init_smc91x();
 
 	if (gpio_request(FSAMPLE_NAND_RB_GPIO_PIN, "NAND ready") < 0)
@@ -326,12 +359,6 @@ static void __init omap_fsample_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init omap_fsample_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
 static struct map_desc omap_fsample_io_desc[] __initdata = {
 	{
@@ -350,49 +377,18 @@ static struct map_desc omap_fsample_io_desc[] __initdata = {
 
 static void __init omap_fsample_map_io(void)
 {
-	omap1_map_common_io();
+	omap15xx_map_io();
 	iotable_init(omap_fsample_io_desc,
 		     ARRAY_SIZE(omap_fsample_io_desc));
-
-	/* Early, board-dependent init */
-
-	/*
-	 * Hold GSM Reset until needed
-	 */
-	omap_writew(omap_readw(OMAP7XX_DSP_M_CTL) & ~1, OMAP7XX_DSP_M_CTL);
-
-	/*
-	 * UARTs -> done automagically by 8250 driver
-	 */
-
-	/*
-	 * CSx timings, GPIO Mux ... setup
-	 */
-
-	/* Flash: CS0 timings setup */
-	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_0);
-	omap_writel(0x00000088, OMAP7XX_FLASH_ACFG_0);
-
-	/*
-	 * Ethernet support through the debug board
-	 * CS1 timings setup
-	 */
-	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_1);
-	omap_writel(0x00000000, OMAP7XX_FLASH_ACFG_1);
-
-	/*
-	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
-	 * It is used as the Ethernet controller interrupt
-	 */
-	omap_writel(omap_readl(OMAP7XX_IO_CONF_9) & 0x1FFFFFFF, OMAP7XX_IO_CONF_9);
 }
 
 MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 /* Maintainer: Brian Swetland <swetland@google.com> */
 	.boot_params	= 0x10000100,
 	.map_io		= omap_fsample_map_io,
+	.init_early	= omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_fsample_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_fsample_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 04fc356..cc0cca7 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -28,12 +28,6 @@
 #include <plat/board.h>
 #include <plat/common.h>
 
-static void __init omap_generic_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 /* assume no Mini-AB port */
 
 #ifdef CONFIG_ARCH_OMAP15XX
@@ -87,17 +81,13 @@ static void __init omap_generic_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init omap_generic_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	/* Maintainer: Tony Lindgren <tony@atomide.com> */
 	.boot_params	= 0x10000100,
-	.map_io		= omap_generic_map_io,
+	.map_io		= omap16xx_map_io,
+	.init_early	= omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_generic_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index cb7fb1a..248a5b8 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -373,12 +373,6 @@ static struct i2c_board_info __initdata h2_i2c_board_info[] = {
 	},
 };
 
-static void __init h2_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static struct omap_usb_config h2_usb_config __initdata = {
 	/* usb1 has a Mini-AB port and external isp1301 transceiver */
 	.otg		= 2,
@@ -454,17 +448,13 @@ static void __init h2_init(void)
 	h2_mmc_init();
 }
 
-static void __init h2_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_H2, "TI-H2")
 	/* Maintainer: Imre Deak <imre.deak@nokia.com> */
 	.boot_params	= 0x10000100,
-	.map_io		= h2_map_io,
+	.map_io		= omap16xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= h2_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= h2_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 31f3487..f28f05f 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -436,23 +436,13 @@ static void __init h3_init(void)
 	h3_mmc_init();
 }
 
-static void __init h3_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
-static void __init h3_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	/* Maintainer: Texas Instruments, Inc. */
 	.boot_params	= 0x10000100,
-	.map_io		= h3_map_io,
+	.map_io		= omap16xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= h3_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= h3_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 36e06ea..67798df 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -500,7 +500,7 @@ static void __init htcherald_lcd_init(void)
 
 static void __init htcherald_map_io(void)
 {
-	omap1_map_common_io();
+	omap7xx_map_io();
 
 	/*
 	 * The LCD panel must be disabled and DMA turned off here, as doing
@@ -601,20 +601,14 @@ static void __init htcherald_init(void)
 #endif
 }
 
-static void __init htcherald_init_irq(void)
-{
-	printk(KERN_INFO "htcherald_init_irq.\n");
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 MACHINE_START(HERALD, "HTC Herald")
 	/* Maintainer: Cory Maccarrone <darkstar6262@gmail.com> */
 	/* Maintainer: wing-linux.sourceforge.net */
 	.boot_params    = 0x10000100,
 	.map_io         = htcherald_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq       = htcherald_init_irq,
+	.init_irq       = omap1_init_irq,
 	.init_machine   = htcherald_init,
 	.timer          = &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 0b1ba46..3e349d0 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -289,12 +289,6 @@ static void __init innovator_init_smc91x(void)
 	}
 }
 
-static void __init innovator_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct omap_usb_config innovator1510_usb_config __initdata = {
 	/* for bundled non-standard host and peripheral cables */
@@ -439,30 +433,32 @@ static void __init innovator_init(void)
 	innovator_mmc_init();
 }
 
+/*
+ * REVISIT: Assume 15xx for now, we don't want to do revision check
+ * until later on. The right way to fix this is to set up a different
+ * machine_id for 16xx Innovator, or use device tree.
+ */
 static void __init innovator_map_io(void)
 {
-	omap1_map_common_io();
+	omap15xx_map_io();
 
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap1510()) {
-		iotable_init(innovator1510_io_desc, ARRAY_SIZE(innovator1510_io_desc));
-		udelay(10);	/* Delay needed for FPGA */
-
-		/* Dump the Innovator FPGA rev early - useful info for support. */
-		printk("Innovator FPGA Rev %d.%d Board Rev %d\n",
-		       fpga_read(OMAP1510_FPGA_REV_HIGH),
-		       fpga_read(OMAP1510_FPGA_REV_LOW),
-		       fpga_read(OMAP1510_FPGA_BOARD_REV));
-	}
-#endif
+	iotable_init(innovator1510_io_desc, ARRAY_SIZE(innovator1510_io_desc));
+	udelay(10);	/* Delay needed for FPGA */
+
+	/* Dump the Innovator FPGA rev early - useful info for support. */
+	pr_debug("Innovator FPGA Rev %d.%d Board Rev %d\n",
+			fpga_read(OMAP1510_FPGA_REV_HIGH),
+			fpga_read(OMAP1510_FPGA_REV_LOW),
+			fpga_read(OMAP1510_FPGA_BOARD_REV));
 }
 
 MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	/* Maintainer: MontaVista Software, Inc. */
 	.boot_params	= 0x10000100,
 	.map_io		= innovator_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= innovator_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= innovator_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 5469ce2..9b348b6 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -39,21 +39,6 @@
 
 #define ADS7846_PENDOWN_GPIO	15
 
-static void __init omap_nokia770_init_irq(void)
-{
-	/* On Nokia 770, the SleepX signal is masked with an
-	 * MPUIO line by default.  It has to be unmasked for it
-	 * to become functional */
-
-	/* SleepX mask direction */
-	omap_writew((omap_readw(0xfffb5008) & ~2), 0xfffb5008);
-	/* Unmask SleepX signal */
-	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
-
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static const unsigned int nokia770_keymap[] = {
 	KEY(1, 0, GROUP_0 | KEY_UP),
 	KEY(2, 0, GROUP_1 | KEY_F5),
@@ -246,6 +231,15 @@ static inline void nokia770_mmc_init(void)
 
 static void __init omap_nokia770_init(void)
 {
+	/* On Nokia 770, the SleepX signal is masked with an
+	 * MPUIO line by default.  It has to be unmasked for it
+	 * to become functional */
+
+	/* SleepX mask direction */
+	omap_writew((omap_readw(0xfffb5008) & ~2), 0xfffb5008);
+	/* Unmask SleepX signal */
+	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
+
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
@@ -258,16 +252,12 @@ static void __init omap_nokia770_init(void)
 	nokia770_mmc_init();
 }
 
-static void __init omap_nokia770_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(NOKIA770, "Nokia 770")
 	.boot_params	= 0x10000100,
-	.map_io		= omap_nokia770_map_io,
+	.map_io		= omap16xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_nokia770_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_nokia770_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index b08a213..562986e 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -279,12 +279,6 @@ static void __init osk_init_cf(void)
 	irq_set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_FALLING);
 }
 
-static void __init osk_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static struct omap_usb_config osk_usb_config __initdata = {
 	/* has usb host connector (A) ... for development it can also
 	 * be used, with a NONSTANDARD gender-bending cable/dongle, as
@@ -576,17 +570,13 @@ static void __init osk_init(void)
 	osk_mistral_init();
 }
 
-static void __init osk_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_OSK, "TI-OSK")
 	/* Maintainer: Dirk Behme <dirk.behme@de.bosch.com> */
 	.boot_params	= 0x10000100,
-	.map_io		= osk_map_io,
+	.map_io		= omap16xx_map_io,
+	.init_early	= omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= osk_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= osk_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 459cb6b..fc9edd8 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -59,12 +59,6 @@
 #define PALMTE_MMC2_GPIO	OMAP_MPUIO(7)
 #define PALMTE_MMC3_GPIO	OMAP_MPUIO(11)
 
-static void __init omap_palmte_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static const unsigned int palmte_keymap[] = {
 	KEY(0, 0, KEY_F1),		/* Calendar */
 	KEY(1, 0, KEY_F2),		/* Contacts */
@@ -269,16 +263,12 @@ static void __init omap_palmte_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init omap_palmte_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.boot_params	= 0x10000100,
-	.map_io		= omap_palmte_map_io,
+	.map_io		= omap15xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_palmte_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmte_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index b214f45..5ff3def 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -263,12 +263,6 @@ static struct spi_board_info __initdata palmtt_boardinfo[] = {
 	}
 };
 
-static void __init omap_palmtt_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static struct omap_usb_config palmtt_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 0,
@@ -315,16 +309,12 @@ static void __init omap_palmtt_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init omap_palmtt_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.boot_params	= 0x10000100,
-	.map_io		= omap_palmtt_map_io,
+	.map_io		= omap15xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_palmtt_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmtt_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 9b0ea48..8e08873 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -57,13 +57,6 @@
 #define PALMZ71_SLIDER_GPIO	OMAP_MPUIO(3)
 #define PALMZ71_MMC_IN_GPIO	OMAP_MPUIO(4)
 
-static void __init
-omap_palmz71_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
 static const unsigned int palmz71_keymap[] = {
 	KEY(0, 0, KEY_F1),
 	KEY(1, 0, KEY_F2),
@@ -334,17 +327,12 @@ omap_palmz71_init(void)
 	palmz71_gpio_setup(0);
 }
 
-static void __init
-omap_palmz71_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.boot_params	= 0x10000100,
-	.map_io		= omap_palmz71_map_io,
+	.map_io		= omap15xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_palmz71_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_palmz71_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 67acd41..6ed649b 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -265,6 +265,39 @@ static void __init perseus2_init_smc91x(void)
 
 static void __init omap_perseus2_init(void)
 {
+	/* Early, board-dependent init */
+
+	/*
+	 * Hold GSM Reset until needed
+	 */
+	omap_writew(omap_readw(OMAP7XX_DSP_M_CTL) & ~1, OMAP7XX_DSP_M_CTL);
+
+	/*
+	 * UARTs -> done automagically by 8250 driver
+	 */
+
+	/*
+	 * CSx timings, GPIO Mux ... setup
+	 */
+
+	/* Flash: CS0 timings setup */
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_0);
+	omap_writel(0x00000088, OMAP7XX_FLASH_ACFG_0);
+
+	/*
+	 * Ethernet support through the debug board
+	 * CS1 timings setup
+	 */
+	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_1);
+	omap_writel(0x00000000, OMAP7XX_FLASH_ACFG_1);
+
+	/*
+	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
+	 * It is used as the Ethernet controller interrupt
+	 */
+	omap_writel(omap_readl(OMAP7XX_IO_CONF_9) & 0x1FFFFFFF,
+				OMAP7XX_IO_CONF_9);
+
 	perseus2_init_smc91x();
 
 	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
@@ -294,11 +327,6 @@ static void __init omap_perseus2_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
-static void __init omap_perseus2_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
 static struct map_desc omap_perseus2_io_desc[] __initdata = {
 	{
@@ -311,49 +339,18 @@ static struct map_desc omap_perseus2_io_desc[] __initdata = {
 
 static void __init omap_perseus2_map_io(void)
 {
-	omap1_map_common_io();
+	omap7xx_map_io();
 	iotable_init(omap_perseus2_io_desc,
 		     ARRAY_SIZE(omap_perseus2_io_desc));
-
-	/* Early, board-dependent init */
-
-	/*
-	 * Hold GSM Reset until needed
-	 */
-	omap_writew(omap_readw(OMAP7XX_DSP_M_CTL) & ~1, OMAP7XX_DSP_M_CTL);
-
-	/*
-	 * UARTs -> done automagically by 8250 driver
-	 */
-
-	/*
-	 * CSx timings, GPIO Mux ... setup
-	 */
-
-	/* Flash: CS0 timings setup */
-	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_0);
-	omap_writel(0x00000088, OMAP7XX_FLASH_ACFG_0);
-
-	/*
-	 * Ethernet support through the debug board
-	 * CS1 timings setup
-	 */
-	omap_writel(0x0000fff3, OMAP7XX_FLASH_CFG_1);
-	omap_writel(0x00000000, OMAP7XX_FLASH_ACFG_1);
-
-	/*
-	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
-	 * It is used as the Ethernet controller interrupt
-	 */
-	omap_writel(omap_readl(OMAP7XX_IO_CONF_9) & 0x1FFFFFFF, OMAP7XX_IO_CONF_9);
 }
 
 MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	/* Maintainer: Kevin Hilman <kjh@hilman.org> */
 	.boot_params	= 0x10000100,
 	.map_io		= omap_perseus2_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_perseus2_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_perseus2_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 9c3b7c5..23326e0 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -407,24 +407,13 @@ static void __init omap_sx1_init(void)
 	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
 	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
 }
-/*----------------------------------------*/
-static void __init omap_sx1_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-/*----------------------------------------*/
-
-static void __init omap_sx1_map_io(void)
-{
-	omap1_map_common_io();
-}
 
 MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.boot_params	= 0x10000100,
-	.map_io		= omap_sx1_map_io,
+	.map_io		= omap15xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_sx1_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= omap_sx1_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 036edc0..1444ce8 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -159,17 +159,6 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 static struct omap_board_config_kernel voiceblue_config[] = {
 };
 
-static void __init voiceblue_init_irq(void)
-{
-	omap1_init_common_hw();
-	omap1_init_irq();
-}
-
-static void __init voiceblue_map_io(void)
-{
-	omap1_map_common_io();
-}
-
 #define MACHINE_PANICED		1
 #define MACHINE_REBOOTING	2
 #define MACHINE_REBOOT		4
@@ -302,9 +291,10 @@ static void __init voiceblue_init(void)
 MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	/* Maintainer: Ladislav Michl <michl@2n.cz> */
 	.boot_params	= 0x10000100,
-	.map_io		= voiceblue_map_io,
+	.map_io		= omap15xx_map_io,
+	.init_early     = omap1_init_early,
 	.reserve	= omap_reserve,
-	.init_irq	= voiceblue_init_irq,
+	.init_irq	= omap1_init_irq,
 	.init_machine	= voiceblue_init,
 	.timer		= &omap1_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 870886a..a16aab7 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -85,50 +85,44 @@ static struct map_desc omap16xx_io_desc[] __initdata = {
 #endif
 
 /*
- * Maps common IO regions for omap1. This should only get called from
- * board specific init.
+ * Maps common IO regions for omap1
  */
-void __init omap1_map_common_io(void)
+static void __init omap1_map_common_io(void)
 {
 	iotable_init(omap_io_desc, ARRAY_SIZE(omap_io_desc));
-
-	/* Normally devicemaps_init() would flush caches and tlb after
-	 * mdesc->map_io(), but we must also do it here because of the CPU
-	 * revision check below.
-	 */
-	local_flush_tlb_all();
-	flush_cache_all();
-
-	/* We want to check CPU revision early for cpu_is_omapxxxx() macros.
-	 * IO space mapping must be initialized before we can do that.
-	 */
-	omap_check_revision();
+}
 
 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
-	if (cpu_is_omap7xx()) {
-		iotable_init(omap7xx_io_desc, ARRAY_SIZE(omap7xx_io_desc));
-	}
+void __init omap7xx_map_io(void)
+{
+	omap1_map_common_io();
+	iotable_init(omap7xx_io_desc, ARRAY_SIZE(omap7xx_io_desc));
+}
 #endif
+
 #ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap15xx()) {
-		iotable_init(omap1510_io_desc, ARRAY_SIZE(omap1510_io_desc));
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP16XX)
-	if (cpu_is_omap16xx()) {
-		iotable_init(omap16xx_io_desc, ARRAY_SIZE(omap16xx_io_desc));
-	}
+void __init omap15xx_map_io(void)
+{
+	omap1_map_common_io();
+	iotable_init(omap1510_io_desc, ARRAY_SIZE(omap1510_io_desc));
+}
 #endif
 
-	omap_sram_init();
+#if defined(CONFIG_ARCH_OMAP16XX)
+void __init omap16xx_map_io(void)
+{
+	omap1_map_common_io();
+	iotable_init(omap16xx_io_desc, ARRAY_SIZE(omap16xx_io_desc));
 }
+#endif
 
 /*
- * Common low-level hardware init for omap1. This should only get called from
- * board specific init.
+ * Common low-level hardware init for omap1.
  */
-void __init omap1_init_common_hw(void)
+void omap1_init_early(void)
 {
+	omap_check_revision();
+
 	/* REVISIT: Refer to OMAP5910 Errata, Advisory SYS_1: "Timeout Abort
 	 * on a Posted Write in the TIPB Bridge".
 	 */
@@ -138,8 +132,8 @@ void __init omap1_init_common_hw(void)
 	/* Must init clocks early to assure that timer interrupt works
 	 */
 	omap1_clk_init();
-
 	omap1_mux_init();
+	omap_sram_init();
 }
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 6591875..c0c7850 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -256,8 +256,31 @@ extern void omap_writel(u32 v, u32 pa);
 
 struct omap_sdrc_params;
 
-extern void omap1_map_common_io(void);
-extern void omap1_init_common_hw(void);
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+void omap7xx_map_io(void);
+#else
+static inline void omap_map_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP15XX
+void omap15xx_map_io(void);
+#else
+static inline void omap15xx_map_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP16XX
+void omap16xx_map_io(void);
+#else
+static inline void omap16xx_map_io(void)
+{
+}
+#endif
+
+void omap1_init_early(void);
 
 #ifdef CONFIG_SOC_OMAP2420
 extern void omap242x_map_common_io(void);

