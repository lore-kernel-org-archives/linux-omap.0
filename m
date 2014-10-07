From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/4] usb: dwc3/phy-exynos5-usbdrd: Extend support to Exynos7
Date: Tue,  7 Oct 2014 15:49:32 +0530
Message-ID: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding required support for clocks and additional VBUS regulators
to enable USB 3.0 support on Exynos7 SoC.

This series depends for ACRH_EXYNOS7 support on following series:
[PATCH v5 0/8] arch: arm64: Enable support for Samsung Exynos7 SoC
http://www.spinics.net/lists/linux-samsung-soc/msg37047.html

The series is based on usb-next branch.

Changes since v1:
 -- Addressed review comments for unnecessary warning messages after
    clk_get() fails for dwc3-exynos and phy-exynos5-usbdrd.
 -- Assigned "exynos->sclk" as well as "phy_drd->utmiclk" and
    "phy_drd->pipeclk" to NULL in case of clk_get() failure to avoid
    unnecessary check for clock.
 -- Modified dependency for symbol PHY_EXYNOS5_USBDRD to depend on
    ARCH_EXYNOS which includes both Exynos5 as well as Exynos7.
 -- Dropped [PATCH 4/5] usb: dwc3: Adding Kconfig dependency for Exynos7
    from v1 of this series, since its not required now.

Vivek Gautam (4):
  dwc3: exynos: Add support for SCLK present on Exynos7
  phy: exynos5-usbdrd: Add pipe-clk and utmi-clk support
  phy: exynos5-usbdrd: Add facility for VBUS-BOOST-5V supply
  phy: exynos7-usbdrd: Update dependency for ARCH_EXYNOS

 .../devicetree/bindings/phy/samsung-phy.txt        |    4 ++
 drivers/phy/Kconfig                                |    2 +-
 drivers/phy/phy-exynos5-usbdrd.c                   |   52 +++++++++++++++++++-
 drivers/usb/dwc3/dwc3-exynos.c                     |   16 ++++++
 4 files changed, 71 insertions(+), 3 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
