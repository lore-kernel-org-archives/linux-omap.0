From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 08/11] OMAP2/3 board-*.c files: read bootloader configuration
	earlier
Date: Tue, 18 Aug 2009 14:56:29 +0300
Message-ID: <20090818115628.14171.99601.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090818115147.14171.55785.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Most board-*.c files read configuration data from the bootloader in
their .init_machine() function.  This needs to happen earlier, at some
point before omap2_init_common_hw() is called.  This is because a
future patch will use the bootloader serial console port information
to enable the UART clocks earlier, immediately after omap2_clk_init().
This is in turn necessary since otherwise clock tree usecounts on
clocks like dpll4_m2x2_ck will be bogus, which can cause the
currently-active console UART clock to be disabled during boot.

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/board-2430sdp.c      |   17 ++++++++---------
 arch/arm/mach-omap2/board-3430sdp.c      |   18 +++++++++---------
 arch/arm/mach-omap2/board-apollon.c      |   20 ++++++++++----------
 arch/arm/mach-omap2/board-generic.c      |   14 +++++++-------
 arch/arm/mach-omap2/board-h4.c           |   20 ++++++++++----------
 arch/arm/mach-omap2/board-ldp.c          |   20 ++++++++++----------
 arch/arm/mach-omap2/board-omap3beagle.c  |   26 +++++++++++++-------------
 arch/arm/mach-omap2/board-omap3evm.c     |   14 +++++++-------
 arch/arm/mach-omap2/board-omap3pandora.c |   20 ++++++++++----------
 arch/arm/mach-omap2/board-overo.c        |   20 ++++++++++----------
 arch/arm/mach-omap2/board-rx51.c         |    4 ++--
 arch/arm/mach-omap2/board-zoom2.c        |   18 +++++++++---------
 arch/arm/mach-omap2/io.c                 |    2 ++
 arch/arm/mach-omap2/serial.c             |   14 +++++++++++++-
 arch/arm/plat-omap/include/mach/serial.h |    3 +++
 15 files changed, 123 insertions(+), 107 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8ec2a13..06c644d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -139,13 +139,6 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static void __init omap_2430sdp_init_irq(void)
