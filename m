From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/7] phy: use syscon framework APIs to set ctrl mod reg
Date: Tue, 4 Aug 2015 20:50:39 +0530
Message-ID: <1438701646-7876-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
Cc: balbi@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This series is split from [1] to include only the PHY patches.

This series is basically to deprecate using phy-omap-control and use
syscon APIs to program the control module registers.

Changes from [1] in PHY patches include
*) cleanup ti_pipe3_probe
*) have mask, power_on and power_off values in usb_phy_data for
   omap-usb2 phy

Did basic enumeration testing in the below platforms.
*) Tested PCIe, SATA and USB in dra7
*) Tested SATA and USB in omap5
*) Tested USB(dwc3) in am43xx_evm
*) Tested USB(musb) in omap4 panda after including [2]

All the testing was done both before applying the dt patches and after
applying the dt patches (dt patches will be posted shortly).

[1] -> https://lkml.org/lkml/2015/6/23/189
[2] -> http://permalink.gmane.org/gmane.linux.kernel/2012427

Kishon Vijay Abraham I (7):
  phy: ti-pipe3: cleanup ti_pipe3_probe()
  phy: ti-pipe3: use ti_pipe3_power_off to power off the PHY during
    probe
  phy: ti-pipe3: use *syscon* framework API to power on/off the PHY
  phy: ti-pipe3: use *syscon* framework API to set PCS value of the PHY
  phy: omap-usb2: use omap_usb_power_off to power off the PHY during
    probe
  phy: omap-usb2: Add a new compatible string for USB2 PHY2
  phy: omap-usb2: use *syscon* framework API to power on/off the PHY

 Documentation/devicetree/bindings/phy/ti-phy.txt |   20 +-
 drivers/phy/phy-omap-usb2.c                      |   96 ++++++--
 drivers/phy/phy-ti-pipe3.c                       |  283 ++++++++++++++++------
 include/linux/phy/omap_usb.h                     |   23 ++
 4 files changed, 329 insertions(+), 93 deletions(-)

-- 
1.7.9.5
