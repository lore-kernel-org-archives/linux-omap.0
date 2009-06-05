From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/8] OMAP2/3 board-*.c files: read bootloader configuration
	earlier
Date: Fri, 05 Jun 2009 04:19:38 -0600
Message-ID: <20090605101920.32500.28842.stgit@localhost.localdomain>
References: <20090605101635.32500.63083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47667 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZFEKUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:20:32 -0400
In-Reply-To: <20090605101635.32500.63083.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Most board-*.c files read configuration data from the bootloader in
their .init_machine() function.  This needs to happen earlier, at some
point before omap2_init_common_hw() is called.  This is because a
future patch will use the bootloader serial console port information
to enable the UART clocks earlier, immediately after omap2_clk_init().
This is in turn necessary since otherwise clock tree usecounts on
clocks like dpll4_m2x2_ck will be bogus, which can cause the
currently-active console UART clock to be disabled during boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |   19 +++++++++----------
 arch/arm/mach-omap2/board-3430sdp.c      |   20 ++++++++++----------
 arch/arm/mach-omap2/board-apollon.c      |   20 ++++++++++----------
 arch/arm/mach-omap2/board-generic.c      |   14 +++++++-------
 arch/arm/mach-omap2/board-h4.c           |   20 ++++++++++----------
 arch/arm/mach-omap2/board-ldp.c          |   20 ++++++++++----------
 arch/arm/mach-omap2/board-omap2evm.c     |   20 ++++++++++----------
 arch/arm/mach-omap2/board-omap3beagle.c  |   24 ++++++++++++------------
 arch/arm/mach-omap2/board-omap3evm.c     |   14 +++++++-------
 arch/arm/mach-omap2/board-omap3pandora.c |   18 +++++++++---------
 arch/arm/mach-omap2/board-overo.c        |   18 +++++++++---------
 arch/arm/mach-omap2/board-rx51.c         |    4 ++--
 arch/arm/mach-omap2/board-zoom2.c        |   18 +++++++++---------
 arch/arm/mach-omap2/io.c                 |    2 ++
 arch/arm/mach-omap2/serial.c             |    6 +++++-
 arch/arm/plat-omap/include/mach/serial.h |    6 ++++++
 16 files changed, 127 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 899e6e3..c563768 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -323,14 +323,6 @@ out:
 	clk_put(gpmc_fck);
 }
 
-static void __init omap_2430sdp_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	sdp2430_init_smc91x();
-}
-
 static struct omap_uart_config sdp2430_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -347,6 +339,15 @@ static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_SERIAL_CONSOLE, &sdp2430_serial_console_config},
 };
 
+static void __init omap_2430sdp_init_irq(void)
+{
+	omap_board_config = sdp2430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	sdp2430_init_smc91x();
+}
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
@@ -406,8 +407,6 @@ static void __init omap_2430sdp_init(void)
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
-	omap_board_config = sdp2430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap_serial_init();
 
 	msecure_init();
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 38550e2..26fa398 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -296,14 +296,6 @@ static inline void __init sdp3430_init_smc91x(void)
 	gpio_direction_input(eth_gpio);
 }
 
-static void __init omap_3430sdp_init_irq(void)
-{
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
-	sdp3430_init_smc91x();
-}
-
 static struct omap_uart_config sdp3430_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -317,6 +309,16 @@ static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
+static void __init omap_3430sdp_init_irq(void)
+{
+	omap_board_config = sdp3430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+	sdp3430_init_smc91x();
+}
+
 static int sdp3430_batt_table[] = {
 /* 0 C*/
 30800, 29500, 28300, 27100,
@@ -668,8 +670,6 @@ static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
-	omap_board_config = sdp3430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 936cb49..3658587 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -330,14 +330,6 @@ out:
 	clk_put(gpmc_fck);
 }
 
