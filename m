From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: OMAP: get rid of OMAP_TAG_USB
Date: Wed, 04 Mar 2009 13:56:13 -0800
Message-ID: <20090304215613.21101.95933.stgit@localhost>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62286 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbZCDV4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 16:56:17 -0500
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi@nokia.com>

OMAP_TAGS should vanish soon since they're not generic arm tags.
Most of them can be converted to a platform_data or parsed
from a command line like e.g. serial tag.

For OMAP_TAG_USB we just let boards call omap_usb_init()
passing a pointer to omap_usb_config.

Patch updated by Tony for mainline, basically make
n770 and h4 compile.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c   |    2 +-
 arch/arm/mach-omap1/board-generic.c     |    5 ++---
 arch/arm/mach-omap1/board-h2.c          |    2 +-
 arch/arm/mach-omap1/board-h3.c          |    2 +-
 arch/arm/mach-omap1/board-innovator.c   |    5 ++---
 arch/arm/mach-omap1/board-nokia770.c    |    9 +-------
 arch/arm/mach-omap1/board-osk.c         |    2 +-
 arch/arm/mach-omap1/board-palmte.c      |    2 +-
 arch/arm/mach-omap1/board-palmtt.c      |    2 +-
 arch/arm/mach-omap1/board-palmz71.c     |    2 +-
 arch/arm/mach-omap1/board-sx1.c         |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c   |    2 +-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-h4.c          |   34 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/board.h |    1 -
 arch/arm/plat-omap/include/mach/usb.h   |    2 ++
 arch/arm/plat-omap/usb.c                |   25 ++++-------------------
 17 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2e61839..8b40aac 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -175,7 +175,6 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 static struct omap_board_config_kernel ams_delta_config[] = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
-	{ OMAP_TAG_USB,		&ams_delta_usb_config },
 };
 
 static struct resource ams_delta_kp_resources[] = {
@@ -232,6 +231,7 @@ static void __init ams_delta_init(void)
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
 
+	omap_usb_init(&ams_delta_usb_config);
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 }
 
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 7d26702..e724940 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -62,7 +62,6 @@ static struct omap_uart_config generic_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel generic_config[] __initdata = {
-	{ OMAP_TAG_USB,		NULL },
 	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
@@ -70,12 +69,12 @@ static void __init omap_generic_init(void)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap15xx()) {
-		generic_config[0].data = &generic1510_usb_config;
+		omap_usb_init(&generic1510_usb_config);
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
 	if (!cpu_is_omap1510()) {
-		generic_config[0].data = &generic1610_usb_config;
+		omap_usb_init(&generic1610_usb_config);
 	}
 #endif
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 0d784a7..9f3b392 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -364,7 +364,6 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_USB,		&h2_usb_config },
 	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
@@ -413,6 +412,7 @@ static void __init h2_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
+	omap_usb_init(&h2_usb_config);
 	h2_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index bf08b6a..a3c513d 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -418,7 +418,6 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
-	{ OMAP_TAG_USB,		&h3_usb_config },
 	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
@@ -472,6 +471,7 @@ static void __init h3_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
+	omap_usb_init(&h3_usb_config);
 	h3_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 071cd02..ed7ee07 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -370,7 +370,6 @@ static struct omap_uart_config innovator_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel innovator_config[] = {
-	{ OMAP_TAG_USB,         NULL },
 	{ OMAP_TAG_LCD,		NULL },
 	{ OMAP_TAG_UART,	&innovator_uart_config },
 };
@@ -392,13 +391,13 @@ static void __init innovator_init(void)
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
-		innovator_config[0].data = &innovator1510_usb_config;
+		omap_usb_init(&innovator1510_usb_config);
 		innovator_config[1].data = &innovator1510_lcd_config;
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (cpu_is_omap1610()) {
-		innovator_config[0].data = &h2_usb_config;
+		omap_usb_init(&h2_usb_config);
 		innovator_config[1].data = &innovator1610_lcd_config;
 	}
 #endif
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index af51e0b..7bc7a3c 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -233,10 +233,6 @@ static inline void nokia770_mmc_init(void)
 }
 #endif
 
