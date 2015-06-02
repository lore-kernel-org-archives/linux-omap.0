From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] phy: ti-pipe3: dra7: sata: allow suspend to RAM (core-retention)
Date: Tue, 2 Jun 2015 12:10:39 +0300
Message-ID: <1433236242-26172-1-git-send-email-rogerq@ti.com>
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
so that we can now turn off sata_refclk to support suspend-to-ram without preventing
core-retention.

Changelog:
v2:
- Fixed pcie disable_clocks. Addressed review comments.

cheers,
-roger

Roger Quadros (3):
  phy: ti-pipe3: fix suspend
  phy: ti-pipe3: i783 workaround for SATA lockup after dpll
    unlock/relock
  ARM: dts: dra7: Add syscon-pllreset syscon to SATA PHY

 Documentation/devicetree/bindings/phy/ti-phy.txt |  16 ++
 arch/arm/boot/dts/dra7.dtsi                      |   1 +
 drivers/phy/phy-ti-pipe3.c                       | 217 +++++++++--------------
 3 files changed, 105 insertions(+), 129 deletions(-)

-- 
2.1.4
