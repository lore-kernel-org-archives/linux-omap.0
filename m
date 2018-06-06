From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v3 0/6] Add MCAN Support for dra76x
Date: Wed, 6 Jun 2018 11:38:20 +0530
Message-ID: <20180606060826.14671-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, faiz_abbas@ti.com, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

The following patches add dts and sysconfig support
for MCAN on TI's dra76 SOCs

The patches depend on the following series:
https://patchwork.kernel.org/patch/10221105/

Changes in v3:
 1. Added reset functionality to the ti-sysc
    driver. This enables me to drop the hwmod
    data patch as everything is being done in dt.

 2. Dropped ti,hwmods from the dts nodes

 3. Fixed the unit address of target-module
    and mcan

 4. Removed the status="disabled" in dtsi
    followed by status="okay" in dts.

Changes in v2:
 1. Added Support for mcan in the ti-sysc driver
    Also added the target-module node for the same

 2. Added clkctrl data for mcan clocks

Faiz Abbas (4):
  clk: ti: dra7: Add clkctrl clock data for the mcan clocks
  bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
  bus: ti-sysc: Add support for software reset
  ARM: dts: Add generic interconnect target module node for MCAN

Franklin S Cooper Jr (1):
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (1):
  ARM: dts: dra762: Add MCAN clock support

 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 arch/arm/boot/dts/dra76-evm.dts               |  6 ++
 arch/arm/boot/dts/dra76x.dtsi                 | 65 +++++++++++++++++++
 drivers/bus/ti-sysc.c                         | 58 +++++++++++++++++
 drivers/clk/ti/clk-7xx.c                      |  1 +
 include/dt-bindings/bus/ti-sysc.h             |  2 +
 include/dt-bindings/clock/dra7.h              |  1 +
 include/linux/platform_data/ti-sysc.h         |  1 +
 8 files changed, 135 insertions(+)

-- 
2.17.0
