From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] omap: get rid of OMAP_TAG_USB
Date: Thu, 25 Sep 2008 17:22:11 +0300
Message-ID: <1222352531-30796-2-git-send-email-felipe.balbi@nokia.com>
References: <1222352531-30796-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18398 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYIYOXT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:23:19 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8PEN1q9013276
	for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 17:23:16 +0300
In-Reply-To: <1222352531-30796-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

OMAP_TAGS should vanish soon since they're not generic arm tags.
Most of them can be converted to a platform_data or parsed
from a command line line the serial tag.

For OMAP_TAG_USB we just let boards call omap_usb_init()
passing a pointer to omap_usb_config.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap1/board-ams-delta.c       |    2 +-
 arch/arm/mach-omap1/board-generic.c         |    5 ++---
 arch/arm/mach-omap1/board-h2.c              |    2 +-
 arch/arm/mach-omap1/board-h3.c              |    2 +-
 arch/arm/mach-omap1/board-innovator.c       |    5 ++---
 arch/arm/mach-omap1/board-nokia770.c        |    3 +--
 arch/arm/mach-omap1/board-osk.c             |    2 +-
 arch/arm/mach-omap1/board-palmte.c          |    2 +-
 arch/arm/mach-omap1/board-palmtt.c          |    2 +-
 arch/arm/mach-omap1/board-palmz71.c         |    2 +-
 arch/arm/mach-omap1/board-sx1.c             |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c       |    2 +-
 arch/arm/mach-omap2/board-apollon.c         |    2 +-
 arch/arm/mach-omap2/board-h4.c              |    2 +-
 arch/arm/plat-omap/include/mach/board.h     |    1 -
 arch/arm/plat-omap/include/mach/usb.h       |    1 +
 arch/arm/plat-omap/usb.c                    |   25 ++++---------------------
 18 files changed, 22 insertions(+), 42 deletions(-)

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
index 2c12dfa..ab1109b 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -494,7 +494,6 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_USB,		&h2_usb_config },
 	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
@@ -549,6 +548,7 @@ static void __init h2_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
+	omap_usb_init(&h2_usb_config);
 	h2_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index c333db1..2bf50f1 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -471,7 +471,6 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
-	{ OMAP_TAG_USB,		&h3_usb_config },
 	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
@@ -630,6 +629,7 @@ static void __init h3_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
+	omap_usb_init(&h3_usb_config);
 	h3_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 7a97f6b..228c86d 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -409,7 +409,6 @@ static struct omap_uart_config innovator_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel innovator_config[] = {
-	{ OMAP_TAG_USB,         NULL },
 	{ OMAP_TAG_LCD,		NULL },
 	{ OMAP_TAG_UART,	&innovator_uart_config },
 };
