From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2/3: UART: enable all UARTs on boot, auto disable on idle
Date: Sun, 23 Aug 2009 23:30:54 +0300
Message-ID: <1251059454-15215-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:4415 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952AbZHWUa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 16:30:57 -0400
Received: by ey-out-2122.google.com with SMTP id 22so495693eye.37
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 13:30:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Drop UART platform_data which decides which UARTs to enable during
boot.  This is no longer necessary since serial core code disables
clocks after inactivity.  Previously, the only reason for boards to
select UARTs was to ensure clocks are not disabled for PM reasons.
With automatic clock disabling during idle, this is no longer
necessary.

Background: with new UART idle code, all on-chip UARTs are idled using
a configurable inactivity timer (default 5 seconds.)  After the
inactivity timer, UART clocks are disabled automatically.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
NOTE: this will cause conflicts with some pending series such
as Paul's pre-hwmod cleanups and the OMAP4 UART fixes.
I will be happy to rework those on top of this series as it
will simplify them.

 arch/arm/mach-omap2/board-2430sdp.c      |    6 +-----
 arch/arm/mach-omap2/board-3430sdp.c      |    6 +-----
 arch/arm/mach-omap2/board-4430sdp.c      |    6 +-----
 arch/arm/mach-omap2/board-apollon.c      |    6 +-----
 arch/arm/mach-omap2/board-generic.c      |    6 +-----
 arch/arm/mach-omap2/board-h4.c           |    6 +-----
 arch/arm/mach-omap2/board-ldp.c          |    6 +-----
 arch/arm/mach-omap2/board-n8x0.c         |    7 +------
 arch/arm/mach-omap2/board-omap3beagle.c  |    6 +-----
 arch/arm/mach-omap2/board-omap3evm.c     |    6 +-----
 arch/arm/mach-omap2/board-omap3pandora.c |    6 +-----
 arch/arm/mach-omap2/board-overo.c        |    5 +----
 arch/arm/mach-omap2/board-rx51.c         |    6 +-----
 arch/arm/mach-omap2/board-zoom2.c        |    6 +-----
 arch/arm/mach-omap2/serial.c             |   11 +----------
 arch/arm/plat-omap/include/mach/board.h  |    6 ------
 arch/arm/plat-omap/include/mach/serial.h |    4 +---
 17 files changed, 16 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index c693668..7f5a74d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
q@@ -146,10 +146,6 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_platform_data sdp2430_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel sdp2430_config[] = {
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
@@ -206,7 +202,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-	omap_serial_init(&sdp2430_uart_config);
+	omap_serial_init();
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c71417f..77be668 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -174,10 +174,6 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_platform_data sdp3430_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config sdp3430_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -491,7 +487,7 @@ static void __init omap_3430sdp_init(void)
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init(&sdp3430_uart_config);
+	omap_serial_init();
 	usb_musb_init();
 	board_smc91x_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 646079f..9bed435 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -38,10 +38,6 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 };
 
-static struct omap_uart_platform_data sdp4430_uart_config __initdata = {
-	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
-};
-
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -72,7 +68,7 @@ static void __init omap_4430sdp_init(void)
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_board_config = sdp4430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
-	omap_serial_init(&sdp4430_uart_config);
+	omap_serial_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index e2947fd..615f21d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -256,10 +256,6 @@ static void __init omap_apollon_init_irq(void)
 	apollon_init_smc91x();
 }
 
-static struct omap_uart_platform_data apollon_uart_config __initdata = {
-	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
-};
-
 static struct omap_usb_config apollon_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
@@ -325,7 +321,7 @@ static void __init omap_apollon_init(void)
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap_serial_init(&apollon_uart_config);
+	omap_serial_init();
 }
 
 static void __init omap_apollon_map_io(void)
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fc9eccb..3e401c5 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -37,10 +37,6 @@ static void __init omap_generic_init_irq(void)
 	omap_init_irq();
 }
 
-static struct omap_uart_platform_data generic_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel generic_config[] = {
 };
 
@@ -48,7 +44,7 @@ static void __init omap_generic_init(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap_serial_init(&generic_uart_config);
+	omap_serial_init();
 }
 
 static void __init omap_generic_map_io(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 7eda321..b6501d2 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -276,10 +276,6 @@ static void __init omap_h4_init_irq(void)
 	h4_init_flash();
 }
 
-static struct omap_uart_platform_data h4_uart_config __initdata = {
-	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config h4_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -368,7 +364,7 @@ static void __init omap_h4_init(void)
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_usb_init(&h4_usb_config);
-	omap_serial_init(&h4_uart_config);
+	omap_serial_init();
 }
 
 static void __init omap_h4_map_io(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 4a4b300..2dd6806 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -276,10 +276,6 @@ static void __init omap_ldp_init_irq(void)
 	ldp_init_smsc911x();
 }
 
