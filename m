From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/2] AM35xx: Enable EHCI in defconfig
Date: Wed,  4 Nov 2009 19:48:33 +0530
Message-ID: <1257344313-14370-2-git-send-email-ajay.gupta@ti.com>
References: <1257344313-14370-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45886 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829AbZKDOSd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Nov 2009 09:18:33 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA4EIZ2Q006256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 Nov 2009 08:18:37 -0600
In-Reply-To: <1257344313-14370-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>

Enabling USB EHCI in am3517_evm_defconfig.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |  153 ++++++++++++++++++++++++++++++++-
 1 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index 787f295..ad54e92 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -464,6 +464,7 @@ CONFIG_BLK_DEV=y
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
@@ -667,8 +668,156 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_NTRIG is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
+# CONFIG_USB_MUSB_HDRC is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+
+#
+# also be needed; see USB_STORAGE Help for more info
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
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
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
-- 
1.6.2.4