@@ -431,13 +430,13 @@ static void __init innovator_init(void)
 
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
index 7b28f4d..40d601a 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -407,8 +407,6 @@ static __init int omap_dsp_init(void)
 
 static void __init omap_nokia770_init(void)
 {
-	nokia770_config[0].data = &nokia770_usb_config;
-
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
@@ -421,6 +419,7 @@ static void __init omap_nokia770_init(void)
 	hwa742_dev_init();
 	ads7846_dev_init();
 	mipid_dev_init();
+	omap_usb_init(&nokia770_usb_config);
 	nokia770_mmc_init();
 }
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3e766e4..bfe4af7 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -327,7 +327,6 @@ static struct omap_lcd_config osk_lcd_config __initdata = {
 #endif
 
 static struct omap_board_config_kernel osk_config[] __initdata = {
-	{ OMAP_TAG_USB,           &osk_usb_config },
 	{ OMAP_TAG_UART,		&osk_uart_config },
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 	{ OMAP_TAG_LCD,			&osk_lcd_config },
@@ -520,6 +519,7 @@ static void __init osk_mistral_init(void)
 	if (gpio_request(2, "lcd_pwr") == 0)
 		gpio_direction_output(2, 1);
 
+	omap_usb_init(&osk_usb_config);
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
 #else
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index ee49e2c..6140e5a 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -307,7 +307,6 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 #endif
 
 static struct omap_board_config_kernel palmte_config[] __initdata = {
-	{ OMAP_TAG_USB,		&palmte_usb_config },
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
 	{ OMAP_TAG_UART,	&palmte_uart_config },
 };
@@ -397,6 +396,7 @@ static void __init omap_palmte_init(void)
 
 	palmte_misc_gpio_setup();
 	omap_serial_init();
+	omap_usb_init(&palmte_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 40f9860..f1def77 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -313,7 +313,6 @@ static struct omap_uart_config palmtt_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel palmtt_config[] __initdata = {
-	{ OMAP_TAG_USB,		&palmtt_usb_config	},
 	{ OMAP_TAG_LCD,		&palmtt_lcd_config	},
 	{ OMAP_TAG_UART,	&palmtt_uart_config	},
 };
@@ -338,6 +337,7 @@ static void __init omap_palmtt_init(void)
 
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
 	omap_serial_init();
+	omap_usb_init(&palmtt_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e8116c5..b17a577 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -276,7 +276,6 @@ static struct omap_uart_config palmz71_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel palmz71_config[] __initdata = {
-	{OMAP_TAG_USB,	&palmz71_usb_config},
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},
 	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
@@ -351,6 +350,7 @@ omap_palmz71_init(void)
 
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
+	omap_usb_init(&palmz71_usb_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	palmz71_gpio_setup(0);
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index e9ba5dc..613c33f 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -405,7 +405,6 @@ static struct omap_uart_config sx1_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel sx1_config[] __initdata = {
-	{ OMAP_TAG_USB,	&sx1_usb_config },
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
@@ -420,6 +419,7 @@ static void __init omap_sx1_init(void)
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap_usb_init(&sx1_usb_config);
 	sx1_mmc_init();
 
 	/* turn on USB power */
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 069ca8d..6b2cbfb 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -145,7 +145,6 @@ static struct omap_uart_config voiceblue_uart_config __initdata = {
 };
 
 static struct omap_board_config_kernel voiceblue_config[] = {
-	{ OMAP_TAG_USB,  &voiceblue_usb_config },
 	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
 
@@ -187,6 +186,7 @@ static void __init voiceblue_init(void)
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
 	omap_serial_init();
+	omap_usb_init(&voiceblue_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	/* There is a good chance board is going up, so enable power LED
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 1f3af48..014fdd5 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -364,7 +364,6 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 
 static struct omap_board_config_kernel apollon_config[] __initdata = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
-	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
@@ -394,6 +393,7 @@ static void __init apollon_usb_init(void)
 	omap_request_gpio(12);
 	omap_set_gpio_direction(12, 0);		/* OUT */
 	omap_set_gpio_dataout(12, 0);
+	omap_usb_init(&apollon_usb_config);
 }
 
 static void __init apollon_tsc_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index c65358b..0062f0d 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -458,7 +458,6 @@ static struct spi_board_info h4_spi_board_info[] __initdata = {
 static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
-	{ OMAP_TAG_USB,		&h4_usb_config },
 };
 
 #ifdef	CONFIG_MACH_OMAP_H4_TUSB
@@ -688,6 +687,7 @@ static void __init omap_h4_init(void)
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_serial_init();
+	omap_usb_init(&h4_usb_config);
 	h4_mmc_init();
 	omap_register_i2c_bus(1, 100, h4_i2c_board_info,
 			      ARRAY_SIZE(h4_i2c_board_info));
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 2ba5e5d..8dc9887 100644
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
index e078155..b3e12b9 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -29,6 +29,7 @@
 
 void __init usb_musb_init(void);
 void __init usb_ehci_init(void);
+void omap_usb_init(struct omap_usb_config *pdata);
 
 #endif
 
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 777485e..4d62cd0 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -775,30 +775,13 @@ static inline void omap_1510_usb_init(struct omap_usb_config *config) {}
 
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
-- 
1.6.0.2.307.gc427

