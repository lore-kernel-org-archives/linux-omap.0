From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap device tree changes for v3.19
Date: Wed, 12 Nov 2014 10:05:11 -0800
Message-ID: <6419.31781215153$1415815585@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55644 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751685AbaKLSGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 13:06:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/dt-part1

for you to fetch changes up to 065bd7fe50de5e6d0fd5034cbc87120a558a1219:

  ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)

----------------------------------------------------------------
Device tree related changes for omaps:

- Fix currently harmless but wrong sizes for various GPMC connected
  devices

- Set up timings for several GPMC connected devices to get rid of
  bootloader dependencies in later patches

- Enable various drivers for dra7xx

- Prepare Igep boards to support new variants

- Add intial support for BeagleBoard-X15

----------------------------------------------------------------
Dmitry Lifshitz (1):
      ARM: dts: sbc-t3x: add DVI display data

Enric Balletbo i Serra (11):
      ARM: dts: omap3-igep00x0: Fix UART2 pins that aren't common.
      ARM: dts: omap3-igep00x0: Move NAND configuration to a common place.
      ARM: dts: omap3-igep0030: Specify IGEP COM revision in device tree.
      ARM: dts: omap3-igep0020: Specify IGEPv2 revision in device tree.
      ARM: dts: omap3-igep00x0: Move outside common file the on board Wifi module.
      ARM: dts: omap3-igep0030-common: Introduce igep0030 common dtsi file.
      ARM: dts: omap3-igep0030-rev-g: Support IGEP COM MODULE Rev. G
      ARM: dts: omap3-igep0020-common: Introduce igep0020 common dtsi file.
      ARM: dts: omap3-igep0020-rev-f: Support IGEPv2 Rev. F
      ARM: dts: omap3-igep00x0: Remove i2c2 node.
      ARM: OMAP2+: igep00x0: Add pdata-quirks for the btwilink device.

Felipe Balbi (1):
      ARM: dts: dra7: add labels to DWC3 nodes

George Cherian (1):
      ARM: dts: dra72-evm: Enable USB support for dra72-evm.

Marek Belisko (1):
      ARM: dts: omap3-gta04: Use omap specific pinctrl defines

Mugunthan V N (3):
      ARM: dts: dra7: Add CPSW and MDIO module nodes for dra7
      ARM: dts: dra7-evm: Enable CPSW and MDIO for dra7xx EVM
      ARM: dts: dra72x-evm: Enable CPSW and MDIO

Nishanth Menon (6):
      ARM: dts: dra72-evm: Provide explicit pinmux for TPS PMIC
      ARM: dts: dra72-evm: Add power button node
      ARM: dts: dra72-evm: Add MMC nodes
      ARM: dts: dra7-evm: Keep all VDD rails always-on
      ARM: dts: Add am57xx-beagle-x15
      ARM: dts: DRA7: Add aliases for all serial ports

Roger Quadros (3):
      ARM: dts: dra72-evm: Add NAND support
      ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi
      ARM: dts: dra72-evm: Add regulator information to USB2 PHYs

Sebastian Andrzej Siewior (2):
      ARM: dts: am33xx: add DMA properties for UART
      ARM: dts: dra7: add DMA properties for UART

Suman Anna (2):
      ARM: dts: DRA7: Add interrupts property to mailbox nodes
      ARM: dts: OMAP2+: Add #mbox-cells property to all mailbox nodes

Tony Lindgren (6):
      ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins
      ARM: dts: Fix wrong GPMC size mappings for omaps
      ARM: dts: Add smc91x GPMC configuration for 2430sdp
      ARM: dts: Add GPMC timings for omap zoom serial port
      ARM: dts: Use better omap GPMC timings for LAN9220
      ARM: dts: Fix missing GPMC NAND device width for omap3 boards

 arch/arm/boot/dts/Makefile                   |   3 +
 arch/arm/boot/dts/am335x-evm.dts             |   4 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi       |   4 +-
 arch/arm/boot/dts/am33xx.dtsi                |   7 +
 arch/arm/boot/dts/am4372.dtsi                |   1 +
 arch/arm/boot/dts/am43x-epos-evm.dts         |   4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts      | 405 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts               | 111 ++++++++
 arch/arm/boot/dts/dra7.dtsi                  | 167 +++++++++--
 arch/arm/boot/dts/dra72-evm.dts              | 296 ++++++++++++++++++++
 arch/arm/boot/dts/dra74x.dtsi                |  22 ++
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi    |  41 +--
 arch/arm/boot/dts/omap-zoom-common.dtsi      |  62 +++-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi  |   4 +-
 arch/arm/boot/dts/omap2420.dtsi              |   1 +
 arch/arm/boot/dts/omap2430-sdp.dts           |  28 +-
 arch/arm/boot/dts/omap2430.dtsi              |   1 +
 arch/arm/boot/dts/omap3-cm-t3517.dts         |  11 +
 arch/arm/boot/dts/omap3-cm-t3530.dts         |  11 +
 arch/arm/boot/dts/omap3-cm-t3730.dts         |  24 ++
 arch/arm/boot/dts/omap3-cm-t3x.dtsi          |  39 +++
 arch/arm/boot/dts/omap3-devkit8000.dts       |   4 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts         |   5 +-
 arch/arm/boot/dts/omap3-gta04.dtsi           |  86 +++---
 arch/arm/boot/dts/omap3-igep.dtsi            | 103 ++++---
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 246 ++++++++++++++++
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts   |  45 +++
 arch/arm/boot/dts/omap3-igep0020.dts         | 285 +++----------------
 arch/arm/boot/dts/omap3-igep0030-common.dtsi |  60 ++++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts   |  67 +++++
 arch/arm/boot/dts/omap3-igep0030.dts         | 123 +++-----
 arch/arm/boot/dts/omap3-ldp.dts              |   3 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi      |   2 +-
 arch/arm/boot/dts/omap3-n900.dts             |  35 ++-
 arch/arm/boot/dts/omap3-n950-n9.dtsi         |   4 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi          |  90 ++++--
 arch/arm/boot/dts/omap3-sbc-t3517.dts        |  14 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts        |  14 +
 arch/arm/boot/dts/omap3-sbc-t3730.dts        |  14 +
 arch/arm/boot/dts/omap3-tao3530.dtsi         |   2 +-
 arch/arm/boot/dts/omap3.dtsi                 |   1 +
 arch/arm/boot/dts/omap3430-sdp.dts           |   8 +-
 arch/arm/boot/dts/omap4.dtsi                 |   1 +
 arch/arm/boot/dts/omap5.dtsi                 |   1 +
 arch/arm/mach-omap2/pdata-quirks.c           |  36 ++-
 45 files changed, 1980 insertions(+), 515 deletions(-)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15.dts
 create mode 100644 arch/arm/boot/dts/omap3-igep0020-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-igep0020-rev-f.dts
 create mode 100644 arch/arm/boot/dts/omap3-igep0030-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-igep0030-rev-g.dts
