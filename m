From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/5] ARM: N800: Update n800 defconfig
Date: Wed,  9 Apr 2008 15:04:04 +0300
Message-ID: <1207742644-6260-6-git-send-email-felipe.balbi@nokia.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com>
 <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com>
 <1207742644-6260-3-git-send-email-felipe.balbi@nokia.com>
 <1207742644-6260-4-git-send-email-felipe.balbi@nokia.com>
 <1207742644-6260-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57447 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYDIMFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 08:05:36 -0400
In-Reply-To: <1207742644-6260-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>

Enables recent drivers and usb.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/configs/n800_defconfig |  189 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 182 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
index ea687ff..a8e133c 100644
--- a/arch/arm/configs/n800_defconfig
+++ b/arch/arm/configs/n800_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6-omap1
-# Fri Mar 28 10:53:25 2008
+# Linux kernel version: 2.6.25-rc8-omap1
+# Tue Apr  8 15:34:27 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -465,8 +465,13 @@ CONFIG_BT_HIDP=y
 #
 # Bluetooth device drivers
 #
+# CONFIG_BT_HCIUSB is not set
+# CONFIG_BT_HCIBTUSB is not set
 # CONFIG_BT_HCIBTSDIO is not set
 # CONFIG_BT_HCIUART is not set
+# CONFIG_BT_HCIBCM203X is not set
+# CONFIG_BT_HCIBPA10X is not set
+# CONFIG_BT_HCIBFUSB is not set
 # CONFIG_BT_HCIBRF6150 is not set
 # CONFIG_BT_HCIH4P is not set
 # CONFIG_BT_HCIVHCI is not set
@@ -578,6 +583,7 @@ CONFIG_BLK_DEV=y
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
@@ -651,6 +657,15 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 CONFIG_PPP=y
 # CONFIG_PPP_MULTILINK is not set
@@ -698,7 +713,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 # CONFIG_KEYBOARD_OMAP is not set
-CONFIG_KEYBOARD_TSC2301=y
+CONFIG_KEYBOARD_LM8323=y
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
@@ -714,9 +729,10 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
 # CONFIG_TOUCHSCREEN_UCB1400 is not set
+CONFIG_TOUCHSCREEN_TSC2005=y
 # CONFIG_TOUCHSCREEN_TSC2102 is not set
 # CONFIG_TOUCHSCREEN_TSC210X is not set
-CONFIG_TOUCHSCREEN_TSC2301=y
+# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -784,6 +800,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -800,6 +817,8 @@ CONFIG_I2C_OMAP=y
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
+CONFIG_SENSORS_TSL2563=y
+CONFIG_LP5521=y
 CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
@@ -826,8 +845,7 @@ CONFIG_SPI_OMAP24XX=y
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
-CONFIG_SPI_TSC2301=y
-CONFIG_SPI_TSC2301_AUDIO=y
+# CONFIG_SPI_TSC2301 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
@@ -911,6 +929,11 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_OMAP_WATCHDOG=y
 
 #
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
+
+#
 # Sonics Silicon Backplane
 #
 CONFIG_SSB_POSSIBLE=y
@@ -939,8 +962,19 @@ CONFIG_VIDEO_TCM825X=y
 # CONFIG_VIDEO_SAA5249 is not set
 # CONFIG_VIDEO_OMAP_CAMERA is not set
 CONFIG_VIDEO_OMAP2=y
+CONFIG_V4L_USB_DRIVERS=y
+# CONFIG_VIDEO_PVRUSB2 is not set
+# CONFIG_VIDEO_EM28XX is not set
+# CONFIG_VIDEO_USBVISION is not set
+# CONFIG_USB_ET61X251 is not set
+# CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_ZC0301 is not set
+# CONFIG_USB_ZR364XX is not set
+# CONFIG_USB_STKWEBCAM is not set
 CONFIG_RADIO_ADAPTERS=y
 CONFIG_RADIO_TEA5761=y
+# CONFIG_USB_DSBR is not set
+# CONFIG_USB_SI470X is not set
 # CONFIG_DVB_CORE is not set
 CONFIG_VIDEOBUF_GEN=y
 CONFIG_VIDEOBUF_DMA_SG=y
@@ -1038,6 +1072,12 @@ CONFIG_SND_OMAP24XX_EAC=y
 #
 
 #
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_CAIAQ is not set
+
+#
 # System on Chip audio support
 #
 # CONFIG_SND_SOC is not set
@@ -1058,7 +1098,140 @@ CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 # CONFIG_HIDRAW is not set
-# CONFIG_USB_SUPPORT is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+CONFIG_USB_SUSPEND=y
+# CONFIG_USB_PERSIST is not set
+CONFIG_USB_OTG=y
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_TUSB6010=y
+# CONFIG_USB_MUSB_HOST is not set
+# CONFIG_USB_MUSB_PERIPHERAL is not set
+CONFIG_USB_MUSB_OTG=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
+CONFIG_USB_MUSB_HDRC_HCD=y
+# CONFIG_MUSB_PIO_ONLY is not set
+# CONFIG_USB_INVENTRA_DMA is not set
+# CONFIG_USB_TI_CPPI_DMA is not set
+CONFIG_USB_TUSB_OMAP_DMA=y
+CONFIG_USB_MUSB_LOGLEVEL=1
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+CONFIG_USB_LIBUSUAL=y
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+CONFIG_USB_TEST=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DEBUG=y
+CONFIG_USB_GADGET_DEBUG_FILES=y
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_ATMEL_USBA is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+# CONFIG_USB_ZERO is not set
+CONFIG_USB_ETH=y
+CONFIG_USB_ETH_RNDIS=y
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_USB_G_PRINTER is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
@@ -1101,6 +1274,7 @@ CONFIG_RTC_LIB=y
 CONFIG_CBUS=y
 CONFIG_CBUS_TAHVO=y
 CONFIG_CBUS_TAHVO_USER=y
+# CONFIG_CBUS_TAHVO_USB is not set
 CONFIG_CBUS_RETU=y
 CONFIG_CBUS_RETU_USER=y
 CONFIG_CBUS_RETU_POWERBUTTON=y
@@ -1306,6 +1480,7 @@ CONFIG_DEBUG_ERRORS=y
 CONFIG_SECURITY=y
 # CONFIG_SECURITY_NETWORK is not set
 # CONFIG_SECURITY_CAPABILITIES is not set
+# CONFIG_SECURITY_ROOTPLUG is not set
 # CONFIG_SECURITY_LOWMEM is not set
 CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_CRYPTO=y
-- 
1.5.5.rc3

