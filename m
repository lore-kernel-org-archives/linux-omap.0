From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v3 0/2] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Tue, 21 Oct 2014 15:30:59 +0530
Message-ID: <1413885661-4850-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

Adding device tree entry for CPSW to make it work in Dual EMAC mode.
These patches were tested with DRA7 hwmod patches on top of linux-next.
Patches are tested on top of Nishanth's PM tree for v3.17 [1] and pushed
my tree to [2].

Did a boot test with CPSW and ping test with suspend/resume, the boot logs
on DRA7xx EVM are posted at [3]

[1] git://github.com/nmenon/linux-2.6-playground.git testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
[2] git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git v3.17/dra7-evm-cpsw-v3
[3] http://pastebin.ubuntu.com/8613072/

Changes from v2:
* Changed pinctrl comments to hold mode0-name.mode-selected-name
* Changes slave numbers in the pinctrl comments
* Added cpsw and cpts clocks

Changes from initial version:
* Dropped patch for pinoff states
* Changed pinoff state to mode15

Mugunthan V N (2):
  ARM: dts: dra7: Add CPSW and MDIO module nodes for dra7
  ARM: dts: dra7-evm: Enable CPSW and MDIO for dra7xx EVM

 arch/arm/boot/dts/dra7-evm.dts | 106 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi    |  61 ++++++++++++++++++++++++
 2 files changed, 167 insertions(+)

-- 
2.1.2.484.g13da0fc
