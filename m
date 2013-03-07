From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 10/10] usb: phy: remove CONFIG_USB_OTG_UTILS
Date: Thu, 7 Mar 2013 11:36:09 +0200
Message-ID: <1362648969-13737-11-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932528Ab3CGJgq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:46 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

there are no more users of CONFIG_USB_OTG_UTILS
left in tree, we can remove it just fine.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/phy/Kconfig | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 832cd69..97de6de 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -3,7 +3,6 @@
 #
 menuconfig USB_PHY
 	tristate "USB Physical Layer drivers"
-	select USB_OTG_UTILS
 	help
 	  USB controllers (those which are host, device or DRD) need a
 	  device to handle the physical layer signalling, commonly called
@@ -13,19 +12,12 @@ menuconfig USB_PHY
 
 if USB_PHY
 
-config USB_OTG_UTILS
-	bool
-	help
-	  Select this to make sure the build includes objects from
-	  the OTG infrastructure directory.
-
 #
 # USB Transceiver Drivers
 #
 config AB8500_USB
 	tristate "AB8500 USB Transceiver Driver"
 	depends on AB8500_CORE
-	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver in AB8500 chip.
 	  This transceiver supports high and full speed devices plus,
@@ -35,14 +27,12 @@ config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
 	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_SUSPEND
 	select USB_OTG
-	select USB_OTG_UTILS
 	help
 	  Enable this to support Freescale USB OTG transceiver.
 
 config ISP1301_OMAP
 	tristate "Philips ISP1301 with OMAP OTG"
 	depends on I2C && ARCH_OMAP_OTG
-	select USB_OTG_UTILS
 	help
 	  If you say yes here you get support for the Philips ISP1301
 	  USB-On-The-Go transceiver working with the OMAP OTG controller.
@@ -56,14 +46,12 @@ config ISP1301_OMAP
 config MV_U3D_PHY
 	bool "Marvell USB 3.0 PHY controller Driver"
 	depends on USB_MV_U3D
-	select USB_OTG_UTILS
 	help
 	  Enable this to support Marvell USB 3.0 phy controller for Marvell
 	  SoC.
 
 config NOP_USB_XCEIV
 	tristate "NOP USB Transceiver Driver"
-	select USB_OTG_UTILS
 	help
 	  This driver is to be used by all the usb transceiver which are either
 	  built-in with usb ip or which are autonomous and doesn't require any
@@ -81,7 +69,6 @@ config OMAP_CONTROL_USB
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
 	depends on ARCH_OMAP2PLUS
-	select USB_OTG_UTILS
 	select OMAP_CONTROL_USB
 	help
 	  Enable this to support the transceiver that is part of SOC. This
@@ -91,7 +78,6 @@ config OMAP_USB2
 
 config OMAP_USB3
 	tristate "OMAP USB3 PHY Driver"
-	select USB_OTG_UTILS
 	select OMAP_CONTROL_USB
 	help
 	  Enable this to support the USB3 PHY that is part of SOC. This
@@ -102,7 +88,6 @@ config OMAP_USB3
 config SAMSUNG_USBPHY
 	bool "Samsung USB PHY controller Driver"
 	depends on USB_S3C_HSOTG || USB_EHCI_S5P || USB_OHCI_EXYNOS
-	select USB_OTG_UTILS
 	help
 	  Enable this to support Samsung USB phy controller for samsung
 	  SoCs.
@@ -110,7 +95,6 @@ config SAMSUNG_USBPHY
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
-	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL4030
 	  family chips (including the TWL5030 and TPS659x0 devices).
@@ -120,7 +104,6 @@ config TWL4030_USB
 config TWL6030_USB
 	tristate "TWL6030 USB Transceiver Driver"
 	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
-	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL6030
 	  family chips. This TWL6030 transceiver has the VBUS and ID GND
@@ -132,7 +115,6 @@ config TWL6030_USB
 config USB_GPIO_VBUS
 	tristate "GPIO based peripheral-only VBUS sensing 'transceiver'"
 	depends on GENERIC_GPIO
-	select USB_OTG_UTILS
 	help
 	  Provides simple GPIO VBUS sensing for controllers with an
 	  internal transceiver via the usb_phy interface, and
@@ -154,7 +136,6 @@ config USB_ISP1301
 config USB_MSM_OTG
 	tristate "OTG support for Qualcomm on-chip USB controller"
 	depends on (USB || USB_GADGET) && ARCH_MSM
-	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on MSM chips. It
 	  handles PHY initialization, clock management, and workarounds
@@ -168,7 +149,6 @@ config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
 	select USB_OTG
-	select USB_OTG_UTILS
 	help
 	  Say Y here if you want to build Marvell USB OTG transciever
 	  driver in kernel (including PXA and MMP series). This driver
@@ -180,7 +160,6 @@ config USB_MXS_PHY
 	tristate "Freescale MXS USB PHY support"
 	depends on ARCH_MXC || ARCH_MXS
 	select STMP_DEVICE
-	select USB_OTG_UTILS
 	help
 	  Enable this to support the Freescale MXS USB PHY.
 
@@ -189,7 +168,6 @@ config USB_MXS_PHY
 config USB_RCAR_PHY
 	tristate "Renesas R-Car USB phy support"
 	depends on USB || USB_GADGET
-	select USB_OTG_UTILS
 	help
 	  Say Y here to add support for the Renesas R-Car USB phy driver.
 	  This chip is typically used as USB phy for USB host, gadget.
@@ -201,7 +179,6 @@ config USB_RCAR_PHY
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
 	depends on ARM
-	select USB_OTG_UTILS
 	help
 	  Enable this to support ULPI connected USB OTG transceivers which
 	  are likely found on embedded boards.
-- 
1.8.1.rc1.5.g7e0651a

