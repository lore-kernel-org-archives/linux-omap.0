From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 00/22] memory: omap-gpmc: mtd: nand: Support GPMC NAND on non-OMAP platforms
Date: Fri, 7 Aug 2015 12:12:10 +0300
Message-ID: <1438938752-31010-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
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

NOTE: I've only adapted dra7.dtsi and dra7x-evms for this series.
I will adapt all other boards when the series is in a shape to be accepted.

cheers,
-roger

This is done in patches 1 to 14

Roger Quadros (22):
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
  ARM: dts: OMAP2+: Fix NAND device nodes.
  memory: omap-gpmc: Move device tree binding to correct location
  memory: omap-gpmc: Support general purpose input for WAITPINs
  memory: omap-gpmc: Reserve WAITPIN if needed for WAIT monitoring
  memory: omap-gpmc: Add irqchip support to the gpiochip
  ARM: dts: dra7: Enable gpio & interrupt controller for gpmc node
  mtd: nand: omap2: Implement NAND ready using gpiolib
  ARM: dts: dra7x-evm: Provide NAND ready pin
  memory: omap-gpmc: Prevent GPMC_STATUS from being accessed via
    gpmc_regs

 .../omap-gpmc.txt}                                 |   0
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   6 +-
 arch/arm/boot/dts/dra7.dtsi                        |   4 +
 arch/arm/boot/dts/dra72-evm.dts                    |   2 +
 arch/arm/boot/dts/omap3-beagle.dts                 |   3 +-
 arch/arm/mach-omap2/gpmc-nand.c                    |  11 +-
 drivers/memory/omap-gpmc.c                         | 610 ++++++++++++---------
 drivers/mtd/nand/omap2.c                           | 261 ++++++---
 include/linux/omap-gpmc.h                          | 172 ++----
 include/linux/platform_data/gpmc-omap.h            | 169 ++++++
 include/linux/platform_data/mtd-nand-omap2.h       |  12 +-
 12 files changed, 782 insertions(+), 484 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/omap-gpmc.txt} (100%)
 create mode 100644 include/linux/platform_data/gpmc-omap.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