-static struct omap_board_config_kernel nokia770_config[] __initdata = {
-	{ OMAP_TAG_USB,		NULL },
-};
-
 #if	defined(CONFIG_OMAP_DSP)
 /*
  * audio power control
@@ -371,19 +367,16 @@ static __init int omap_dsp_init(void)
 
 static void __init omap_nokia770_init(void)
 {
-	nokia770_config[0].data = &nokia770_usb_config;
-
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
-	omap_board_config = nokia770_config;
-	omap_board_config_size = ARRAY_SIZE(nokia770_config);
 	omap_gpio_init();
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_dsp_init();
 	ads7846_dev_init();
 	mipid_dev_init();
+	omap_usb_init(&nokia770_usb_config);
 	nokia770_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 1a16ecb..99913ac 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -290,7 +290,6 @@ static struct omap_lcd_config osk_lcd_config __initdata = {
 #endif
 
 static struct omap_board_config_kernel osk_config[] __initdata = {
-	{ OMAP_TAG_USB,           &osk_usb_config },
 	{ OMAP_TAG_UART,		&osk_uart_config },
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 	{ OMAP_TAG_LCD,			&osk_lcd_config },
@@ -510,6 +509,7 @@ static void __init osk_mistral_init(void)
 	i2c_register_board_info(1, mistral_i2c_board_info,
 			ARRAY_SIZE(mistral_i2c_board_info));
 
+	omap_usb_init(&osk_usb_config);
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 99f2b43..b2d3a36 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -286,7 +286,6 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 #endif
 
 static struct omap_board_config_kernel palmte_config[] __initdata = {
-	{ OMAP_TAG_USB,		&palmte_usb_config },
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
 	{ OMAP_TAG_UART,	&palmte_uart_config },
 };
@@ -341,6 +340,7 @@ static void __init omap_palmte_init(void)
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
 	palmte_misc_gpio_setup();
 	omap_serial_init();
+	omap_usb_init(&palmte_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 1cbc127..90795bf 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -272,7 +272,6 @@ static struct omap_uart_config palmtt_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel palmtt_config[] __initdata = {
-	{ OMAP_TAG_USB,		&palmtt_usb_config	},
 	{ OMAP_TAG_LCD,		&palmtt_lcd_config	},
 	{ OMAP_TAG_UART,	&palmtt_uart_config	},
 };
@@ -297,6 +296,7 @@ static void __init omap_palmtt_init(void)
 
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
+	omap_usb_init(&palmtt_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index baf5efb..89b50e8 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -239,7 +239,6 @@ static struct omap_uart_config palmz71_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel palmz71_config[] __initdata = {
-	{OMAP_TAG_USB,	&palmz71_usb_config},
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},
 	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
@@ -313,6 +312,7 @@ omap_palmz71_init(void)
 
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
+	omap_usb_init(&palmz71_usb_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	palmz71_gpio_setup(0);
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 28c76a1..7d6f0b7 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -373,7 +373,6 @@ static struct omap_uart_config sx1_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel sx1_config[] __initdata = {
-	{ OMAP_TAG_USB,	&sx1_usb_config },
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
@@ -388,6 +387,7 @@ static void __init omap_sx1_init(void)
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_usb_init(&sx1_usb_config);
 	sx1_mmc_init();
 
 	/* turn on USB power */
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index a765354..98275e0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -145,7 +145,6 @@ static struct omap_uart_config voiceblue_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel voiceblue_config[] = {
-	{ OMAP_TAG_USB,  &voiceblue_usb_config },
 	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
 
@@ -185,6 +184,7 @@ static void __init voiceblue_init(void)
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
+	omap_usb_init(&voiceblue_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	/* There is a good chance board is going up, so enable power LED
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 0a7b24b..30e7049 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -272,7 +272,6 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 
 static struct omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
-	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
@@ -299,6 +298,7 @@ static void __init apollon_usb_init(void)
 	omap_cfg_reg(P21_242X_GPIO12);
 	gpio_request(12, "USB suspend");
 	gpio_direction_output(12, 0);
+	omap_usb_init(&apollon_usb_config);
 }
 
 static void __init omap_apollon_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 5e9b146..ff51c0f 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -377,6 +377,39 @@ static struct omap_lcd_config h4_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
+static struct omap_usb_config h4_usb_config __initdata = {
+#ifdef	CONFIG_MACH_OMAP2_H4_USB1
+	/* NOTE:  usb1 could also be used with 3 wire signaling */
+	.pins[1]	= 4,
+#endif
+
+#ifdef	CONFIG_MACH_OMAP_H4_OTG
+	/* S1.10 ON -- USB OTG port
+	 * usb0 switched to Mini-AB port and isp1301 transceiver;
+	 * S2.POS3 = OFF, S2.POS4 = ON ... to allow battery charging
+	 */
+	.otg		= 1,
+	.pins[0]	= 4,
+#ifdef	CONFIG_USB_GADGET_OMAP
+	/* use OTG cable, or standard A-to-MiniB */
+	.hmc_mode	= 0x14,	/* 0:dev/otg 1:host 2:disable */
+#elif	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	/* use OTG cable, or NONSTANDARD (B-to-MiniB) */
+	.hmc_mode	= 0x11,	/* 0:host 1:host 2:disable */
+#endif	/* XX */
+
+#else
+	/* S1.10 OFF -- usb "download port"
+	 * usb0 switched to Mini-B port and isp1105 transceiver;
+	 * S2.POS3 = ON, S2.POS4 = OFF ... to enable battery charging
+	 */
+	.register_dev	= 1,
+	.pins[0]	= 3,
+/*	.hmc_mode	= 0x14,*/	/* 0:dev 1:host 2:disable */
+	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
+#endif
+};
+
 static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
@@ -428,6 +461,7 @@ static void __init omap_h4_init(void)
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
+	omap_usb_init(&h4_usb_config);
 	omap_serial_init();
 }
 
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 9466772..5e857f8 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -17,7 +17,6 @@
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_SERIAL_CONSOLE 0x4f03
-#define OMAP_TAG_USB		0x4f04
 #define OMAP_TAG_LCD		0x4f05
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
 #define OMAP_TAG_UART		0x4f07
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index a56a610..e033e51 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -29,6 +29,8 @@
 
 #endif
 
