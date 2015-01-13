From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/4] phy: ti-pipe3: fixes for 3.19-rc
Date: Tue, 13 Jan 2015 14:23:18 +0200
Message-ID: <1421151802-7396-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, george.cherian@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

During system suspend L3INIT_960M_GFCLK and L3INIT_480M_GFCLK clocks remain
active on the DRA7 platform. This is because the pipe3 driver doesn't shut
them off as part of .suspend(). Patch 1 addresses this issue.

SATA on both OMAP5 and DRA7 breaks when SATA drive is plugged in after a
system suspend/resume or if AHCI_PLATFORM driver is used as module.
Patches 2,3,4 fix it.

Hope to get these patches in through the 3.19-rc cycle.

Tony,

Do you wish to take the DTS patches or let them go in through PHY tree?

cheers,
-roger

---
Changelog
- v3 : Commit message updated. dts changes moved to separate patch.
- v2 : Don't break SATA with old DTB.

Roger Quadros (4):
  phy: ti-pipe3: Disable clocks on system suspend
  phy: ti-pipe3: Fix SATA across suspend/resume
  ARM: dts: DRA7: Fix SATA PHY node
  ARM: dts: OMAP5: Fix SATA PHY node

 arch/arm/boot/dts/dra7.dtsi  |   4 +-
 arch/arm/boot/dts/omap5.dtsi |   4 +-
 drivers/phy/phy-ti-pipe3.c   | 142 +++++++++++++++++++++++++++++++++----------
 3 files changed, 115 insertions(+), 35 deletions(-)

-- 
2.1.0
