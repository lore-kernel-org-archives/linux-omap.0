From: Benoit Cousson <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.10
Date: Tue, 9 Apr 2013 00:46:13 +0200
Message-ID: <516348B5.3060400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53696 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762266Ab3DHWqU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 18:46:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Please pull the following commits for OMAP Device Tree for v3.10.

Note that the branch is based on two other branches:

- omap-devel-b-for-3.10 from Paul to get the AM33xx missing hwmod and thus avoid a regression with Santosh's hwmod cleanup including in this DT series [1]. It avoids breaking bisect if this series is merged before Paul's fixes.

- omap-for-v3.10/usb branch to avoid nasty merge conflict in omap3.dtsi and omap4.dtsi due to the DTS patches contains in the USB branch.

Regards,
Benoit

[1] https://patchwork.kernel.org/patch/2366291/

---

The following changes since commit 5852264f9d6139751796853fdfca9d5230cbfb97:
  Benoit Cousson (1):
        Merge tag 'omap-devel-b-for-3.10' of git://git.kernel.org/.../pjw/omap-pending into for_3.10/dts_merged

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.10/dts

Anil Kumar (3):
      ARM: dts: Add minimal DT support for DevKit8000
      ARM: dts: omap3-devkit8000: Enable audio support
      ARM: dts: omap3-devkit8000: Add NAND DT node

AnilKumar Ch (3):
      ARM: dts: AM33XX: Rename I2C and GPIO nodes
      ARM: dts: AM33XX: Add d_can instances to aliases
      ARM: dts: AM33XX: Add memory resource to d_can node

Felipe Balbi (1):
      ARM: dts: OMAP5: Add SPI nodes

Florian Vaussard (3):
      ARM: dts: omap3-overo: Add support for pwm-leds
      ARM: dts: omap3-overo: Add audio support
      ARM: dts: OMAP3: Add GPMC controller

Javier Martinez Canillas (5):
      ARM: dts: omap3: Add generic DT support for IGEP devices
      ARM: dts: omap3: Add support for IGEPv2 board
      ARM: dts: omap3: Add support for IGEP COM Module
      ARM: dts: OMAP3: reduce GPMC mapped registers address space
      Documentation: dt: gpio-omap: Move interrupt-controller from #interrupt-cells description

Jon Hunter (16):
      ARM: OMAP2+: Prepare for device-tree PMU support
      ARM: dts: OMAP2+: Add PMU nodes
      ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
      ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
      ARM: dts: Add OMAP2 gpio bindings
      ARM: dts: OMAP3+: Correct gpio #interrupts-cells property
      ARM: dts: OMAP3: Add reg and interrupt properties for gpio
      ARM: dts: OMAP3: Add support for OMAP3430 SDP board
      ARM: OMAP: Force dmtimer restore if context loss is not detectable
      ARM: OMAP: Add function to request timer by node
      ARM: dts: OMAP2+: Update DMTIMER compatibility property
      ARM: OMAP2+: Populate DMTIMER errata when using device-tree
      ARM: dts: OMAP2+: Identify GPIO banks that are always powered
      ARM: dts: Update OMAP3430 SDP NAND and ONENAND properties
      ARM: dts: Add NOR flash bindings for OMAP2420 H4
      ARM: dts: Add OMAP3430 SDP NOR flash memory binding

Kishon Vijay Abraham I (7):
      ARM: dts: OMAP4: Add omap control usb data
      ARM: dts: OMAP4: Add omap-usb2 data
      ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards
      ARM: dts: OMAP5: Add OMAP control usb data
      ARM: dts: OMAP5: Add ocp2scp data
      ARM: dts: OMAP5: Add omap-usb3 and omap-usb2 data
      ARM: dts: OMAP5: add dwc3 omap and dwc3 core data

Lokesh Vutla (1):
      ARM: dts: OMAP5: Add watchdog timer node

Matthias Brugger (1):
      ARM: dts: omap3-igep: Add uart1 and uart2 to igep boards

NeilBrown (1):
      ARM: OMAP: Simplify dmtimer context-loss handling

Nishanth Menon (6):
      ARM: dts: OMAP34xx/35xx: Add CPU OPP table
      ARM: dts: OMAP36xx: Add CPU OPP table
      ARM: dts: OMAP3: use twl4030 vdd1 regulator for CPU
      ARM: dts: OMAP443x: Add CPU OPP table
      ARM: dts: omap4-panda: move generic sections to panda-common
      ARM: dts: OMAP4460: Add CPU OPP table

Peter Ujfalusi (5):
      ARM: dts: twl4030: Add PWM support
      ARM: dts: twl6030: Add PWM support
      ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
      ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging LED)
      ARM: dts: omap4-sdp: Add support for pwm-backlight

