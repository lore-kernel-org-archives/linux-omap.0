From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/10] usb: phy: move all PHY drivers to drivers/usb/phy/
Date: Thu, 7 Mar 2013 11:36:03 +0200
Message-ID: <1362648969-13737-5-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293Ab3CGJgn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:43 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

that's a much more reasonable location for
those drivers. It helps us saving drivers/usb/otg/
for when we actually start adding generic OTG
code.

Also completely delete drivers/usb/otg/ as there's
nothing left there.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/Kconfig                      |   2 -
 drivers/usb/Makefile                     |   2 -
 drivers/usb/otg/Kconfig                  | 141 --------------------------
 drivers/usb/otg/Makefile                 |  21 ----
 drivers/usb/phy/Kconfig                  | 168 +++++++++++++++++++++++++++----
 drivers/usb/phy/Makefile                 |  24 ++++-
 drivers/usb/{otg => phy}/ab8500-usb.c    |   0
 drivers/usb/{otg => phy}/fsl_otg.c       |   0
 drivers/usb/{otg => phy}/fsl_otg.h       |   0
 drivers/usb/{otg => phy}/gpio_vbus.c     |   0
 drivers/usb/{otg => phy}/isp1301_omap.c  |   0
 drivers/usb/{otg => phy}/msm_otg.c       |   0
 drivers/usb/{otg => phy}/mv_otg.c        |   0
 drivers/usb/{otg => phy}/mv_otg.h        |   0
 drivers/usb/{otg => phy}/mxs-phy.c       |   0
 drivers/usb/{otg => phy}/nop-usb-xceiv.c |   0
 drivers/usb/{otg => phy}/otg_fsm.c       |   0
 drivers/usb/{otg => phy}/otg_fsm.h       |   0
 drivers/usb/{otg => phy}/twl4030-usb.c   |   0
 drivers/usb/{otg => phy}/twl6030-usb.c   |   0
 drivers/usb/{otg => phy}/ulpi.c          |   0
 drivers/usb/{otg => phy}/ulpi_viewport.c |   0
 22 files changed, 171 insertions(+), 187 deletions(-)
 delete mode 100644 drivers/usb/otg/Kconfig
 delete mode 100644 drivers/usb/otg/Makefile
 rename drivers/usb/{otg => phy}/ab8500-usb.c (100%)
 rename drivers/usb/{otg => phy}/fsl_otg.c (100%)
 rename drivers/usb/{otg => phy}/fsl_otg.h (100%)
 rename drivers/usb/{otg => phy}/gpio_vbus.c (100%)
 rename drivers/usb/{otg => phy}/isp1301_omap.c (100%)
 rename drivers/usb/{otg => phy}/msm_otg.c (100%)
 rename drivers/usb/{otg => phy}/mv_otg.c (100%)
 rename drivers/usb/{otg => phy}/mv_otg.h (100%)
 rename drivers/usb/{otg => phy}/mxs-phy.c (100%)
 rename drivers/usb/{otg => phy}/nop-usb-xceiv.c (100%)
 rename drivers/usb/{otg => phy}/otg_fsm.c (100%)
 rename drivers/usb/{otg => phy}/otg_fsm.h (100%)
 rename drivers/usb/{otg => phy}/twl4030-usb.c (100%)
 rename drivers/usb/{otg => phy}/twl6030-usb.c (100%)
 rename drivers/usb/{otg => phy}/ulpi.c (100%)
 rename drivers/usb/{otg => phy}/ulpi_viewport.c (100%)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 640ae6c..2c481b8 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -186,6 +186,4 @@ source "drivers/usb/atm/Kconfig"
 
 source "drivers/usb/gadget/Kconfig"
 
-source "drivers/usb/otg/Kconfig"
-
 endif # USB_SUPPORT
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index f5ed3d7..5aa98f0 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -6,8 +6,6 @@
 
 obj-$(CONFIG_USB)		+= core/
 
