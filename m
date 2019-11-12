From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 00/10] ARM: dts: dra7: add cal nodes
Date: Tue, 12 Nov 2019 08:27:43 -0600
Message-ID: <20191112142753.22976-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds the needed clkctrl and ty-sysc nodes for CAL module.
It also adds support for the module in related dtsi and dts for DRA72,
DRA76 and AM654 SoC.

Changes since v2:
- Add non-standard clock node naming to commit message as per Tony's
  comment

Changes since v1:
- Fix clock name to make it generic
- Updated the binding to use ti,camerrx-control instead of sycon_camerrx
- Split off the clk code into its own patch
- Add clk mailing list as requested

Benoit Parrot (10):
  clk: ti: dra7: add cam clkctrl data
  ARM: dts: dra7: add cam clkctrl node
  ARM: OMAP: DRA7xx: Make CAM clock domain SWSUP only
  ARM: dts: dra7-l4: Add ti-sysc node for CAM
  ARM: dts: DRA72: Add CAL dtsi node
  arm: dts: dra72-evm-common: Add entries for the CSI2 cameras
  arm: dtsi: dra76x: Add CAL dtsi node
  arm: dts: dra76-evm: Add CAL and OV5640 nodes
  arm64: dts: k3-am65-main Add CAL node
  arm64: dts: k3-am654-base-board: Add CSI2 OV5640 camera

 arch/arm/boot/dts/dra7-l4.dtsi                | 43 ++++++++++++++++---
 arch/arm/boot/dts/dra72-evm-common.dtsi       | 35 +++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi                 | 43 +++++++++++++++++++
 arch/arm/boot/dts/dra76-evm.dts               | 39 +++++++++++++++++
 arch/arm/boot/dts/dra76x.dtsi                 | 43 +++++++++++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi          | 14 ++++++
 arch/arm/mach-omap2/clockdomains7xx_data.c    |  2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 23 ++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 36 ++++++++++++++++
 drivers/clk/ti/clk-7xx.c                      | 19 ++++++++
 include/dt-bindings/clock/dra7.h              | 10 +++++
 11 files changed, 300 insertions(+), 7 deletions(-)

-- 
2.17.1
