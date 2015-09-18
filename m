From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND on non-OMAP platforms
Date: Fri, 18 Sep 2015 17:53:22 +0300
Message-ID: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

We do a couple of things in this series which result in
cleaner device tree implementation, faster perfomance and
multi-platform support. As an added bonus we get new GPI/Interrupt pins
for use in the system.

- Establish a custom interface between NAND and GPMC driver. This is
needed because all of the NAND registers sit in the GPMC register space.
Some bits like NAND IRQ are even shared with GPMC.

- Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
This causes performance increase when using prefetch-irq mode.
30% increase in read, 17% increase in write in prefetch-irq mode.

- Clean up device tree support so that omap-gpmc IP and the omap2 NAND
driver can be used on non-OMAP platforms. e.g. Keystone.

- Implement GPIOCHIP + IRQCHIP for the GPMC WAITPINS. SoCs can contain
2 to 4 of these and most of them would be unused otherwise. It also
allows a cleaner implementation of NAND Ready pin status for the NAND driver.

- Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.

This series is available at
git@github.com:rogerq/linux.git
in branch
for-v4.4/gpmc-v3

cheers,
-roger

Changelog:
v3:
-Fixed and tested NAND using legacy boot on omap3-beagle.
-Support rising and falling edge interrupts on WAITpins.
-Update DT node of all gpmc users.

Roger Quadros (27):
  ARM: OMAP2+: gpmc: Add platform data
  ARM: OMAP2+: gpmc: Add gpmc timings and settings to platform data
  memory: omap-gpmc: Introduce GPMC to NAND interface
  mtd: nand: omap2: Use gpmc_omap_get_nand_ops() to get NAND registers
  memory: omap-gpmc: Add GPMC-NAND ops to get writebufferempty status
  mtd: nand: omap2: Switch to using GPMC-NAND ops for writebuffer empty
    check
  memory: omap-gpmc: Remove NAND IRQ code
  memory: omap-gpmc: Add IRQ ops for GPMC-NAND interface
  mtd: nand: omap2: manage NAND interrupts
  mtd: nand: omap: Copy platform data parameters to omap_nand_info data
  mtd: nand: omap: Clean up device tree support
  mtd: nand: omap: Update DT binding documentation
  memory: omap-gpmc: Prevent mapping into 1st 16MB
  memory: omap-gpmc: Move device tree binding to correct location
  memory: omap-gpmc: Support general purpose input for WAITPINs
  memory: omap-gpmc: Reserve WAITPIN if needed for WAIT monitoring
  memory: omap-gpmc: Add irqchip support to the gpiochip
  mtd: nand: omap2: Implement NAND ready using gpiolib
  memory: omap-gpmc: Prevent GPMC_STATUS from being accessed via
    gpmc_regs
  ARM: dts: dra7: Fix NAND device nodes.
  ARM: dts: dra7x-evm: Provide NAND ready pin
  ARM: dts: am437x: Fix NAND device nodes
  ARM: dts: am437x-gp-evm: Provide NAND ready pin
  ARM: dts: am335x: Fix NAND device nodes
  ARM: dts: am335x: Provide NAND ready pin
  ARM: dts: dm816x: Fix gpmc and NAND node
  ARM: dts: omap3: Fix gpmc and NAND nodes

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  | 130 -----
 .../bindings/memory-controllers/omap-gpmc.txt      | 130 +++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi             |   7 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   7 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   7 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   4 +
 arch/arm/boot/dts/am4372.dtsi                      |   4 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |   8 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   8 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |   7 +-
 arch/arm/boot/dts/dm816x.dtsi                      |   4 +
 arch/arm/boot/dts/dra7-evm.dts                     |   6 +-
 arch/arm/boot/dts/dra7.dtsi                        |   4 +
 arch/arm/boot/dts/dra72-evm.dts                    |   6 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   7 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   2 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   5 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   3 +
 arch/arm/boot/dts/omap3-evm-37xx.dts               |   7 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   3 +
 arch/arm/boot/dts/omap3-igep.dtsi                  |   5 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |   4 +-
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |   4 +
 arch/arm/boot/dts/omap3-ldp.dts                    |   9 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   5 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   3 +
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   5 +-
 arch/arm/boot/dts/omap3.dtsi                       |   4 +
 arch/arm/boot/dts/omap3430-sdp.dts                 |   5 +-
 arch/arm/mach-omap2/gpmc-nand.c                    |  11 +-
 drivers/memory/omap-gpmc.c                         | 640 ++++++++++++---------
 drivers/mtd/nand/omap2.c                           | 261 ++++++---
 include/linux/omap-gpmc.h                          | 183 ++----
 include/linux/platform_data/gpmc-omap.h            | 167 ++++++
 include/linux/platform_data/mtd-nand-omap2.h       |  12 +-
 36 files changed, 1045 insertions(+), 648 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
 create mode 100644 include/linux/platform_data/gpmc-omap.h

-- 
2.1.4
