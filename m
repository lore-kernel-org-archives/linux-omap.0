From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 14/14] MMC: OMAP: Make board-h2.c uses new board-h2-mmc.c
 code
Date: Thu, 20 Sep 2007 11:04:10 -0400
Message-ID: <46F28BEA.5070804@indt.org.br>
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.lima@indt.org.br>

Make board-h2.c file uses new board-h2-mmc.c code.

This patch also:
- Introduces a new gpio_switch to get events when inserting and removing
  MMC/SD/SDIO cards to/from the slot.
- Enables the following options on omap_h2_1610_defconfig to use
  multislot support:
  - GPIO switch support
  - MMC/SD card support
  - VFAT fs support
  - NLS ISO 8859-1

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/configs/omap_h2_1610_defconfig |   22 ++++++++++++++++------
 arch/arm/mach-omap1/Makefile            |    2 +-
 arch/arm/mach-omap1/board-h2.c          |   29 +++++++++++++++++------------
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 83f0587..f8a8c75 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -161,7 +161,7 @@ CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_BOOT_REASON is not set
 # CONFIG_OMAP_COMPONENT_VERSION is not set
-# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_GPIO_SWITCH=y
 CONFIG_OMAP_MUX=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
@@ -1034,11 +1034,20 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_FILE_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# Real Time Clock
+# MMC/SD Card Drivers
 #
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+
+#
+# MMC/SD Host Controller Drivers
+#
+CONFIG_MMC_OMAP=y
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -1126,8 +1135,9 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_FAT_FS=y
 CONFIG_MSDOS_FS=y
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1200,7 +1210,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -1224,7 +1234,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 43f90f3..c0416fc 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -19,7 +19,7 @@ mmu_mach-objs			:= mmu.o
 led-y := leds.o
 
 # Specific board support
-obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o
+obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o board-h2-mmc.o
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d2214ad..876bdcf 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/irda.h>
@@ -457,16 +458,6 @@ static struct omap_usb_config h2_usb_config __initdata = {
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
@@ -476,12 +467,23 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
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
-- 1.5.3.GIT
