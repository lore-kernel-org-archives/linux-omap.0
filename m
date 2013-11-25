From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 00/10] Make dwc3 use Generic PHY Framework
Date: Mon, 25 Nov 2013 15:31:20 +0530
Message-ID: <1385373690-12170-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Modified dwc3 core to find PHYs only if the platform indicates that it has 
to use a PHY (using quirks). Adapted DWC3 and USB3 PHY to use Generic PHY
framework. Also  changed the name of USB3 PHY driver to PIPE3 PHY driver
since the same driver has to be used for SATA and PCIE too.

Changes from v2:
* added a couple of fixes. One is invoking phy_resume after phy_init and the
other is power off phy in error patch
* used quirks to identify if a particular platform does not have PHYs
* removed using separate header for pipe3 driver and also removed all referencs
to SATA and PCIe in pipe3 driver since it's not yet adapted for those drivers.

Changes from v1:
* The logic in which the driver detects the presence of PHYs has changed.
* patch ordering has changed
* udelay is replaced with usleep_range
* A patch to remove set_suspend callback which was deferred from Generic
PHY Framework series has been included.

Kishon Vijay Abraham I (10):
  usb: dwc3: invoke phy_resume after phy_init
  usb: dwc3: power off usb phy in error path
  usb: dwc3: preparation for adapting dwc3 to generic phy framework
  usb: dwc3: use quirks to know if a particualr platform doesn't have
    PHY
  usb: dwc3: adapt dwc3 core to use Generic PHY Framework
  Documentation: dt bindings: move ..usb/usb-phy.txt to
    ..phy/ti-phy.txt
  drivers: phy: usb3/pipe3: Adapt pipe3 driver to Generic PHY Framework
  usb: phy: omap-usb2: remove *set_suspend* callback from omap-usb2
  phy: omap-usb2: move omap_usb.h from linux/usb/ to linux/phy/
  arm/dts: added dt properties to adapt to the new phy framwork

 .../bindings/{usb/usb-phy.txt => phy/ti-phy.txt}   |    8 +-
 Documentation/devicetree/bindings/usb/dwc3.txt     |    6 +-
 arch/arm/boot/dts/omap5.dtsi                       |    4 +
 drivers/phy/Kconfig                                |   11 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-omap-usb2.c                        |   27 +--
 .../phy/phy-omap-usb3.c => phy/phy-ti-pipe3.c}     |  232 ++++++++++++--------
 drivers/usb/dwc3/Kconfig                           |    2 +
 drivers/usb/dwc3/core.c                            |  189 +++++++++++-----
 drivers/usb/dwc3/core.h                            |   22 ++
 drivers/usb/dwc3/platform_data.h                   |    5 +
 drivers/usb/phy/Kconfig                            |   11 -
 drivers/usb/phy/Makefile                           |    1 -
 include/linux/{usb => phy}/omap_usb.h              |    3 -
 14 files changed, 320 insertions(+), 202 deletions(-)
 rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/ti-phy.txt} (88%)
 rename drivers/{usb/phy/phy-omap-usb3.c => phy/phy-ti-pipe3.c} (55%)
 rename include/linux/{usb => phy}/omap_usb.h (95%)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