-obj-$(CONFIG_USB_OTG_UTILS)	+= otg/
-
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 
 obj-$(CONFIG_USB_MON)		+= mon/
diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
deleted file mode 100644
index 37962c9..0000000
--- a/drivers/usb/otg/Kconfig
+++ /dev/null
@@ -1,141 +0,0 @@
-#
-# USB OTG infrastructure may be needed for peripheral-only, host-only,
-# or OTG-capable configurations when OTG transceivers or controllers
-# are used.
-#
-
-comment "OTG and related infrastructure"
-
-config USB_OTG_UTILS
-	bool
-	help
-	  Select this to make sure the build includes objects from
-	  the OTG infrastructure directory.
-
-if USB || USB_GADGET
-
-#
-# USB Transceiver Drivers
-#
-config USB_GPIO_VBUS
-	tristate "GPIO based peripheral-only VBUS sensing 'transceiver'"
-	depends on GENERIC_GPIO
-	select USB_OTG_UTILS
-	help
-	  Provides simple GPIO VBUS sensing for controllers with an
-	  internal transceiver via the usb_phy interface, and
-	  optionally control of a D+ pullup GPIO as well as a VBUS
-	  current limit regulator.
-
-config ISP1301_OMAP
-	tristate "Philips ISP1301 with OMAP OTG"
-	depends on I2C && ARCH_OMAP_OTG
-	select USB_OTG_UTILS
-	help
-	  If you say yes here you get support for the Philips ISP1301
-	  USB-On-The-Go transceiver working with the OMAP OTG controller.
-	  The ISP1301 is a full speed USB  transceiver which is used in
-	  products including H2, H3, and H4 development boards for Texas
-	  Instruments OMAP processors.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called isp1301_omap.
-
-config USB_ULPI
-	bool "Generic ULPI Transceiver Driver"
-	depends on ARM
-	select USB_OTG_UTILS
-	help
-	  Enable this to support ULPI connected USB OTG transceivers which
-	  are likely found on embedded boards.
-
-config USB_ULPI_VIEWPORT
-	bool
-	depends on USB_ULPI
-	help
-	  Provides read/write operations to the ULPI phy register set for
-	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
-
-config TWL4030_USB
-	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
-	select USB_OTG_UTILS
-	help
-	  Enable this to support the USB OTG transceiver on TWL4030
-	  family chips (including the TWL5030 and TPS659x0 devices).
-	  This transceiver supports high and full speed devices plus,
-	  in host mode, low speed.
-
-config TWL6030_USB
-	tristate "TWL6030 USB Transceiver Driver"
-	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
-	select USB_OTG_UTILS
-	help
-	  Enable this to support the USB OTG transceiver on TWL6030
-	  family chips. This TWL6030 transceiver has the VBUS and ID GND
-	  and OTG SRP events capabilities. For all other transceiver functionality
-	  UTMI PHY is embedded in OMAP4430. The internal PHY configurations APIs
-	  are hooked to this driver through platform_data structure.
-	  The definition of internal PHY APIs are in the mach-omap2 layer.
-
-config NOP_USB_XCEIV
-	tristate "NOP USB Transceiver Driver"
-	select USB_OTG_UTILS
-	help
-	  This driver is to be used by all the usb transceiver which are either
-	  built-in with usb ip or which are autonomous and doesn't require any
-	  phy programming such as ISP1x04 etc.
-
-config USB_MSM_OTG
-	tristate "OTG support for Qualcomm on-chip USB controller"
-	depends on (USB || USB_GADGET) && ARCH_MSM
-	select USB_OTG_UTILS
-	help
-	  Enable this to support the USB OTG transceiver on MSM chips. It
-	  handles PHY initialization, clock management, and workarounds
-	  required after resetting the hardware and power management.
-	  This driver is required even for peripheral only or host only
-	  mode configurations.
-	  This driver is not supported on boards like trout which
-	  has an external PHY.
-
-config AB8500_USB
-	tristate "AB8500 USB Transceiver Driver"
-	depends on AB8500_CORE
-	select USB_OTG_UTILS
-	help
-	  Enable this to support the USB OTG transceiver in AB8500 chip.
-	  This transceiver supports high and full speed devices plus,
-	  in host mode, low speed.
-
-config FSL_USB2_OTG
-	bool "Freescale USB OTG Transceiver Driver"
-	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_SUSPEND
-	select USB_OTG
-	select USB_OTG_UTILS
-	help
-	  Enable this to support Freescale USB OTG transceiver.
-
-config USB_MXS_PHY
-	tristate "Freescale MXS USB PHY support"
-	depends on ARCH_MXC || ARCH_MXS
-	select STMP_DEVICE
-	select USB_OTG_UTILS
-	help
-	  Enable this to support the Freescale MXS USB PHY.
-
-	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
-
-config USB_MV_OTG
-	tristate "Marvell USB OTG support"
-	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
-	select USB_OTG
-	select USB_OTG_UTILS
-	help
-	  Say Y here if you want to build Marvell USB OTG transciever
-	  driver in kernel (including PXA and MMP series). This driver
-	  implements role switch between EHCI host driver and gadget driver.
-
-	  To compile this driver as a module, choose M here.
-
-endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
deleted file mode 100644
index 6abc453..0000000
--- a/drivers/usb/otg/Makefile
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# OTG infrastructure and transceiver drivers
-#
-
-ccflags-$(CONFIG_USB_DEBUG)		:= -DDEBUG
-ccflags-$(CONFIG_USB_GADGET_DEBUG)	+= -DDEBUG
-
-# transceiver drivers
-obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
-obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
-obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
-obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o
-obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
-obj-$(CONFIG_USB_ULPI)		+= ulpi.o
-obj-$(CONFIG_USB_ULPI_VIEWPORT)	+= ulpi_viewport.o
-obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
-obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
-fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
-obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
-obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
-obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 65217a5..32ce740 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -4,6 +4,73 @@
 comment "USB Physical Layer drivers"
 	depends on USB || USB_GADGET
 
