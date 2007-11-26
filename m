From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 14/17] MMC: OMAP: Make board-h2.c uses new board-h2-mmc.c
 code
Date: Mon, 26 Nov 2007 12:01:58 -0400
Message-ID: <474AEDF6.60609@indt.org.br>
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
 arch/arm/configs/omap_h2_1610_defconfig |   99 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap1/Makefile            |    2 +-
 arch/arm/mach-omap1/board-h2.c          |   29 +++++++--
 3 files changed, 115 insertions(+), 15 deletions(-)

diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 1b37b82..90cd538 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -26,20 +26,25 @@ CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# General setup
+# Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -74,12 +79,20 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
+
+#
+# Block layer
+#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -151,7 +164,7 @@ CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_BOOT_REASON is not set
 # CONFIG_OMAP_COMPONENT_VERSION is not set
-# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_GPIO_SWITCH=y
 CONFIG_OMAP_MUX=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
@@ -358,8 +371,20 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
 # CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -410,6 +435,10 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_DEBUG_DRIVER=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 CONFIG_MTD_DEBUG=y
@@ -489,8 +518,21 @@ CONFIG_MTD_CFI_UTIL=y
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
+
+#
+# Parallel port support
+#
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
+
+#
+# Plug and Play support
+#
+# CONFIG_PNPACPI is not set
+
+#
+# Block devices
+#
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -511,7 +553,15 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
 # CONFIG_MD is not set
+
+#
+# Network device support
+#
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
@@ -520,6 +570,10 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_AX88796 is not set
@@ -529,6 +583,10 @@ CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 
 #
+# Token Ring devices
+#
+
+#
 # Wireless LAN
 #
 # CONFIG_WLAN_PRE80211 is not set
@@ -563,6 +621,10 @@ CONFIG_SLHC=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
 # CONFIG_ISDN is not set
 
 #
@@ -599,6 +661,7 @@ CONFIG_INPUT_MISC=y
 # CONFIG_INPUT_POWERMATE is not set
 # CONFIG_INPUT_YEALINK is not set
 CONFIG_INPUT_UINPUT=y
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Hardware I/O ports
@@ -633,6 +696,10 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
@@ -652,6 +719,10 @@ CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
 # CONFIG_TCG_TPM is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
@@ -978,7 +1049,20 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_FILE_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
-# CONFIG_MMC is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD Card Drivers
+#
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
@@ -1082,8 +1166,9 @@ CONFIG_DNOTIFY=y
 #
 CONFIG_FAT_FS=y
 CONFIG_MSDOS_FS=y
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1155,7 +1240,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -1179,7 +1264,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index dc0a870..a8d95a1 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -20,7 +20,7 @@ mmu_mach-objs			:= mmu.o
 led-y := leds.o
 
 # Specific board support
-obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o
+obj-$(CONFIG_MACH_OMAP_H2)		+= board-h2.o board-h2-mmc.o
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d7345c9..1ba59bb 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpio-switch.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/irda.h>
@@ -458,15 +459,14 @@ static struct omap_usb_config h2_usb_config __initdata = {
 };
 
 static struct omap_mmc_config h2_mmc_config __initdata = {
-	.mmc [0] = {
-		.enabled 	= 1,
+	.mmc[0] = {
+		.enabled	= 1,
 		.wire4		= 1,
-		.wp_pin		= OMAP_MPUIO(3),
-		.power_pin	= -1,	/* tps65010 gpio3 */
-		.switch_pin	= OMAP_MPUIO(1),
 	},
 };
 
+extern struct omap_mmc_platform_data h2_mmc_data;
+
 static struct omap_uart_config h2_uart_config __initdata = {
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
@@ -476,12 +476,24 @@ static struct omap_lcd_config h2_lcd_config __initdata = {
 };
 
 static struct omap_board_config_kernel h2_config[] __initdata = {
-	{ OMAP_TAG_USB,           &h2_usb_config },
-	{ OMAP_TAG_MMC,           &h2_mmc_config },
+	{ OMAP_TAG_USB,		&h2_usb_config },
+	{ OMAP_TAG_MMC,		&h2_mmc_config },
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
@@ -533,6 +545,9 @@ static void __init h2_init(void)
 	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
+	h2_mmc_init();
+	omap_register_gpio_switches(h2_gpio_switches,
+				    ARRAY_SIZE(h2_gpio_switches));
 }
 
 static void __init h2_map_io(void)
-- 1.5.3.GIT
