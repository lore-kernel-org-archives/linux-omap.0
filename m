From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND on non-OMAP platforms
Date: Thu, 7 Apr 2016 13:08:18 +0300
Message-ID: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com, boris.brezillon@free-electrons.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

As this series has cross dependency between omap and mtd subsystems,
I'll set up a immutable branch which omap-soc and l2-mtd must
merge in together to avoid any conflicts/breakage during integration.

Brian has acked all mtd patches. Tony needs to give his Ack for the
gpmc driver part and then I can provide the immutable branch.

Patches based on v4.6-rc1 and tested on:
dra-evm, am437x-gp-evm, beagleboard-c4, beagleboard-c4-legacyboot.

Summary:

We do a couple of things in this series which result in
cleaner device tree implementation, faster perfomance and
multi-platform support. As an added bonus we get to use the GPMC_WAIT
pins as GPI/Interrupts.

- Establish a custom interface between NAND and GPMC driver. This is
needed because all of the NAND registers sit in the GPMC register space.

- Clean up device tree support so that omap-gpmc IP and the omap2 NAND
driver can be used on non-OMAP platforms. e.g. Keystone.

- Implement GPIOCHIP for the GPMC WAITPINS. SoCs can contain
2 to 4 of these and most of them would be unused otherwise. It also
allows a cleaner implementation of NAND Ready pin status for the NAND driver.

- Implement GPMC IRQ domain to proivde the 2 NAND events and
GPMC WAITPIN edge interrupts.

- Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
On dra7-evm, Read speed increases from 13768 KiB/ to 17246 KiB/s.
Write speed was unchanged at 7123 KiB/s.

Changelog:
v6:
-addressed review comments.
-re-orderd patches so that functionality isn't broken at any point.
-rebased to v4.6-rc1.

v5:
-changed ready/busy# GPIO DT binding from "ready-gpio" to "rb-gpios".
-use irqdomain for gpmc NAND interrupts: fifoevent and termcount.

v4:
-Warn if using older incompatible DT i.e. compatible property not present
in nand node.
-Applied Tony's patch to fix broken ethernet on torpedo.

v3:
-Fixed and tested NAND using legacy boot on omap3-beagle.
-Support rising and falling edge interrupts on WAITpins.
-Update DT node of all gpmc users.

--
cheers,
-roger

Roger Quadros (17):
  ARM: OMAP2+: gpmc: Add platform data
  ARM: OMAP2+: gpmc: Add gpmc timings and settings to platform data
  memory: omap-gpmc: Introduce GPMC to NAND interface
  memory: omap-gpmc: Add GPMC-NAND ops to get writebufferempty status
  memory: omap-gpmc: Implement IRQ domain for NAND IRQs
  mtd: nand: omap: Use gpmc_omap_get_nand_ops() to get NAND registers
  mtd: nand: omap: Switch to using GPMC-NAND ops for writebuffer empty
    check
  mtd: nand: omap: Copy platform data parameters to omap_nand_info data
  mtd: nand: omap: Clean up device tree support
  mtd: nand: omap: Update DT binding documentation
  memory: omap-gpmc: Prevent mapping into 1st 16MB
  memory: omap-gpmc: Move device tree binding to correct location
  memory: omap-gpmc: Support general purpose input for WAITPINs
  memory: omap-gpmc: Reserve WAITPIN if needed for WAIT monitoring
  memory: omap-gpmc: Support WAIT pin edge interrupts
  memory: omap-gpmc: Prevent GPMC_STATUS from being accessed via
    gpmc_regs
  mtd: nand: omap2: Implement NAND ready using gpiolib

 .../omap-gpmc.txt}                                 |  17 +
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  19 +-
 arch/arm/mach-omap2/gpmc-nand.c                    |   7 +-
 drivers/memory/Kconfig                             |   1 +
 drivers/memory/omap-gpmc.c                         | 655 +++++++++++++--------
 drivers/mtd/nand/omap2.c                           | 194 ++++--
 include/linux/omap-gpmc.h                          | 172 +-----
 .../{omap-gpmc.h => platform_data/gpmc-omap.h}     | 101 ++--
 include/linux/platform_data/mtd-nand-omap2.h       |  12 +-
 9 files changed, 679 insertions(+), 499 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/omap-gpmc.txt} (89%)
 copy include/linux/{omap-gpmc.h => platform_data/gpmc-omap.h} (71%)

-- 
2.5.0