+config USB_OTG_UTILS
+	bool
+	help
+	  Select this to make sure the build includes objects from
+	  the OTG infrastructure directory.
+
+if USB || USB_GADGET
+
+#
+# USB Transceiver Drivers
+#
+config AB8500_USB
+	tristate "AB8500 USB Transceiver Driver"
+	depends on AB8500_CORE
+	select USB_OTG_UTILS
+	help
+	  Enable this to support the USB OTG transceiver in AB8500 chip.
+	  This transceiver supports high and full speed devices plus,
+	  in host mode, low speed.
+
+config FSL_USB2_OTG
+	bool "Freescale USB OTG Transceiver Driver"
+	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_SUSPEND
+	select USB_OTG
+	select USB_OTG_UTILS
+	help
+	  Enable this to support Freescale USB OTG transceiver.
+
+config ISP1301_OMAP
+	tristate "Philips ISP1301 with OMAP OTG"
+	depends on I2C && ARCH_OMAP_OTG
+	select USB_OTG_UTILS
+	help
+	  If you say yes here you get support for the Philips ISP1301
+	  USB-On-The-Go transceiver working with the OMAP OTG controller.
+	  The ISP1301 is a full speed USB  transceiver which is used in
+	  products including H2, H3, and H4 development boards for Texas
+	  Instruments OMAP processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called isp1301_omap.
+
+config MV_U3D_PHY
+	bool "Marvell USB 3.0 PHY controller Driver"
+	depends on USB_MV_U3D
+	select USB_OTG_UTILS
+	help
+	  Enable this to support Marvell USB 3.0 phy controller for Marvell
+	  SoC.
+
+config NOP_USB_XCEIV
+	tristate "NOP USB Transceiver Driver"
+	select USB_OTG_UTILS
+	help
+	  This driver is to be used by all the usb transceiver which are either
+	  built-in with usb ip or which are autonomous and doesn't require any
+	  phy programming such as ISP1x04 etc.
+
+config OMAP_CONTROL_USB
+	tristate "OMAP CONTROL USB Driver"
+	help
+	  Enable this to add support for the USB part present in the control
+	  module. This driver has API to power on the USB2 PHY and to write to
+	  the mailbox. The mailbox is present only in omap4 and the register to
+	  power on the USB2 PHY is present in OMAP4 and OMAP5. OMAP5 has an
+	  additional register to power on USB3 PHY.
+
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
 	depends on ARCH_OMAP2PLUS
