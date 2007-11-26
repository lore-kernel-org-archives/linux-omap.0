From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 16/17] MMC: OMAP: Make board-sx1.c uses new board-sx1-mmc.c
 code
Date: Mon, 26 Nov 2007 12:02:04 -0400
Message-ID: <474AEDFC.7070109@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Make board-sx1.c file uses new board-sx1-mmc.c code.

This patch also:
- Introduces a new gpio_switch to get events when inserting and removing
  MMC/SD/SDIO cards to/from the slot.
- Enables the GPIO switch support option on sx1_defconfig to use
  multislot support:

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 arch/arm/configs/sx1_defconfig  |    2 +-
 arch/arm/mach-omap1/Makefile    |    2 +-
 arch/arm/mach-omap1/board-sx1.c |   22 ++++++++++++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/sx1_defconfig b/arch/arm/configs/sx1_defconfig
index 808dd99..853dcdd 100644
--- a/arch/arm/configs/sx1_defconfig
+++ b/arch/arm/configs/sx1_defconfig
@@ -159,7 +159,7 @@ CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_BOOT_REASON is not set
 # CONFIG_OMAP_COMPONENT_VERSION is not set
-# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_GPIO_SWITCH=y
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index a8d95a1..6ebf23b 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
 obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
-obj-$(CONFIG_MACH_SX1)			+= board-sx1.o
+obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index de921be..163ad92 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -33,6 +33,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
@@ -392,11 +393,8 @@ static struct omap_usb_config sx1_usb_config __initdata = {
 
 static struct omap_mmc_config sx1_mmc_config __initdata = {
 	.mmc [0] = {
-		.enabled 	= 1,
+		.enabled	= 1,
 		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1, /* power is in Sofia */
-		.switch_pin	= OMAP_MPUIO(3),
 	},
 };
 
@@ -431,6 +429,19 @@ static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },
 	{ OMAP_TAG_UART,	&sx1_uart_config },
 };
+
+static struct omap_gpio_switch sx1_gpio_switches[] __initdata = {
+	{
+		.name                   = "mmc_slot",
+		.gpio                   = OMAP_MPUIO(3),
+		.type                   = OMAP_GPIO_SWITCH_TYPE_COVER,
+		.debounce_rising        = 100,
+		.debounce_falling       = 0,
+		.notify                 = sx1_mmc_slot_cover_handler,
+		.notify_data            = NULL,
+	},
+};
+
 /*-----------------------------------------*/
 
 extern void __init sx1_mmc_init(void);
@@ -443,6 +454,9 @@ static void __init omap_sx1_init(void)
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	sx1_mmc_init();
+	omap_register_gpio_switches(sx1_gpio_switches,
+				    ARRAY_SIZE(sx1_gpio_switches));
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
-- 1.5.3.GIT