+void omap_usb_init(struct omap_usb_config *pdata);
+
 /*-------------------------------------------------------------------------*/
 
 /*
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index e278de6..509f2ed 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -729,30 +729,13 @@ static inline void omap_1510_usb_init(struct omap_usb_config *config) {}
 
 /*-------------------------------------------------------------------------*/
 
-static struct omap_usb_config platform_data;
-
-static int __init
-omap_usb_init(void)
+void __init omap_usb_init(struct omap_usb_config *pdata)
 {
-	const struct omap_usb_config *config;
-
-	config = omap_get_config(OMAP_TAG_USB, struct omap_usb_config);
-	if (config == NULL) {
-		printk(KERN_ERR "USB: No board-specific "
-				"platform config found\n");
-		return -ENODEV;
-	}
-	platform_data = *config;
-
 	if (cpu_is_omap730() || cpu_is_omap16xx() || cpu_is_omap24xx())
-		omap_otg_init(&platform_data);
+		omap_otg_init(pdata);
 	else if (cpu_is_omap15xx())
-		omap_1510_usb_init(&platform_data);
-	else {
+		omap_1510_usb_init(pdata);
+	else
 		printk(KERN_ERR "USB: No init for your chip yet\n");
-		return -ENODEV;
-	}
-	return 0;
 }
 
-subsys_initcall(omap_usb_init);

