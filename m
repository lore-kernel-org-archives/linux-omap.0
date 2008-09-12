From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Clean-up MMC device init (Was: [PATCH]Enable
	4-bit in HSMMC1 and HSMMC2 platform data)
Date: Thu, 11 Sep 2008 17:48:49 -0700
Message-ID: <20080912004848.GO21163@atomide.com>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911091309.GD26078@flint.arm.linux.org.uk> <20080911173333.GI21163@atomide.com> <20080911181312.GC4986@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1SQmhf2mF2YjsYvc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61295 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbYILAtC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 20:49:02 -0400
Content-Disposition: inline
In-Reply-To: <20080911181312.GC4986@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>, Carlos Aguiar <carlos.aguiar@indt.org.br>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080911 11:13]:
> On Thu, Sep 11, 2008 at 10:33:33AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080911 02:13]:
> > > New version of the MMC updates for mainline pushed out - with additional
> > > cleanups in place (and since it's a different patch, I've dropped Tony's
> > > ack from it.)
> > 
> > While we're at it, let's clean up the mmc mess further and split the
> > resources to mach-omap1/devices.c and mach-omap2/devices.c. That way
> > we get rid of the ifdef else between omap1 and omap2.
> 
> Great, it would be nice to get something in OMAP to the point where we
> can say it's finished, and doesn't have to be regularly tinkered with
> anymore.

OK, I've pushed a patch to l-o tree. Here's a patch for you against your
devel branch.

> Is there anything else that the MMC stuff is missing at present?

Well the omap_hsmmc.c driver is not quite ready yet. That should not
affect the device init code.

Tony

--1SQmhf2mF2YjsYvc
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-mmc-init.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 11 Sep 2008 17:42:37 -0700
Subject: [PATCH] ARM: OMAP: Clean-up MMC device init

Clean-up MMC device init:

- Initialize devices in mach-omap1/devices.c and mach-omap2/devices.c
  instead of plat-omap/devices.c

- Remove old struct omap_mmc_config, use struct omap_mmc_platform_data instead

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index ab9ee58..37031e0 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -14,6 +14,7 @@
 
 #include <mach/mmc.h>
 #include <mach/gpio.h>
+#include <mach/mmc.h>
 
 #ifdef CONFIG_MMC_OMAP
 static int slot_cover_open;