-static void __init omap_apollon_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	apollon_init_smc91x();
-}
-
 static struct tsc210x_config tsc_platform_data = {
 	.use_internal		= 1,
 	.monitor		= TSC_TEMP,
@@ -376,6 +368,16 @@ static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
+static void __init omap_apollon_init_irq(void)
+{
+	omap_board_config = apollon_config;
+	omap_board_config_size = ARRAY_SIZE(apollon_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	apollon_init_smc91x();
+}
+
 static void __init apollon_led_init(void)
 {
 	/* LED0 - AA10 */
@@ -506,8 +508,6 @@ static void __init omap_apollon_init(void)
 	 * if not needed.
 	 */
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
-	omap_board_config = apollon_config;
-	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_register_i2c_bus(2, 100, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 0e353b3..7bb7722 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -31,12 +31,6 @@
 #include <mach/board.h>
 #include <mach/common.h>
 
-static void __init omap_generic_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-}
-
 static struct omap_uart_config generic_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -45,10 +39,16 @@ static struct omap_board_config_kernel generic_config[] __initdata = {
 	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
-static void __init omap_generic_init(void)
+static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+}
+
+static void __init omap_generic_init(void)
+{
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_register_i2c_bus(2, 100, NULL, 0);
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 6145139..66b527e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -358,14 +358,6 @@ static void __init h4_init_flash(void)
 	h4_flash_resource.end	= base + SZ_64M - 1;
 }
 
-static void __init omap_h4_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	h4_init_flash();
-}
-
 static struct omap_uart_config h4_uart_config __initdata = {
 #ifdef	CONFIG_MACH_OMAP2_H4_USB1
 	.enabled_uarts = ((1 << 0) | (1 << 1)),
@@ -443,6 +435,16 @@ static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
+static void __init omap_h4_init_irq(void)
+{
+	omap_board_config = h4_config;
+	omap_board_config_size = ARRAY_SIZE(h4_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	h4_init_flash();
+}
+
 #ifdef	CONFIG_MACH_OMAP_H4_TUSB
 
 #include <linux/usb/musb.h>
@@ -756,8 +758,6 @@ static void __init omap_h4_init(void)
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
 
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
-	omap_board_config = h4_config;
-	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_serial_init();
 	omap_usb_init(&h4_usb_config);
 	omap_register_i2c_bus(1, 100, h4_i2c_board_info,
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b79f989..8da85c1 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -353,14 +353,6 @@ static inline void __init ldp_init_smsc911x(void)
 }
 
 
-static void __init omap_ldp_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	ldp_init_smsc911x();
-}
-
 static struct omap_uart_config ldp_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -374,6 +366,16 @@ static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
+static void __init omap_ldp_init_irq(void)
+{
+	omap_board_config = ldp_config;
+	omap_board_config_size = ARRAY_SIZE(ldp_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	ldp_init_smsc911x();
+}
+
 static int ldp_batt_table[] = {
 /* 0 C*/
 30800, 29500, 28300, 27100,
@@ -559,8 +561,6 @@ static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
-	omap_board_config = ldp_config;
-	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	ts_gpio = 54;
 	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
 	spi_register_board_info(ldp_spi_board_info,
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index 86477cc..3b80315 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -278,14 +278,6 @@ static struct twl4030_keypad_data omap2evm_kp_data = {
 	.rep		= 1,
 };
 
-static void __init omap2_evm_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	omap2evm_init_smc911x();
-}
-
 static struct omap_uart_config omap2_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -295,6 +287,16 @@ static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
 };
 
+static void __init omap2_evm_init_irq(void)
+{
+	omap_board_config = omap2_evm_config;
+	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	omap2evm_init_smc911x();
+}
+
 static struct twl4030_gpio_platform_data omap2evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -357,8 +359,6 @@ static void __init omap2_evm_init(void)
 	omap2_evm_i2c_init();
 
 	platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
-	omap_board_config = omap2_evm_config;
-	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
 	spi_register_board_info(omap2evm_spi_board_info,
 				ARRAY_SIZE(omap2evm_spi_board_info));
 	omap_serial_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 19bc2a1..f40ed10 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -306,16 +306,6 @@ static int __init omap3_beagle_i2c_init(void)
 	return 0;
 }
 
-static void __init omap3_beagle_init_irq(void)
-{
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-#ifdef CONFIG_OMAP_32K_TIMER
-	omap2_gp_clockevent_set_gptimer(12);
-#endif
-	omap_gpio_init();
-}
-
 static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -378,6 +368,18 @@ static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
 };
 
+static void __init omap3_beagle_init_irq(void)
+{
+	omap_board_config = omap3_beagle_config;
+	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+#ifdef CONFIG_OMAP_32K_TIMER
+	omap2_gp_clockevent_set_gptimer(12);
+#endif
+	omap_gpio_init();
+}
+
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&omap3_beagle_lcd_device,
 	&leds_gpio,
@@ -427,8 +429,6 @@ static void __init omap3_beagle_init(void)
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
-	omap_board_config = omap3_beagle_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
 	omap_cfg_reg(J25_34XX_GPIO170);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6eb3c52..b7f5e1d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -279,19 +279,21 @@ struct spi_board_info omap3evm_spi_board_info[] = {
 	},
 };
 
+static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
+	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
+	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
+};
+
 static void __init omap3_evm_init_irq(void)
 {
+	omap_board_config = omap3_evm_config;
+	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 	omap3evm_init_smc911x();
 }
 
