From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] OMAP: remove OMAP_TAG_UART
Date: Tue, 11 Aug 2009 12:47:56 +0300
Message-ID: <20090811094756.32577.86259.stgit@localhost>
References: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090811094348.32577.81307.stgit@localhost>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Kalle Valo <kalle.valo@iki.fi>

Omap tags are deprecrated and convert all OMAP_TAG_UART cases to use
omap_uart_platform_data instead.

Tested on rx51 and n8x0. Compile tested on omap_osk_5912.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c    |    5 ++---
 arch/arm/mach-omap1/board-fsample.c      |    5 ++---
 arch/arm/mach-omap1/board-generic.c      |    5 ++---
 arch/arm/mach-omap1/board-h2.c           |    5 ++---
 arch/arm/mach-omap1/board-h3.c           |    5 ++---
 arch/arm/mach-omap1/board-innovator.c    |    5 ++---
 arch/arm/mach-omap1/board-nokia770.c     |    5 ++++-
 arch/arm/mach-omap1/board-osk.c          |    5 ++---
 arch/arm/mach-omap1/board-palmte.c       |    5 ++---
 arch/arm/mach-omap1/board-palmtt.c       |    5 ++---
 arch/arm/mach-omap1/board-palmz71.c      |    5 ++---
 arch/arm/mach-omap1/board-perseus2.c     |    5 ++---
 arch/arm/mach-omap1/board-sx1.c          |    5 ++---
 arch/arm/mach-omap1/board-voiceblue.c    |    5 ++---
 arch/arm/mach-omap1/serial.c             |    8 +++-----
 arch/arm/mach-omap2/board-2430sdp.c      |    5 ++---
 arch/arm/mach-omap2/board-3430sdp.c      |    5 ++---
 arch/arm/mach-omap2/board-4430sdp.c      |    5 ++---
 arch/arm/mach-omap2/board-apollon.c      |    5 ++---
 arch/arm/mach-omap2/board-generic.c      |    5 ++---
 arch/arm/mach-omap2/board-h4.c           |    5 ++---
 arch/arm/mach-omap2/board-ldp.c          |    5 ++---
 arch/arm/mach-omap2/board-omap3beagle.c  |    5 ++---
 arch/arm/mach-omap2/board-omap3evm.c     |    5 ++---
 arch/arm/mach-omap2/board-omap3pandora.c |    5 ++---
 arch/arm/mach-omap2/board-overo.c        |    5 ++---
 arch/arm/mach-omap2/board-rx51.c         |    5 ++---
 arch/arm/mach-omap2/board-zoom2.c        |    5 ++---
 arch/arm/mach-omap2/serial.c             |    9 +++------
 arch/arm/plat-omap/include/mach/board.h  |    3 +--
 arch/arm/plat-omap/include/mach/serial.h |    4 +++-
 31 files changed, 66 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 8b40aac..db4d9a4 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -162,7 +162,7 @@ static struct omap_lcd_config ams_delta_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_uart_config ams_delta_uart_config __initdata = {
+static struct omap_uart_platform_data ams_delta_uart_config __initdata = {
 	.enabled_uarts = 1,
 };
 
@@ -174,7 +174,6 @@ static struct omap_usb_config ams_delta_usb_config __initdata = {
 
 static struct omap_board_config_kernel ams_delta_config[] = {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
-	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 };
 
 static struct resource ams_delta_kp_resources[] = {
@@ -225,7 +224,7 @@ static void __init ams_delta_init(void)
 
 	omap_board_config = ams_delta_config;
 	omap_board_config_size = ARRAY_SIZE(ams_delta_config);
-	omap_serial_init();
+	omap_serial_init(&ams_delta_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 19e0e92..3eda799 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -240,7 +240,7 @@ static int nand_dev_ready(struct omap_nand_platform_data *data)
 	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
-static struct omap_uart_config fsample_uart_config __initdata = {
+static struct omap_uart_platform_data fsample_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1)),
 };
 
@@ -249,7 +249,6 @@ static struct omap_lcd_config fsample_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel fsample_config[] = {
-	{ OMAP_TAG_UART,	&fsample_uart_config },
 	{ OMAP_TAG_LCD,		&fsample_lcd_config },
 };
 
@@ -266,7 +265,7 @@ static void __init omap_fsample_init(void)
 
 	omap_board_config = fsample_config;
 	omap_board_config_size = ARRAY_SIZE(fsample_config);
-	omap_serial_init();
+	omap_serial_init(&fsample_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e724940..d700277 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -57,12 +57,11 @@ static struct omap_usb_config generic1610_usb_config __initdata = {
 };
 #endif
 
-static struct omap_uart_config generic_uart_config __initdata = {
+static struct omap_uart_platform_data generic_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel generic_config[] __initdata = {
-	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
 static void __init omap_generic_init(void)
@@ -80,7 +79,7 @@ static void __init omap_generic_init(void)
 
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap_serial_init();
+	omap_serial_init(&generic_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index f695aa0..9c12d9a 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -360,7 +360,7 @@ static struct omap_usb_config h2_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_uart_config h2_uart_config __initdata = {
+static struct omap_uart_platform_data h2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -369,7 +369,6 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
 
@@ -414,7 +413,7 @@ static void __init h2_init(void)
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
-	omap_serial_init();
+	omap_serial_init(&h2_uart_config);
 	omap_register_i2c_bus(1, 100, h2_i2c_board_info,
 			      ARRAY_SIZE(h2_i2c_board_info));
 	omap_usb_init(&h2_usb_config);
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index f597968..8c003ee 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -313,7 +313,7 @@ static struct omap_usb_config h3_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_uart_config h3_uart_config __initdata = {
+static struct omap_uart_platform_data h3_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -322,7 +322,6 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
-	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
 
@@ -372,7 +371,7 @@ static void __init h3_init(void)
 				ARRAY_SIZE(h3_spi_board_info));
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
-	omap_serial_init();
+	omap_serial_init(&h3_uart_config);
 	omap_register_i2c_bus(1, 100, h3_i2c_board_info,
 			      ARRAY_SIZE(h3_i2c_board_info));
 	omap_usb_init(&h3_usb_config);
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 2fd9826..e09705c 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -368,13 +368,12 @@ static inline void innovator_mmc_init(void)
 }
 #endif
 
-static struct omap_uart_config innovator_uart_config __initdata = {
+static struct omap_uart_platform_data innovator_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel innovator_config[] = {
 	{ OMAP_TAG_LCD,		NULL },
-	{ OMAP_TAG_UART,	&innovator_uart_config },
 };
 
 static void __init innovator_init(void)
@@ -406,7 +405,7 @@ static void __init innovator_init(void)
 #endif
 	omap_board_config = innovator_config;
 	omap_board_config_size = ARRAY_SIZE(innovator_config);
-	omap_serial_init();
+	omap_serial_init(&innovator_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	innovator_mmc_init();
 }
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index ed2a48a..e08fe46 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -380,7 +380,10 @@ static void __init omap_nokia770_init(void)
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_gpio_init();
-	omap_serial_init();
+
+	/* FIXME: configure serial ports */
+	omap_serial_init(NULL);
+
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_dsp_init();
 	hwa742_dev_init();
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index cf3247b..3eac0a1 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -293,7 +293,7 @@ static struct omap_usb_config osk_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_uart_config osk_uart_config __initdata = {
+static struct omap_uart_platform_data osk_uart_config __initdata = {
 	.enabled_uarts = (1 << 0),
 };
 
@@ -304,7 +304,6 @@ static struct omap_lcd_config osk_lcd_config __initdata = {
 #endif
 
 static struct omap_board_config_kernel osk_config[] __initdata = {
-	{ OMAP_TAG_UART,		&osk_uart_config },
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 	{ OMAP_TAG_LCD,			&osk_lcd_config },
 #endif
@@ -561,7 +560,7 @@ static void __init osk_init(void)
 	if (gpio_request(OMAP_MPUIO(1), "tps65010") == 0)
 		gpio_direction_input(OMAP_MPUIO(1));
 
-	omap_serial_init();
+	omap_serial_init(&osk_uart_config);
 	omap_register_i2c_bus(1, 400, osk_i2c_board_info,
 			      ARRAY_SIZE(osk_i2c_board_info));
 	osk_mistral_init();
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 886b4c0..2ad30fa 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -212,7 +212,7 @@ static struct omap_lcd_config palmte_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_uart_config palmte_uart_config __initdata = {
+static struct omap_uart_platform_data palmte_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
@@ -302,7 +302,6 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 
 static struct omap_board_config_kernel palmte_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
-	{ OMAP_TAG_UART,	&palmte_uart_config },
 };
 
 static struct spi_board_info palmte_spi_info[] __initdata = {
@@ -354,7 +353,7 @@ static void __init omap_palmte_init(void)
 
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
 	palmte_misc_gpio_setup();
-	omap_serial_init();
+	omap_serial_init(&palmte_uart_config);
 	omap_usb_init(&palmte_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 4f1b448..41aab87 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -274,13 +274,12 @@ static struct omap_lcd_config palmtt_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
-static struct omap_uart_config palmtt_uart_config __initdata = {
+static struct omap_uart_platform_data palmtt_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
 static struct omap_board_config_kernel palmtt_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&palmtt_lcd_config	},
-	{ OMAP_TAG_UART,	&palmtt_uart_config	},
 };
 
 static void __init omap_mpu_wdt_mode(int mode) {
@@ -302,7 +301,7 @@ static void __init omap_palmtt_init(void)
 	platform_add_devices(palmtt_devices, ARRAY_SIZE(palmtt_devices));
 
 	spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
-	omap_serial_init();
+	omap_serial_init(&palmtt_uart_config);
 	omap_usb_init(&palmtt_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 9a55c3c..ba2b96c 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -244,13 +244,12 @@ static struct omap_lcd_config palmz71_lcd_config __initdata = {
 	.ctrl_name = "internal",
 };
 
-static struct omap_uart_config palmz71_uart_config __initdata = {
+static struct omap_uart_platform_data palmz71_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
 static struct omap_board_config_kernel palmz71_config[] __initdata = {
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},
-	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
 
 static irqreturn_t
@@ -323,7 +322,7 @@ omap_palmz71_init(void)
 	spi_register_board_info(palmz71_boardinfo,
 				ARRAY_SIZE(palmz71_boardinfo));
 	omap_usb_init(&palmz71_usb_config);
-	omap_serial_init();
+	omap_serial_init(&palmz71_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	palmz71_gpio_setup(0);
 }
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 3b9f907..8b3dbdc 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -208,7 +208,7 @@ static int nand_dev_ready(struct omap_nand_platform_data *data)
 	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
-static struct omap_uart_config perseus2_uart_config __initdata = {
+static struct omap_uart_platform_data perseus2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1)),
 };
 
@@ -217,7 +217,6 @@ static struct omap_lcd_config perseus2_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel perseus2_config[] __initdata = {
-	{ OMAP_TAG_UART,	&perseus2_uart_config },
 	{ OMAP_TAG_LCD,		&perseus2_lcd_config },
 };
 
@@ -234,7 +233,7 @@ static void __init omap_perseus2_init(void)
 
 	omap_board_config = perseus2_config;
 	omap_board_config_size = ARRAY_SIZE(perseus2_config);
-	omap_serial_init();
+	omap_serial_init(&perseus2_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 }
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index c096577..4aa4fa6 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -369,13 +369,12 @@ static struct platform_device *sx1_devices[] __initdata = {
 };
 /*-----------------------------------------*/
 
-static struct omap_uart_config sx1_uart_config __initdata = {
+static struct omap_uart_platform_data sx1_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
-	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
 
 /*-----------------------------------------*/
@@ -386,7 +385,7 @@ static void __init omap_sx1_init(void)
 
 	omap_board_config = sx1_config;
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
-	omap_serial_init();
+	omap_serial_init(&sx1_uart_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	omap_usb_init(&sx1_usb_config);
 	sx1_mmc_init();
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 98275e0..b9a11c6 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -140,12 +140,11 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_uart_config voiceblue_uart_config __initdata = {
+static struct omap_uart_platform_data voiceblue_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel voiceblue_config[] = {
-	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
 
 static void __init voiceblue_init_irq(void)
@@ -183,7 +182,7 @@ static void __init voiceblue_init(void)
 	platform_add_devices(voiceblue_devices, ARRAY_SIZE(voiceblue_devices));
 	omap_board_config = voiceblue_config;
 	omap_board_config_size = ARRAY_SIZE(voiceblue_config);
-	omap_serial_init();
+	omap_serial_init(&voiceblue_uart_config);
 	omap_usb_init(&voiceblue_usb_config);
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 6f54b2c..afd5252 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -106,10 +106,9 @@ static struct platform_device serial_device = {
  * By default UART2 does not work on Innovator-1510 if you have
  * USB OHCI enabled. To use UART2, you must disable USB2 first.
  */
-void __init omap_serial_init(void)
+void __init omap_serial_init(const struct omap_uart_platform_data *pdata)
 {
 	int i;
-	const struct omap_uart_config *info;
 
 	if (cpu_is_omap730()) {
 		serial_platform_data[0].regshift = 0;
@@ -131,14 +130,13 @@ void __init omap_serial_init(void)
 		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
 	}
 
-	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
-	if (info == NULL)
+	if (pdata == NULL)
 		return;
 
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		unsigned char reg;
 
-		if (!((1 << i) & info->enabled_uarts)) {
+		if (!((1 << i) & pdata->enabled_uarts)) {
 			serial_platform_data[i].membase = NULL;
 			serial_platform_data[i].mapbase = 0;
 			continue;
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 9c3fdcd..03f0887 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -146,12 +146,11 @@ static void __init omap_2430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_config sdp2430_uart_config __initdata = {
+static struct omap_uart_platform_data sdp2430_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel sdp2430_config[] = {
-	{OMAP_TAG_UART, &sdp2430_uart_config},
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 };
 
@@ -207,7 +206,7 @@ static void __init omap_2430sdp_init(void)
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-	omap_serial_init();
+	omap_serial_init(&sdp2430_uart_config);
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 496a90e..3f5c316 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -174,7 +174,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_config sdp3430_uart_config __initdata = {
+static struct omap_uart_platform_data sdp3430_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -183,7 +183,6 @@ static struct omap_lcd_config sdp3430_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
-	{ OMAP_TAG_UART,	&sdp3430_uart_config },
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
@@ -492,7 +491,7 @@ static void __init omap_3430sdp_init(void)
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	omap_serial_init(&sdp3430_uart_config);
 	usb_musb_init();
 	board_smc91x_init();
 }
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 543c0a4..ef60ed8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -38,7 +38,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 };
 
-static struct omap_uart_config sdp4430_uart_config __initdata = {
+static struct omap_uart_platform_data sdp4430_uart_config __initdata = {
 	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
 };
 
@@ -47,7 +47,6 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel sdp4430_config[] __initdata = {
-	{ OMAP_TAG_UART,	&sdp4430_uart_config },
 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
 };
 
@@ -73,7 +72,7 @@ static void __init omap_4430sdp_init(void)
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_board_config = sdp4430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
-	omap_serial_init();
+	omap_serial_init(&sdp4430_uart_config);
 }
 
 static void __init omap_4430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 06dfba8..49c654d 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -256,7 +256,7 @@ static void __init omap_apollon_init_irq(void)
 	apollon_init_smc91x();
 }
 
-static struct omap_uart_config apollon_uart_config __initdata = {
+static struct omap_uart_platform_data apollon_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
 };
 
@@ -272,7 +272,6 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel apollon_config[] = {
-	{ OMAP_TAG_UART,	&apollon_uart_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
@@ -326,7 +325,7 @@ static void __init omap_apollon_init(void)
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap_serial_init();
+	omap_serial_init(&apollon_uart_config);
 }
 
 static void __init omap_apollon_map_io(void)
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 3492162..ea59e61 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -37,19 +37,18 @@ static void __init omap_generic_init_irq(void)
 	omap_init_irq();
 }
 
-static struct omap_uart_config generic_uart_config __initdata = {
+static struct omap_uart_platform_data generic_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel generic_config[] = {
-	{ OMAP_TAG_UART,	&generic_uart_config },
 };
 
 static void __init omap_generic_init(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap_serial_init();
+	omap_serial_init(&generic_uart_config);
 }
 
 static void __init omap_generic_map_io(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index e7d017c..d91b52f 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -276,7 +276,7 @@ static void __init omap_h4_init_irq(void)
 	h4_init_flash();
 }
 
-static struct omap_uart_config h4_uart_config __initdata = {
+static struct omap_uart_platform_data h4_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -318,7 +318,6 @@ static struct omap_usb_config h4_usb_config __initdata = {
 };
 
 static struct omap_board_config_kernel h4_config[] = {
-	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
@@ -369,7 +368,7 @@ static void __init omap_h4_init(void)
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_usb_init(&h4_usb_config);
-	omap_serial_init();
+	omap_serial_init(&h4_uart_config);
 }
 
 static void __init omap_h4_map_io(void)
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index d8bc0a7..fdfe7e3 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -276,7 +276,7 @@ static void __init omap_ldp_init_irq(void)
 	ldp_init_smsc911x();
 }
 
-static struct omap_uart_config ldp_uart_config __initdata = {
+static struct omap_uart_platform_data ldp_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -290,7 +290,6 @@ static struct omap_lcd_config ldp_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel ldp_config[] __initdata = {
-	{ OMAP_TAG_UART,	&ldp_uart_config },
 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
@@ -384,7 +383,7 @@ static void __init omap_ldp_init(void)
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	omap_serial_init(&ldp_uart_config);
 	usb_musb_init();
 
 	twl4030_mmc_init(mmc);
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 991ac9c..cc02002 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -108,7 +108,7 @@ static struct platform_device omap3beagle_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct omap_uart_config omap3_beagle_uart_config __initdata = {
+static struct omap_uart_platform_data omap3_beagle_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -344,7 +344,6 @@ static struct platform_device keys_gpio = {
 };
 
 static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
 	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
 };
 
@@ -399,7 +398,7 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
-	omap_serial_init();
+	omap_serial_init(&omap3_beagle_uart_config);
 
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d3cc145..29d2b11 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -91,7 +91,7 @@ static inline void __init omap3evm_init_smc911x(void)
 	gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
 }
 
-static struct omap_uart_config omap3_evm_uart_config __initdata = {
+static struct omap_uart_platform_data omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -286,7 +286,6 @@ static void __init omap3_evm_init_irq(void)
 }
 
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
 	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
 };
 
@@ -306,7 +305,7 @@ static void __init omap3_evm_init(void)
 	spi_register_board_info(omap3evm_spi_board_info,
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
-	omap_serial_init();
+	omap_serial_init(&omap3_evm_uart_config);
 	usb_musb_init();
 	ads7846_dev_init();
 }
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index e32aa23..019855c 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -212,7 +212,7 @@ static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
 	{}	/* Terminator */
 };
 
-static struct omap_uart_config omap3pandora_uart_config __initdata = {
+static struct omap_uart_platform_data omap3pandora_uart_config __initdata = {
 	.enabled_uarts	= (1 << 2), /* UART3 */
 };
 
@@ -374,7 +374,6 @@ static struct omap_lcd_config omap3pandora_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
-	{ OMAP_TAG_UART,	&omap3pandora_uart_config },
 	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
 };
 
@@ -391,7 +390,7 @@ static void __init omap3pandora_init(void)
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_board_config = omap3pandora_config;
 	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
-	omap_serial_init();
+	omap_serial_init(&omap3pandora_uart_config);
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap3pandora_ads7846_init();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index dff5528..6f0e051 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -269,7 +269,7 @@ static void __init overo_flash_init(void)
 			printk(KERN_ERR "Unable to register NAND device\n");
 	}
 }
-static struct omap_uart_config overo_uart_config __initdata = {
+static struct omap_uart_platform_data overo_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -375,7 +375,6 @@ static struct omap_lcd_config overo_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel overo_config[] __initdata = {
-	{ OMAP_TAG_UART,	&overo_uart_config },
 	{ OMAP_TAG_LCD,		&overo_lcd_config },
 };
 
@@ -389,7 +388,7 @@ static void __init overo_init(void)
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
-	omap_serial_init();
+	omap_serial_init(&overo_uart_config);
 	overo_flash_init();
 	usb_musb_init();
 	overo_ads7846_init();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 374ff63..7cadc23 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,7 +31,7 @@
 #include <mach/gpmc.h>
 #include <mach/usb.h>
 
-static struct omap_uart_config rx51_uart_config = {
+static struct omap_uart_platform_data rx51_uart_config = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
@@ -52,7 +52,6 @@ static struct omap_fbmem_config rx51_fbmem2_config = {
 };
 
 static struct omap_board_config_kernel rx51_config[] = {
-	{ OMAP_TAG_UART,	&rx51_uart_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
 	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
@@ -72,7 +71,7 @@ static void __init rx51_init(void)
 {
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
-	omap_serial_init();
+	omap_serial_init(&rx51_uart_config);
 	usb_musb_init();
 	rx51_peripherals_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index bcc0f76..4cefa3f 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -30,12 +30,11 @@ static void __init omap_zoom2_init_irq(void)
 	omap_gpio_init();
 }
 
-static struct omap_uart_config zoom2_uart_config __initdata = {
+static struct omap_uart_platform_data zoom2_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
 static struct omap_board_config_kernel zoom2_config[] __initdata = {
-	{ OMAP_TAG_UART,	&zoom2_uart_config },
 };
 
 static struct twl4030_gpio_platform_data zoom2_gpio_data = {
@@ -87,7 +86,7 @@ static void __init omap_zoom2_init(void)
 	omap_i2c_init();
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap_serial_init();
+	omap_serial_init(&zoom2_uart_config);
 	omap_zoom2_debugboard_init();
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 07fb275..555e735 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -480,10 +480,9 @@ static struct platform_device serial_device = {
 	},
 };
 
-void __init omap_serial_init(void)
+void __init omap_serial_init(const struct omap_uart_platform_data *pdata)
 {
 	int i, err;
-	const struct omap_uart_config *info;
 	char name[16];
 
 	/*
@@ -492,9 +491,7 @@ void __init omap_serial_init(void)
 	 * if not needed.
 	 */
 
-	info = omap_get_config(OMAP_TAG_UART, struct omap_uart_config);
-
-	if (info == NULL)
+	if (pdata == NULL)
 		return;
 	if (cpu_is_omap44xx()) {
 		for (i = 0; i < OMAP_MAX_NR_PORTS; i++)
@@ -505,7 +502,7 @@ void __init omap_serial_init(void)
 		struct plat_serial8250_port *p = serial_platform_data + i;
 		struct omap_uart_state *uart = &omap_uart[i];
 
-		if (!(info->enabled_uarts & (1 << i))) {
+		if (!(pdata->enabled_uarts & (1 << i))) {
 			p->membase = NULL;
 			p->mapbase = 0;
 			continue;
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 0d12586..ac8e6d8 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -18,7 +18,6 @@
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_LCD		0x4f05
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
-#define OMAP_TAG_UART		0x4f07
 #define OMAP_TAG_FBMEM		0x4f08
 #define OMAP_TAG_STI_CONSOLE	0x4f09
 #define OMAP_TAG_CAMERA_SENSOR	0x4f0a
@@ -112,7 +111,7 @@ struct omap_gpio_switch_config {
 	int key_code:24; /* Linux key code */
 };
 
-struct omap_uart_config {
+struct omap_uart_platform_data {
 	/* Bit field of UARTs present; bit 0 --> UART1 */
 	unsigned int enabled_uarts;
 };
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index 13abd02..02a196f 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -53,7 +53,9 @@
 			})
 
 #ifndef __ASSEMBLER__
-extern void omap_serial_init(void);
+struct omap_uart_platform_data;
+
+extern void omap_serial_init(const struct omap_uart_platform_data *pdata);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