-{
-	omap2_init_common_hw(NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static struct omap_uart_config sdp2430_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -155,6 +148,14 @@ static struct omap_board_config_kernel sdp2430_config[] = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
+static void __init omap_2430sdp_init_irq(void)
+{
+	omap_board_config = sdp2430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
@@ -205,8 +206,6 @@ static void __init omap_2430sdp_init(void)
 	omap2430_i2c_init();
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
-	omap_board_config = sdp2430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ac262cd..e51c124 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -167,13 +167,6 @@ static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_lcd_device,
 };
 
-static void __init omap_3430sdp_init_irq(void)
-{
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static struct omap_uart_config sdp3430_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -187,6 +180,15 @@ static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
+static void __init omap_3430sdp_init_irq(void)
+{
+	omap_board_config = sdp3430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
 static int sdp3430_batt_table[] = {
 /* 0 C*/
 30800, 29500, 28300, 27100,
@@ -482,8 +484,6 @@ static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
-	omap_board_config = sdp3430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index dcfc20d..8e063ba 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -248,14 +248,6 @@ out:
 	clk_put(gpmc_fck);
 }
 
-static void __init omap_apollon_init_irq(void)
-{
-	omap2_init_common_hw(NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	apollon_init_smc91x();
-}
-
 static struct omap_uart_config apollon_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
 };
@@ -276,6 +268,16 @@ static struct omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
+static void __init omap_apollon_init_irq(void)
+{
+	omap_board_config = apollon_config;
+	omap_board_config_size = ARRAY_SIZE(apollon_config);
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	apollon_init_smc91x();
+}
+
 static void __init apollon_led_init(void)
 {
 	/* LED0 - AA10 */
@@ -324,8 +326,6 @@ static void __init omap_apollon_init(void)
 	 * if not needed.
 	 */
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
-	omap_board_config = apollon_config;
-	omap_board_config_size = ARRAY_SIZE(apollon_config);
 	omap_serial_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fd00aa0..ef0dc67 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -31,12 +31,6 @@
 #include <mach/board.h>
 #include <mach/common.h>
 
-static void __init omap_generic_init_irq(void)
-{
-	omap2_init_common_hw(NULL, NULL);
-	omap_init_irq();
-}
-
 static struct omap_uart_config generic_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -45,10 +39,16 @@ static struct omap_board_config_kernel generic_config[] = {
 	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
-static void __init omap_generic_init(void)
+static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+}
+
+static void __init omap_generic_init(void)
+{
 	omap_serial_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 7b1d61d..66f710e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -268,14 +268,6 @@ static void __init h4_init_flash(void)
 	h4_flash_resource.end	= base + SZ_64M - 1;
 }
 
-static void __init omap_h4_init_irq(void)
-{
-	omap2_init_common_hw(NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	h4_init_flash();
-}
-
 static struct omap_uart_config h4_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -322,6 +314,16 @@ static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
+static void __init omap_h4_init_irq(void)
+{
+	omap_board_config = h4_config;
+	omap_board_config_size = ARRAY_SIZE(h4_config);
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	h4_init_flash();
+}
+
 static struct at24_platform_data m24c01 = {
 	.byte_len	= SZ_1K / 8,
 	.page_size	= 16,
@@ -366,8 +368,6 @@ static void __init omap_h4_init(void)
 			ARRAY_SIZE(h4_i2c_board_info));
 
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
-	omap_board_config = h4_config;
-	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_usb_init(&h4_usb_config);
 	omap_serial_init();
 }
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea383f8..cc64aa7 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -268,14 +268,6 @@ static inline void __init ldp_init_smsc911x(void)
 	gpio_direction_input(eth_gpio);
 }
 
-static void __init omap_ldp_init_irq(void)
-{
-	omap2_init_common_hw(NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
-	ldp_init_smsc911x();
-}
-
 static struct omap_uart_config ldp_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -294,6 +286,16 @@ static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
+static void __init omap_ldp_init_irq(void)
+{
+	omap_board_config = ldp_config;
+	omap_board_config_size = ARRAY_SIZE(ldp_config);
+	omap2_init_common_hw(NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+	ldp_init_smsc911x();
+}
+
 static struct twl4030_usb_data ldp_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -377,8 +379,6 @@ static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
-	omap_board_config = ldp_config;
-	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	ts_gpio = 54;
 	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
 	spi_register_board_info(ldp_spi_board_info,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e00ba12..f74358a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -280,17 +280,6 @@ static int __init omap3_beagle_i2c_init(void)
 	return 0;
 }
 
-static void __init omap3_beagle_init_irq(void)
-{
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-#ifdef CONFIG_OMAP_32K_TIMER
-	omap2_gp_clockevent_set_gptimer(12);
-#endif
-	omap_gpio_init();
-}
-
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "beagleboard::usr0",
@@ -349,6 +338,19 @@ static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
 };
 
+static void __init omap3_beagle_init_irq(void)
+{
+	omap_board_config = omap3_beagle_config;
+	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
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
@@ -398,8 +400,6 @@ static void __init omap3_beagle_init(void)
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
-	omap_board_config = omap3_beagle_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
 	omap_cfg_reg(J25_34XX_GPIO170);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c4b1446..067d2bc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -278,19 +278,21 @@ struct spi_board_info omap3evm_spi_board_info[] = {
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
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
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
@@ -301,8 +303,6 @@ static void __init omap3_evm_init(void)
 	omap3_evm_i2c_init();
 
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
-	omap_board_config = omap3_evm_config;
-	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 864ee3d..4958d94 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -309,14 +309,6 @@ static int __init omap3pandora_i2c_init(void)
 	return 0;
 }
 
-static void __init omap3pandora_init_irq(void)
-{
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static void __init omap3pandora_ads7846_init(void)
 {
 	int gpio = OMAP3_PANDORA_TS_GPIO;
@@ -380,6 +372,16 @@ static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
 };
 
+static void __init omap3pandora_init_irq(void)
+{
+	omap_board_config = omap3pandora_config;
+	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&omap3pandora_lcd_device,
 	&pandora_leds_gpio,
@@ -391,8 +393,6 @@ static void __init omap3pandora_init(void)
 	omap3pandora_i2c_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
-	omap_board_config = omap3pandora_config;
-	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
 	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 6bce230..a44aa13 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -360,14 +360,6 @@ static int __init overo_i2c_init(void)
 	return 0;
 }
 
-static void __init overo_init_irq(void)
-{
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
 static struct platform_device overo_lcd_device = {
 	.name		= "overo_lcd",
 	.id		= -1,
@@ -382,6 +374,16 @@ static struct omap_board_config_kernel overo_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&overo_lcd_config },
 };
 
+static void __init overo_init_irq(void)
+{
+	omap_board_config = overo_config;
+	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
 static struct platform_device *overo_devices[] __initdata = {
 	&overo_lcd_device,
 };
@@ -390,8 +392,6 @@ static void __init overo_init(void)
 {
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
-	omap_board_config = overo_config;
-	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 1c9e07f..5a0f83e 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -61,6 +61,8 @@ static struct omap_board_config_kernel rx51_config[] = {
 
 static void __init rx51_init_irq(void)
 {
+	omap_board_config = rx51_config;
+	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
@@ -70,8 +72,6 @@ extern void __init rx51_peripherals_init(void);
 
 static void __init rx51_init(void)
 {
-	omap_board_config = rx51_config;
-	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 427b7b8..df36b46 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -23,13 +23,6 @@
 
 #include "mmc-twl4030.h"
 
-static void __init omap_zoom2_init_irq(void)
-{
-	omap2_init_common_hw(NULL, NULL);
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
+	omap2_init_common_hw(NULL, NULL);
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
index 4bfe873..470b1d1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -32,6 +32,7 @@
 #include <mach/sram.h>
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
+#include <mach/serial.h>
 
 #ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
@@ -287,6 +288,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+	omap_serial_early_init();
 	omap_pm_if_init();
 	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 	_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a7421a5..098ac58 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -552,7 +552,7 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
 	},
 };
 
-void __init omap_serial_init(void)
+void __init omap_serial_early_init(void)
 {
 	int i;
 	const struct omap_uart_config *info;
@@ -607,6 +607,18 @@ void __init omap_serial_init(void)
 			p->irq += 32;
 
 		omap_uart_enable_clocks(uart);
+	}
+}
+
+void __init omap_serial_init(void)
+{
+	int i;
+
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		struct omap_uart_state *uart = &omap_uart[i];
+		struct platform_device *pdev = &uart->pdev;
+		struct device *dev = &pdev->dev;
+
 		omap_uart_reset(uart);
 		omap_uart_idle_init(uart);
 
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index def0529..e249186 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -13,6 +13,8 @@
 #ifndef __ASM_ARCH_SERIAL_H
 #define __ASM_ARCH_SERIAL_H
 
+#include <linux/init.h>
+
 #if defined(CONFIG_ARCH_OMAP1)
 /* OMAP1 serial ports */
 #define OMAP_UART1_BASE		0xfffb0000
@@ -53,6 +55,7 @@
 			})
 
 #ifndef __ASSEMBLER__
+extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
