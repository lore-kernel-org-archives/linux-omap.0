From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/3] phy: ti-pipe3: dra7: sata: allow suspend to RAM
Date: Tue, 12 May 2015 19:07:05 +0300
Message-ID: <1431446828-5473-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

We fix 2 things here to ensure that PHY clocks are disabled during
system suspend.

1) Stop relying on pm_runtime ops to disable our clocks as they don't
fit in well with the PHY framework usage scenario. This ensures that all clocks are
disabled when phy_exit() is called.

2) Implement workaround for SATA errata i783 (SATA Lockup After SATA DPLL Unlock/Relock)
so that we can now turn off sata_refclk to support suspend-to-ram.

cheers,
-roger

Roger Quadros (3):
  phy: ti-pipe3: fix suspend
  phy: ti-pipe3: i783 workaround for SATA lockup after dpll
    unlock/relock
  ARM: dts: dra7: Add syscon-pllreset syscon to SATA PHY

 Documentation/devicetree/bindings/phy/ti-phy.txt |  16 +++
 arch/arm/boot/dts/dra7.dtsi                      |   1 +
 drivers/phy/phy-ti-pipe3.c                       | 173 ++++++++++-------------
 3 files changed, 90 insertions(+), 100 deletions(-)

-- 
2.1.4