-static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
-	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
-};
-
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
 	&omap3evm_smc911x_device,
@@ -302,8 +304,6 @@ static void __init omap3_evm_init(void)
 	omap3_evm_i2c_init();
 
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
-	omap_board_config = omap3_evm_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index c525b16..e8fa926 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -263,13 +263,6 @@ static int __init omap3pandora_i2c_init(void)
 	return 0;
 }
 
-static void __init omap3pandora_init_irq(void)
-{
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static void __init omap3pandora_ads7846_init(void)
 {
 	int gpio = OMAP3_PANDORA_TS_GPIO;
@@ -333,6 +326,15 @@ static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
 };
 
+static void __init omap3pandora_init_irq(void)
+{
+	omap_board_config = omap3pandora_config;
+	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&omap3pandora_lcd_device,
 };
@@ -342,8 +344,6 @@ static void __init omap3pandora_init(void)
 	omap3pandora_i2c_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
-	omap_board_config = omap3pandora_config;
-	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
 	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 3a9c519..0462e99 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -363,13 +363,6 @@ static int __init overo_i2c_init(void)
 	return 0;
 }
 
-static void __init overo_init_irq(void)
-{
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static struct platform_device overo_lcd_device = {
 	.name		= "overo_lcd",
 	.id		= -1,
@@ -384,6 +377,15 @@ static struct omap_board_config_kernel overo_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&overo_lcd_config },
 };
 
+static void __init overo_init_irq(void)
+{
+	omap_board_config = overo_config;
+	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
 static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
@@ -392,8 +394,6 @@ static void __init overo_init(void)
 {
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
-	omap_board_config = overo_config;
-	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 5ee62f8..4714576 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -62,6 +62,8 @@ static struct omap_board_config_kernel rx51_config[] = {
 
 static void __init rx51_init_irq(void)
 {
+	omap_board_config = rx51_config;
+	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap2_init_common_hw(rx51_get_sdram_timings());
 	omap_init_irq();
 	omap_gpio_init();
@@ -72,8 +74,6 @@ extern void __init rx51_video_init(void);
 
 static void __init rx51_init(void)
 {
-	omap_board_config = rx51_config;
-	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 8535c3a..bce4c60 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -23,13 +23,6 @@
 
 #include "mmc-twl4030.h"
 
-static void __init omap_zoom2_init_irq(void)
-{
-	omap2_init_common_hw(NULL);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static struct omap_uart_config zoom2_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -38,6 +31,15 @@ static struct omap_board_config_kernel zoom2_config[] __initdata = {
 	{ OMAP_TAG_UART,	&zoom2_uart_config },
 };
 
+static void __init omap_zoom2_init_irq(void)
+{
+	omap_board_config = zoom2_config;
+	omap_board_config_size = ARRAY_SIZE(zoom2_config);
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
 static struct twl4030_gpio_platform_data zoom2_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -85,8 +87,6 @@ extern int __init omap_zoom2_debugboard_init(void);
 static void __init omap_zoom2_init(void)
 {
 	omap_i2c_init();
-	omap_board_config = zoom2_config;
-	omap_board_config_size = ARRAY_SIZE(zoom2_config);
 	omap_serial_init();
 	omap_zoom2_debugboard_init();
 	twl4030_mmc_init(mmc);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 916fcd3..deb309a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -29,6 +29,7 @@
 #include <mach/sram.h>
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
+#include <mach/serial.h>
 
 #include "clock.h"
 
@@ -201,6 +202,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+	omap_serial_early_init();
 	omap2_sdrc_init(sp);
 	gpmc_init();
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3c2d325..352b88d 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -106,7 +106,7 @@ static struct platform_device serial_device = {
 	},
 };
 
-void __init omap_serial_init(void)
+void __init omap_serial_early_init(void)
 {
 	int i;
 	const struct omap_uart_config *info;
@@ -150,6 +150,10 @@ void __init omap_serial_init(void)
 
 		omap_serial_reset(p);
 	}
+}
 
+void __init omap_serial_init(void)
+{
 	platform_device_register(&serial_device);
 }
+
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index 8a676a0..b34fa47 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARCH_SERIAL_H
 #define __ASM_ARCH_SERIAL_H
 
+#include <linux/init.h>
+
 #if defined(CONFIG_ARCH_OMAP1)
 /* OMAP1 serial ports */
 #define OMAP_UART1_BASE		0xfffb0000
@@ -40,4 +42,8 @@
 			__ret;						\
 			})
 
+#ifndef __ASSEMBLER__
+void __init omap_serial_early_init(void);
+#endif
+
 #endif


