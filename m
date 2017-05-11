From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 3/3] phy: Group vendor specific phy drivers
Date: Thu, 11 May 2017 12:17:42 +0530
Message-ID: <1494485262-18995-3-git-send-email-vivek.gautam@codeaurora.org>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1494485262-18995-1-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adding vendor specific directories in phy to group
phy drivers under their respective vendor umbrella.

Also updated the MAINTAINERS file to reflect the correct
directory structure for phy drivers.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---

Changes since v4:
 - Reprepared the patch based on latest torvalds/master.
 - Added new directory for amlogic, since there's a new patch [1]
   coming in for amlogic platforms.

Changes since v3:
 - Added 'Acked-by' and 'Reviewed by' tags received for this patch.
 - No functional change.

Changes since v2:
 - Rebased on linux-phy/next.
 - Took care of drivers added/removed for each vendors since v2.
 - Updated the 'Signed-off-by' tag with my current email id.

Changes from v1:
 - Updated the MAINTAINERS file to reflect the same change
   in directory structure.
 - Removed PHY_PLAT config as pointed out by Kishon.
   So we don't require the second patch in the v1 of this series:
   [PATCH 2/2] arm: mach-spear: Enable PHY_PLAT to meet dependency
 - Renamed sunxi --> allwinner; rcar --> renesas.
 - Fixed error coming with qcom Makefile.

* Build tested multi_v7_defconfig.
* Build tested arm64 defconfig with all the involved configs enabled.

