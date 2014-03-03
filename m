From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/12] ARM: OMAP: SATA support for OMAP5 & DRA7
Date: Mon, 3 Mar 2014 17:07:22 +0200
Message-ID: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds SATA support for OMAP5 uevm and DRA7-evm boards.

- Cleans up the ti-pipe3 PHY driver
- Adds SATA DPLL support to ti-pipe3 PHY driver
- Adds SATA nodes to hwmod and SoC DT data

Patches are based on [1].
To test SATA you will also need [2].

[1] - http://article.gmane.org/gmane.linux.kernel/1658825
[2] - http://article.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7285

cheers,
-roger

---
Balaji T K (2):
  ARM: dts: omap5: add sata node
  ARM: dts: dra7: add OCP2SCP3 and SATA nodes

Keshava Munegowda (1):
  ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods

Kishon Vijay Abraham I (1):
  phy: rename struct omap_control_usb to struct omap_control_phy

Nikhil Devshatwar (1):
  ARM: DRA7: hwmod: Add ocp2scp3 and sata hwmods

Roger Quadros (7):
  phy: omap-control: Update DT binding information
  phy: ti-pipe3: cleanup clock handling
  ARM: dts: omap5: Add clocks to usb3_phy node
  phy: ti-pipe3: Add SATA DPLL support
  phy: omap: Select OMAP_OCP2SCP bus driver
  phy: ti-pipe3: streamline PHY operations
  phy: ti-pipe3: Fix suspend/resume and module reload

 Documentation/devicetree/bindings/phy/ti-phy.txt   |  28 +-
 Documentation/devicetree/bindings/usb/omap-usb.txt |  24 --
 arch/arm/boot/dts/dra7.dtsi                        |  39 +++
 arch/arm/boot/dts/omap5.dtsi                       |  42 +++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  73 +++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  41 ++-
 drivers/phy/Kconfig                                |  16 +-
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-omap-control.c                     | 320 +++++++++++++++++++++
 drivers/phy/phy-omap-usb2.c                        |   8 +-
 drivers/phy/phy-ti-pipe3.c                         | 257 ++++++++++-------
 drivers/usb/musb/omap2430.c                        |   2 +-
 drivers/usb/phy/Kconfig                            |  10 -
 drivers/usb/phy/Makefile                           |   1 -
 drivers/usb/phy/phy-omap-control.c                 | 319 --------------------
 include/linux/phy/omap_control_phy.h               |  89 ++++++
 include/linux/usb/omap_control_usb.h               |  89 ------
 17 files changed, 798 insertions(+), 561 deletions(-)
 create mode 100644 drivers/phy/phy-omap-control.c
 delete mode 100644 drivers/usb/phy/phy-omap-control.c
 create mode 100644 include/linux/phy/omap_control_phy.h
 delete mode 100644 include/linux/usb/omap_control_usb.h

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
