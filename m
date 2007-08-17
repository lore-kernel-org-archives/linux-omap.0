From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [13/17 PATCH] MMC: OMAP: Make board-h3.c uses new board-h3-mmc.c
 code.
Date: Fri, 17 Aug 2007 15:02:19 -0400
Message-ID: <46C5F0BB.8070209@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020404030602040402090504"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020404030602040402090504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Felipe Balbi <felipe.lima@indt.org.br>

Make board-h3.c file uses new board-h3-mmc.c code. This patch also
introduces a new gpio_switch to get events when inserting and removing
MMC/SD/SDIO cards to/from the slot.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

--------------020404030602040402090504
Content-Type: text/plain;
	name*0="0013-MMC-OMAP-Make-board-h3.c-uses-new-board-h3-mmc.c-code.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0013-MMC-OMAP-Make-board-h3.c-uses-new-board-h3-mmc.c-code.d";
	filename*1="iff"

Make board-h3.c file uses new board-h3-mmc.c code. This patch also introduces
a new gpio_switch to get events when inserting and removing MMC/SD/SDIO
cards to/from the slot.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Index: linux-omap/arch/arm/mach-omap1/Makefile
===================================================================
--- linux-omap.orig/arch/arm/mach-omap1/Makefile	2007-08-17 09:26:50.000000000 -0400
+++ linux-omap/arch/arm/mach-omap1/Makefile	2007-08-17 09:37:50.000000000 -0400
@@ -25,7 +25,7 @@ obj-$(CONFIG_MACH_OMAP_GENERIC)		+= boar
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
 obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o
 obj-$(CONFIG_MACH_OMAP_OSK)		+= board-osk.o
-obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o
+obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o board-h3-mmc.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
 obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
Index: linux-omap/arch/arm/mach-omap1/board-h3.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap1/board-h3.c	2007-08-17 09:26:50.000000000 -0400
+++ linux-omap/arch/arm/mach-omap1/board-h3.c	2007-08-17 09:37:50.000000000 -0400
@@ -38,6 +38,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/gpioexpander.h>
 #include <asm/arch/irqs.h>
 #include <asm/arch/mux.h>
@@ -517,14 +518,6 @@ static struct omap_usb_config h3_usb_con
 	.pins[1]	= 3,
 };
 
-static struct omap_mmc_config h3_mmc_config __initdata = {
-	.mmc[0] = {
-		.enabled 	= 1,
-		.power_pin	= -1,   /* tps65010 GPIO4 */
-		.switch_pin	= OMAP_MPUIO(1),
-	},
-};
-
 static struct omap_uart_config h3_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -535,11 +528,22 @@ static struct omap_lcd_config h3_lcd_con
 
 static struct omap_board_config_kernel h3_config[] __initdata = {
 	{ OMAP_TAG_USB,		&h3_usb_config },
-	{ OMAP_TAG_MMC,		&h3_mmc_config },
 	{ OMAP_TAG_UART,	&h3_uart_config },
 	{ OMAP_TAG_LCD,		&h3_lcd_config },
 };
 
+static struct omap_gpio_switch h3_gpio_switches[] __initdata = {
+	{
+		.name			= "mmc_slot",
+		.gpio                   = OMAP_MPUIO(1),
+		.type                   = OMAP_GPIO_SWITCH_TYPE_COVER,
+		.debounce_rising        = 100,
+		.debounce_falling       = 0,
+		.notify                 = h3_mmc_slot_cover_handler,
+		.notify_data            = NULL,
+	},
+};
+
 #define H3_NAND_RB_GPIO_PIN	10
 
 static int nand_dev_ready(struct nand_platform_data *data)
@@ -575,6 +579,9 @@ static void __init h3_init(void)
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
+	h3_mmc_init();
+	omap_register_gpio_switches(h3_gpio_switches,
+				    ARRAY_SIZE(h3_gpio_switches));
 }
 
 static void __init h3_init_smc91x(void)

--------------020404030602040402090504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020404030602040402090504--