@@ -25,14 +92,45 @@ config OMAP_USB3
 	  This driver interacts with the "OMAP Control USB Driver" to power
 	  on/off the PHY.
 
-config OMAP_CONTROL_USB
-	tristate "OMAP CONTROL USB Driver"
+config SAMSUNG_USBPHY
+	bool "Samsung USB PHY controller Driver"
+	depends on USB_S3C_HSOTG || USB_EHCI_S5P || USB_OHCI_EXYNOS
+	select USB_OTG_UTILS
 	help
-	  Enable this to add support for the USB part present in the control
-	  module. This driver has API to power on the USB2 PHY and to write to
-	  the mailbox. The mailbox is present only in omap4 and the register to
-	  power on the USB2 PHY is present in OMAP4 and OMAP5. OMAP5 has an
-	  additional register to power on USB3 PHY.
+	  Enable this to support Samsung USB phy controller for samsung
+	  SoCs.
+
+config TWL4030_USB
+	tristate "TWL4030 USB Transceiver Driver"
+	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
+	select USB_OTG_UTILS
+	help
+	  Enable this to support the USB OTG transceiver on TWL4030
+	  family chips (including the TWL5030 and TPS659x0 devices).
+	  This transceiver supports high and full speed devices plus,
+	  in host mode, low speed.
+
+config TWL6030_USB
+	tristate "TWL6030 USB Transceiver Driver"
+	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
+	select USB_OTG_UTILS
+	help
+	  Enable this to support the USB OTG transceiver on TWL6030
+	  family chips. This TWL6030 transceiver has the VBUS and ID GND
+	  and OTG SRP events capabilities. For all other transceiver functionality
+	  UTMI PHY is embedded in OMAP4430. The internal PHY configurations APIs
+	  are hooked to this driver through platform_data structure.
+	  The definition of internal PHY APIs are in the mach-omap2 layer.
+
+config USB_GPIO_VBUS
+	tristate "GPIO based peripheral-only VBUS sensing 'transceiver'"
+	depends on GENERIC_GPIO
+	select USB_OTG_UTILS
+	help
+	  Provides simple GPIO VBUS sensing for controllers with an
+	  internal transceiver via the usb_phy interface, and
+	  optionally control of a D+ pullup GPIO as well as a VBUS
+	  current limit regulator.
 
 config USB_ISP1301
 	tristate "NXP ISP1301 USB transceiver support"
@@ -46,13 +144,40 @@ config USB_ISP1301
 	  To compile this driver as a module, choose M here: the
 	  module will be called isp1301.
 
-config MV_U3D_PHY
-	bool "Marvell USB 3.0 PHY controller Driver"
-	depends on USB_MV_U3D
+config USB_MSM_OTG
+	tristate "OTG support for Qualcomm on-chip USB controller"
+	depends on (USB || USB_GADGET) && ARCH_MSM
 	select USB_OTG_UTILS
 	help