Philip Avinash (1):
      ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node

Rajendra Nayak (1):
      ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer

Santosh Shilimkar (9):
      ARM: dts: omap5-evm: Update available memory to 2032 MB
      ARM: dts: OMAP5: Align the local timer dt node as per the current binding code
      ARM: dts: OMAP5: Move the gic node out of ocp space
      ARM: dts: OMAP5: Update the timer and GIC nodes for HYP kernel support
      ARM: dts: OMAP5: Update keypad reg property
      Documentation: dt: OMAP: l3-noc: Add *reg* in required properties
      ARM: dts: OMAP4/5: Update l3-noc DT nodes
      ARM: OMAP2+: hwmod: extract module address space from DT blob
      ARM: OMAP2+: hwmod: Don't call _init_mpu_rt_base if no sysc

Sebastien Guiriec (1):
      ARM: dts: OMAP2+: Add SDMA Audio IPs bindings

Sourav Poddar (4):
      ARM: dts: omap4-sdp: Add I2c pinctrl data
      ARM: dts: omap5-evm: Add I2c pinctrl data
      ARM: dts: omap4-panda: Add I2c pinctrl data
      ARM: dts: omap5-evm: Add mcspi data

 .../devicetree/bindings/arm/omap/l3-noc.txt        |    1 +
 .../devicetree/bindings/arm/omap/timer.txt         |   17 ++-
 .../devicetree/bindings/gpio/gpio-omap.txt         |    8 +-
 Documentation/devicetree/bindings/usb/omap-usb.txt |    1 +
 arch/arm/boot/dts/Makefile                         |    4 +
 arch/arm/boot/dts/am335x-bone.dts                  |   10 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   18 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   18 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   40 ++--
 arch/arm/boot/dts/am3517-evm.dts                   |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |    2 +-
 arch/arm/boot/dts/omap2.dtsi                       |   39 +++-
 arch/arm/boot/dts/omap2420-h4.dts                  |   46 ++++
 arch/arm/boot/dts/omap2420.dtsi                    |   67 +++++-
 arch/arm/boot/dts/omap2430.dtsi                    |   87 +++++++-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   26 ++-
 arch/arm/boot/dts/omap3-beagle.dts                 |    8 +-
 arch/arm/boot/dts/omap3-devkit8000.dts             |  169 +++++++++++++
 arch/arm/boot/dts/omap3-evm.dts                    |   14 +-
 arch/arm/boot/dts/omap3-igep.dtsi                  |  122 ++++++++++
 arch/arm/boot/dts/omap3-igep0020.dts               |   56 +++++
 arch/arm/boot/dts/omap3-igep0030.dts               |   44 ++++
 arch/arm/boot/dts/omap3-overo.dtsi                 |   31 ++-
 arch/arm/boot/dts/omap3.dtsi                       |  132 +++++++++--
 arch/arm/boot/dts/omap3430-sdp.dts                 |  190 +++++++++++++++
 arch/arm/boot/dts/omap34xx.dtsi                    |   28 +++
 arch/arm/boot/dts/omap36xx.dtsi                    |   13 +
 arch/arm/boot/dts/omap4-panda-a4.dts               |    5 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  251 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda-es.dts               |    5 +-
 arch/arm/boot/dts/omap4-panda.dts                  |  201 +----------------
 arch/arm/boot/dts/omap4-sdp.dts                    |   74 ++++++-
 arch/arm/boot/dts/omap4-var-som.dts                |    2 +-
 arch/arm/boot/dts/omap4.dtsi                       |  135 +++++++++--
 arch/arm/boot/dts/omap443x.dtsi                    |   27 ++
 arch/arm/boot/dts/omap4460.dtsi                    |   32 +++
 arch/arm/boot/dts/omap5-evm.dts                    |  110 +++++++++-
 arch/arm/boot/dts/omap5.dtsi                       |  245 ++++++++++++++++---
 arch/arm/boot/dts/twl4030.dtsi                     |   18 ++-
 arch/arm/boot/dts/twl6030.dtsi                     |   12 +
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/omap_hwmod.c                   |   48 ++++-
 arch/arm/mach-omap2/pmu.c                          |   14 +-
 arch/arm/mach-omap2/timer.c                        |    7 +-
 arch/arm/plat-omap/dmtimer.c                       |  241 +++++++++++--------
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 46 files changed, 2167 insertions(+), 455 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-devkit8000.dts
 create mode 100644 arch/arm/boot/dts/omap3-igep.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-igep0020.dts
 create mode 100644 arch/arm/boot/dts/omap3-igep0030.dts
 create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
 create mode 100644 arch/arm/boot/dts/omap34xx.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-panda-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap443x.dtsi
 create mode 100644 arch/arm/boot/dts/omap4460.dtsi
