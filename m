From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [16/17 PATCH] MMC: OMAP: Make board-h2.c uses new board-h2-mmc.c
 code.
Date: Fri, 17 Aug 2007 15:02:32 -0400
Message-ID: <46C5F0C8.6030306@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040803070901070005070203"
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
--------------040803070901070005070203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Felipe Balbi <felipe.lima@indt.org.br>

Make board-h2.c file uses new board-h2-mmc.c code. This patch also
introduces a new gpio_switch to get events when inserting and removing
MMC/SD/SDIO cards to/from the slot.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

--------------040803070901070005070203
Content-Type: text/plain;
	name*0="0016-MMC-OMAP-Make-board-h2.c-uses-new-board-h2-mmc.c-code.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0016-MMC-OMAP-Make-board-h2.c-uses-new-board-h2-mmc.c-code.d";
	filename*1="iff"

Make board-h2.c file uses new board-h2-mmc.c code. This patch also introduces
a new gpio_switch to get events when inserting and removing MMC/SD/SDIO
cards to/from the slot.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
igned-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Index: linux-omap/arch/arm/mach-omap1/Makefile
===================================================================
--- linux-omap.orig/arch/arm/mach-omap1/Makefile	2007-08-17 09:44:55.000000000 -0400
+++ linux-omap/arch/arm/mach-omap1/Makefile	2007-08-17 09:52:39.000000000 -0400
@@ -19,7 +19,7 @@ mmu_mach-objs			:= mmu.o
 led-y := leds.o
 
 # Specific board support
-obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o
+obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o board-h2-mmc.o
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
Index: linux-omap/arch/arm/mach-omap1/board-h2.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap1/board-h2.c	2007-08-17 09:26:48.000000000 -0400
+++ linux-omap/arch/arm/mach-omap1/board-h2.c	2007-08-17 11:18:34.000000000 -0400
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/irda.h>
@@ -457,16 +458,6 @@ static struct omap_usb_config h2_usb_con
 	.pins[1]	= 3,
 };
 
-static struct omap_mmc_config h2_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
-		.wire4		= 1,
-		.wp_pin		= OMAP_MPUIO(3),
-		.power_pin	= -1,	/* tps65010 gpio3 */
-		.switch_pin	= OMAP_MPUIO(1),
-	},
-};
-
 static struct omap_uart_config h2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -476,12 +467,23 @@ static struct omap_lcd_config h2_lcd_con
 };
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_USB,           &h2_usb_config },
-	{ OMAP_TAG_MMC,           &h2_mmc_config },
+	{ OMAP_TAG_USB,		&h2_usb_config },
 	{ OMAP_TAG_UART,	&h2_uart_config },
 	{ OMAP_TAG_LCD,		&h2_lcd_config },
 };
 
+static struct omap_gpio_switch h2_gpio_switches[] __initdata = {
+	{
+		.name                   = "mmc_slot",
+		.gpio                   = OMAP_MPUIO(1),
+		.type                   = OMAP_GPIO_SWITCH_TYPE_COVER,
+		.debounce_rising        = 100,
+		.debounce_falling       = 0,
+		.notify                 = h2_mmc_slot_cover_handler,
+		.notify_data            = NULL,
+	},
+};
+
 #define H2_NAND_RB_GPIO_PIN	62
 
 static int h2_nand_dev_ready(struct nand_platform_data *data)
@@ -530,6 +532,9 @@ static void __init h2_init(void)
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
+	h2_mmc_init();
+	omap_register_gpio_switches(h2_gpio_switches,
+				    ARRAY_SIZE(h2_gpio_switches));
 }
 
 static void __init h2_map_io(void)

--------------040803070901070005070203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040803070901070005070203--