-	  Enable this to support Marvell USB 3.0 phy controller for Marvell
-	  SoC.
+	  Enable this to support the USB OTG transceiver on MSM chips. It
+	  handles PHY initialization, clock management, and workarounds
+	  required after resetting the hardware and power management.
+	  This driver is required even for peripheral only or host only
+	  mode configurations.
+	  This driver is not supported on boards like trout which
+	  has an external PHY.
+
+config USB_MV_OTG
+	tristate "Marvell USB OTG support"
+	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
+	select USB_OTG
+	select USB_OTG_UTILS
+	help
+	  Say Y here if you want to build Marvell USB OTG transciever
+	  driver in kernel (including PXA and MMP series). This driver
+	  implements role switch between EHCI host driver and gadget driver.
+
+	  To compile this driver as a module, choose M here.
+
+config USB_MXS_PHY
+	tristate "Freescale MXS USB PHY support"
+	depends on ARCH_MXC || ARCH_MXS
+	select STMP_DEVICE
+	select USB_OTG_UTILS
+	help
+	  Enable this to support the Freescale MXS USB PHY.
+
+	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
 
 config USB_RCAR_PHY
 	tristate "Renesas R-Car USB phy support"
@@ -66,10 +191,19 @@ config USB_RCAR_PHY
 	  To compile this driver as a module, choose M here: the
 	  module will be called rcar-phy.
 
-config SAMSUNG_USBPHY
-	bool "Samsung USB PHY controller Driver"
-	depends on USB_S3C_HSOTG || USB_EHCI_S5P || USB_OHCI_EXYNOS
+config USB_ULPI
+	bool "Generic ULPI Transceiver Driver"
+	depends on ARM
 	select USB_OTG_UTILS
 	help
-	  Enable this to support Samsung USB phy controller for samsung
-	  SoCs.
+	  Enable this to support ULPI connected USB OTG transceivers which
+	  are likely found on embedded boards.
+
+config USB_ULPI_VIEWPORT
+	bool
+	depends on USB_ULPI
+	help
+	  Provides read/write operations to the ULPI phy register set for
+	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
+
+endif # USB || OTG
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 9fa6327..34488ce 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -5,11 +5,27 @@
 ccflags-$(CONFIG_USB_DEBUG) := -DDEBUG
 
 obj-$(CONFIG_USB_OTG_UTILS)		+= phy.o
+
+# transceiver drivers, keep the list sorted
+
+obj-$(CONFIG_AB8500_USB)		+= ab8500-usb.o
+fsl_usb2_otg-objs			:= fsl_otg.o otg_fsm.o
+obj-$(CONFIG_FSL_USB2_OTG)		+= fsl_usb2_otg.o
+obj-$(CONFIG_ISP1301_OMAP)		+= isp1301_omap.o
+obj-$(CONFIG_MV_U3D_PHY)		+= mv_u3d_phy.o
+obj-$(CONFIG_NOP_USB_XCEIV)		+= nop-usb-xceiv.o
+obj-$(CONFIG_OMAP_CONTROL_USB)		+= omap-control-usb.o
 obj-$(CONFIG_OMAP_USB2)			+= omap-usb2.o
 obj-$(CONFIG_OMAP_USB3)			+= omap-usb3.o
-obj-$(CONFIG_OMAP_CONTROL_USB)		+= omap-control-usb.o
+obj-$(CONFIG_SAMSUNG_USBPHY)		+= samsung-usbphy.o
+obj-$(CONFIG_TWL4030_USB)		+= twl4030-usb.o
+obj-$(CONFIG_TWL6030_USB)		+= twl6030-usb.o
+obj-$(CONFIG_USB_EHCI_TEGRA)		+= tegra_usb_phy.o
+obj-$(CONFIG_USB_GPIO_VBUS)		+= gpio_vbus.o
 obj-$(CONFIG_USB_ISP1301)		+= isp1301.o
-obj-$(CONFIG_MV_U3D_PHY)		+= mv_u3d_phy.o
-obj-$(CONFIG_USB_EHCI_TEGRA)	+= tegra_usb_phy.o
+obj-$(CONFIG_USB_MSM_OTG)		+= msm_otg.o
+obj-$(CONFIG_USB_MV_OTG)		+= mv_otg.o
+obj-$(CONFIG_USB_MXS_PHY)		+= mxs-phy.o
 obj-$(CONFIG_USB_RCAR_PHY)		+= rcar-phy.o