[1] https://patchwork.kernel.org/patch/9684303/

 MAINTAINERS                                        |  18 +-
 drivers/phy/Kconfig                                | 493 +--------------------
 drivers/phy/Makefile                               |  70 +--
 drivers/phy/allwinner/Kconfig                      |  31 ++
 drivers/phy/allwinner/Makefile                     |   2 +
 drivers/phy/{ => allwinner}/phy-sun4i-usb.c        |   0
 drivers/phy/{ => allwinner}/phy-sun9i-usb.c        |   0
 drivers/phy/amlogic/Kconfig                        |  14 +
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/{ => amlogic}/phy-meson8b-usb2.c       |   0
 drivers/phy/broadcom/Kconfig                       |  55 +++
 drivers/phy/broadcom/Makefile                      |   6 +
 drivers/phy/{ => broadcom}/phy-bcm-cygnus-pcie.c   |   0
 drivers/phy/{ => broadcom}/phy-bcm-kona-usb2.c     |   0
 drivers/phy/{ => broadcom}/phy-bcm-ns-usb2.c       |   0
 drivers/phy/{ => broadcom}/phy-bcm-ns-usb3.c       |   0
 drivers/phy/{ => broadcom}/phy-bcm-ns2-pcie.c      |   0
 drivers/phy/{ => broadcom}/phy-brcm-sata.c         |   0
 drivers/phy/hisilicon/Kconfig                      |  20 +
 drivers/phy/hisilicon/Makefile                     |   2 +
 drivers/phy/{ => hisilicon}/phy-hi6220-usb.c       |   0
 drivers/phy/{ => hisilicon}/phy-hix5hd2-sata.c     |   0
 drivers/phy/marvell/Kconfig                        |  50 +++
 drivers/phy/marvell/Makefile                       |   6 +
 drivers/phy/{ => marvell}/phy-armada375-usb2.c     |   0
 drivers/phy/{ => marvell}/phy-berlin-sata.c        |   0
 drivers/phy/{ => marvell}/phy-berlin-usb.c         |   0
 drivers/phy/{ => marvell}/phy-mvebu-sata.c         |   0
 drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c      |   0
 drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c      |   0
 drivers/phy/qualcomm/Kconfig                       |  58 +++
 drivers/phy/qualcomm/Makefile                      |   9 +
 drivers/phy/{ => qualcomm}/phy-qcom-apq8064-sata.c |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ipq806x-sata.c |   0
 drivers/phy/{ => qualcomm}/phy-qcom-qmp.c          |   0
 drivers/phy/{ => qualcomm}/phy-qcom-qusb2.c        |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ufs-i.h        |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.c |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.h |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.c |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.h |   0
 drivers/phy/{ => qualcomm}/phy-qcom-ufs.c          |   0
 drivers/phy/{ => qualcomm}/phy-qcom-usb-hs.c       |   0
 drivers/phy/{ => qualcomm}/phy-qcom-usb-hsic.c     |   0
 drivers/phy/renesas/Kconfig                        |  17 +
 drivers/phy/renesas/Makefile                       |   2 +
 drivers/phy/{ => renesas}/phy-rcar-gen2.c          |   0
 drivers/phy/{ => renesas}/phy-rcar-gen3-usb2.c     |   0
 drivers/phy/rockchip/Kconfig                       |  51 +++
 drivers/phy/rockchip/Makefile                      |   6 +
 drivers/phy/{ => rockchip}/phy-rockchip-dp.c       |   0
 drivers/phy/{ => rockchip}/phy-rockchip-emmc.c     |   0
 .../phy/{ => rockchip}/phy-rockchip-inno-usb2.c    |   0
 drivers/phy/{ => rockchip}/phy-rockchip-pcie.c     |   0
 drivers/phy/{ => rockchip}/phy-rockchip-typec.c    |   0
 drivers/phy/{ => rockchip}/phy-rockchip-usb.c      |   0
 drivers/phy/samsung/Kconfig                        |  95 ++++
 drivers/phy/samsung/Makefile                       |  11 +
 drivers/phy/{ => samsung}/phy-exynos-dp-video.c    |   0
 drivers/phy/{ => samsung}/phy-exynos-mipi-video.c  |   0
 drivers/phy/{ => samsung}/phy-exynos-pcie.c        |   0
 drivers/phy/{ => samsung}/phy-exynos4210-usb2.c    |   0
 drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c    |   0
 drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c     |   0
 drivers/phy/{ => samsung}/phy-exynos5250-sata.c    |   0
 drivers/phy/{ => samsung}/phy-exynos5250-usb2.c    |   0
 drivers/phy/{ => samsung}/phy-s5pv210-usb2.c       |   0
 drivers/phy/{ => samsung}/phy-samsung-usb2.c       |   0
 drivers/phy/{ => samsung}/phy-samsung-usb2.h       |   0
 drivers/phy/st/Kconfig                             |  33 ++
 drivers/phy/st/Makefile                            |   4 +
 drivers/phy/{ => st}/phy-miphy28lp.c               |   0
 drivers/phy/{ => st}/phy-spear1310-miphy.c         |   0
 drivers/phy/{ => st}/phy-spear1340-miphy.c         |   0
 drivers/phy/{ => st}/phy-stih407-usb.c             |   0
 drivers/phy/ti/Kconfig                             |  78 ++++
 drivers/phy/ti/Makefile                            |   7 +
 drivers/phy/{ => ti}/phy-da8xx-usb.c               |   0
 drivers/phy/{ => ti}/phy-dm816x-usb.c              |   0
 drivers/phy/{ => ti}/phy-omap-control.c            |   0
 drivers/phy/{ => ti}/phy-omap-usb2.c               |   0
 drivers/phy/{ => ti}/phy-ti-pipe3.c                |   0
 drivers/phy/{ => ti}/phy-tusb1210.c                |   0
 drivers/phy/{ => ti}/phy-twl4030-usb.c             |   0
 84 files changed, 594 insertions(+), 545 deletions(-)
 create mode 100644 drivers/phy/allwinner/Kconfig
 create mode 100644 drivers/phy/allwinner/Makefile
 rename drivers/phy/{ => allwinner}/phy-sun4i-usb.c (100%)
 rename drivers/phy/{ => allwinner}/phy-sun9i-usb.c (100%)
 create mode 100644 drivers/phy/amlogic/Kconfig
 create mode 100644 drivers/phy/amlogic/Makefile
 rename drivers/phy/{ => amlogic}/phy-meson8b-usb2.c (100%)
 create mode 100644 drivers/phy/broadcom/Kconfig
 create mode 100644 drivers/phy/broadcom/Makefile
 rename drivers/phy/{ => broadcom}/phy-bcm-cygnus-pcie.c (100%)
 rename drivers/phy/{ => broadcom}/phy-bcm-kona-usb2.c (100%)
 rename drivers/phy/{ => broadcom}/phy-bcm-ns-usb2.c (100%)
 rename drivers/phy/{ => broadcom}/phy-bcm-ns-usb3.c (100%)
 rename drivers/phy/{ => broadcom}/phy-bcm-ns2-pcie.c (100%)
 rename drivers/phy/{ => broadcom}/phy-brcm-sata.c (100%)
 create mode 100644 drivers/phy/hisilicon/Kconfig
 create mode 100644 drivers/phy/hisilicon/Makefile
 rename drivers/phy/{ => hisilicon}/phy-hi6220-usb.c (100%)
 rename drivers/phy/{ => hisilicon}/phy-hix5hd2-sata.c (100%)
 create mode 100644 drivers/phy/marvell/Kconfig
 create mode 100644 drivers/phy/marvell/Makefile
 rename drivers/phy/{ => marvell}/phy-armada375-usb2.c (100%)
 rename drivers/phy/{ => marvell}/phy-berlin-sata.c (100%)
 rename drivers/phy/{ => marvell}/phy-berlin-usb.c (100%)
 rename drivers/phy/{ => marvell}/phy-mvebu-sata.c (100%)
 rename drivers/phy/{ => marvell}/phy-pxa-28nm-hsic.c (100%)
 rename drivers/phy/{ => marvell}/phy-pxa-28nm-usb2.c (100%)
 create mode 100644 drivers/phy/qualcomm/Kconfig
 create mode 100644 drivers/phy/qualcomm/Makefile
 rename drivers/phy/{ => qualcomm}/phy-qcom-apq8064-sata.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ipq806x-sata.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-qmp.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-qusb2.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-i.h (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-14nm.h (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ufs-qmp-20nm.h (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-ufs.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-usb-hs.c (100%)
 rename drivers/phy/{ => qualcomm}/phy-qcom-usb-hsic.c (100%)
 create mode 100644 drivers/phy/renesas/Kconfig
 create mode 100644 drivers/phy/renesas/Makefile
 rename drivers/phy/{ => renesas}/phy-rcar-gen2.c (100%)
 rename drivers/phy/{ => renesas}/phy-rcar-gen3-usb2.c (100%)
 create mode 100644 drivers/phy/rockchip/Kconfig
 create mode 100644 drivers/phy/rockchip/Makefile
 rename drivers/phy/{ => rockchip}/phy-rockchip-dp.c (100%)
 rename drivers/phy/{ => rockchip}/phy-rockchip-emmc.c (100%)
 rename drivers/phy/{ => rockchip}/phy-rockchip-inno-usb2.c (100%)
 rename drivers/phy/{ => rockchip}/phy-rockchip-pcie.c (100%)
 rename drivers/phy/{ => rockchip}/phy-rockchip-typec.c (100%)
 rename drivers/phy/{ => rockchip}/phy-rockchip-usb.c (100%)
 create mode 100644 drivers/phy/samsung/Kconfig
 create mode 100644 drivers/phy/samsung/Makefile
 rename drivers/phy/{ => samsung}/phy-exynos-dp-video.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos-mipi-video.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos-pcie.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos4210-usb2.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos4x12-usb2.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos5-usbdrd.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos5250-sata.c (100%)
 rename drivers/phy/{ => samsung}/phy-exynos5250-usb2.c (100%)
 rename drivers/phy/{ => samsung}/phy-s5pv210-usb2.c (100%)
 rename drivers/phy/{ => samsung}/phy-samsung-usb2.c (100%)
 rename drivers/phy/{ => samsung}/phy-samsung-usb2.h (100%)
 create mode 100644 drivers/phy/st/Kconfig
 create mode 100644 drivers/phy/st/Makefile
 rename drivers/phy/{ => st}/phy-miphy28lp.c (100%)
 rename drivers/phy/{ => st}/phy-spear1310-miphy.c (100%)
 rename drivers/phy/{ => st}/phy-spear1340-miphy.c (100%)
 rename drivers/phy/{ => st}/phy-stih407-usb.c (100%)
 create mode 100644 drivers/phy/ti/Kconfig
 create mode 100644 drivers/phy/ti/Makefile
 rename drivers/phy/{ => ti}/phy-da8xx-usb.c (100%)
 rename drivers/phy/{ => ti}/phy-dm816x-usb.c (100%)
 rename drivers/phy/{ => ti}/phy-omap-control.c (100%)
 rename drivers/phy/{ => ti}/phy-omap-usb2.c (100%)
 rename drivers/phy/{ => ti}/phy-ti-pipe3.c (100%)
 rename drivers/phy/{ => ti}/phy-tusb1210.c (100%)
 rename drivers/phy/{ => ti}/phy-twl4030-usb.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a4a9e31fed72..4550abed3b93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1825,8 +1825,8 @@ F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/media/platform/sti/c8sectpfe/
 F:	drivers/mmc/host/sdhci-st.c
-F:	drivers/phy/phy-miphy28lp.c
-F:	drivers/phy/phy-stih407-usb.c
+F:	drivers/phy/st/phy-miphy28lp.c
+F:	drivers/phy/st/phy-stih407-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/remoteproc/st_remoteproc.c
 F:	drivers/remoteproc/st_slim_rproc.c
@@ -10810,7 +10810,7 @@ RENESAS USB2 PHY DRIVER
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
 L:	linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
-F:	drivers/phy/phy-rcar-gen3-usb2.c
+F:	drivers/phy/renesas/phy-rcar-gen3-usb2.c
 
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
@@ -11212,12 +11212,12 @@ L:	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/samsung-phy.txt
 F:	Documentation/phy/samsung-usb2.txt
-F:	drivers/phy/phy-exynos4210-usb2.c
-F:	drivers/phy/phy-exynos4x12-usb2.c
-F:	drivers/phy/phy-exynos5250-usb2.c
-F:	drivers/phy/phy-s5pv210-usb2.c
-F:	drivers/phy/phy-samsung-usb2.c
-F:	drivers/phy/phy-samsung-usb2.h
+F:	drivers/phy/samsung/phy-exynos4210-usb2.c
+F:	drivers/phy/samsung/phy-exynos4x12-usb2.c
+F:	drivers/phy/samsung/phy-exynos5250-usb2.c
+F:	drivers/phy/samsung/phy-s5pv210-usb2.c
+F:	drivers/phy/samsung/phy-samsung-usb2.c
+F:	drivers/phy/samsung/phy-samsung-usb2.h
 
 SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index afaf7b643eeb..b353ac603ea0 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -15,73 +15,6 @@ config GENERIC_PHY
 	  phy users can obtain reference to the PHY. All the users of this
 	  framework should select this config.
 
-config PHY_BCM_NS_USB2
-	tristate "Broadcom Northstar USB 2.0 PHY Driver"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	depends on HAS_IOMEM && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support Broadcom USB 2.0 PHY connected to the USB
-	  controller on Northstar family.
-
-config PHY_BCM_NS_USB3
-	tristate "Broadcom Northstar USB 3.0 PHY Driver"
-	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	depends on HAS_IOMEM && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support Broadcom USB 3.0 PHY connected to the USB
-	  controller on Northstar family.
-
-config PHY_BERLIN_USB
-	tristate "Marvell Berlin USB PHY Driver"
-	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support the USB PHY on Marvell Berlin SoCs.
-
-config PHY_BERLIN_SATA
-	tristate "Marvell Berlin SATA PHY driver"
-	depends on ARCH_BERLIN && HAS_IOMEM && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
-
-config ARMADA375_USBCLUSTER_PHY
-	def_bool y
-	depends on MACH_ARMADA_375 || COMPILE_TEST
-	depends on OF && HAS_IOMEM
-	select GENERIC_PHY
-
-config PHY_DA8XX_USB
-	tristate "TI DA8xx USB PHY Driver"
-	depends on ARCH_DAVINCI_DA8XX
-	select GENERIC_PHY
-	select MFD_SYSCON
-	help
-	  Enable this to support the USB PHY on DA8xx SoCs.
-
-	  This driver controls both the USB 1.1 PHY and the USB 2.0 PHY.
-
-config PHY_DM816X_USB
-	tristate "TI dm816x USB PHY driver"
-	depends on ARCH_OMAP2PLUS
-	depends on USB_SUPPORT
-	select GENERIC_PHY
-	select USB_PHY
-	help
-	  Enable this for dm816x USB to work.
-
-config PHY_EXYNOS_MIPI_VIDEO
-	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
-	depends on HAS_IOMEM
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select GENERIC_PHY
-	default y if ARCH_S5PV210 || ARCH_EXYNOS
-	help
-	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
-	  and EXYNOS SoCs.
-
 config PHY_LPC18XX_USB_OTG
 	tristate "NXP LPC18xx/43xx SoC USB OTG PHY driver"
 	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
@@ -93,146 +26,6 @@ config PHY_LPC18XX_USB_OTG
 	  This driver is need for USB0 support on LPC18xx/43xx and takes
 	  care of enabling and clock setup.
 
-config PHY_PXA_28NM_HSIC
-	tristate "Marvell USB HSIC 28nm PHY Driver"
-	depends on HAS_IOMEM
-	select GENERIC_PHY
-	help
-	  Enable this to support Marvell USB HSIC PHY driver for Marvell
-	  SoC. This driver will do the PHY initialization and shutdown.
-	  The PHY driver will be used by Marvell ehci driver.
-
-	  To compile this driver as a module, choose M here.
-
-config PHY_PXA_28NM_USB2
-	tristate "Marvell USB 2.0 28nm PHY Driver"
-	depends on HAS_IOMEM
-	select GENERIC_PHY
-	help
-	  Enable this to support Marvell USB 2.0 PHY driver for Marvell
-	  SoC. This driver will do the PHY initialization and shutdown.
-	  The PHY driver will be used by Marvell udc/ehci/otg driver.
-
-	  To compile this driver as a module, choose M here.
-
-config PHY_MVEBU_SATA
-	def_bool y
-	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
-	depends on OF
-	select GENERIC_PHY
-
-config PHY_MIPHY28LP
-	tristate "STMicroelectronics MIPHY28LP PHY driver for STiH407"
-	depends on ARCH_STI
-	select GENERIC_PHY
-	help
-	  Enable this to support the miphy transceiver (for SATA/PCIE/USB3)
-	  that is part of STMicroelectronics STiH407 SoC.
-
-config PHY_RCAR_GEN2
-	tristate "Renesas R-Car generation 2 USB PHY driver"
-	depends on ARCH_RENESAS
-	depends on GENERIC_PHY
-	help
-	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
-
-config PHY_RCAR_GEN3_USB2
-	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
-	depends on ARCH_RENESAS
-	depends on EXTCON
-	select GENERIC_PHY
-	help
-	  Support for USB 2.0 PHY found on Renesas R-Car generation 3 SoCs.
-
-config OMAP_CONTROL_PHY
-	tristate "OMAP CONTROL PHY Driver"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
-	help
-	  Enable this to add support for the PHY part present in the control
-	  module. This driver has API to power on the USB2 PHY and to write to
-	  the mailbox. The mailbox is present only in omap4 and the register to
-	  power on the USB2 PHY is present in OMAP4 and OMAP5. OMAP5 has an
-	  additional register to power on USB3 PHY/SATA PHY/PCIE PHY
-	  (PIPE3 PHY).
-
-config OMAP_USB2
-	tristate "OMAP USB2 PHY Driver"
-	depends on ARCH_OMAP2PLUS
-	depends on USB_SUPPORT
-	select GENERIC_PHY
-	select USB_PHY
-	select OMAP_CONTROL_PHY
-	depends on OMAP_OCP2SCP
-	help
-	  Enable this to support the transceiver that is part of SOC. This
-	  driver takes care of all the PHY functionality apart from comparator.
-	  The USB OTG controller communicates with the comparator using this
-	  driver.
-
-config TI_PIPE3
-	tristate "TI PIPE3 PHY Driver"
-	depends on ARCH_OMAP2PLUS || COMPILE_TEST
-	select GENERIC_PHY
-	select OMAP_CONTROL_PHY
-	depends on OMAP_OCP2SCP
-	help
-	  Enable this to support the PIPE3 PHY that is part of TI SOCs. This
-	  driver takes care of all the PHY functionality apart from comparator.
-	  This driver interacts with the "OMAP Control PHY Driver" to power
-	  on/off the PHY.
-
-config TWL4030_USB
-	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
-	depends on USB_SUPPORT
-	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't 'y'
-	select GENERIC_PHY
-	select USB_PHY
-	help
-	  Enable this to support the USB OTG transceiver on TWL4030
-	  family chips (including the TWL5030 and TPS659x0 devices).
-	  This transceiver supports high and full speed devices plus,
-	  in host mode, low speed.
-
-config PHY_EXYNOS_DP_VIDEO
-	tristate "EXYNOS SoC series Display Port PHY driver"
-	depends on OF
-	depends on ARCH_EXYNOS || COMPILE_TEST
-	default ARCH_EXYNOS
-	select GENERIC_PHY
-	help
-	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
-
-config BCM_KONA_USB2_PHY
-	tristate "Broadcom Kona USB2 PHY Driver"
-	depends on HAS_IOMEM
-	select GENERIC_PHY
-	help
-	  Enable this to support the Broadcom Kona USB 2.0 PHY.
-
-config PHY_EXYNOS5250_SATA
-	tristate "Exynos5250 Sata SerDes/PHY driver"
-	depends on SOC_EXYNOS5250
-	depends on HAS_IOMEM
-	depends on OF
-	select GENERIC_PHY
-	select I2C
-	select I2C_S3C2410
-	select MFD_SYSCON
-	help
-	  Enable this to support SATA SerDes/Phy found on Samsung's
-	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
-	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host
-	  port to accept one SATA device.
-
-config PHY_HIX5HD2_SATA
-	tristate "HIX5HD2 SATA PHY Driver"
-	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
-	select GENERIC_PHY
-	select MFD_SYSCON
-	help
-	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
-
 config PHY_MT65XX_USB3
 	tristate "Mediatek USB3.0 PHY Driver"
 	depends on ARCH_MEDIATEK && OF
@@ -241,104 +34,6 @@ config PHY_MT65XX_USB3
 	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver,
 	  it supports multiple usb2.0 and usb3.0 ports.
 
-config PHY_HI6220_USB
-	tristate "hi6220 USB PHY support"
-	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
-	select GENERIC_PHY
-	select MFD_SYSCON
-	help
-	  Enable this to support the HISILICON HI6220 USB PHY.
-
-	  To compile this driver as a module, choose M here.
-
-config PHY_SUN4I_USB
-	tristate "Allwinner sunxi SoC USB PHY driver"
-	depends on ARCH_SUNXI && HAS_IOMEM && OF
-	depends on RESET_CONTROLLER
-	depends on EXTCON
-	depends on POWER_SUPPLY
-	depends on USB_SUPPORT
-	select GENERIC_PHY
-	select USB_COMMON
-	help
-	  Enable this to support the transceiver that is part of Allwinner
-	  sunxi SoCs.
-
-	  This driver controls the entire USB PHY block, both the USB OTG
-	  parts, as well as the 2 regular USB 2 host PHYs.
-
-config PHY_SUN9I_USB
-	tristate "Allwinner sun9i SoC USB PHY driver"
-	depends on ARCH_SUNXI && HAS_IOMEM && OF
-	depends on RESET_CONTROLLER
-	depends on USB_SUPPORT
-	select USB_COMMON
-	select GENERIC_PHY
-	help
-	  Enable this to support the transceiver that is part of Allwinner
-	  sun9i SoCs.
-
-	  This driver controls each individual USB 2 host PHY.
-
-config PHY_SAMSUNG_USB2
-	tristate "Samsung USB 2.0 PHY driver"
-	depends on HAS_IOMEM
-	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
-	select GENERIC_PHY
-	select MFD_SYSCON
-	default ARCH_EXYNOS
-	help
-	  Enable this to support the Samsung USB 2.0 PHY driver for Samsung
-	  SoCs. This driver provides the interface for USB 2.0 PHY. Support
-	  for particular PHYs will be enabled based on the SoC type in addition
-	  to this driver.
-
-config PHY_S5PV210_USB2
-	bool "Support for S5PV210"
-	depends on PHY_SAMSUNG_USB2
-	depends on ARCH_S5PV210
-	help
-	  Enable USB PHY support for S5PV210. This option requires that Samsung
-	  USB 2.0 PHY driver is enabled and means that support for this
-	  particular SoC is compiled in the driver. In case of S5PV210 two phys
-	  are available - device and host.
-
-config PHY_EXYNOS4210_USB2
-	bool
-	depends on PHY_SAMSUNG_USB2
-	default CPU_EXYNOS4210
-
-config PHY_EXYNOS4X12_USB2
-	bool
-	depends on PHY_SAMSUNG_USB2
-	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
-
-config PHY_EXYNOS5250_USB2
-	bool
-	depends on PHY_SAMSUNG_USB2
-	default SOC_EXYNOS5250 || SOC_EXYNOS5420
-
-config PHY_EXYNOS5_USBDRD
-	tristate "Exynos5 SoC series USB DRD PHY driver"
-	depends on ARCH_EXYNOS && OF
-	depends on HAS_IOMEM
-	depends on USB_DWC3_EXYNOS
-	select GENERIC_PHY
-	select MFD_SYSCON
-	default y
-	help
-	  Enable USB DRD PHY support for Exynos 5 SoC series.
-	  This driver provides PHY interface for USB 3.0 DRD controller
-	  present on Exynos5 SoC series.
-
-config PHY_EXYNOS_PCIE
-	bool "Exynos PCIe PHY driver"
-	depends on OF && (ARCH_EXYNOS || COMPILE_TEST)
-	select GENERIC_PHY
-	help
-	  Enable PCIe PHY support for Exynos SoC series.
-	  This driver provides PHY interface for Exynos PCIe controller.
-
 config PHY_PISTACHIO_USB
 	tristate "IMG Pistachio USB2.0 PHY driver"
 	depends on MACH_PISTACHIO
@@ -346,83 +41,6 @@ config PHY_PISTACHIO_USB
 	help
 	  Enable this to support the USB2.0 PHY on the IMG Pistachio SoC.
 
-config PHY_QCOM_APQ8064_SATA
-	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
-	depends on ARCH_QCOM
-	depends on HAS_IOMEM
-	depends on OF
-	select GENERIC_PHY
-
-config PHY_QCOM_IPQ806X_SATA
-	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
-	depends on ARCH_QCOM
-	depends on HAS_IOMEM
-	depends on OF
-	select GENERIC_PHY
-
-config PHY_ROCKCHIP_USB
-	tristate "Rockchip USB2 PHY Driver"
-	depends on ARCH_ROCKCHIP && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support the Rockchip USB 2.0 PHY.
-
-config PHY_ROCKCHIP_INNO_USB2
-	tristate "Rockchip INNO USB2PHY Driver"
-	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
-	depends on COMMON_CLK
-	depends on EXTCON
-	depends on USB_SUPPORT
-	select GENERIC_PHY
-	select USB_COMMON
-	help
-	  Support for Rockchip USB2.0 PHY with Innosilicon IP block.
-
-config PHY_ROCKCHIP_EMMC
-	tristate "Rockchip EMMC PHY Driver"
-	depends on ARCH_ROCKCHIP && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support the Rockchip EMMC PHY.
-
-config PHY_ROCKCHIP_DP
-	tristate "Rockchip Display Port PHY Driver"
-	depends on ARCH_ROCKCHIP && OF
-	select GENERIC_PHY
-	help
-	  Enable this to support the Rockchip Display Port PHY.
-
-config PHY_ROCKCHIP_PCIE
-	tristate "Rockchip PCIe PHY Driver"
-	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
-	select GENERIC_PHY
-	select MFD_SYSCON
-	help
-	  Enable this to support the Rockchip PCIe PHY.
-
-config PHY_ROCKCHIP_TYPEC
-	tristate "Rockchip TYPEC PHY Driver"
-	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
-	select EXTCON
-	select GENERIC_PHY
-	select RESET_CONTROLLER
-	help
-	  Enable this to support the Rockchip USB TYPEC PHY.
-
-config PHY_ST_SPEAR1310_MIPHY
-	tristate "ST SPEAR1310-MIPHY driver"
-	select GENERIC_PHY
-	depends on MACH_SPEAR1310 || COMPILE_TEST
-	help
-	  Support for ST SPEAr1310 MIPHY which can be used for PCIe and SATA.
-
-config PHY_ST_SPEAR1340_MIPHY
-	tristate "ST SPEAR1340-MIPHY driver"
-	select GENERIC_PHY
-	depends on MACH_SPEAR1340 || COMPILE_TEST
-	help
-	  Support for ST SPEAr1340 MIPHY which can be used for PCIe and SATA.
-
 config PHY_XGENE
 	tristate "APM X-Gene 15Gbps PHY support"
 	depends on HAS_IOMEM && OF && (ARM64 || COMPILE_TEST)
@@ -430,104 +48,21 @@ config PHY_XGENE
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.
 
-config PHY_STIH407_USB
-	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
-	depends on RESET_CONTROLLER
-	depends on ARCH_STI || COMPILE_TEST
-	select GENERIC_PHY
-	help
-	  Enable this support to enable the picoPHY device used by USB2
-	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
-
-config PHY_QCOM_QMP
-	tristate "Qualcomm QMP PHY Driver"
-	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
-	select GENERIC_PHY
-	help
-	  Enable this to support the QMP PHY transceiver that is used
-	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
-
-config PHY_QCOM_QUSB2
-	tristate "Qualcomm QUSB2 PHY Driver"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
-	depends on NVMEM || !NVMEM
-	select GENERIC_PHY
-	help
-	  Enable this to support the HighSpeed QUSB2 PHY transceiver for USB
-	  controllers on Qualcomm chips. This driver supports the high-speed
-	  PHY which is usually paired with either the ChipIdea or Synopsys DWC3
-	  USB IPs on MSM SOCs.
-
-config PHY_QCOM_UFS
-	tristate "Qualcomm UFS PHY driver"
-	depends on OF && ARCH_QCOM
-	select GENERIC_PHY
-	help
-	  Support for UFS PHY on QCOM chipsets.
-
-config PHY_QCOM_USB_HS
-	tristate "Qualcomm USB HS PHY module"
-	depends on USB_ULPI_BUS
-	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
-	select GENERIC_PHY
-	help
-	  Support for the USB high-speed ULPI compliant phy on Qualcomm
-	  chipsets.
-
-config PHY_QCOM_USB_HSIC
-	tristate "Qualcomm USB HSIC ULPI PHY module"
-	depends on USB_ULPI_BUS
-	select GENERIC_PHY
-	help
-	  Support for the USB HSIC ULPI compliant PHY on QCOM chipsets.
-
-config PHY_TUSB1210
-	tristate "TI TUSB1210 ULPI PHY module"
-	depends on USB_ULPI_BUS
-	select GENERIC_PHY
-	help
-	  Support for TI TUSB1210 USB ULPI PHY.
-
-config PHY_BRCM_SATA
-	tristate "Broadcom SATA PHY driver"
-	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
-	depends on OF
-	select GENERIC_PHY
-	default ARCH_BCM_IPROC
-	help
-	  Enable this to support the Broadcom SATA PHY.
-	  If unsure, say N.
-
-config PHY_CYGNUS_PCIE
-	tristate "Broadcom Cygnus PCIe PHY driver"
-	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
-	select GENERIC_PHY
-	default ARCH_BCM_CYGNUS
-	help
-	  Enable this to support the Broadcom Cygnus PCIe PHY.
-	  If unsure, say N.
-
+menu "Platform Phy drivers"
+
+source "drivers/phy/allwinner/Kconfig"
+source "drivers/phy/amlogic/Kconfig"
+source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/hisilicon/Kconfig"
+source "drivers/phy/marvell/Kconfig"
+source "drivers/phy/qualcomm/Kconfig"
+source "drivers/phy/renesas/Kconfig"
+source "drivers/phy/rockchip/Kconfig"
+source "drivers/phy/samsung/Kconfig"
+source "drivers/phy/st/Kconfig"
 source "drivers/phy/tegra/Kconfig"
+source "drivers/phy/ti/Kconfig"
 
-config PHY_NS2_PCIE
-	tristate "Broadcom Northstar2 PCIe PHY driver"
-	depends on OF && MDIO_BUS_MUX_BCM_IPROC
-	select GENERIC_PHY
-	default ARCH_BCM_IPROC
-	help
-	  Enable this to support the Broadcom Northstar2 PCIe PHY.
-	  If unsure, say N.
-
-config PHY_MESON8B_USB2
-	tristate "Meson8b and GXBB USB2 PHY driver"
-	default ARCH_MESON
-	depends on OF && (ARCH_MESON || COMPILE_TEST)
-	depends on USB_SUPPORT
-	select USB_COMMON
-	select GENERIC_PHY
-	help
-	  Enable this to support the Meson USB2 PHYs found in Meson8b
-	  and GXBB SoCs.
-	  If unsure, say N.
+endmenu
 
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f8047b4639fa..c1bd1fa3c853 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -3,64 +3,20 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
-obj-$(CONFIG_PHY_BCM_NS_USB2)		+= phy-bcm-ns-usb2.o
-obj-$(CONFIG_PHY_BCM_NS_USB3)		+= phy-bcm-ns-usb3.o
-obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
-obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
-obj-$(CONFIG_PHY_DA8XX_USB)		+= phy-da8xx-usb.o
-obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
-obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
-obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
-obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
-obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
-obj-$(CONFIG_PHY_PXA_28NM_USB2)		+= phy-pxa-28nm-usb2.o
-obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
-obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
-obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
-obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
-obj-$(CONFIG_PHY_RCAR_GEN3_USB2)	+= phy-rcar-gen3-usb2.o
-obj-$(CONFIG_OMAP_CONTROL_PHY)		+= phy-omap-control.o
-obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
-obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
-obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
-obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
-obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
-obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
 obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
-obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
-obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
-obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
-phy-exynos-usb2-y			+= phy-samsung-usb2.o
-phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
-phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
-phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
-phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
-obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
-obj-$(CONFIG_PHY_EXYNOS_PCIE)	+= phy-exynos-pcie.o
-obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
-obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
-obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
-obj-$(CONFIG_PHY_ROCKCHIP_EMMC) += phy-rockchip-emmc.o
-obj-$(CONFIG_PHY_ROCKCHIP_PCIE) += phy-rockchip-pcie.o
-obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
-obj-$(CONFIG_PHY_ROCKCHIP_TYPEC) += phy-rockchip-typec.o
-obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
-obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
-obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
-obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
-obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
-obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
-obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
-obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
-obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
-obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
-obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
-obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
-obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
-obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
-obj-$(CONFIG_ARCH_TEGRA) += tegra/
-obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
-obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
+
+obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
+obj-$(CONFIG_ARCH_MESON)		+= amlogic/
+obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
+obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
+obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
+obj-y					+= broadcom/	\
+					   hisilicon/	\
+					   marvell/	\
+					   qualcomm/	\
+					   samsung/	\
+					   st/		\
+					   ti/
diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
new file mode 100644
index 000000000000..cdc1e745ba47
--- /dev/null
+++ b/drivers/phy/allwinner/Kconfig
@@ -0,0 +1,31 @@
+#
+# Phy drivers for Allwinner platforms
+#
+config PHY_SUN4I_USB
+	tristate "Allwinner sunxi SoC USB PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	depends on EXTCON
+	depends on POWER_SUPPLY
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select USB_COMMON
+	help
+	  Enable this to support the transceiver that is part of Allwinner
+	  sunxi SoCs.
+
+	  This driver controls the entire USB PHY block, both the USB OTG
+	  parts, as well as the 2 regular USB 2 host PHYs.
+
+config PHY_SUN9I_USB
+	tristate "Allwinner sun9i SoC USB PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	depends on USB_SUPPORT
+	select USB_COMMON
+	select GENERIC_PHY
+	help
+	  Enable this to support the transceiver that is part of Allwinner
+	  sun9i SoCs.
+
+	  This driver controls each individual USB 2 host PHY.
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
new file mode 100644
index 000000000000..8605529c01a1
--- /dev/null
+++ b/drivers/phy/allwinner/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
+obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
similarity index 100%
rename from drivers/phy/phy-sun4i-usb.c
rename to drivers/phy/allwinner/phy-sun4i-usb.c
diff --git a/drivers/phy/phy-sun9i-usb.c b/drivers/phy/allwinner/phy-sun9i-usb.c
similarity index 100%
rename from drivers/phy/phy-sun9i-usb.c
rename to drivers/phy/allwinner/phy-sun9i-usb.c
diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
new file mode 100644
index 000000000000..edcd5b65179f
--- /dev/null
+++ b/drivers/phy/amlogic/Kconfig
@@ -0,0 +1,14 @@
+#
+# Phy drivers for Amlogic platforms
+#
+config PHY_MESON8B_USB2
+	tristate "Meson8b and GXBB USB2 PHY driver"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	depends on USB_SUPPORT
+	select USB_COMMON
+	select GENERIC_PHY
+	help
+	  Enable this to support the Meson USB2 PHYs found in Meson8b
+	  and GXBB SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
new file mode 100644
index 000000000000..47b6eecc3864
--- /dev/null
+++ b/drivers/phy/amlogic/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
diff --git a/drivers/phy/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
similarity index 100%
rename from drivers/phy/phy-meson8b-usb2.c
rename to drivers/phy/amlogic/phy-meson8b-usb2.c
diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
new file mode 100644
index 000000000000..d2d99023ec50
--- /dev/null
+++ b/drivers/phy/broadcom/Kconfig
@@ -0,0 +1,55 @@
+#
+# Phy drivers for Broadcom platforms
+#
+config PHY_CYGNUS_PCIE
+	tristate "Broadcom Cygnus PCIe PHY driver"
+	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
+	select GENERIC_PHY
+	default ARCH_BCM_CYGNUS
+	help
+	  Enable this to support the Broadcom Cygnus PCIe PHY.
+	  If unsure, say N.
+
+config BCM_KONA_USB2_PHY
+	tristate "Broadcom Kona USB2 PHY Driver"
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support the Broadcom Kona USB 2.0 PHY.
+
+config PHY_BCM_NS_USB2
+	tristate "Broadcom Northstar USB 2.0 PHY Driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support Broadcom USB 2.0 PHY connected to the USB
+	  controller on Northstar family.
+
+config PHY_BCM_NS_USB3
+	tristate "Broadcom Northstar USB 3.0 PHY Driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support Broadcom USB 3.0 PHY connected to the USB
+	  controller on Northstar family.
+
+config PHY_NS2_PCIE
+	tristate "Broadcom Northstar2 PCIe PHY driver"
+	depends on OF && MDIO_BUS_MUX_BCM_IPROC
+	select GENERIC_PHY
+	default ARCH_BCM_IPROC
+	help
+	  Enable this to support the Broadcom Northstar2 PCIe PHY.
+	  If unsure, say N.
+
+config PHY_BRCM_SATA
+	tristate "Broadcom SATA PHY driver"
+	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	default ARCH_BCM_IPROC
+	help
+	  Enable this to support the Broadcom SATA PHY.
+	  If unsure, say N.
diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
new file mode 100644
index 000000000000..357a7d16529f
--- /dev/null
+++ b/drivers/phy/broadcom/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
+obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
+obj-$(CONFIG_PHY_BCM_NS_USB2)		+= phy-bcm-ns-usb2.o
+obj-$(CONFIG_PHY_BCM_NS_USB3)		+= phy-bcm-ns-usb3.o
+obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
+obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
diff --git a/drivers/phy/phy-bcm-cygnus-pcie.c b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
similarity index 100%
rename from drivers/phy/phy-bcm-cygnus-pcie.c
rename to drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
diff --git a/drivers/phy/phy-bcm-kona-usb2.c b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
similarity index 100%
rename from drivers/phy/phy-bcm-kona-usb2.c
rename to drivers/phy/broadcom/phy-bcm-kona-usb2.c
diff --git a/drivers/phy/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
similarity index 100%
rename from drivers/phy/phy-bcm-ns-usb2.c
rename to drivers/phy/broadcom/phy-bcm-ns-usb2.c
diff --git a/drivers/phy/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
similarity index 100%
rename from drivers/phy/phy-bcm-ns-usb3.c
rename to drivers/phy/broadcom/phy-bcm-ns-usb3.c
diff --git a/drivers/phy/phy-bcm-ns2-pcie.c b/drivers/phy/broadcom/phy-bcm-ns2-pcie.c
similarity index 100%
rename from drivers/phy/phy-bcm-ns2-pcie.c
rename to drivers/phy/broadcom/phy-bcm-ns2-pcie.c
diff --git a/drivers/phy/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
similarity index 100%
rename from drivers/phy/phy-brcm-sata.c
rename to drivers/phy/broadcom/phy-brcm-sata.c
diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
new file mode 100644
index 000000000000..6164c4cd0f65
--- /dev/null
+++ b/drivers/phy/hisilicon/Kconfig
@@ -0,0 +1,20 @@
+#
+# Phy drivers for Hisilicon platforms
+#
+config PHY_HI6220_USB
+	tristate "hi6220 USB PHY support"
+	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the HISILICON HI6220 USB PHY.
+
+	  To compile this driver as a module, choose M here.
+
+config PHY_HIX5HD2_SATA
+	tristate "HIX5HD2 SATA PHY Driver"
+	depends on ARCH_HIX5HD2 && OF && HAS_IOMEM
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
diff --git a/drivers/phy/hisilicon/Makefile b/drivers/phy/hisilicon/Makefile
new file mode 100644
index 000000000000..541b348187a8
--- /dev/null
+++ b/drivers/phy/hisilicon/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PHY_HI6220_USB)		+= phy-hi6220-usb.o
+obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
diff --git a/drivers/phy/phy-hi6220-usb.c b/drivers/phy/hisilicon/phy-hi6220-usb.c
similarity index 100%
rename from drivers/phy/phy-hi6220-usb.c
rename to drivers/phy/hisilicon/phy-hi6220-usb.c
diff --git a/drivers/phy/phy-hix5hd2-sata.c b/drivers/phy/hisilicon/phy-hix5hd2-sata.c
similarity index 100%
rename from drivers/phy/phy-hix5hd2-sata.c
rename to drivers/phy/hisilicon/phy-hix5hd2-sata.c
diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
new file mode 100644
index 000000000000..048d8893bc2e
--- /dev/null
+++ b/drivers/phy/marvell/Kconfig
@@ -0,0 +1,50 @@
+#
+# Phy drivers for Marvell platforms
+#
+config ARMADA375_USBCLUSTER_PHY
+	def_bool y
+	depends on MACH_ARMADA_375 || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	select GENERIC_PHY
+
+config PHY_BERLIN_SATA
+	tristate "Marvell Berlin SATA PHY driver"
+	depends on ARCH_BERLIN && HAS_IOMEM && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
+
+config PHY_BERLIN_USB
+	tristate "Marvell Berlin USB PHY Driver"
+	depends on ARCH_BERLIN && RESET_CONTROLLER && HAS_IOMEM && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB PHY on Marvell Berlin SoCs.
+
+config PHY_MVEBU_SATA
+	def_bool y
+	depends on ARCH_DOVE || MACH_DOVE || MACH_KIRKWOOD
+	depends on OF
+	select GENERIC_PHY
+
+config PHY_PXA_28NM_HSIC
+	tristate "Marvell USB HSIC 28nm PHY Driver"
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support Marvell USB HSIC PHY driver for Marvell
+	  SoC. This driver will do the PHY initialization and shutdown.
+	  The PHY driver will be used by Marvell ehci driver.
+
+	  To compile this driver as a module, choose M here.
+
+config PHY_PXA_28NM_USB2
+	tristate "Marvell USB 2.0 28nm PHY Driver"
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support Marvell USB 2.0 PHY driver for Marvell
+	  SoC. This driver will do the PHY initialization and shutdown.
+	  The PHY driver will be used by Marvell udc/ehci/otg driver.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
new file mode 100644
index 000000000000..3fc188f59118
--- /dev/null
+++ b/drivers/phy/marvell/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
+obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
+obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
+obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
+obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
+obj-$(CONFIG_PHY_PXA_28NM_USB2)		+= phy-pxa-28nm-usb2.o
diff --git a/drivers/phy/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
similarity index 100%
rename from drivers/phy/phy-armada375-usb2.c
rename to drivers/phy/marvell/phy-armada375-usb2.c
diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
similarity index 100%
rename from drivers/phy/phy-berlin-sata.c
rename to drivers/phy/marvell/phy-berlin-sata.c
diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
similarity index 100%
rename from drivers/phy/phy-berlin-usb.c
rename to drivers/phy/marvell/phy-berlin-usb.c
diff --git a/drivers/phy/phy-mvebu-sata.c b/drivers/phy/marvell/phy-mvebu-sata.c
similarity index 100%
rename from drivers/phy/phy-mvebu-sata.c
rename to drivers/phy/marvell/phy-mvebu-sata.c
diff --git a/drivers/phy/phy-pxa-28nm-hsic.c b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
similarity index 100%
rename from drivers/phy/phy-pxa-28nm-hsic.c
rename to drivers/phy/marvell/phy-pxa-28nm-hsic.c
diff --git a/drivers/phy/phy-pxa-28nm-usb2.c b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
similarity index 100%
rename from drivers/phy/phy-pxa-28nm-usb2.c
rename to drivers/phy/marvell/phy-pxa-28nm-usb2.c
diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
new file mode 100644
index 000000000000..7bfa64baf837
--- /dev/null
+++ b/drivers/phy/qualcomm/Kconfig
@@ -0,0 +1,58 @@
+#
+# Phy drivers for Qualcomm platforms
+#
+config PHY_QCOM_APQ8064_SATA
+	tristate "Qualcomm APQ8064 SATA SerDes/PHY driver"
+	depends on ARCH_QCOM
+	depends on HAS_IOMEM
+	depends on OF
+	select GENERIC_PHY
+
+config PHY_QCOM_IPQ806X_SATA
+	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
+	depends on ARCH_QCOM
+	depends on HAS_IOMEM
+	depends on OF
+	select GENERIC_PHY
+
+config PHY_QCOM_QMP
+	tristate "Qualcomm QMP PHY Driver"
+	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable this to support the QMP PHY transceiver that is used
+	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
+
+config PHY_QCOM_QUSB2
+	tristate "Qualcomm QUSB2 PHY Driver"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on NVMEM || !NVMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support the HighSpeed QUSB2 PHY transceiver for USB
+	  controllers on Qualcomm chips. This driver supports the high-speed
+	  PHY which is usually paired with either the ChipIdea or Synopsys DWC3
+	  USB IPs on MSM SOCs.
+
+config PHY_QCOM_UFS
+	tristate "Qualcomm UFS PHY driver"
+	depends on OF && ARCH_QCOM
+	select GENERIC_PHY
+	help
+	  Support for UFS PHY on QCOM chipsets.
+
+config PHY_QCOM_USB_HS
+	tristate "Qualcomm USB HS PHY module"
+	depends on USB_ULPI_BUS
+	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
+	select GENERIC_PHY
+	help
+	  Support for the USB high-speed ULPI compliant phy on Qualcomm
+	  chipsets.
+
+config PHY_QCOM_USB_HSIC
+	tristate "Qualcomm USB HSIC ULPI PHY module"
+	depends on USB_ULPI_BUS
+	select GENERIC_PHY
+	help
+	  Support for the USB HSIC ULPI compliant PHY on QCOM chipsets.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
new file mode 100644
index 000000000000..2e183d7695fd
--- /dev/null
+++ b/drivers/phy/qualcomm/Makefile
@@ -0,0 +1,9 @@
+obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
+obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
+obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
+obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
+obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs.o
+obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-14nm.o
+obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-20nm.o
+obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
+obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
diff --git a/drivers/phy/phy-qcom-apq8064-sata.c b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
similarity index 100%
rename from drivers/phy/phy-qcom-apq8064-sata.c
rename to drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
diff --git a/drivers/phy/phy-qcom-ipq806x-sata.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c
similarity index 100%
rename from drivers/phy/phy-qcom-ipq806x-sata.c
rename to drivers/phy/qualcomm/phy-qcom-ipq806x-sata.c
diff --git a/drivers/phy/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
similarity index 100%
rename from drivers/phy/phy-qcom-qmp.c
rename to drivers/phy/qualcomm/phy-qcom-qmp.c
diff --git a/drivers/phy/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
similarity index 100%
rename from drivers/phy/phy-qcom-qusb2.c
rename to drivers/phy/qualcomm/phy-qcom-qusb2.c
diff --git a/drivers/phy/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
similarity index 100%
rename from drivers/phy/phy-qcom-ufs-i.h
rename to drivers/phy/qualcomm/phy-qcom-ufs-i.h
diff --git a/drivers/phy/phy-qcom-ufs-qmp-14nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
similarity index 100%
rename from drivers/phy/phy-qcom-ufs-qmp-14nm.c
rename to drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
diff --git a/drivers/phy/phy-qcom-ufs-qmp-14nm.h b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.h
similarity index 100%
rename from drivers/phy/phy-qcom-ufs-qmp-14nm.h
rename to drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.h
diff --git a/drivers/phy/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
similarity index 100%
rename from drivers/phy/phy-qcom-ufs-qmp-20nm.c
rename to drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
diff --git a/drivers/phy/phy-qcom-ufs-qmp-20nm.h b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.h
similarity index 100%
rename from drivers/phy/phy-qcom-ufs-qmp-20nm.h
rename to drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.h
diff --git a/drivers/phy/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
similarity index 100%
rename from drivers/phy/phy-qcom-ufs.c
rename to drivers/phy/qualcomm/phy-qcom-ufs.c
diff --git a/drivers/phy/phy-qcom-usb-hs.c b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
similarity index 100%
rename from drivers/phy/phy-qcom-usb-hs.c
rename to drivers/phy/qualcomm/phy-qcom-usb-hs.c
diff --git a/drivers/phy/phy-qcom-usb-hsic.c b/drivers/phy/qualcomm/phy-qcom-usb-hsic.c
similarity index 100%
rename from drivers/phy/phy-qcom-usb-hsic.c
rename to drivers/phy/qualcomm/phy-qcom-usb-hsic.c
diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
new file mode 100644
index 000000000000..432e2715e9c4
--- /dev/null
+++ b/drivers/phy/renesas/Kconfig
@@ -0,0 +1,17 @@
+#
+# Phy drivers for Renesas platforms
+#
+config PHY_RCAR_GEN2
+	tristate "Renesas R-Car generation 2 USB PHY driver"
+	depends on ARCH_RENESAS
+	depends on GENERIC_PHY
+	help
+	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
+
+config PHY_RCAR_GEN3_USB2
+	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
+	depends on ARCH_RENESAS
+	depends on EXTCON
+	select GENERIC_PHY
+	help
+	  Support for USB 2.0 PHY found on Renesas R-Car generation 3 SoCs.
diff --git a/drivers/phy/renesas/Makefile b/drivers/phy/renesas/Makefile
new file mode 100644
index 000000000000..695241aebf69
--- /dev/null
+++ b/drivers/phy/renesas/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
+obj-$(CONFIG_PHY_RCAR_GEN3_USB2)	+= phy-rcar-gen3-usb2.o
diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
similarity index 100%
rename from drivers/phy/phy-rcar-gen2.c
rename to drivers/phy/renesas/phy-rcar-gen2.c
diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
similarity index 100%
rename from drivers/phy/phy-rcar-gen3-usb2.c
rename to drivers/phy/renesas/phy-rcar-gen3-usb2.c
diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
new file mode 100644
index 000000000000..f5325b2b679e
--- /dev/null
+++ b/drivers/phy/rockchip/Kconfig
@@ -0,0 +1,51 @@
+#
+# Phy drivers for Rockchip platforms
+#
+config PHY_ROCKCHIP_DP
+	tristate "Rockchip Display Port PHY Driver"
+	depends on ARCH_ROCKCHIP && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the Rockchip Display Port PHY.
+
+config PHY_ROCKCHIP_EMMC
+	tristate "Rockchip EMMC PHY Driver"
+	depends on ARCH_ROCKCHIP && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the Rockchip EMMC PHY.
+
+config PHY_ROCKCHIP_INNO_USB2
+	tristate "Rockchip INNO USB2PHY Driver"
+	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on COMMON_CLK
+	depends on EXTCON
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select USB_COMMON
+	help
+	  Support for Rockchip USB2.0 PHY with Innosilicon IP block.
+
+config PHY_ROCKCHIP_PCIE
+	tristate "Rockchip PCIe PHY Driver"
+	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the Rockchip PCIe PHY.
+
+config PHY_ROCKCHIP_TYPEC
+	tristate "Rockchip TYPEC PHY Driver"
+	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
+	select EXTCON
+	select GENERIC_PHY
+	select RESET_CONTROLLER
+	help
+	  Enable this to support the Rockchip USB TYPEC PHY.
+
+config PHY_ROCKCHIP_USB
+	tristate "Rockchip USB2 PHY Driver"
+	depends on ARCH_ROCKCHIP && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the Rockchip USB 2.0 PHY.
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
new file mode 100644
index 000000000000..bd0acdf38e0f
--- /dev/null
+++ b/drivers/phy/rockchip/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
+obj-$(CONFIG_PHY_ROCKCHIP_EMMC)		+= phy-rockchip-emmc.o
+obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
+obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
+obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
+obj-$(CONFIG_PHY_ROCKCHIP_USB)		+= phy-rockchip-usb.o
diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/rockchip/phy-rockchip-dp.c
similarity index 100%
rename from drivers/phy/phy-rockchip-dp.c
rename to drivers/phy/rockchip/phy-rockchip-dp.c
diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
similarity index 100%
rename from drivers/phy/phy-rockchip-emmc.c
rename to drivers/phy/rockchip/phy-rockchip-emmc.c
diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
similarity index 100%
rename from drivers/phy/phy-rockchip-inno-usb2.c
rename to drivers/phy/rockchip/phy-rockchip-inno-usb2.c
diff --git a/drivers/phy/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
similarity index 100%
rename from drivers/phy/phy-rockchip-pcie.c
rename to drivers/phy/rockchip/phy-rockchip-pcie.c
diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
similarity index 100%
rename from drivers/phy/phy-rockchip-typec.c
rename to drivers/phy/rockchip/phy-rockchip-typec.c
diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
similarity index 100%
rename from drivers/phy/phy-rockchip-usb.c
rename to drivers/phy/rockchip/phy-rockchip-usb.c
diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
new file mode 100644
index 000000000000..b7e0645a7bd9
--- /dev/null
+++ b/drivers/phy/samsung/Kconfig
@@ -0,0 +1,95 @@
+#
+# Phy drivers for Samsung platforms
+#
+config PHY_EXYNOS_DP_VIDEO
+	tristate "EXYNOS SoC series Display Port PHY driver"
+	depends on OF
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	default ARCH_EXYNOS
+	select GENERIC_PHY
+	help
+	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
+
+config PHY_EXYNOS_MIPI_VIDEO
+	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
+	depends on HAS_IOMEM
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select GENERIC_PHY
+	default y if ARCH_S5PV210 || ARCH_EXYNOS
+	help
+	  Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
+	  and EXYNOS SoCs.
+
+config PHY_EXYNOS_PCIE
+	bool "Exynos PCIe PHY driver"
+	depends on OF && (ARCH_EXYNOS || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable PCIe PHY support for Exynos SoC series.
+	  This driver provides PHY interface for Exynos PCIe controller.
+
+config PHY_SAMSUNG_USB2
+	tristate "Samsung USB 2.0 PHY driver"
+	depends on HAS_IOMEM
+	depends on USB_EHCI_EXYNOS || USB_OHCI_EXYNOS || USB_DWC2
+	select GENERIC_PHY
+	select MFD_SYSCON
+	default ARCH_EXYNOS
+	help
+	  Enable this to support the Samsung USB 2.0 PHY driver for Samsung
+	  SoCs. This driver provides the interface for USB 2.0 PHY. Support
+	  for particular PHYs will be enabled based on the SoC type in addition
+	  to this driver.
+
+config PHY_EXYNOS4210_USB2
+	bool
+	depends on PHY_SAMSUNG_USB2
+	default CPU_EXYNOS4210
+
+config PHY_EXYNOS4X12_USB2
+	bool
+	depends on PHY_SAMSUNG_USB2
+	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
+
+config PHY_EXYNOS5250_USB2
+	bool
+	depends on PHY_SAMSUNG_USB2
+	default SOC_EXYNOS5250 || SOC_EXYNOS5420
+
+config PHY_S5PV210_USB2
+	bool "Support for S5PV210"
+	depends on PHY_SAMSUNG_USB2
+	depends on ARCH_S5PV210
+	help
+	  Enable USB PHY support for S5PV210. This option requires that Samsung
+	  USB 2.0 PHY driver is enabled and means that support for this
+	  particular SoC is compiled in the driver. In case of S5PV210 two phys
+	  are available - device and host.
+
+config PHY_EXYNOS5_USBDRD
+	tristate "Exynos5 SoC series USB DRD PHY driver"
+	depends on ARCH_EXYNOS && OF
+	depends on HAS_IOMEM
+	depends on USB_DWC3_EXYNOS
+	select GENERIC_PHY
+	select MFD_SYSCON
+	default y
+	help
+	  Enable USB DRD PHY support for Exynos 5 SoC series.
+	  This driver provides PHY interface for USB 3.0 DRD controller
+	  present on Exynos5 SoC series.
+
+config PHY_EXYNOS5250_SATA
+	tristate "Exynos5250 Sata SerDes/PHY driver"
+	depends on SOC_EXYNOS5250
+	depends on HAS_IOMEM
+	depends on OF
+	select GENERIC_PHY
+	select I2C
+	select I2C_S3C2410
+	select MFD_SYSCON
+	help
+	  Enable this to support SATA SerDes/Phy found on Samsung's
+	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
+	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host
+	  port to accept one SATA device.
diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
new file mode 100644
index 000000000000..20d7f2424772
--- /dev/null
+++ b/drivers/phy/samsung/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
+obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
+obj-$(CONFIG_PHY_EXYNOS_PCIE)		+= phy-exynos-pcie.o
+obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
+phy-exynos-usb2-y			+= phy-samsung-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)	+= phy-exynos4210-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
+phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
+obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
+obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
diff --git a/drivers/phy/phy-exynos-dp-video.c b/drivers/phy/samsung/phy-exynos-dp-video.c
similarity index 100%
rename from drivers/phy/phy-exynos-dp-video.c
rename to drivers/phy/samsung/phy-exynos-dp-video.c
diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/samsung/phy-exynos-mipi-video.c
similarity index 100%
rename from drivers/phy/phy-exynos-mipi-video.c
rename to drivers/phy/samsung/phy-exynos-mipi-video.c
diff --git a/drivers/phy/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
similarity index 100%
rename from drivers/phy/phy-exynos-pcie.c
rename to drivers/phy/samsung/phy-exynos-pcie.c
diff --git a/drivers/phy/phy-exynos4210-usb2.c b/drivers/phy/samsung/phy-exynos4210-usb2.c
similarity index 100%
rename from drivers/phy/phy-exynos4210-usb2.c
rename to drivers/phy/samsung/phy-exynos4210-usb2.c
diff --git a/drivers/phy/phy-exynos4x12-usb2.c b/drivers/phy/samsung/phy-exynos4x12-usb2.c
similarity index 100%
rename from drivers/phy/phy-exynos4x12-usb2.c
rename to drivers/phy/samsung/phy-exynos4x12-usb2.c
diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
similarity index 100%
rename from drivers/phy/phy-exynos5-usbdrd.c
rename to drivers/phy/samsung/phy-exynos5-usbdrd.c
diff --git a/drivers/phy/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
similarity index 100%
rename from drivers/phy/phy-exynos5250-sata.c
rename to drivers/phy/samsung/phy-exynos5250-sata.c
diff --git a/drivers/phy/phy-exynos5250-usb2.c b/drivers/phy/samsung/phy-exynos5250-usb2.c
similarity index 100%
rename from drivers/phy/phy-exynos5250-usb2.c
rename to drivers/phy/samsung/phy-exynos5250-usb2.c
diff --git a/drivers/phy/phy-s5pv210-usb2.c b/drivers/phy/samsung/phy-s5pv210-usb2.c
similarity index 100%
rename from drivers/phy/phy-s5pv210-usb2.c
rename to drivers/phy/samsung/phy-s5pv210-usb2.c
diff --git a/drivers/phy/phy-samsung-usb2.c b/drivers/phy/samsung/phy-samsung-usb2.c
similarity index 100%
rename from drivers/phy/phy-samsung-usb2.c
rename to drivers/phy/samsung/phy-samsung-usb2.c
diff --git a/drivers/phy/phy-samsung-usb2.h b/drivers/phy/samsung/phy-samsung-usb2.h
similarity index 100%
rename from drivers/phy/phy-samsung-usb2.h
rename to drivers/phy/samsung/phy-samsung-usb2.h
diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
new file mode 100644
index 000000000000..0814d3f87ec6
--- /dev/null
+++ b/drivers/phy/st/Kconfig
@@ -0,0 +1,33 @@
+#
+# Phy drivers for STMicro platforms
+#
+config PHY_MIPHY28LP
+	tristate "STMicroelectronics MIPHY28LP PHY driver for STiH407"
+	depends on ARCH_STI
+	select GENERIC_PHY
+	help
+	  Enable this to support the miphy transceiver (for SATA/PCIE/USB3)
+	  that is part of STMicroelectronics STiH407 SoC.
+
+config PHY_ST_SPEAR1310_MIPHY
+	tristate "ST SPEAR1310-MIPHY driver"
+	select GENERIC_PHY
+	depends on MACH_SPEAR1310 || COMPILE_TEST
+	help
+	  Support for ST SPEAr1310 MIPHY which can be used for PCIe and SATA.
+
+config PHY_ST_SPEAR1340_MIPHY
+	tristate "ST SPEAR1340-MIPHY driver"
+	select GENERIC_PHY
+	depends on MACH_SPEAR1340 || COMPILE_TEST
+	help
+	  Support for ST SPEAr1340 MIPHY which can be used for PCIe and SATA.
+
+config PHY_STIH407_USB
+	tristate "STMicroelectronics USB2 picoPHY driver for STiH407 family"
+	depends on RESET_CONTROLLER
+	depends on ARCH_STI || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Enable this support to enable the picoPHY device used by USB2
+	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
diff --git a/drivers/phy/st/Makefile b/drivers/phy/st/Makefile
new file mode 100644
index 000000000000..e2adfe2166d2
--- /dev/null
+++ b/drivers/phy/st/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
+obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
+obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
+obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
similarity index 100%
rename from drivers/phy/phy-miphy28lp.c
rename to drivers/phy/st/phy-miphy28lp.c
diff --git a/drivers/phy/phy-spear1310-miphy.c b/drivers/phy/st/phy-spear1310-miphy.c
similarity index 100%
rename from drivers/phy/phy-spear1310-miphy.c
rename to drivers/phy/st/phy-spear1310-miphy.c
diff --git a/drivers/phy/phy-spear1340-miphy.c b/drivers/phy/st/phy-spear1340-miphy.c
similarity index 100%
rename from drivers/phy/phy-spear1340-miphy.c
rename to drivers/phy/st/phy-spear1340-miphy.c
diff --git a/drivers/phy/phy-stih407-usb.c b/drivers/phy/st/phy-stih407-usb.c
similarity index 100%
rename from drivers/phy/phy-stih407-usb.c
rename to drivers/phy/st/phy-stih407-usb.c
diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
new file mode 100644
index 000000000000..20503562666c
--- /dev/null
+++ b/drivers/phy/ti/Kconfig
@@ -0,0 +1,78 @@
+#
+# Phy drivers for TI platforms
+#
+config PHY_DA8XX_USB
+	tristate "TI DA8xx USB PHY Driver"
+	depends on ARCH_DAVINCI_DA8XX
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support the USB PHY on DA8xx SoCs.
+
+	  This driver controls both the USB 1.1 PHY and the USB 2.0 PHY.
+
+config PHY_DM816X_USB
+	tristate "TI dm816x USB PHY driver"
+	depends on ARCH_OMAP2PLUS
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this for dm816x USB to work.
+
+config OMAP_CONTROL_PHY
+	tristate "OMAP CONTROL PHY Driver"
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	help
+	  Enable this to add support for the PHY part present in the control
+	  module. This driver has API to power on the USB2 PHY and to write to
+	  the mailbox. The mailbox is present only in omap4 and the register to
+	  power on the USB2 PHY is present in OMAP4 and OMAP5. OMAP5 has an
+	  additional register to power on USB3 PHY/SATA PHY/PCIE PHY
+	  (PIPE3 PHY).
+
+config OMAP_USB2
+	tristate "OMAP USB2 PHY Driver"
+	depends on ARCH_OMAP2PLUS
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select USB_PHY
+	select OMAP_CONTROL_PHY
+	depends on OMAP_OCP2SCP
+	help
+	  Enable this to support the transceiver that is part of SOC. This
+	  driver takes care of all the PHY functionality apart from comparator.
+	  The USB OTG controller communicates with the comparator using this
+	  driver.
+
+config TI_PIPE3
+	tristate "TI PIPE3 PHY Driver"
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	select GENERIC_PHY
+	select OMAP_CONTROL_PHY
+	depends on OMAP_OCP2SCP
+	help
+	  Enable this to support the PIPE3 PHY that is part of TI SOCs. This
+	  driver takes care of all the PHY functionality apart from comparator.
+	  This driver interacts with the "OMAP Control PHY Driver" to power
+	  on/off the PHY.
+
+config PHY_TUSB1210
+	tristate "TI TUSB1210 ULPI PHY module"
+	depends on USB_ULPI_BUS
+	select GENERIC_PHY
+	help
+	  Support for TI TUSB1210 USB ULPI PHY.
+
+config TWL4030_USB
+	tristate "TWL4030 USB Transceiver Driver"
+	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
+	depends on USB_SUPPORT
+	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't 'y'
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support the USB OTG transceiver on TWL4030
+	  family chips (including the TWL5030 and TPS659x0 devices).
+	  This transceiver supports high and full speed devices plus,
+	  in host mode, low speed.
diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
new file mode 100644
index 000000000000..0cc3a1a557a3
--- /dev/null
+++ b/drivers/phy/ti/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_PHY_DA8XX_USB)		+= phy-da8xx-usb.o
+obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
+obj-$(CONFIG_OMAP_CONTROL_PHY)		+= phy-omap-control.o
+obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
+obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
+obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
+obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
similarity index 100%
rename from drivers/phy/phy-da8xx-usb.c
rename to drivers/phy/ti/phy-da8xx-usb.c
diff --git a/drivers/phy/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
similarity index 100%
rename from drivers/phy/phy-dm816x-usb.c
rename to drivers/phy/ti/phy-dm816x-usb.c
diff --git a/drivers/phy/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
similarity index 100%
rename from drivers/phy/phy-omap-control.c
rename to drivers/phy/ti/phy-omap-control.c
diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
similarity index 100%
rename from drivers/phy/phy-omap-usb2.c
rename to drivers/phy/ti/phy-omap-usb2.c
diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
similarity index 100%
rename from drivers/phy/phy-ti-pipe3.c
rename to drivers/phy/ti/phy-ti-pipe3.c
diff --git a/drivers/phy/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
similarity index 100%
rename from drivers/phy/phy-tusb1210.c
rename to drivers/phy/ti/phy-tusb1210.c
diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
similarity index 100%
rename from drivers/phy/phy-twl4030-usb.c
rename to drivers/phy/ti/phy-twl4030-usb.c
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
