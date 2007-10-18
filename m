From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 2/3] MMC: OMAP: Make board-sx1.c uses new board-sx1-mmc.c
 code
Date: Thu, 18 Oct 2007 14:29:30 -0400
Message-ID: <4717A60A.8060003@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: Tony Lindgren <tony@atomide.com>, Vladimir Ananiev <vovan888@gmail.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
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
 arch/arm/mach-omap1/board-sx1.c |   30 +++++++++++++++++-------------
 3 files changed, 19 insertions(+), 15 deletions(-)

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
index c0416fc..c6d80ac 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
 obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
-obj-$(CONFIG_MACH_SX1)			+= board-sx1.o
+obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index f25ec6f..9a93d03 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -33,6 +33,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
@@ -388,18 +389,6 @@ static struct omap_usb_config sx1_usb_config __initdata = {
 	.pins[2]	= 0,
 };
 
-/*----------- MMC -------------------------*/
-
-static struct omap_mmc_config sx1_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
-		.wire4		= 0,
-		.wp_pin		= -1,
-		.power_pin	= -1, /* power is in Sofia */
-		.switch_pin	= OMAP_MPUIO(3),
-	},
-};
-
 /*----------- LCD -------------------------*/
 
 static struct platform_device sx1_lcd_device = {
@@ -427,10 +416,22 @@ static struct omap_uart_config sx1_uart_config __initdata = {
 
 static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_USB,	&sx1_usb_config },
-	{ OMAP_TAG_MMC,	&sx1_mmc_config },
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
 static void __init omap_sx1_init(void)
 {
@@ -439,6 +440,9 @@ static void __init omap_sx1_init(void)
 	omap_board_config = sx1_config;
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
+	sx1_mmc_init();
+	omap_register_gpio_switches(sx1_gpio_switches,
+				    ARRAY_SIZE(sx1_gpio_switches));
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
-- 1.5.3.GIT