-obj-$(CONFIG_SAMSUNG_USBPHY)		+= samsung-usbphy.o
+obj-$(CONFIG_USB_ULPI)			+= ulpi.o
+obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= ulpi_viewport.o
diff --git a/drivers/usb/otg/ab8500-usb.c b/drivers/usb/phy/ab8500-usb.c
similarity index 100%
rename from drivers/usb/otg/ab8500-usb.c
rename to drivers/usb/phy/ab8500-usb.c
diff --git a/drivers/usb/otg/fsl_otg.c b/drivers/usb/phy/fsl_otg.c
similarity index 100%
rename from drivers/usb/otg/fsl_otg.c
rename to drivers/usb/phy/fsl_otg.c
diff --git a/drivers/usb/otg/fsl_otg.h b/drivers/usb/phy/fsl_otg.h
similarity index 100%
rename from drivers/usb/otg/fsl_otg.h
rename to drivers/usb/phy/fsl_otg.h
diff --git a/drivers/usb/otg/gpio_vbus.c b/drivers/usb/phy/gpio_vbus.c
similarity index 100%
rename from drivers/usb/otg/gpio_vbus.c
rename to drivers/usb/phy/gpio_vbus.c
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/phy/isp1301_omap.c
similarity index 100%
rename from drivers/usb/otg/isp1301_omap.c
rename to drivers/usb/phy/isp1301_omap.c
diff --git a/drivers/usb/otg/msm_otg.c b/drivers/usb/phy/msm_otg.c
similarity index 100%
rename from drivers/usb/otg/msm_otg.c
rename to drivers/usb/phy/msm_otg.c
diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/phy/mv_otg.c
similarity index 100%
rename from drivers/usb/otg/mv_otg.c
rename to drivers/usb/phy/mv_otg.c
diff --git a/drivers/usb/otg/mv_otg.h b/drivers/usb/phy/mv_otg.h
similarity index 100%
rename from drivers/usb/otg/mv_otg.h
rename to drivers/usb/phy/mv_otg.h
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/phy/mxs-phy.c
similarity index 100%
rename from drivers/usb/otg/mxs-phy.c
rename to drivers/usb/phy/mxs-phy.c
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/phy/nop-usb-xceiv.c
similarity index 100%
rename from drivers/usb/otg/nop-usb-xceiv.c
rename to drivers/usb/phy/nop-usb-xceiv.c
diff --git a/drivers/usb/otg/otg_fsm.c b/drivers/usb/phy/otg_fsm.c
similarity index 100%
rename from drivers/usb/otg/otg_fsm.c
rename to drivers/usb/phy/otg_fsm.c
diff --git a/drivers/usb/otg/otg_fsm.h b/drivers/usb/phy/otg_fsm.h
similarity index 100%
rename from drivers/usb/otg/otg_fsm.h
rename to drivers/usb/phy/otg_fsm.h
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/phy/twl4030-usb.c
similarity index 100%
rename from drivers/usb/otg/twl4030-usb.c
rename to drivers/usb/phy/twl4030-usb.c
diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/phy/twl6030-usb.c
similarity index 100%
rename from drivers/usb/otg/twl6030-usb.c
rename to drivers/usb/phy/twl6030-usb.c
diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/phy/ulpi.c
similarity index 100%
rename from drivers/usb/otg/ulpi.c
rename to drivers/usb/phy/ulpi.c
diff --git a/drivers/usb/otg/ulpi_viewport.c b/drivers/usb/phy/ulpi_viewport.c
similarity index 100%
rename from drivers/usb/otg/ulpi_viewport.c
rename to drivers/usb/phy/ulpi_viewport.c
-- 
1.8.1.rc1.5.g7e0651a

