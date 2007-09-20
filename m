From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 12/14] MMC: OMAP: Make board-h3.c uses new board-h3-mmc.c
 code
Date: Thu, 20 Sep 2007 11:03:56 -0400
Message-ID: <46F28BDC.8040508@indt.org.br>
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

Make board-h3.c file uses new board-h3-mmc.c code.

This patch also:
- Introduces a new gpio_switch to get events when inserting and removing
  MMC/SD/SDIO cards to/from the slot.
- Enables the following options on omap_h3_1710_defconfig to use
  multislot support:
  - GPIO switch support
  - MSDOS fs support
  - VFAT fs support
  - Codepage 437
  - NLS ISO 8859-1

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/configs/omap_h3_1710_defconfig |   56 ++++++++++++++++++++++++++----
 arch/arm/mach-omap1/Makefile            |    2 +-
 arch/arm/mach-omap1/board-h3.c          |   25 +++++++++-----
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/arch/arm/configs/omap_h3_1710_defconfig b/arch/arm/configs/omap_h3_1710_defconfig
index 6791236..63f5bd6 100644
--- a/arch/arm/configs/omap_h3_1710_defconfig
+++ b/arch/arm/configs/omap_h3_1710_defconfig
@@ -153,13 +153,14 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 CONFIG_ARCH_OMAP1=y
 # CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_BOOT_TAG is not set
-# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_GPIO_SWITCH=y
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
@@ -1036,15 +1037,12 @@ CONFIG_MMC=y
 # MMC/SD Card Drivers
 #
 CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP=y
-
-#
-# Real Time Clock
-#
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -1133,8 +1131,11 @@ CONFIG_DNOTIFY=y
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1198,7 +1199,46 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Native Language Support
 #
-# CONFIG_NLS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
 
 #
 # Distributed Lock Manager
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 8377665..43f90f3 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
 obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o
 obj-$(CONFIG_MACH_OMAP_OSK)		+= board-osk.o
-obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o
+obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o board-h3-mmc.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
 obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index df77cf5..a2ae7ab 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -38,6 +38,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/gpioexpander.h>
 #include <asm/arch/irqs.h>
 #include <asm/arch/mux.h>
@@ -517,14 +518,6 @@ static struct omap_usb_config h3_usb_config __initdata = {
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
@@ -535,11 +528,22 @@ static struct omap_lcd_config h3_lcd_config __initdata = {
 
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
-- 1.5.3.GIT