-static struct omap_uart_platform_data ldp_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct platform_device ldp_lcd_device = {
 	.name		= "ldp_lcd",
 	.id		= -1,
@@ -383,7 +379,7 @@ static void __init omap_ldp_init(void)
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init(&ldp_uart_config);
+	omap_serial_init();
 	usb_musb_init();
 
 	twl4030_mmc_init(mmc);
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index af6fcee..8341632 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -96,11 +96,6 @@ static void __init n8x0_onenand_init(void) {}
 
 #endif
 
-/* FIXME: n810 needs UART1 */
-static struct omap_uart_platform_data n8x0_uart_config __initdata = {
-	.enabled_uarts = (1 << 2),
-};
-
 static void __init n8x0_map_io(void)
 {
 	omap2_set_globals_242x();
@@ -120,7 +115,7 @@ static void __init n8x0_init_machine(void)
 	spi_register_board_info(n800_spi_board_info,
 				ARRAY_SIZE(n800_spi_board_info));
 
-	omap_serial_init(&n8x0_uart_config);
+	omap_serial_init();
 	n8x0_onenand_init();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 07aee90..f1e2dbe 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -108,10 +108,6 @@ static struct platform_device omap3beagle_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct omap_uart_platform_data omap3_beagle_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -404,7 +400,7 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
-	omap_serial_init(&omap3_beagle_uart_config);
+	omap_serial_init();
 
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b3a080f..ba97c75 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -91,10 +91,6 @@ static inline void __init omap3evm_init_smc911x(void)
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
-static struct omap_uart_platform_data omap3_evm_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -305,7 +301,7 @@ static void __init omap3_evm_init(void)
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
-	omap_serial_init(&omap3_evm_uart_config);
+	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	ads7846_dev_init();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 1991f19..d05dd37 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -213,10 +213,6 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct omap_uart_platform_data omap3pandora_uart_config __initdata = {
-	.enabled_uarts	= (1 << 2), /* UART3 */
-};
-
 static struct regulator_consumer_supply pandora_vmmc1_supply = {
 	.supply			= "vmmc",
 };
@@ -392,7 +388,7 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_board_config = omap3pandora_config;
 	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
-	omap_serial_init(&omap3pandora_uart_config);
+	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index a9d7c2e..3b3ee7c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -271,9 +271,6 @@ static void __init overo_flash_init(void)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
-static struct omap_uart_platform_data overo_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
 
 static struct twl4030_hsmmc_info mmc[] = {
 	{
@@ -391,7 +388,7 @@ static void __init overo_init(void)
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
-	omap_serial_init(&overo_uart_config);
+	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 183, -EINVAL);
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 8a3dc61..c0d1340 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,10 +31,6 @@
 #include <mach/gpmc.h>
 #include <mach/usb.h>
 
-static struct omap_uart_platform_data rx51_uart_config = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -71,7 +67,7 @@ static void __init rx51_init(void)
 {
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
-	omap_serial_init(&rx51_uart_config);
+	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
 
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 4d295d5..dabba27 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -97,10 +97,6 @@ static void __init omap_zoom2_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_platform_data zoom2_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
-};
-
 static struct omap_board_config_kernel zoom2_config[] __initdata = {
 };
 
@@ -268,7 +264,7 @@ static void __init omap_zoom2_init(void)
 	omap_i2c_init();
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap_serial_init(&zoom2_uart_config);
+	omap_serial_init();
 	omap_zoom2_debugboard_init();
 	usb_musb_init();
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c036f0c..409b033 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -552,7 +552,7 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
 	},
 };
 
-void __init omap_serial_init(const struct omap_uart_platform_data *pdata)
+void __init omap_serial_init(void)
 {
 	int i;
 	char name[16];
@@ -563,21 +563,12 @@ void __init omap_serial_init(const struct omap_uart_platform_data *pdata)
 	 * if not needed.
 	 */
 
-	if (pdata == NULL)
-		return;
-
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
 		struct plat_serial8250_port *p = dev->platform_data;
 
-		if (!(pdata->enabled_uarts & (1 << i))) {
-			p->membase = NULL;
-			p->mapbase = 0;
-			continue;
-		}
-
 		sprintf(name, "uart%d_ick", i+1);
 		uart->ick = clk_get(NULL, name);
 		if (IS_ERR(uart->ick)) {
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index ac8e6d8..8245185 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -111,12 +111,6 @@ struct omap_gpio_switch_config {
 	int key_code:24; /* Linux key code */
 };
 
-struct omap_uart_platform_data {
-	/* Bit field of UARTs present; bit 0 --> UART1 */
-	unsigned int enabled_uarts;
-};
-
-
 struct omap_flash_part_config {
 	char part_table[0];
 };
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index 88e1e56..def0529 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -53,9 +53,7 @@
 			})
 
 #ifndef __ASSEMBLER__
-struct omap_uart_platform_data;
-
-extern void omap_serial_init(const struct omap_uart_platform_data *pdata);
+extern void omap_serial_init(void);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-- 
1.6.4

