From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] phy: Group vendor specific phy drivers
Date: Fri, 01 Apr 2016 17:16:59 +0200
Message-ID: <2184537.UxPmHQG1V3@phil>
References: <1459510156-9147-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459510156-9147-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Am Freitag, 1. April 2016, 16:59:15 schrieb Vivek Gautam:
> Adding vendor specific directories in phy to group
> phy drivers under their respective vendor umbrella.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

I don't have a preference about the phy-locations either way, so for 
Rockchip phys

Acked-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

> ---
> 
> With growing number of phy drivers, it makes sense to
> group these drivers under their respective vendor/platform
> umbrella directory.
> 
> Build-tested 'multi_v7_defconfig'.
> 
>  drivers/phy/Kconfig                               | 386
> +--------------------- drivers/phy/Makefile                             
> |  57 +---
>  drivers/phy/bcom/Kconfig                          |  27 ++
>  drivers/phy/bcom/Makefile                         |   3 +
>  drivers/phy/{ => bcom}/phy-bcm-cygnus-pcie.c      |   0
>  drivers/phy/{ => bcom}/phy-bcm-kona-usb2.c        |   0
>  drivers/phy/{ => bcom}/phy-brcmstb-sata.c         |   0
>  drivers/phy/hisi/Kconfig                          |  20 ++
>  drivers/phy/hisi/Makefile                         |   2 +
>  drivers/phy/{ => hisi}/phy-hi6220-usb.c           |   0
>  drivers/phy/{ => hisi}/phy-hix5hd2-sata.c         |   0
>  drivers/phy/marvell/Kconfig                       |  50 +++
>  drivers/phy/marvell/Makefile                      |   6 +
>  drivers/phy/{ => marvell}/phy-armada375-usb2.c    |   0
>  drivers/phy/{ => marvell}/phy-berlin-sata.c       |   0
>  drivers/phy/{ => marvell}/phy-berlin-usb.c        |   0
>  drivers/phy/{ => marvell}/phy-mvebu-sata.c        |   0
>  drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c     |   0
>  drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c     |   0
>  drivers/phy/qcom/Kconfig                          |  23 ++
>  drivers/phy/qcom/Makefile                         |   5 +
>  drivers/phy/{ => qcom}/phy-qcom-apq8064-sata.c    |   0
>  drivers/phy/{ => qcom}/phy-qcom-ipq806x-sata.c    |   0
>  drivers/phy/{ => qcom}/phy-qcom-ufs-i.h           |   0
>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.c    |   0
>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.h    |   0
>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.c    |   0
>  drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.h    |   0
>  drivers/phy/{ => qcom}/phy-qcom-ufs.c             |   0
>  drivers/phy/rcar/Kconfig                          |  16 +
>  drivers/phy/rcar/Makefile                         |   2 +
>  drivers/phy/{ => rcar}/phy-rcar-gen2.c            |   0
>  drivers/phy/{ => rcar}/phy-rcar-gen3-usb2.c       |   0
>  drivers/phy/rockchip/Kconfig                      |  23 ++
>  drivers/phy/rockchip/Makefile                     |   3 +
>  drivers/phy/{ => rockchip}/phy-rockchip-dp.c      |   0
>  drivers/phy/{ => rockchip}/phy-rockchip-emmc.c    |   0
>  drivers/phy/{ => rockchip}/phy-rockchip-usb.c     |   0
>  drivers/phy/samsung/Kconfig                       |  87 +++++
>  drivers/phy/samsung/Makefile                      |  10 +
>  drivers/phy/{ => samsung}/phy-exynos-dp-video.c   |   0
>  drivers/phy/{ => samsung}/phy-exynos-mipi-video.c |   0
>  drivers/phy/{ => samsung}/phy-exynos4210-usb2.c   |   0
>  drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c   |   0
>  drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c    |   0
>  drivers/phy/{ => samsung}/phy-exynos5250-sata.c   |   0
>  drivers/phy/{ => samsung}/phy-exynos5250-usb2.c   |   0
>  drivers/phy/{ => samsung}/phy-s5pv210-usb2.c      |   0
>  drivers/phy/{ => samsung}/phy-samsung-usb2.c      |   0
>  drivers/phy/{ => samsung}/phy-samsung-usb2.h      |   0
>  drivers/phy/st/Kconfig                            |  51 +++
>  drivers/phy/st/Makefile                           |   6 +
>  drivers/phy/{ => st}/phy-miphy28lp.c              |   0
>  drivers/phy/{ => st}/phy-miphy365x.c              |   0
>  drivers/phy/{ => st}/phy-spear1310-miphy.c        |   0
>  drivers/phy/{ => st}/phy-spear1340-miphy.c        |   0
>  drivers/phy/{ => st}/phy-stih407-usb.c            |   0
>  drivers/phy/{ => st}/phy-stih41x-usb.c            |   0
>  drivers/phy/sunxi/Kconfig                         |  28 ++
>  drivers/phy/sunxi/Makefile                        |   2 +
>  drivers/phy/{ => sunxi}/phy-sun4i-usb.c           |   0
>  drivers/phy/{ => sunxi}/phy-sun9i-usb.c           |   0
>  drivers/phy/ti/Kconfig                            |  67 ++++
>  drivers/phy/ti/Makefile                           |   6 +
>  drivers/phy/{ => ti}/phy-dm816x-usb.c             |   0
>  drivers/phy/{ => ti}/phy-omap-control.c           |   0
>  drivers/phy/{ => ti}/phy-omap-usb2.c              |   0
>  drivers/phy/{ => ti}/phy-ti-pipe3.c               |   0
>  drivers/phy/{ => ti}/phy-tusb1210.c               |   0
>  drivers/phy/{ => ti}/phy-twl4030-usb.c            |   0
>  drivers/phy/{ => ti}/ulpi_phy.h                   |   0
>  71 files changed, 464 insertions(+), 416 deletions(-)
>  create mode 100644 drivers/phy/bcom/Kconfig
>  create mode 100644 drivers/phy/bcom/Makefile
>  rename drivers/phy/{ => bcom}/phy-bcm-cygnus-pcie.c (100%)
>  rename drivers/phy/{ => bcom}/phy-bcm-kona-usb2.c (100%)
>  rename drivers/phy/{ => bcom}/phy-brcmstb-sata.c (100%)
>  create mode 100644 drivers/phy/hisi/Kconfig
>  create mode 100644 drivers/phy/hisi/Makefile
>  rename drivers/phy/{ => hisi}/phy-hi6220-usb.c (100%)
>  rename drivers/phy/{ => hisi}/phy-hix5hd2-sata.c (100%)
>  create mode 100644 drivers/phy/marvell/Kconfig
>  create mode 100644 drivers/phy/marvell/Makefile
>  rename drivers/phy/{ => marvell}/phy-armada375-usb2.c (100%)
>  rename drivers/phy/{ => marvell}/phy-berlin-sata.c (100%)
>  rename drivers/phy/{ => marvell}/phy-berlin-usb.c (100%)
>  rename drivers/phy/{ => marvell}/phy-mvebu-sata.c (100%)
>  rename drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c (100%)
>  rename drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c (100%)
>  create mode 100644 drivers/phy/qcom/Kconfig
>  create mode 100644 drivers/phy/qcom/Makefile
>  rename drivers/phy/{ => qcom}/phy-qcom-apq8064-sata.c (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ipq806x-sata.c (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-i.h (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.c (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-14nm.h (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.c (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ufs-qmp-20nm.h (100%)
>  rename drivers/phy/{ => qcom}/phy-qcom-ufs.c (100%)
>  create mode 100644 drivers/phy/rcar/Kconfig
>  create mode 100644 drivers/phy/rcar/Makefile
>  rename drivers/phy/{ => rcar}/phy-rcar-gen2.c (100%)
>  rename drivers/phy/{ => rcar}/phy-rcar-gen3-usb2.c (100%)
>  create mode 100644 drivers/phy/rockchip/Kconfig
>  create mode 100644 drivers/phy/rockchip/Makefile
>  rename drivers/phy/{ => rockchip}/phy-rockchip-dp.c (100%)
>  rename drivers/phy/{ => rockchip}/phy-rockchip-emmc.c (100%)
>  rename drivers/phy/{ => rockchip}/phy-rockchip-usb.c (100%)
>  create mode 100644 drivers/phy/samsung/Kconfig
>  create mode 100644 drivers/phy/samsung/Makefile
>  rename drivers/phy/{ => samsung}/phy-exynos-dp-video.c (100%)
>  rename drivers/phy/{ => samsung}/phy-exynos-mipi-video.c (100%)
>  rename drivers/phy/{ => samsung}/phy-exynos4210-usb2.c (100%)
>  rename drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c (100%)
>  rename drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c (100%)
>  rename drivers/phy/{ => samsung}/phy-exynos5250-sata.c (100%)
>  rename drivers/phy/{ => samsung}/phy-exynos5250-usb2.c (100%)
>  rename drivers/phy/{ => samsung}/phy-s5pv210-usb2.c (100%)
>  rename drivers/phy/{ => samsung}/phy-samsung-usb2.c (100%)
>  rename drivers/phy/{ => samsung}/phy-samsung-usb2.h (100%)
>  create mode 100644 drivers/phy/st/Kconfig
>  create mode 100644 drivers/phy/st/Makefile
>  rename drivers/phy/{ => st}/phy-miphy28lp.c (100%)
>  rename drivers/phy/{ => st}/phy-miphy365x.c (100%)
>  rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
>  rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
>  rename drivers/phy/{ => st}/phy-stih407-usb.c (100%)
>  rename drivers/phy/{ => st}/phy-stih41x-usb.c (100%)
>  create mode 100644 drivers/phy/sunxi/Kconfig
>  create mode 100644 drivers/phy/sunxi/Makefile
>  rename drivers/phy/{ => sunxi}/phy-sun4i-usb.c (100%)
>  rename drivers/phy/{ => sunxi}/phy-sun9i-usb.c (100%)
>  create mode 100644 drivers/phy/ti/Kconfig
>  create mode 100644 drivers/phy/ti/Makefile
>  rename drivers/phy/{ => ti}/phy-dm816x-usb.c (100%)
>  rename drivers/phy/{ => ti}/phy-omap-control.c (100%)
>  rename drivers/phy/{ => ti}/phy-omap-usb2.c (100%)
>  rename drivers/phy/{ => ti}/phy-ti-pipe3.c (100%)
>  rename drivers/phy/{ => ti}/phy-tusb1210.c (100%)
>  rename drivers/phy/{ => ti}/phy-twl4030-usb.c (100%)
>  rename drivers/phy/{ => ti}/ulpi_phy.h (100%)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 26566db..80c8c68 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -15,45 +15,6 @@ config GENERIC_PHY
>  	  phy users can obtain reference to the PHY. All the users of this
>  	  framework should select this config.
> 
> -config PHY_BERLIN_USB
> -	tristate "Marvell Berlin USB PHY Driver"
> -	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the USB PHY on Marvell Berlin SoCs.
> -
> -config PHY_BERLIN_SATA
> -	tristate "Marvell Berlin SATA PHY driver"
> -	depends on ARCH_BERLIN && HAS_IOMEM && OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
> -
> -config ARMADA375_USBCLUSTER_PHY
> -	def_bool y
> -	depends on MACH_ARMADA_375 || COMPILE_TEST
> -	depends on OF && HAS_IOMEM
> -	select GENERIC_PHY
> -
> -config PHY_DM816X_USB
> -	tristate "TI dm816x USB PHY driver"
> -	depends on ARCH_OMAP2PLUS
> -	depends on USB_SUPPORT
> -	select GENERIC_PHY
> -	select USB_PHY
> -	help
> -	  Enable this for dm816x USB to work.
> -
> -config PHY_EXYNOS_MIPI_VIDEO
> -	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
> -	depends on HAS_IOMEM
> -	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> -	select GENERIC_PHY
> -	default y if ARCH_S5PV210 || ARCH_EXYNOS
> -	help
> -	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
> -	  and EXYNOS SoCs.
> -
>  config PHY_LPC18XX_USB_OTG
>  	tristate "NXP LPC18xx/43xx SoC USB OTG PHY driver"
>  	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
> @@ -65,154 +26,6 @@ config PHY_LPC18XX_USB_OTG
>  	  This driver is need for USB0 support on LPC18xx/43xx and takes
>  	  care of enabling and clock setup.
> 
> -config PHY_PXA_28NM_HSIC
> -	tristate "Marvell USB HSIC 28nm PHY Driver"
> -	depends on HAS_IOMEM
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support Marvell USB HSIC PHY driver for Marvell
> -	  SoC. This driver will do the PHY initialization and shutdown.
> -	  The PHY driver will be used by Marvell ehci driver.
> -
> -	  To compile this driver as a module, choose M here.
> -
> -config PHY_PXA_28NM_USB2
> -	tristate "Marvell USB 2.0 28nm PHY Driver"
> -	depends on HAS_IOMEM
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support Marvell USB 2.0 PHY driver for Marvell
> -	  SoC. This driver will do the PHY initialization and shutdown.
> -	  The PHY driver will be used by Marvell udc/ehci/otg driver.
> -
> -	  To compile this driver as a module, choose M here.
> -
> -config PHY_MVEBU_SATA
> -	def_bool y
> -	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
> -	depends on OF
> -	select GENERIC_PHY
> -
> -config PHY_MIPHY28LP
> -	tristate "STMicroelectronics MIPHY28LP PHY driver for STiH407"
> -	depends on ARCH_STI
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the miphy transceiver (for SATA/PCIE/USB3)
> -	  that is part of STMicroelectronics STiH407 SoC.
> -
> -config PHY_MIPHY365X
> -	tristate "STMicroelectronics MIPHY365X PHY driver for STiH41x series"
> -	depends on ARCH_STI
> -	depends on HAS_IOMEM
> -	depends on OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the miphy transceiver (for SATA/PCIE)
> -	  that is part of STMicroelectronics STiH41x SoC series.
> -
> -config PHY_RCAR_GEN2
> -	tristate "Renesas R-Car generation 2 USB PHY driver"
> -	depends on ARCH_SHMOBILE
> -	depends on GENERIC_PHY
> -	help
> -	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
> -
> -config PHY_RCAR_GEN3_USB2
> -	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
> -	depends on OF && ARCH_SHMOBILE
> -	select GENERIC_PHY
> -	help
> -	  Support for USB 2.0 PHY found on Renesas R-Car generation 3 SoCs.
> -
> -config OMAP_CONTROL_PHY
> -	tristate "OMAP CONTROL PHY Driver"
> -	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> -	help
> -	  Enable this to add support for the PHY part present in the control
> -	  module. This driver has API to power on the USB2 PHY and to write to
> -	  the mailbox. The mailbox is present only in omap4 and the register to
> -	  power on the USB2 PHY is present in OMAP4 and OMAP5. OMAP5 has an
> -	  additional register to power on USB3 PHY/SATA PHY/PCIE PHY
> -	  (PIPE3 PHY).
> -
> -config OMAP_USB2
> -	tristate "OMAP USB2 PHY Driver"
> -	depends on ARCH_OMAP2PLUS
> -	depends on USB_SUPPORT
> -	select GENERIC_PHY
> -	select USB_PHY
> -	select OMAP_CONTROL_PHY
> -	depends on OMAP_OCP2SCP
> -	help
> -	  Enable this to support the transceiver that is part of SOC. This
> -	  driver takes care of all the PHY functionality apart from comparator.
> -	  The USB OTG controller communicates with the comparator using this
> -	  driver.
> -
> -config TI_PIPE3
> -	tristate "TI PIPE3 PHY Driver"
> -	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> -	select GENERIC_PHY
> -	select OMAP_CONTROL_PHY
> -	depends on OMAP_OCP2SCP
> -	help
> -	  Enable this to support the PIPE3 PHY that is part of TI SOCs. This
> -	  driver takes care of all the PHY functionality apart from comparator.
> -	  This driver interacts with the "OMAP Control PHY Driver" to power
> -	  on/off the PHY.
> -
> -config TWL4030_USB
> -	tristate "TWL4030 USB Transceiver Driver"
> -	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
> -	depends on USB_SUPPORT
> -	select GENERIC_PHY
> -	select USB_PHY
> -	help
> -	  Enable this to support the USB OTG transceiver on TWL4030
> -	  family chips (including the TWL5030 and TPS659x0 devices).
> -	  This transceiver supports high and full speed devices plus,
> -	  in host mode, low speed.
> -
> -config PHY_EXYNOS_DP_VIDEO
> -	tristate "EXYNOS SoC series Display Port PHY driver"
> -	depends on OF
> -	depends on ARCH_EXYNOS || COMPILE_TEST
> -	default ARCH_EXYNOS
> -	select GENERIC_PHY
> -	help
> -	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
> -
> -config BCM_KONA_USB2_PHY
> -	tristate "Broadcom Kona USB2 PHY Driver"
> -	depends on HAS_IOMEM
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the Broadcom Kona USB 2.0 PHY.
> -
> -config PHY_EXYNOS5250_SATA
> -	tristate "Exynos5250 Sata SerDes/PHY driver"
> -	depends on SOC_EXYNOS5250
> -	depends on HAS_IOMEM
> -	depends on OF
> -	select GENERIC_PHY
> -	select I2C
> -	select I2C_S3C2410
> -	select MFD_SYSCON
> -	help
> -	  Enable this to support SATA SerDes/Phy found on Samsung's
> -	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
> -	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host
> -	  port to accept one SATA device.
> -
> -config PHY_HIX5HD2_SATA
> -	tristate "HIX5HD2 SATA PHY Driver"
> -	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
> -	select GENERIC_PHY
> -	select MFD_SYSCON
> -	help
> -	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
> -
>  config PHY_MT65XX_USB3
>  	tristate "Mediatek USB3.0 PHY Driver"
>  	depends on ARCH_MEDIATEK && OF
> @@ -222,93 +35,6 @@ config PHY_MT65XX_USB3
>  	  for mt65xx SoCs. it supports two usb2.0 ports and
>  	  one usb3.0 port.
> 
> -config PHY_HI6220_USB
> -	tristate "hi6220 USB PHY support"
> -	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> -	select GENERIC_PHY
> -	select MFD_SYSCON
> -	help
> -	  Enable this to support the HISILICON HI6220 USB PHY.
> -
> -	  To compile this driver as a module, choose M here.
> -
> -config PHY_SUN4I_USB
> -	tristate "Allwinner sunxi SoC USB PHY driver"
> -	depends on ARCH_SUNXI && HAS_IOMEM && OF
> -	depends on RESET_CONTROLLER
> -	depends on EXTCON
> -	depends on POWER_SUPPLY
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the transceiver that is part of Allwinner
> -	  sunxi SoCs.
> -
> -	  This driver controls the entire USB PHY block, both the USB OTG
> -	  parts, as well as the 2 regular USB 2 host PHYs.
> -
> -config PHY_SUN9I_USB
> -	tristate "Allwinner sun9i SoC USB PHY driver"
> -	depends on ARCH_SUNXI && HAS_IOMEM && OF
> -	depends on RESET_CONTROLLER
> -	depends on USB_COMMON
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the transceiver that is part of Allwinner
> -	  sun9i SoCs.
> -
> -	  This driver controls each individual USB 2 host PHY.
> -
> -config PHY_SAMSUNG_USB2
> -	tristate "Samsung USB 2.0 PHY driver"
> -	depends on HAS_IOMEM
> -	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
> -	select GENERIC_PHY
> -	select MFD_SYSCON
> -	default ARCH_EXYNOS
> -	help
> -	  Enable this to support the Samsung USB 2.0 PHY driver for Samsung
> -	  SoCs. This driver provides the interface for USB 2.0 PHY. Support
> -	  for particular PHYs will be enabled based on the SoC type in addition
> -	  to this driver.
> -
> -config PHY_S5PV210_USB2
> -	bool "Support for S5PV210"
> -	depends on PHY_SAMSUNG_USB2
> -	depends on ARCH_S5PV210
> -	help
> -	  Enable USB PHY support for S5PV210. This option requires that Samsung
> -	  USB 2.0 PHY driver is enabled and means that support for this
> -	  particular SoC is compiled in the driver. In case of S5PV210 two phys
> -	  are available - device and host.
> -
> -config PHY_EXYNOS4210_USB2
> -	bool
> -	depends on PHY_SAMSUNG_USB2
> -	default CPU_EXYNOS4210
> -
> -config PHY_EXYNOS4X12_USB2
> -	bool
> -	depends on PHY_SAMSUNG_USB2
> -	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
> -
> -config PHY_EXYNOS5250_USB2
> -	bool
> -	depends on PHY_SAMSUNG_USB2
> -	default SOC_EXYNOS5250 || SOC_EXYNOS5420
> -
> -config PHY_EXYNOS5_USBDRD
> -	tristate "Exynos5 SoC series USB DRD PHY driver"
> -	depends on ARCH_EXYNOS && OF
> -	depends on HAS_IOMEM
> -	depends on USB_DWC3_EXYNOS
> -	select GENERIC_PHY
> -	select MFD_SYSCON
> -	default y
> -	help
> -	  Enable USB DRD PHY support for Exynos 5 SoC series.
> -	  This driver provides PHY interface for USB 3.0 DRD controller
> -	  present on Exynos5 SoC series.
> -
>  config PHY_PISTACHIO_USB
>  	tristate "IMG Pistachio USB2.0 PHY driver"
>  	depends on MACH_PISTACHIO
> @@ -316,55 +42,6 @@ config PHY_PISTACHIO_USB
>  	help
>  	  Enable this to support the USB2.0 PHY on the IMG Pistachio SoC.
> 
> -config PHY_QCOM_APQ8064_SATA
> -	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
> -	depends on ARCH_QCOM
> -	depends on HAS_IOMEM
> -	depends on OF
> -	select GENERIC_PHY
> -
> -config PHY_QCOM_IPQ806X_SATA
> -	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
> -	depends on ARCH_QCOM
> -	depends on HAS_IOMEM
> -	depends on OF
> -	select GENERIC_PHY
> -
> -config PHY_ROCKCHIP_USB
> -	tristate "Rockchip USB2 PHY Driver"
> -	depends on ARCH_ROCKCHIP && OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the Rockchip USB 2.0 PHY.
> -
> -config PHY_ROCKCHIP_EMMC
> -	tristate "Rockchip EMMC PHY Driver"
> -	depends on ARCH_ROCKCHIP && OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the Rockchip EMMC PHY.
> -
> -config PHY_ROCKCHIP_DP
> -	tristate "Rockchip Display Port PHY Driver"
> -	depends on ARCH_ROCKCHIP && OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the Rockchip Display Port PHY.
> -
> -config PHY_ST_SPEAR1310_MIPHY
> -	tristate "ST SPEAR1310-MIPHY driver"
> -	select GENERIC_PHY
> -	depends on MACH_SPEAR1310 || COMPILE_TEST
> -	help
> -	  Support for ST SPEAr1310 MIPHY which can be used for PCIe and SATA.
> -
> -config PHY_ST_SPEAR1340_MIPHY
> -	tristate "ST SPEAR1340-MIPHY driver"
> -	select GENERIC_PHY
> -	depends on MACH_SPEAR1340 || COMPILE_TEST
> -	help
> -	  Support for ST SPEAr1340 MIPHY which can be used for PCIe and SATA.
> -
>  config PHY_XGENE
>  	tristate "APM X-Gene 15Gbps PHY support"
>  	depends on HAS_IOMEM && OF && (ARM64 || COMPILE_TEST)
> @@ -372,53 +49,20 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
> 
> -config PHY_STIH407_USB
> -	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
> -	depends on RESET_CONTROLLER
> -	depends on ARCH_STI || COMPILE_TEST
> -	select GENERIC_PHY
> -	help
> -	  Enable this support to enable the picoPHY device used by USB2
> -	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
> -
> -config PHY_STIH41X_USB
> -	tristate "STMicroelectronics USB2 PHY driver for STiH41x series"
> -	depends on ARCH_STI
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the USB transceiver that is part of
> -	  STMicroelectronics STiH41x SoC series.
> -
> -config PHY_QCOM_UFS
> -	tristate "Qualcomm UFS PHY driver"
> -	depends on OF && ARCH_QCOM
> -	select GENERIC_PHY
> -	help
> -	  Support for UFS PHY on QCOM chipsets.
> -
> -config PHY_TUSB1210
> -	tristate "TI TUSB1210 ULPI PHY module"
> -	depends on USB_ULPI_BUS
> -	select GENERIC_PHY
> -	help
> -	  Support for TI TUSB1210 USB ULPI PHY.
> -
> -config PHY_BRCMSTB_SATA
> -	tristate "Broadcom STB SATA PHY driver"
> -	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> -	depends on OF
> -	select GENERIC_PHY
> -	help
> -	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB
> SoCs. -	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
> -
> -config PHY_CYGNUS_PCIE
> -	tristate "Broadcom Cygnus PCIe PHY driver"
> -	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
> -	select GENERIC_PHY
> -	default ARCH_BCM_CYGNUS
> -	help
> -	  Enable this to support the Broadcom Cygnus PCIe PHY.
> -	  If unsure, say N.
> +menuconfig PHY_PLAT
> +	bool "Platform Phy drivers"
> +
> +if PHY_PLAT
> +source "drivers/phy/bcom/Kconfig"
> +source "drivers/phy/hisi/Kconfig"
> +source "drivers/phy/marvell/Kconfig"
> +source "drivers/phy/qcom/Kconfig"
> +source "drivers/phy/rcar/Kconfig"
> +source "drivers/phy/rockchip/Kconfig"
> +source "drivers/phy/samsung/Kconfig"
> +source "drivers/phy/st/Kconfig"
> +source "drivers/phy/sunxi/Kconfig"
> +source "drivers/phy/ti/Kconfig"
> +endif
> 
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 24596a9..73d563b 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -3,52 +3,19 @@
>  #
> 
>  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
> -obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
> -obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
> -obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
> -obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
> -obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
> -obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
> -obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
> -obj-$(CONFIG_PHY_PXA_28NM_USB2)		+= phy-pxa-28nm-usb2.o
> -obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
> -obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
> -obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
> -obj-$(CONFIG_PHY_MIPHY365X)		+= phy-miphy365x.o
> -obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
> -obj-$(CONFIG_PHY_RCAR_GEN3_USB2)	+= phy-rcar-gen3-usb2.o
> -obj-$(CONFIG_OMAP_CONTROL_PHY)		+= phy-omap-control.o
> -obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
> -obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
> -obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> -obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
> -obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> -obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
>  obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
> -obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
> -obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
> -obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
> -phy-exynos-usb2-y			+= phy-samsung-usb2.o
> -phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
> -phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
> -phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
> -phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
> -obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
> -obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
> -obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
> -obj-$(CONFIG_PHY_ROCKCHIP_EMMC) += phy-rockchip-emmc.o
> -obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
> -obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> -obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
> -obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
> -obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
> -obj-$(CONFIG_PHY_STIH41X_USB)		+= phy-stih41x-usb.o
> -obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
> -obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
> -obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
> -obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
> -obj-$(CONFIG_PHY_BRCMSTB_SATA)		+= phy-brcmstb-sata.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> -obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
> +
> +# Phy drivers for different platforms.
> +obj-$(CONFIG_PHY_PLAT)		+= bcom/	\
> +				   hisi/	\
> +				   marvell/	\
> +				   qcom/	\
> +				   rcar/	\
> +				   rockchip/	\
> +				   samsung/	\
> +				   st/		\
> +				   sunxi/	\
> +				   ti/
> diff --git a/drivers/phy/bcom/Kconfig b/drivers/phy/bcom/Kconfig
> new file mode 100644
> index 0000000..8243372
> --- /dev/null
> +++ b/drivers/phy/bcom/Kconfig
> @@ -0,0 +1,27 @@
> +#
> +# PHY drivers for Broadcom platforms
> +#
> +config PHY_CYGNUS_PCIE
> +	tristate "Broadcom Cygnus PCIe PHY driver"
> +	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
> +	select GENERIC_PHY
> +	default ARCH_BCM_CYGNUS
> +	help
> +	  Enable this to support the Broadcom Cygnus PCIe PHY.
> +	  If unsure, say N.
> +
> +config BCM_KONA_USB2_PHY
> +	tristate "Broadcom Kona USB2 PHY Driver"
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Broadcom Kona USB 2.0 PHY.
> +
> +config PHY_BRCMSTB_SATA
> +	tristate "Broadcom STB SATA PHY driver"
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB
> SoCs. +	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
> diff --git a/drivers/phy/bcom/Makefile b/drivers/phy/bcom/Makefile
> new file mode 100644
> index 0000000..f30fa76
> --- /dev/null
> +++ b/drivers/phy/bcom/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
> +obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
> +obj-$(CONFIG_PHY_BRCMSTB_SATA)		+= phy-brcmstb-sata.o
> diff --git a/drivers/phy/phy-bcm-cygnus-pcie.c
> b/drivers/phy/bcom/phy-bcm-cygnus-pcie.c similarity index 100%
> rename from drivers/phy/phy-bcm-cygnus-pcie.c
> rename to drivers/phy/bcom/phy-bcm-cygnus-pcie.c
> diff --git a/drivers/phy/phy-bcm-kona-usb2.c
> b/drivers/phy/bcom/phy-bcm-kona-usb2.c similarity index 100%
> rename from drivers/phy/phy-bcm-kona-usb2.c
> rename to drivers/phy/bcom/phy-bcm-kona-usb2.c
> diff --git a/drivers/phy/phy-brcmstb-sata.c
> b/drivers/phy/bcom/phy-brcmstb-sata.c similarity index 100%
> rename from drivers/phy/phy-brcmstb-sata.c
> rename to drivers/phy/bcom/phy-brcmstb-sata.c
> diff --git a/drivers/phy/hisi/Kconfig b/drivers/phy/hisi/Kconfig
> new file mode 100644
> index 0000000..affa9ed
> --- /dev/null
> +++ b/drivers/phy/hisi/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# PHY drivers for HiSilicon platforms
> +#
> +config PHY_HIX5HD2_SATA
> +	tristate "HIX5HD2 SATA PHY Driver"
> +	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
> +
> +config PHY_HI6220_USB
> +	tristate "hi6220 USB PHY support"
> +	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the HISILICON HI6220 USB PHY.
> +
> +	  To compile this driver as a module, choose M here.
> diff --git a/drivers/phy/hisi/Makefile b/drivers/phy/hisi/Makefile
> new file mode 100644
> index 0000000..6059ed8
> --- /dev/null
> +++ b/drivers/phy/hisi/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
> +obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
> diff --git a/drivers/phy/phy-hi6220-usb.c
> b/drivers/phy/hisi/phy-hi6220-usb.c similarity index 100%
> rename from drivers/phy/phy-hi6220-usb.c
> rename to drivers/phy/hisi/phy-hi6220-usb.c
> diff --git a/drivers/phy/phy-hix5hd2-sata.c
> b/drivers/phy/hisi/phy-hix5hd2-sata.c similarity index 100%
> rename from drivers/phy/phy-hix5hd2-sata.c
> rename to drivers/phy/hisi/phy-hix5hd2-sata.c
> diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> new file mode 100644
> index 0000000..6c1576c
> --- /dev/null
> +++ b/drivers/phy/marvell/Kconfig
> @@ -0,0 +1,50 @@
> +#
> +# PHY drivers for Marvell platforms
> +#
> +config ARMADA375_USBCLUSTER_PHY
> +	def_bool y
> +	depends on MACH_ARMADA_375 || COMPILE_TEST
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +
> +config PHY_BERLIN_USB
> +	tristate "Marvell Berlin USB PHY Driver"
> +	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the USB PHY on Marvell Berlin SoCs.
> +
> +config PHY_BERLIN_SATA
> +	tristate "Marvell Berlin SATA PHY driver"
> +	depends on ARCH_BERLIN && HAS_IOMEM && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
> +
> +config PHY_MVEBU_SATA
> +	def_bool y
> +	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
> +	depends on OF
> +	select GENERIC_PHY
> +
> +config PHY_PXA_28NM_HSIC
> +	tristate "Marvell USB HSIC 28nm PHY Driver"
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support Marvell USB HSIC PHY driver for Marvell
> +	  SoC. This driver will do the PHY initialization and shutdown.
> +	  The PHY driver will be used by Marvell ehci driver.
> +
> +	  To compile this driver as a module, choose M here.
> +
> +config PHY_PXA_28NM_USB2
> +	tristate "Marvell USB 2.0 28nm PHY Driver"
> +	depends on HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support Marvell USB 2.0 PHY driver for Marvell
> +	  SoC. This driver will do the PHY initialization and shutdown.
> +	  The PHY driver will be used by Marvell udc/ehci/otg driver.
> +
> +	  To compile this driver as a module, choose M here.
> diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
> new file mode 100644
> index 0000000..f4fa255
> --- /dev/null
> +++ b/drivers/phy/marvell/Makefile
> @@ -0,0 +1,6 @@
> +obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
> +obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
> +obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
> +obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
> +obj-$(CONFIG_PHY_PXA_28NM_USB2)		+= phy-pxa-28nm-usb2.o
> +obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
> diff --git a/drivers/phy/phy-armada375-usb2.c
> b/drivers/phy/marvell/phy-armada375-usb2.c similarity index 100%
> rename from drivers/phy/phy-armada375-usb2.c
> rename to drivers/phy/marvell/phy-armada375-usb2.c
> diff --git a/drivers/phy/phy-berlin-sata.c
> b/drivers/phy/marvell/phy-berlin-sata.c similarity index 100%
> rename from drivers/phy/phy-berlin-sata.c
> rename to drivers/phy/marvell/phy-berlin-sata.c
> diff --git a/drivers/phy/phy-berlin-usb.c
> b/drivers/phy/marvell/phy-berlin-usb.c similarity index 100%
> rename from drivers/phy/phy-berlin-usb.c
> rename to drivers/phy/marvell/phy-berlin-usb.c
> diff --git a/drivers/phy/phy-mvebu-sata.c
> b/drivers/phy/marvell/phy-mvebu-sata.c similarity index 100%
> rename from drivers/phy/phy-mvebu-sata.c
> rename to drivers/phy/marvell/phy-mvebu-sata.c
> diff --git a/drivers/phy/phy-pxa-28nm-hsic.c
> b/drivers/phy/marvell/phy-pxa-28nm-hsic.c similarity index 100%
> rename from drivers/phy/phy-pxa-28nm-hsic.c
> rename to drivers/phy/marvell/phy-pxa-28nm-hsic.c
> diff --git a/drivers/phy/phy-pxa-28nm-usb2.c
> b/drivers/phy/marvell/phy-pxa-28nm-usb2.c similarity index 100%
> rename from drivers/phy/phy-pxa-28nm-usb2.c
> rename to drivers/phy/marvell/phy-pxa-28nm-usb2.c
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> new file mode 100644
> index 0000000..9718d01
> --- /dev/null
> +++ b/drivers/phy/qcom/Kconfig
> @@ -0,0 +1,23 @@
> +#
> +# PHY drivers for Qualcomm platforms
> +#
> +config PHY_QCOM_APQ8064_SATA
> +	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
> +	depends on ARCH_QCOM
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +
> +config PHY_QCOM_IPQ806X_SATA
> +	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
> +	depends on ARCH_QCOM
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +
> +config PHY_QCOM_UFS
> +	tristate "Qualcomm UFS PHY driver"
> +	depends on OF && ARCH_QCOM
> +	select GENERIC_PHY
> +	help
> +	  Support for UFS PHY on QCOM chipsets.
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> new file mode 100644
> index 0000000..2db3e77
> --- /dev/null
> +++ b/drivers/phy/qcom/Makefile
> @@ -0,0 +1,5 @@
> +obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
> +obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> +obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs.o \
> +					+= phy-qcom-ufs-qmp-20nm.o \
> +					+= phy-qcom-ufs-qmp-14nm.o
> diff --git a/drivers/phy/phy-qcom-apq8064-sata.c
> b/drivers/phy/qcom/phy-qcom-apq8064-sata.c similarity index 100%
> rename from drivers/phy/phy-qcom-apq8064-sata.c
> rename to drivers/phy/qcom/phy-qcom-apq8064-sata.c
> diff --git a/drivers/phy/phy-qcom-ipq806x-sata.c
> b/drivers/phy/qcom/phy-qcom-ipq806x-sata.c similarity index 100%
> rename from drivers/phy/phy-qcom-ipq806x-sata.c
> rename to drivers/phy/qcom/phy-qcom-ipq806x-sata.c
> diff --git a/drivers/phy/phy-qcom-ufs-i.h
> b/drivers/phy/qcom/phy-qcom-ufs-i.h similarity index 100%
> rename from drivers/phy/phy-qcom-ufs-i.h
> rename to drivers/phy/qcom/phy-qcom-ufs-i.h
> diff --git a/drivers/phy/phy-qcom-ufs-qmp-14nm.c
> b/drivers/phy/qcom/phy-qcom-ufs-qmp-14nm.c similarity index 100%
> rename from drivers/phy/phy-qcom-ufs-qmp-14nm.c
> rename to drivers/phy/qcom/phy-qcom-ufs-qmp-14nm.c
> diff --git a/drivers/phy/phy-qcom-ufs-qmp-14nm.h
> b/drivers/phy/qcom/phy-qcom-ufs-qmp-14nm.h similarity index 100%
> rename from drivers/phy/phy-qcom-ufs-qmp-14nm.h
> rename to drivers/phy/qcom/phy-qcom-ufs-qmp-14nm.h
> diff --git a/drivers/phy/phy-qcom-ufs-qmp-20nm.c
> b/drivers/phy/qcom/phy-qcom-ufs-qmp-20nm.c similarity index 100%
> rename from drivers/phy/phy-qcom-ufs-qmp-20nm.c
> rename to drivers/phy/qcom/phy-qcom-ufs-qmp-20nm.c
> diff --git a/drivers/phy/phy-qcom-ufs-qmp-20nm.h
> b/drivers/phy/qcom/phy-qcom-ufs-qmp-20nm.h similarity index 100%
> rename from drivers/phy/phy-qcom-ufs-qmp-20nm.h
> rename to drivers/phy/qcom/phy-qcom-ufs-qmp-20nm.h
> diff --git a/drivers/phy/phy-qcom-ufs.c b/drivers/phy/qcom/phy-qcom-ufs.c
> similarity index 100%
> rename from drivers/phy/phy-qcom-ufs.c
> rename to drivers/phy/qcom/phy-qcom-ufs.c
> diff --git a/drivers/phy/rcar/Kconfig b/drivers/phy/rcar/Kconfig
> new file mode 100644
> index 0000000..169b5e2
> --- /dev/null
> +++ b/drivers/phy/rcar/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# PHY drivers for Renesas's r-car platforms
> +#
> +config PHY_RCAR_GEN2
> +	tristate "Renesas R-Car generation 2 USB PHY driver"
> +	depends on ARCH_SHMOBILE
> +	depends on GENERIC_PHY
> +	help
> +	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
> +
> +config PHY_RCAR_GEN3_USB2
> +	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
> +	depends on OF && ARCH_SHMOBILE
> +	select GENERIC_PHY
> +	help
> +	  Support for USB 2.0 PHY found on Renesas R-Car generation 3 SoCs.
> diff --git a/drivers/phy/rcar/Makefile b/drivers/phy/rcar/Makefile
> new file mode 100644
> index 0000000..695241a
> --- /dev/null
> +++ b/drivers/phy/rcar/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
> +obj-$(CONFIG_PHY_RCAR_GEN3_USB2)	+= phy-rcar-gen3-usb2.o
> diff --git a/drivers/phy/phy-rcar-gen2.c
> b/drivers/phy/rcar/phy-rcar-gen2.c similarity index 100%
> rename from drivers/phy/phy-rcar-gen2.c
> rename to drivers/phy/rcar/phy-rcar-gen2.c
> diff --git a/drivers/phy/phy-rcar-gen3-usb2.c
> b/drivers/phy/rcar/phy-rcar-gen3-usb2.c similarity index 100%
> rename from drivers/phy/phy-rcar-gen3-usb2.c
> rename to drivers/phy/rcar/phy-rcar-gen3-usb2.c
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> new file mode 100644
> index 0000000..c575d1e
> --- /dev/null
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -0,0 +1,23 @@
> +#
> +# PHY drivers for Rockchip platforms
> +#
> +config PHY_ROCKCHIP_USB
> +	tristate "Rockchip USB2 PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip USB 2.0 PHY.
> +
> +config PHY_ROCKCHIP_EMMC
> +	tristate "Rockchip EMMC PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip EMMC PHY.
> +
> +config PHY_ROCKCHIP_DP
> +	tristate "Rockchip Display Port PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Rockchip Display Port PHY.
> diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> new file mode 100644
> index 0000000..c15acc1
> --- /dev/null
> +++ b/drivers/phy/rockchip/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_PHY_ROCKCHIP_DP)	+= phy-rockchip-dp.o
> +obj-$(CONFIG_PHY_ROCKCHIP_EMMC)	+= phy-rockchip-emmc.o
> +obj-$(CONFIG_PHY_ROCKCHIP_USB)	+= phy-rockchip-usb.o
> diff --git a/drivers/phy/phy-rockchip-dp.c
> b/drivers/phy/rockchip/phy-rockchip-dp.c similarity index 100%
> rename from drivers/phy/phy-rockchip-dp.c
> rename to drivers/phy/rockchip/phy-rockchip-dp.c
> diff --git a/drivers/phy/phy-rockchip-emmc.c
> b/drivers/phy/rockchip/phy-rockchip-emmc.c similarity index 100%
> rename from drivers/phy/phy-rockchip-emmc.c
> rename to drivers/phy/rockchip/phy-rockchip-emmc.c
> diff --git a/drivers/phy/phy-rockchip-usb.c
> b/drivers/phy/rockchip/phy-rockchip-usb.c similarity index 100%
> rename from drivers/phy/phy-rockchip-usb.c
> rename to drivers/phy/rockchip/phy-rockchip-usb.c
> diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> new file mode 100644
> index 0000000..80bdea7
> --- /dev/null
> +++ b/drivers/phy/samsung/Kconfig
> @@ -0,0 +1,87 @@
> +#
> +# PHY drivers for Samsung platforms
> +#
> +config PHY_SAMSUNG_USB2
> +	tristate "Samsung USB 2.0 PHY driver"
> +	depends on HAS_IOMEM
> +	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	default ARCH_EXYNOS
> +	help
> +	  Enable this to support the Samsung USB 2.0 PHY driver for Samsung
> +	  SoCs. This driver provides the interface for USB 2.0 PHY. Support
> +	  for particular PHYs will be enabled based on the SoC type in addition
> +	  to this driver.
> +
> +config PHY_S5PV210_USB2
> +	bool "Support for S5PV210"
> +	depends on PHY_SAMSUNG_USB2
> +	depends on ARCH_S5PV210
> +	help
> +	  Enable USB PHY support for S5PV210. This option requires that Samsung
> +	  USB 2.0 PHY driver is enabled and means that support for this
> +	  particular SoC is compiled in the driver. In case of S5PV210 two phys
> +	  are available - device and host.
> +
> +config PHY_EXYNOS4210_USB2
> +	bool
> +	depends on PHY_SAMSUNG_USB2
> +	default CPU_EXYNOS4210
> +
> +config PHY_EXYNOS4X12_USB2
> +	bool
> +	depends on PHY_SAMSUNG_USB2
> +	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
> +
> +config PHY_EXYNOS5250_USB2
> +	bool
> +	depends on PHY_SAMSUNG_USB2
> +	default SOC_EXYNOS5250 || SOC_EXYNOS5420
> +
> +config PHY_EXYNOS5_USBDRD
> +	tristate "Exynos5 SoC series USB DRD PHY driver"
> +	depends on ARCH_EXYNOS && OF
> +	depends on HAS_IOMEM
> +	depends on USB_DWC3_EXYNOS
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	default y
> +	help
> +	  Enable USB DRD PHY support for Exynos 5 SoC series.
> +	  This driver provides PHY interface for USB 3.0 DRD controller
> +	  present on Exynos5 SoC series.
> +
> +config PHY_EXYNOS_DP_VIDEO
> +	tristate "EXYNOS SoC series Display Port PHY driver"
> +	depends on OF
> +	depends on ARCH_EXYNOS || COMPILE_TEST
> +	default ARCH_EXYNOS
> +	select GENERIC_PHY
> +	help
> +	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
> +
> +config PHY_EXYNOS_MIPI_VIDEO
> +	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
> +	depends on HAS_IOMEM
> +	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> +	select GENERIC_PHY
> +	default y if ARCH_S5PV210 || ARCH_EXYNOS
> +	help
> +	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
> +	  and EXYNOS SoCs.
> +
> +config PHY_EXYNOS5250_SATA
> +	tristate "Exynos5250 Sata SerDes/PHY driver"
> +	depends on SOC_EXYNOS5250
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +	select I2C
> +	select I2C_S3C2410
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support SATA SerDes/Phy found on Samsung's
> +	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
> +	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host
> +	  port to accept one SATA device.
> diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
> new file mode 100644
> index 0000000..585dbd7
> --- /dev/null
> +++ b/drivers/phy/samsung/Makefile
> @@ -0,0 +1,10 @@
> +obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
> +phy-exynos-usb2-y			+= phy-samsung-usb2.o
> +phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
> +phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
> +phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
> +phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
> +obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
> +obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
> +obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
> +obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
> diff --git a/drivers/phy/phy-exynos-dp-video.c
> b/drivers/phy/samsung/phy-exynos-dp-video.c similarity index 100%
> rename from drivers/phy/phy-exynos-dp-video.c
> rename to drivers/phy/samsung/phy-exynos-dp-video.c
> diff --git a/drivers/phy/phy-exynos-mipi-video.c
> b/drivers/phy/samsung/phy-exynos-mipi-video.c similarity index 100%
> rename from drivers/phy/phy-exynos-mipi-video.c
> rename to drivers/phy/samsung/phy-exynos-mipi-video.c
> diff --git a/drivers/phy/phy-exynos4210-usb2.c
> b/drivers/phy/samsung/phy-exynos4210-usb2.c similarity index 100%
> rename from drivers/phy/phy-exynos4210-usb2.c
> rename to drivers/phy/samsung/phy-exynos4210-usb2.c
> diff --git a/drivers/phy/phy-exynos4x12-usb2.c
> b/drivers/phy/samsung/phy-exynos4x12-usb2.c similarity index 100%
> rename from drivers/phy/phy-exynos4x12-usb2.c
> rename to drivers/phy/samsung/phy-exynos4x12-usb2.c
> diff --git a/drivers/phy/phy-exynos5-usbdrd.c
> b/drivers/phy/samsung/phy-exynos5-usbdrd.c similarity index 100%
> rename from drivers/phy/phy-exynos5-usbdrd.c
> rename to drivers/phy/samsung/phy-exynos5-usbdrd.c
> diff --git a/drivers/phy/phy-exynos5250-sata.c
> b/drivers/phy/samsung/phy-exynos5250-sata.c similarity index 100%
> rename from drivers/phy/phy-exynos5250-sata.c
> rename to drivers/phy/samsung/phy-exynos5250-sata.c
> diff --git a/drivers/phy/phy-exynos5250-usb2.c
> b/drivers/phy/samsung/phy-exynos5250-usb2.c similarity index 100%
> rename from drivers/phy/phy-exynos5250-usb2.c
> rename to drivers/phy/samsung/phy-exynos5250-usb2.c
> diff --git a/drivers/phy/phy-s5pv210-usb2.c
> b/drivers/phy/samsung/phy-s5pv210-usb2.c similarity index 100%
> rename from drivers/phy/phy-s5pv210-usb2.c
> rename to drivers/phy/samsung/phy-s5pv210-usb2.c
> diff --git a/drivers/phy/phy-samsung-usb2.c
> b/drivers/phy/samsung/phy-samsung-usb2.c similarity index 100%
> rename from drivers/phy/phy-samsung-usb2.c
> rename to drivers/phy/samsung/phy-samsung-usb2.c
> diff --git a/drivers/phy/phy-samsung-usb2.h
> b/drivers/phy/samsung/phy-samsung-usb2.h similarity index 100%
> rename from drivers/phy/phy-samsung-usb2.h
> rename to drivers/phy/samsung/phy-samsung-usb2.h
> diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
> new file mode 100644
> index 0000000..651b2bf
> --- /dev/null
> +++ b/drivers/phy/st/Kconfig
> @@ -0,0 +1,51 @@
> +#
> +# PHY drivers for ST Micro platforms
> +#
> +config PHY_MIPHY28LP
> +	tristate "STMicroelectronics MIPHY28LP PHY driver for STiH407"
> +	depends on ARCH_STI
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the miphy transceiver (for SATA/PCIE/USB3)
> +	  that is part of STMicroelectronics STiH407 SoC.
> +
> +config PHY_MIPHY365X
> +	tristate "STMicroelectronics MIPHY365X PHY driver for STiH41x series"
> +	depends on ARCH_STI
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the miphy transceiver (for SATA/PCIE)
> +	  that is part of STMicroelectronics STiH41x SoC series.
> +
> +config PHY_ST_SPEAR1310_MIPHY
> +	tristate "ST SPEAR1310-MIPHY driver"
> +	select GENERIC_PHY
> +	depends on MACH_SPEAR1310 || COMPILE_TEST
> +	help
> +	  Support for ST SPEAr1310 MIPHY which can be used for PCIe and SATA.
> +
> +config PHY_ST_SPEAR1340_MIPHY
> +	tristate "ST SPEAR1340-MIPHY driver"
> +	select GENERIC_PHY
> +	depends on MACH_SPEAR1340 || COMPILE_TEST
> +	help
> +	  Support for ST SPEAr1340 MIPHY which can be used for PCIe and SATA.
> +
> +config PHY_STIH407_USB
> +	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
> +	depends on RESET_CONTROLLER
> +	depends on ARCH_STI || COMPILE_TEST
> +	select GENERIC_PHY
> +	help
> +	  Enable this support to enable the picoPHY device used by USB2
> +	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
> +
> +config PHY_STIH41X_USB
> +	tristate "STMicroelectronics USB2 PHY driver for STiH41x series"
> +	depends on ARCH_STI
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the USB transceiver that is part of
> +	  STMicroelectronics STiH41x SoC series.
> diff --git a/drivers/phy/st/Makefile b/drivers/phy/st/Makefile
> new file mode 100644
> index 0000000..907561b
> --- /dev/null
> +++ b/drivers/phy/st/Makefile
> @@ -0,0 +1,6 @@
> +obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
> +obj-$(CONFIG_PHY_MIPHY365X)		+= phy-miphy365x.o
> +obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
> +obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
> +obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
> +obj-$(CONFIG_PHY_STIH41X_USB)		+= phy-stih41x-usb.o
> diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
> similarity index 100%
> rename from drivers/phy/phy-miphy28lp.c
> rename to drivers/phy/st/phy-miphy28lp.c
> diff --git a/drivers/phy/phy-miphy365x.c b/drivers/phy/st/phy-miphy365x.c
> similarity index 100%
> rename from drivers/phy/phy-miphy365x.c
> rename to drivers/phy/st/phy-miphy365x.c
> diff --git a/drivers/phy/phy-spear1310-miphy.c
> b/drivers/phy/st/phy-spear1310-miphy.c similarity index 100%
> rename from drivers/phy/phy-spear1310-miphy.c
> rename to drivers/phy/st/phy-spear1310-miphy.c
> diff --git a/drivers/phy/phy-spear1340-miphy.c
> b/drivers/phy/st/phy-spear1340-miphy.c similarity index 100%
> rename from drivers/phy/phy-spear1340-miphy.c
> rename to drivers/phy/st/phy-spear1340-miphy.c
> diff --git a/drivers/phy/phy-stih407-usb.c
> b/drivers/phy/st/phy-stih407-usb.c similarity index 100%
> rename from drivers/phy/phy-stih407-usb.c
> rename to drivers/phy/st/phy-stih407-usb.c
> diff --git a/drivers/phy/phy-stih41x-usb.c
> b/drivers/phy/st/phy-stih41x-usb.c similarity index 100%
> rename from drivers/phy/phy-stih41x-usb.c
> rename to drivers/phy/st/phy-stih41x-usb.c
> diff --git a/drivers/phy/sunxi/Kconfig b/drivers/phy/sunxi/Kconfig
> new file mode 100644
> index 0000000..eb06427
> --- /dev/null
> +++ b/drivers/phy/sunxi/Kconfig
> @@ -0,0 +1,28 @@
> +#
> +# PHY drivers for Allwinner's sunxi platforms
> +#
> +config PHY_SUN4I_USB
> +	tristate "Allwinner sunxi SoC USB PHY driver"
> +	depends on ARCH_SUNXI && HAS_IOMEM && OF
> +	depends on RESET_CONTROLLER
> +	depends on EXTCON
> +	depends on POWER_SUPPLY
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the transceiver that is part of Allwinner
> +	  sunxi SoCs.
> +
> +	  This driver controls the entire USB PHY block, both the USB OTG
> +	  parts, as well as the 2 regular USB 2 host PHYs.
> +
> +config PHY_SUN9I_USB
> +	tristate "Allwinner sun9i SoC USB PHY driver"
> +	depends on ARCH_SUNXI && HAS_IOMEM && OF
> +	depends on RESET_CONTROLLER
> +	depends on USB_COMMON
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the transceiver that is part of Allwinner
> +	  sun9i SoCs.
> +
> +	  This driver controls each individual USB 2 host PHY.
> diff --git a/drivers/phy/sunxi/Makefile b/drivers/phy/sunxi/Makefile
> new file mode 100644
> index 0000000..8605529c
> --- /dev/null
> +++ b/drivers/phy/sunxi/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
> +obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
> diff --git a/drivers/phy/phy-sun4i-usb.c
> b/drivers/phy/sunxi/phy-sun4i-usb.c similarity index 100%
> rename from drivers/phy/phy-sun4i-usb.c
> rename to drivers/phy/sunxi/phy-sun4i-usb.c
> diff --git a/drivers/phy/phy-sun9i-usb.c
> b/drivers/phy/sunxi/phy-sun9i-usb.c similarity index 100%
> rename from drivers/phy/phy-sun9i-usb.c
> rename to drivers/phy/sunxi/phy-sun9i-usb.c
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> new file mode 100644
> index 0000000..1e3e307
> --- /dev/null
> +++ b/drivers/phy/ti/Kconfig
> @@ -0,0 +1,67 @@
> +#
> +# PHY drivers for TI platforms
> +#
> +config PHY_DM816X_USB
> +	tristate "TI dm816x USB PHY driver"
> +	depends on ARCH_OMAP2PLUS
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	help
> +	  Enable this for dm816x USB to work.
> +
> +config OMAP_CONTROL_PHY
> +	tristate "OMAP CONTROL PHY Driver"
> +	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +	help
> +	  Enable this to add support for the PHY part present in the control
> +	  module. This driver has API to power on the USB2 PHY and to write to
> +	  the mailbox. The mailbox is present only in omap4 and the register to
> +	  power on the USB2 PHY is present in OMAP4 and OMAP5. OMAP5 has an
> +	  additional register to power on USB3 PHY/SATA PHY/PCIE PHY
> +	  (PIPE3 PHY).
> +
> +config OMAP_USB2
> +	tristate "OMAP USB2 PHY Driver"
> +	depends on ARCH_OMAP2PLUS
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	select OMAP_CONTROL_PHY
> +	depends on OMAP_OCP2SCP
> +	help
> +	  Enable this to support the transceiver that is part of SOC. This
> +	  driver takes care of all the PHY functionality apart from comparator.
> +	  The USB OTG controller communicates with the comparator using this
> +	  driver.
> +
> +config TI_PIPE3
> +	tristate "TI PIPE3 PHY Driver"
> +	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +	select GENERIC_PHY
> +	select OMAP_CONTROL_PHY
> +	depends on OMAP_OCP2SCP
> +	help
> +	  Enable this to support the PIPE3 PHY that is part of TI SOCs. This
> +	  driver takes care of all the PHY functionality apart from comparator.
> +	  This driver interacts with the "OMAP Control PHY Driver" to power
> +	  on/off the PHY.
> +
> +config PHY_TUSB1210
> +	tristate "TI TUSB1210 ULPI PHY module"
> +	depends on USB_ULPI_BUS
> +	select GENERIC_PHY
> +	help
> +	  Support for TI TUSB1210 USB ULPI PHY.
> +
> +config TWL4030_USB
> +	tristate "TWL4030 USB Transceiver Driver"
> +	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	help
> +	  Enable this to support the USB OTG transceiver on TWL4030
> +	  family chips (including the TWL5030 and TPS659x0 devices).
> +	  This transceiver supports high and full speed devices plus,
> +	  in host mode, low speed.
> diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
> new file mode 100644
> index 0000000..2d16f77
> --- /dev/null
> +++ b/drivers/phy/ti/Makefile
> @@ -0,0 +1,6 @@
> +obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
> +obj-$(CONFIG_OMAP_CONTROL_PHY)		+= phy-omap-control.o
> +obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
> +obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
> +obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
> +obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> diff --git a/drivers/phy/phy-dm816x-usb.c
> b/drivers/phy/ti/phy-dm816x-usb.c similarity index 100%
> rename from drivers/phy/phy-dm816x-usb.c
> rename to drivers/phy/ti/phy-dm816x-usb.c
> diff --git a/drivers/phy/phy-omap-control.c
> b/drivers/phy/ti/phy-omap-control.c similarity index 100%
> rename from drivers/phy/phy-omap-control.c
> rename to drivers/phy/ti/phy-omap-control.c
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> similarity index 100%
> rename from drivers/phy/phy-omap-usb2.c
> rename to drivers/phy/ti/phy-omap-usb2.c
> diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> similarity index 100%
> rename from drivers/phy/phy-ti-pipe3.c
> rename to drivers/phy/ti/phy-ti-pipe3.c
> diff --git a/drivers/phy/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> similarity index 100%
> rename from drivers/phy/phy-tusb1210.c
> rename to drivers/phy/ti/phy-tusb1210.c
> diff --git a/drivers/phy/phy-twl4030-usb.c
> b/drivers/phy/ti/phy-twl4030-usb.c similarity index 100%
> rename from drivers/phy/phy-twl4030-usb.c
> rename to drivers/phy/ti/phy-twl4030-usb.c
> diff --git a/drivers/phy/ulpi_phy.h b/drivers/phy/ti/ulpi_phy.h
> similarity index 100%
> rename from drivers/phy/ulpi_phy.h
> rename to drivers/phy/ti/ulpi_phy.h

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
