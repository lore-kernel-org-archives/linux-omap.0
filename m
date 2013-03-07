From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] usb: phy: remove CONFIG_USB_OTG_UTILS
Date: Thu, 7 Mar 2013 16:41:39 +0200
Message-ID: <1362667299-17752-1-git-send-email-balbi@ti.com>
References: <1362648969-13737-11-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362648969-13737-11-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

there are no more users of CONFIG_USB_OTG_UTILS
left in tree, we can remove it just fine.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---

v1 -> v2:
	. removed a few extra instances which my original (and stupid)
		grep didn't find

 drivers/power/Kconfig      |  2 +-
 drivers/usb/dwc3/Kconfig   |  1 -
 drivers/usb/gadget/Kconfig |  3 ---
 drivers/usb/host/Kconfig   |  1 -
 drivers/usb/musb/Kconfig   |  1 -
 drivers/usb/phy/Kconfig    | 23 -----------------------
 6 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 9e00c38..ffe02fb 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -254,7 +254,7 @@ config BATTERY_RX51
 
 config CHARGER_ISP1704
 	tristate "ISP1704 USB Charger Detection"
-	depends on USB_OTG_UTILS
+	depends on USB_PHY
 	help
 	  Say Y to enable support for USB Charger Detection with
 	  ISP1707/ISP1704 USB transceivers.
diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 68e9a2c..ea5ee9c 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -1,7 +1,6 @@
 config USB_DWC3
 	tristate "DesignWare USB3 DRD Core Support"
 	depends on (USB || USB_GADGET) && GENERIC_HARDIRQS
-	select USB_OTG_UTILS
 	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system has a Dual Role SuperSpeed
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 50586ff..7ad108a 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -195,7 +195,6 @@ config USB_OMAP
 	tristate "OMAP USB Device Controller"
 	depends on ARCH_OMAP1
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_H4_OTG
-	select USB_OTG_UTILS if ARCH_OMAP
 	help
 	   Many Texas Instruments OMAP processors have flexible full
 	   speed USB device controllers, with support for up to 30
@@ -210,7 +209,6 @@ config USB_OMAP
 config USB_PXA25X
 	tristate "PXA 25x or IXP 4xx"
 	depends on (ARCH_PXA && PXA25x) || ARCH_IXP4XX
-	select USB_OTG_UTILS
 	help
 	   Intel's PXA 25x series XScale ARM-5TE processors include
 	   an integrated full speed USB 1.1 device controller.  The
@@ -258,7 +256,6 @@ config USB_RENESAS_USBHS_UDC
 
 config USB_PXA27X
 	tristate "PXA 27x"
-	select USB_OTG_UTILS
 	help
 	   Intel's PXA 27x series XScale ARM v5TE processors include
 	   an integrated full speed USB 1.1 device controller.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c59a112..ba1347c 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -300,7 +300,6 @@ config USB_OHCI_HCD
 	tristate "OHCI HCD support"
 	depends on USB && USB_ARCH_HAS_OHCI
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
-	select USB_OTG_UTILS if ARCH_OMAP
 	depends on USB_ISP1301 || !ARCH_LPC32XX
 	---help---
 	  The Open Host Controller Interface (OHCI) is a standard for accessing
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index b387431..079330b 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -10,7 +10,6 @@ config USB_MUSB_HDRC
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
 	select NOP_USB_XCEIV if (SOC_TI81XX || SOC_AM33XX)
 	select OMAP_CONTROL_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
-	select USB_OTG_UTILS
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on the Mentor Graphics silicon IP.  Then
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