@@ -83,6 +84,8 @@ static struct omap_mmc_platform_data h2_mmc_data = {
 	.init                           = h2_mmc_late_init,
 	.cleanup                        = h2_mmc_cleanup,
 	.slots[0]       = {
+		.enabled		= 1,
+		.wire4			= 1,
 		.set_power              = h2_mmc_set_power,
 		.set_bus_mode           = h2_mmc_set_bus_mode,
 		.get_ro                 = NULL,
@@ -95,7 +98,7 @@ static struct omap_mmc_platform_data h2_mmc_data = {
 
 void __init h2_mmc_init(void)
 {
-	omap_set_mmc_info(1, &h2_mmc_data);
+	omap1_init_mmc(&h2_mmc_data);
 }
 
 #else
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 3b65914..3b59354 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -381,15 +381,6 @@ static struct omap_usb_config h2_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_mmc_config h2_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.wire4		= 1,
-	},
-};
-
-extern struct omap_mmc_platform_data h2_mmc_data;
-
 static struct omap_uart_config h2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -400,7 +391,6 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
 	{ OMAP_TAG_USB,		&h2_usb_config },
-	{ OMAP_TAG_MMC,		&h2_mmc_config },
 	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 3608581..44e9d53 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -14,6 +14,7 @@
 
 #include <mach/mmc.h>
 #include <mach/gpio.h>
+#include <mach/mmc.h>
 
 #ifdef CONFIG_MMC_OMAP
 static int slot_cover_open;
@@ -87,6 +88,8 @@ static struct omap_mmc_platform_data h3_mmc_data = {
 	.init                           = h3_mmc_late_init,
 	.cleanup                        = h3_mmc_cleanup,
 	.slots[0]       = {
+		.enabled		= 1,
+		.wire4			= 1,
 		.set_power              = h3_mmc_set_power,
 		.set_bus_mode           = h3_mmc_set_bus_mode,
 		.get_ro                 = NULL,
@@ -99,7 +102,7 @@ static struct omap_mmc_platform_data h3_mmc_data = {
 
 void __init h3_mmc_init(void)
 {
-	omap_set_mmc_info(1, &h3_mmc_data);
+	omap1_init_mmc(&h3_mmc_data);
 }
 
 #else
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 2ced6d9..ff9bbe2 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -447,15 +447,6 @@ static struct omap_usb_config h3_usb_config __initdata = {
 	.pins[1]	= 3,
 };
 
-static struct omap_mmc_config h3_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.wire4		= 1,
-       },
-};
-
-extern struct omap_mmc_platform_data h3_mmc_data;
-
 static struct omap_uart_config h3_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -466,7 +457,6 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
 	{ OMAP_TAG_USB,		&h3_usb_config },
-	{ OMAP_TAG_MMC,		&h3_mmc_config },
 	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index cbc11be..9ed0fef 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -39,6 +39,7 @@
 #include <mach/common.h>
 #include <mach/mcbsp.h>
 #include <mach/omap-alsa.h>
+#include <mach/mmc.h>
 
 static int innovator_keymap[] = {
 	KEY(0, 0, KEY_F1),
@@ -360,13 +361,15 @@ static struct omap_lcd_config innovator1610_lcd_config __initdata = {
 };
 #endif
 
-static struct omap_mmc_config innovator_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
-		.wire4		= 1,
-		.wp_pin		= OMAP_MPUIO(3),
-		.power_pin	= -1,	/* FPGA F3 UIO42 */
-		.switch_pin	= -1,	/* FPGA F4 UIO43 */
+static struct omap_mmc_platform_data innovator_mmc_data = {
+	.nr_slots                       = 1,
+	.slots[0]       = {
+		.enabled		= 1,
+		.wire4			= 1,
+		.wp_pin			= OMAP_MPUIO(3),
+		.power_pin		= -1,	/* FPGA F3 UIO42 */
+		.switch_pin		= -1,	/* FPGA F4 UIO43 */
+		.name                   = "mmcblk",
 	},
 };
 
@@ -377,7 +380,6 @@ static struct omap_uart_config innovator_uart_config __initdata = {
 static struct omap_board_config_kernel innovator_config[] = {
 	{ OMAP_TAG_USB,         NULL },
 	{ OMAP_TAG_LCD,		NULL },
-	{ OMAP_TAG_MMC,		&innovator_mmc_config },
 	{ OMAP_TAG_UART,	&innovator_uart_config },
 };
 
@@ -412,6 +414,7 @@ static void __init innovator_init(void)
 	omap_board_config_size = ARRAY_SIZE(innovator_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap1_init_mmc(&innovator_mmc_data);
 }
 
 static void __init innovator_map_io(void)
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 38d9783..a8d2fef 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -35,6 +35,7 @@
 #include <mach/aic23.h>
 #include <mach/omapfb.h>
 #include <mach/lcd_mipid.h>
+#include <mach/mmc.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 
@@ -173,26 +174,29 @@ static struct omap_usb_config nokia770_usb_config __initdata = {
 	.pins[0]	= 6,
 };
 
-static struct omap_mmc_config nokia770_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 0,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
+static struct omap_mmc_platform_data nokia770_mmc_data = {
+	.nr_slots                       = 2,
+	.slots[0]       = {
+		.enabled		= 0,
+		.wire4			= 0,
+		.wp_pin			= -1,
+		.power_pin		= -1,
+		.switch_pin		= -1,
+		.name                   = "mmcblk",
 	},
-	.mmc[1] = {
-		.enabled	= 0,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
+	.slots[1]       = {
+		.enabled		= 0,
+		.wire4			= 0,
+		.wp_pin			= -1,
+		.power_pin		= -1,
+		.switch_pin		= -1,
+		.name                   = "mmcblk",
 	},
+
 };
 
 static struct omap_board_config_kernel nokia770_config[] __initdata = {
 	{ OMAP_TAG_USB,		NULL },
-	{ OMAP_TAG_MMC,		&nokia770_mmc_config },
 };
 
 #if	defined(CONFIG_OMAP_DSP)
@@ -335,6 +339,7 @@ static void __init omap_nokia770_init(void)
 	omap_dsp_init();
 	ads7846_dev_init();
 	mipid_dev_init();
+	omap1_init_mmc(&nokia770_mmc_data);
 }
 
 static void __init omap_nokia770_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index b580436..52fd4e3 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -44,6 +44,7 @@
 #include <mach/common.h>
 #include <mach/mcbsp.h>
 #include <mach/omap-alsa.h>
+#include <mach/mmc.h>
 
 static void __init omap_palmte_init_irq(void)
 {
@@ -195,12 +196,14 @@ static struct omap_usb_config palmte_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_mmc_config palmte_mmc_config __initdata = {
-	.mmc[0]		= {
-		.enabled 	= 1,
-		.wp_pin		= PALMTE_MMC_WP_GPIO,
-		.power_pin	= PALMTE_MMC_POWER_GPIO,
-		.switch_pin	= PALMTE_MMC_SWITCH_GPIO,
+static struct omap_mmc_platform_data palmzte_mmc_data = {
+	.nr_slots                       = 1,
+	.slots[0]       = {
+		.enabled		= 1,
+		.wp_pin			= PALMTE_MMC_WP_GPIO,
+		.power_pin		= PALMTE_MMC_POWER_GPIO,
+		.switch_pin		= PALMTE_MMC_SWITCH_GPIO,
+		.name                   = "mmcblk",
 	},
 };
 
@@ -316,7 +319,6 @@ static void palmte_get_power_status(struct apm_power_info *info, int *battery)
 
 static struct omap_board_config_kernel palmte_config[] __initdata = {
 	{ OMAP_TAG_USB,		&palmte_usb_config },
-	{ OMAP_TAG_MMC,		&palmte_mmc_config },
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
 	{ OMAP_TAG_UART,	&palmte_uart_config },
 };
@@ -372,6 +374,7 @@ static void __init omap_palmte_init(void)
 	palmte_misc_gpio_setup();
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	omap1_init_mmc(&palmte_mmc_data);
 }
 
 static void __init omap_palmte_map_io(void)
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e719294..5c75b9a 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -43,6 +43,7 @@
 #include <mach/keypad.h>
 #include <mach/common.h>
 #include <mach/omap-alsa.h>
+#include <mach/mmc.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -267,13 +268,15 @@ static struct omap_usb_config palmz71_usb_config __initdata = {
 	.pins[0]	= 2,
 };
 
-static struct omap_mmc_config palmz71_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.wire4		= 0,
-		.wp_pin		= PALMZ71_MMC_WP_GPIO,
-		.power_pin	= -1,
-		.switch_pin	= PALMZ71_MMC_IN_GPIO,
+static struct omap_mmc_platform_data palmz71_mmc_data = {
+	.nr_slots                       = 1,
+	.slots[0]       = {
+		.enabled		= 1,
+		.wire4			= 0,
+		.wp_pin			= PALMZ71_MMC_WP_GPIO,
+		.power_pin		= -1,
+		.switch_pin		= PALMZ71_MMC_IN_GPIO,
+		.name                   = "mmcblk",
 	},
 };
 
@@ -287,7 +290,6 @@ static struct omap_uart_config palmz71_uart_config __initdata = {
 
 static struct omap_board_config_kernel palmz71_config[] __initdata = {
 	{OMAP_TAG_USB,	&palmz71_usb_config},
-	{OMAP_TAG_MMC,	&palmz71_mmc_config},
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},
 	{OMAP_TAG_UART,	&palmz71_uart_config},
 };
@@ -365,6 +367,7 @@ omap_palmz71_init(void)
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 	palmz71_gpio_setup(0);
+	omap1_init_mmc(&palmz71_mmc_data);
 }
 
 static void __init
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index 0be4eba..524d22d 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -12,6 +12,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/platform_device.h>
+
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/gpio.h>
@@ -97,6 +99,8 @@ static struct omap_mmc_platform_data sx1_mmc_data = {
 	.init                           = sx1_mmc_late_init,
 	.cleanup                        = sx1_mmc_cleanup,
 	.slots[0]       = {
+		.enabled		= 1,
+		.wire4			= 0,
 		.set_power              = sx1_mmc_set_power,
 		.set_bus_mode           = sx1_mmc_set_bus_mode,
 		.get_ro                 = NULL,
@@ -109,7 +113,7 @@ static struct omap_mmc_platform_data sx1_mmc_data = {
 
 void __init sx1_mmc_init(void)
 {
-	omap_set_mmc_info(1, &sx1_mmc_data);
+	omap1_init_mmc(&sx1_mmc_data);
 }
 
 #else
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 130bcc6..f915839 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -378,15 +378,6 @@ static struct omap_usb_config sx1_usb_config __initdata = {
 	.pins[2]	= 0,
 };
 
-/*----------- MMC -------------------------*/
-
-static struct omap_mmc_config sx1_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled	= 1,
-		.wire4		= 0,
-	},
-};
-
 /*----------- LCD -------------------------*/
 
 static struct platform_device sx1_lcd_device = {
@@ -414,7 +405,6 @@ static struct omap_uart_config sx1_uart_config __initdata = {
 
 static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_USB,	&sx1_usb_config },
-	{ OMAP_TAG_MMC,	&sx1_mmc_config },
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
@@ -443,7 +433,6 @@ static void __init omap_sx1_init(void)
 	omap_set_gpio_dataout(1, 1);/*A_IRDA_OFF = 1 */
 	omap_set_gpio_dataout(11, 0);/*A_SWITCH = 0 */
 	omap_set_gpio_dataout(15, 0);/*A_USB_ON = 0 */
-
 }
 /*----------------------------------------*/
 static void __init omap_sx1_init_irq(void)
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 213b487..f5d8ba6 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -33,6 +33,7 @@
 #include <mach/mux.h>
 #include <mach/tc.h>
 #include <mach/usb.h>
+#include <mach/mmc.h>
 
 static struct plat_serial8250_port voiceblue_ports[] = {
 	{
@@ -139,11 +140,13 @@ static struct omap_usb_config voiceblue_usb_config __initdata = {
 	.pins[2]	= 6,
 };
 
-static struct omap_mmc_config voiceblue_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled	= 1,
-		.power_pin	= 2,
-		.switch_pin	= -1,
+static struct omap_mmc_platform_data voiceblue_mmc_data = {
+	.nr_slots                       = 1,
+	.slots[0]       = {
+		.enabled		= 1,
+		.power_pin		= 2,
+		.switch_pin		= -1,
+		.name                   = "mmcblk",
 	},
 };
 
@@ -153,7 +156,6 @@ static struct omap_uart_config voiceblue_uart_config __initdata = {
 
 static struct omap_board_config_kernel voiceblue_config[] = {
 	{ OMAP_TAG_USB,  &voiceblue_usb_config },
-	{ OMAP_TAG_MMC,  &voiceblue_mmc_config },
 	{ OMAP_TAG_UART, &voiceblue_uart_config },
 };
 
@@ -201,6 +203,8 @@ static void __init voiceblue_init(void)
 	 * (it is connected through invertor) */
 	omap_writeb(0x00, OMAP_LPG1_LCR);
 	omap_writeb(0x00, OMAP_LPG1_PMR);	/* Disable clock */
+
+	omap1_init_mmc(&voiceblue_mmc_data);
 }
 
 static void __init voiceblue_map_io(void)
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 99982d3..d9a1002 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -22,6 +22,7 @@
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
+#include <mach/mmc.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -99,6 +100,136 @@ static inline void omap_init_mbox(void)
 static inline void omap_init_mbox(void) { }
 #endif
 
+/*-------------------------------------------------------------------------*/
+
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+
+#define	OMAP1_MMC1_BASE		0xfffb7800
+#define	OMAP1_MMC1_END		(OMAP1_MMC1_BASE + 0x7f)
+#define OMAP1_MMC1_INT		INT_MMC
+
+#define	OMAP1_MMC2_BASE		0xfffb7c00	/* omap16xx only */
+#define	OMAP1_MMC2_END		(OMAP1_MMC2_BASE + 0x7f)
+#define	OMAP1_MMC2_INT		INT_1610_MMC2
+
+static u64 omap1_mmc1_dmamask = 0xffffffff;
+
+static struct resource omap1_mmc1_resources[] = {
+	{
+		.start		= OMAP1_MMC1_BASE,
+		.end		= OMAP1_MMC1_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP1_MMC1_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap1_mmc1_device = {
+	.name		= "mmci-omap",
+	.id		= 1,
+	.dev = {
+		.dma_mask	= &omap1_mmc1_dmamask,
+	},
+	.num_resources	= ARRAY_SIZE(omap1_mmc1_resources),
+	.resource	= omap1_mmc1_resources,
+};
+
+#if defined(CONFIG_ARCH_OMAP16XX)
+
+static u64 omap1_mmc2_dmamask = 0xffffffff;
+
+static struct resource omap1_mmc2_resources[] = {
+	{
+		.start		= OMAP1_MMC2_BASE,
+		.end		= OMAP1_MMC2_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP1_MMC2_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap1_mmc2_device = {
+	.name		= "mmci-omap",
+	.id		= 2,
+	.dev = {
+		.dma_mask	= &omap1_mmc2_dmamask,
+	},
+	.num_resources	= ARRAY_SIZE(omap1_mmc2_resources),
+	.resource	= omap1_mmc2_resources,
+};
+#define OMAP1_MMC2_DEVICE	&omap1_mmc2_device
+#else
+#define OMAP1_MMC2_DEVICE	&omap1_mmc1_device	/* Dummy */
+#endif
+
+static inline void omap1_mmc_mux(struct omap_mmc_platform_data *info)
+{
+	if (info->slots[0].enabled) {
+		omap_cfg_reg(MMC_CMD);
+		omap_cfg_reg(MMC_CLK);
+		omap_cfg_reg(MMC_DAT0);
+		if (cpu_is_omap1710()) {
+			omap_cfg_reg(M15_1710_MMC_CLKI);
+			omap_cfg_reg(P19_1710_MMC_CMDDIR);
+			omap_cfg_reg(P20_1710_MMC_DATDIR0);
+		}
+		if (info->slots[0].wire4) {
+			omap_cfg_reg(MMC_DAT1);
+			/* NOTE: DAT2 can be on W10 (here) or M15 */
+			if (!info->slots[0].nomux)
+				omap_cfg_reg(MMC_DAT2);
+			omap_cfg_reg(MMC_DAT3);
+		}
+	}
+
+	/* Block 2 is on newer chips, and has many pinout options */
+	if (cpu_is_omap16xx() && info->slots[1].enabled) {
+		if (!info->slots[1].nomux) {
+			omap_cfg_reg(Y8_1610_MMC2_CMD);
+			omap_cfg_reg(Y10_1610_MMC2_CLK);
+			omap_cfg_reg(R18_1610_MMC2_CLKIN);
+			omap_cfg_reg(W8_1610_MMC2_DAT0);
+			if (info->slots[1].wire4) {
+				omap_cfg_reg(V8_1610_MMC2_DAT1);
+				omap_cfg_reg(W15_1610_MMC2_DAT2);
+				omap_cfg_reg(R10_1610_MMC2_DAT3);
+			}
+
+			/* These are needed for the level shifter */
+			omap_cfg_reg(V9_1610_MMC2_CMDDIR);
+			omap_cfg_reg(V5_1610_MMC2_DATDIR0);
+			omap_cfg_reg(W19_1610_MMC2_DATDIR1);
+		}
+
+		/* Feedback clock must be set on OMAP-1710 MMC2 */
+		if (cpu_is_omap1710())
+			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
+					MOD_CONF_CTRL_1);
+	}
+}
+
+void omap1_init_mmc(struct omap_mmc_platform_data *info)
+{
+	if (!info)
+		return;
+
+	omap1_mmc_mux(info);
+	platform_set_drvdata(&omap1_mmc1_device, info);
+
+	if (cpu_is_omap16xx())
+		platform_set_drvdata(OMAP1_MMC2_DEVICE, info);
+
+	omap_init_mmc(info, &omap1_mmc1_device, OMAP1_MMC2_DEVICE);
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_OMAP_STI)
 
 #define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 989ad15..eec2fea 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -261,16 +261,6 @@ static struct omap_uart_config apollon_uart_config __initdata = {
 	.enabled_uarts = (1 << 0) | (0 << 1) | (0 << 2),
 };
 
-static struct omap_mmc_config apollon_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
-		.wire4		= 1,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_usb_config apollon_usb_config __initdata = {
 	.register_dev	= 1,
 	.hmc_mode	= 0x14,	/* 0:dev 1:host1 2:disable */
@@ -284,7 +274,6 @@ static struct omap_lcd_config apollon_lcd_config __initdata = {
 
 static struct omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
-	{ OMAP_TAG_MMC,		&apollon_mmc_config },
 	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 9ba0978..3b34c20 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -41,19 +41,8 @@ static struct omap_uart_config generic_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_mmc_config generic_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 0,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_board_config_kernel generic_config[] = {
 	{ OMAP_TAG_UART,	&generic_uart_config },
-	{ OMAP_TAG_MMC,		&generic_mmc_config },
 };
 
 static void __init omap_generic_init(void)
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index d4e3b6f..9f01681 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -371,23 +371,12 @@ static struct omap_uart_config h4_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_mmc_config h4_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled	= 1,
-		.wire4		= 1,
-		.wp_pin		= -1,
-		.power_pin	= -1,
-		.switch_pin	= -1,
-	},
-};
-
 static struct omap_lcd_config h4_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
 static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
-	{ OMAP_TAG_MMC,		&h4_mmc_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2ee954a..79a026e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,10 +19,12 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
+#include <mach/control.h>
 #include <mach/tc.h>
 #include <mach/board.h>
 #include <mach/mux.h>
 #include <mach/gpio.h>
+#include <mach/mmc.h>
 
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 
@@ -203,6 +205,113 @@ static inline void omap_init_mcspi(void) {}
 
 /*-------------------------------------------------------------------------*/
 
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+
+#define	OMAP2_MMC1_BASE		0x4809c000
+#define	OMAP2_MMC1_END		(OMAP2_MMC1_BASE + 0x1fc)
+#define	OMAP2_MMC1_INT		INT_24XX_MMC_IRQ
+
+#define	OMAP2_MMC2_BASE		0x480b4000
+#define	OMAP2_MMC2_END		(OMAP2_MMC2_BASE + 0x1fc)
+#define	OMAP2_MMC2_INT		INT_24XX_MMC2_IRQ
+
+static u64 omap2_mmc1_dmamask = 0xffffffff;
+
+static struct resource omap2_mmc1_resources[] = {
+	{
+		.start		= OMAP2_MMC1_BASE,
+		.end		= OMAP2_MMC1_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_MMC1_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap2_mmc1_device = {
+	.name		= "mmci-omap",
+	.id		= 1,
+	.dev = {
+		.dma_mask	= &omap2_mmc1_dmamask,
+	},
+	.num_resources	= ARRAY_SIZE(omap2_mmc1_resources),
+	.resource	= omap2_mmc1_resources,
+};
+
+static u64 omap2_mmc2_dmamask = 0xffffffff;
+
+static struct resource omap2_mmc2_resources[] = {
+	{
+		.start		= OMAP2_MMC2_BASE,
+		.end		= OMAP2_MMC2_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_MMC2_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap2_mmc2_device = {
+	.name		= "mmci-omap",
+	.id		= 2,
+	.dev = {
+		.dma_mask	= &omap2_mmc2_dmamask,
+	},
+	.num_resources	= ARRAY_SIZE(omap2_mmc2_resources),
+	.resource	= omap2_mmc2_resources,
+};
+
+static inline void omap2_mmc_mux(struct omap_mmc_platform_data *info)
+{
+	if (!cpu_is_omap2420())
+		return;
+
+	if (info->slots[0].enabled) {
+		omap_cfg_reg(H18_24XX_MMC_CMD);
+		omap_cfg_reg(H15_24XX_MMC_CLKI);
+		omap_cfg_reg(G19_24XX_MMC_CLKO);
+		omap_cfg_reg(F20_24XX_MMC_DAT0);
+		omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
+		omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
+		if (info->slots[0].wire4) {
+			omap_cfg_reg(H14_24XX_MMC_DAT1);
+			omap_cfg_reg(E19_24XX_MMC_DAT2);
+			omap_cfg_reg(D19_24XX_MMC_DAT3);
+			omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
+			omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
+			omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
+		}
+
+		/*
+		 * Use internal loop-back in MMC/SDIO Module Input Clock
+		 * selection
+		 */
+		if (info->slots[0].internal_clock) {
+			u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+			v |= (1 << 24);
+			omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
+		}
+	}
+}
+
+void omap2_init_mmc(struct omap_mmc_platform_data *info)
+{
+	if (!info)
+		return;
+
+	omap2_mmc_mux(info);
+	omap2_mmc1_device.dev.platform_data = info;
+	omap2_mmc2_device.dev.platform_data = info;
+	omap_init_mmc(info, &omap2_mmc1_device, &omap2_mmc2_device);
+}
+
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 static int __init omap2_init_devices(void)
 {
 	/* please keep these calls, and their implementations above,
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index b38410f..db63c24 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -198,212 +198,22 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 #if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-#define	OMAP_MMC1_BASE		0x4809c000
-#define	OMAP_MMC1_END		(OMAP_MMC1_BASE + 0x1fc)
-#define	OMAP_MMC1_INT		INT_24XX_MMC_IRQ
-
-#define	OMAP_MMC2_BASE		0x480b4000
-#define	OMAP_MMC2_END		(OMAP_MMC2_BASE + 0x1fc)
-#define	OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
-
-#else
-
-#define	OMAP_MMC1_BASE		0xfffb7800
-#define	OMAP_MMC1_END		(OMAP_MMC1_BASE + 0x7f)
-#define OMAP_MMC1_INT		INT_MMC
-
-#define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
-#define	OMAP_MMC2_END		(OMAP_MMC2_BASE + 0x7f)
-#define	OMAP_MMC2_INT		INT_1610_MMC2
-
-#endif
-
-static struct omap_mmc_platform_data mmc1_data;
-
-static u64 mmc1_dmamask = 0xffffffff;
-
-static struct resource mmc1_resources[] = {
-	{
-		.start		= OMAP_MMC1_BASE,
-		.end		= OMAP_MMC1_END,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP_MMC1_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mmc_omap_device1 = {
-	.name		= "mmci-omap",
-	.id		= 1,
-	.dev = {
-		.dma_mask	= &mmc1_dmamask,
-		.platform_data	= &mmc1_data,
-	},
-	.num_resources	= ARRAY_SIZE(mmc1_resources),
-	.resource	= mmc1_resources,
-};
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
-	defined(CONFIG_ARCH_OMAP34XX)
-
-static struct omap_mmc_platform_data mmc2_data;
-
-static u64 mmc2_dmamask = 0xffffffff;
-
-static struct resource mmc2_resources[] = {
-	{
-		.start		= OMAP_MMC2_BASE,
-		.end		= OMAP_MMC2_END,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= OMAP_MMC2_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mmc_omap_device2 = {
-	.name		= "mmci-omap",
-	.id		= 2,
-	.dev = {
-		.dma_mask	= &mmc2_dmamask,
-		.platform_data	= &mmc2_data,
-	},
-	.num_resources	= ARRAY_SIZE(mmc2_resources),
-	.resource	= mmc2_resources,
-};
-#endif
-
-static inline void omap_init_mmc_conf(const struct omap_mmc_config *mmc_conf)
-{
-	if (cpu_is_omap2430() || cpu_is_omap34xx())
-		return;
-
-	if (mmc_conf->mmc[0].enabled) {
-		if (cpu_is_omap24xx()) {
-			omap_cfg_reg(H18_24XX_MMC_CMD);
-			omap_cfg_reg(H15_24XX_MMC_CLKI);
-			omap_cfg_reg(G19_24XX_MMC_CLKO);
-			omap_cfg_reg(F20_24XX_MMC_DAT0);
-			omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
-			omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
-		} else {
-			omap_cfg_reg(MMC_CMD);
-			omap_cfg_reg(MMC_CLK);
-			omap_cfg_reg(MMC_DAT0);
-			if (cpu_is_omap1710()) {
-				omap_cfg_reg(M15_1710_MMC_CLKI);
-				omap_cfg_reg(P19_1710_MMC_CMDDIR);
-				omap_cfg_reg(P20_1710_MMC_DATDIR0);
-			}
-		}
-		if (mmc_conf->mmc[0].wire4) {
-			if (cpu_is_omap24xx()) {
-				omap_cfg_reg(H14_24XX_MMC_DAT1);
-				omap_cfg_reg(E19_24XX_MMC_DAT2);
-				omap_cfg_reg(D19_24XX_MMC_DAT3);
-				omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
-				omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
-				omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
-			} else {
-				omap_cfg_reg(MMC_DAT1);
-				/* NOTE:  DAT2 can be on W10 (here) or M15 */
-				if (!mmc_conf->mmc[0].nomux)
-					omap_cfg_reg(MMC_DAT2);
-				omap_cfg_reg(MMC_DAT3);
-			}
-		}
-#if defined(CONFIG_ARCH_OMAP2420)
-		if (mmc_conf->mmc[0].internal_clock) {
-			/*
-			 * Use internal loop-back in MMC/SDIO
-			 * Module Input Clock selection
-			 */
-			if (cpu_is_omap24xx()) {
-				u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-				v |= (1 << 24); /* not used in 243x */
-				omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-			}
-		}
-#endif
-	}
-
-#ifdef	CONFIG_ARCH_OMAP16XX
-	/* block 2 is on newer chips, and has many pinout options */
-	if (mmc_conf->mmc[1].enabled) {
-		if (!mmc_conf->mmc[1].nomux) {
-			omap_cfg_reg(Y8_1610_MMC2_CMD);
-			omap_cfg_reg(Y10_1610_MMC2_CLK);
-			omap_cfg_reg(R18_1610_MMC2_CLKIN);
-			omap_cfg_reg(W8_1610_MMC2_DAT0);
-			if (mmc_conf->mmc[1].wire4) {
-				omap_cfg_reg(V8_1610_MMC2_DAT1);
-				omap_cfg_reg(W15_1610_MMC2_DAT2);
-				omap_cfg_reg(R10_1610_MMC2_DAT3);
-			}
-
-			/* These are needed for the level shifter */
-			omap_cfg_reg(V9_1610_MMC2_CMDDIR);
-			omap_cfg_reg(V5_1610_MMC2_DATDIR0);
-			omap_cfg_reg(W19_1610_MMC2_DATDIR1);
-		}
-
-		/* Feedback clock must be set on OMAP-1710 MMC2 */
-		if (cpu_is_omap1710())
-			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
-				     MOD_CONF_CTRL_1);
-	}
-#endif
-}
-
-static void __init omap_init_mmc(void)
+/*
+ * Register MMC devices. Called from mach-omap1 and mach-omap2 device init.
+ */
+void omap_init_mmc(struct omap_mmc_platform_data *info,
+		struct platform_device *pdev1, struct platform_device *pdev2)
 {
-	const struct omap_mmc_config	*mmc_conf;
-
-	/* NOTE:  assumes MMC was never (wrongly) enabled */
-	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
-	if (!mmc_conf)
+	if (!info)
 		return;
 
-	omap_init_mmc_conf(mmc_conf);
-
-	if (mmc_conf->mmc[0].enabled) {
-		mmc1_data.conf = mmc_conf->mmc[0];
-		(void) platform_device_register(&mmc_omap_device1);
-	}
-
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
-	defined(CONFIG_ARCH_OMAP34XX)
-	if (mmc_conf->mmc[1].enabled) {
-		mmc2_data.conf = mmc_conf->mmc[1];
-		(void) platform_device_register(&mmc_omap_device2);
-	}
-#endif
-}
+	if (info->slots[0].enabled && pdev1)
+		(void) platform_device_register(pdev1);
 
-void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
-{
-	switch (host) {
-	case 1:
-		mmc1_data = *info;
-		break;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
-	defined(CONFIG_ARCH_OMAP34XX)
-	case 2:
-		mmc2_data = *info;
-		break;
-#endif
-	default:
-		BUG();
-	}
+	if (info->slots[1].enabled && pdev2)
+		(void) platform_device_register(pdev2);
 }
 
-#else
-static inline void omap_init_mmc(void) {}
-void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info) {}
 #endif
 
 /*-------------------------------------------------------------------------*/
@@ -547,7 +357,6 @@ static int __init omap_init_devices(void)
 	 */
 	omap_init_dsp();
 	omap_init_kp();
-	omap_init_mmc();
 	omap_init_uwire();
 	omap_init_wdt();
 	omap_init_rng();
diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
index 5444564..9466772 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/mach/board.h
@@ -16,7 +16,6 @@
 
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
-#define OMAP_TAG_MMC		0x4f02
 #define OMAP_TAG_SERIAL_CONSOLE 0x4f03
 #define OMAP_TAG_USB		0x4f04
 #define OMAP_TAG_LCD		0x4f05
@@ -35,25 +34,6 @@ struct omap_clock_config {
 	u8 system_clock_type;
 };
 
-struct omap_mmc_conf {
-	unsigned enabled:1;
-	/* nomux means "standard" muxing is wrong on this board, and that
-	 * board-specific code handled it before common init logic.
-	 */
-	unsigned nomux:1;
-	/* switch pin can be for card detect (default) or card cover */
-	unsigned cover:1;
-	/* 4 wire signaling is optional, and is only used for SD/SDIO */
-	unsigned wire4:1;
-	s16 power_pin;
-	s16 switch_pin;
-	s16 wp_pin;
-};
-
-struct omap_mmc_config {
-	struct omap_mmc_conf mmc[2];
-};
-
 struct omap_serial_console_config {
 	u8 console_uart;
 	u32 console_speed;
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 62aa7df..57414c4 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -279,6 +279,7 @@
 #define INT_24XX_USB_IRQ_HSOF	79
 #define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
+#define INT_24XX_MMC2_IRQ	86
 
 #define	INT_34XX_BENCH_MPU_EMUL	3
 
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index fc15d13..af391e6 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -20,7 +20,6 @@
 #define OMAP_MMC_MAX_SLOTS	2
 
 struct omap_mmc_platform_data {
-	struct omap_mmc_conf	conf;
 
 	/* number of slots on board */
 	unsigned nr_slots:2;
@@ -42,6 +41,27 @@ struct omap_mmc_platform_data {
 	int (*resume)(struct device *dev, int slot);
 
 	struct omap_mmc_slot_data {
+
+		unsigned enabled:1;
+
+		/*
+		 * nomux means "standard" muxing is wrong on this board, and
+		 * that board-specific code handled it before common init logic.
+		 */
+		unsigned nomux:1;
+
+		/* switch pin can be for card detect (default) or card cover */
+		unsigned cover:1;
+
+		/* 4 wire signaling is optional, and is only used for SD/SDIO */
+		unsigned wire4:1;
+
+		/* use the internal clock */
+		unsigned internal_clock:1;
+		s16 power_pin;
+		s16 switch_pin;
+		s16 wp_pin;
+
 		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);
 		int (* get_ro)(struct device *dev, int slot);
@@ -66,9 +86,30 @@ struct omap_mmc_platform_data {
 	} slots[OMAP_MMC_MAX_SLOTS];
 };
 
-extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info);
-
 /* called from board-specific card detection service routine */
 extern void omap_mmc_notify_cover_event(struct device *dev, int slot, int is_closed);
 
+#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
+	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void omap1_init_mmc(struct omap_mmc_platform_data *info);
+void omap2_init_mmc(struct omap_mmc_platform_data *info);
+void omap_init_mmc(struct omap_mmc_platform_data *info,
+		struct platform_device *pdev1, struct platform_device *pdev2);
+#else
+static inline void omap1_init_mmc(struct omap_mmc_platform_data *info)
+{
+}
+static inline void omap2_init_mmc(struct omap_mmc_platform_data *info)
+{
+}
+static inline void omap_init_mmc(struct omap_mmc_platform_data *info,
+		struct platform_device *pdev1, struct platform_device *pdev2)
+{
+}
+#endif
+
+#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
+void __init hsmmc_init(void);
+#endif
+
 #endif
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 1b9fc3c..6088294 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1317,7 +1317,7 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	host->slots[id] = slot;
 
 	mmc->caps = 0;
-	if (host->pdata->conf.wire4)
+	if (host->pdata->slots[id].wire4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	mmc->ops = &mmc_omap_ops;

--1SQmhf2mF2YjsYvc--
