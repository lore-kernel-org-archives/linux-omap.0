From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/6] omap: phy: dra7-evm PHY fixes for 3.16
Date: Fri, 4 Jul 2014 12:55:42 +0300
Message-ID: <1404467748-12154-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, kishon@ti.com, balbi@ti.com
Cc: nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On DRA7-evm, the VDDA_1V8_PHY supply must be always-on for proper functioning
of the PHYs on the SoC.

The 3.3V USB supply (ldousb_reg) can be turned OFF when the High Speed USB PHYs
are not in use. We add regulator support in the PHY framework core to manage
the PHY's regulator during PHY power on/off.

Finally we add the 3.3V regulator information to the USB2 PHYs.

This series should get the USB and SATA working again on 3.16 on DRA7-evm.

cheers,
-roger

Changelog:

v2:
- removed if (!NULL) check around regulator_put()
- added more technical information in commit message about 1V8_PHY power line
- added pm_runtime_disable in omap_usb2_remove()

---
Roger Quadros (6):
  ARM: dts: dra7-evm: Make VDDA_1V8_PHY supply always on
  phy: core: Fix error path in phy_create()
  phy: core: Support regulator supply for PHY power
  phy: core: Add phy-supply to DT binding documentation
  phy: omap-usb2: Balance pm_runtime_enable() on probe failure and
    remove
  ARM: dts: dra7-evm: Add regulator information to USB2 PHYs

 .../devicetree/bindings/phy/phy-bindings.txt       |  4 +++
 arch/arm/boot/dts/dra7-evm.dts                     |  9 ++++++
 drivers/phy/phy-core.c                             | 33 ++++++++++++++++++++--
 drivers/phy/phy-omap-usb2.c                        |  7 +++--
 include/linux/phy/phy.h                            |  2 ++
 5 files changed, 50 insertions(+), 5 deletions(-)

-- 
1.8.3.2
