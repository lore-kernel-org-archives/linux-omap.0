From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap dts changes for v3.17 merge window, part1
Date: Wed, 16 Jul 2014 05:55:58 -0700
Message-ID: <20140716125553.GC18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62449 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801AbaGPM5l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2014 08:57:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/dt-part1

for you to fetch changes up to 3c9464ed75d6c15ee864da6d8f6a4cd3b0f2c934:

  ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040) (2014-07-15 00:21:25 -0700)

----------------------------------------------------------------
First set of .dts changes for omaps for v3.17 merge
window:

- Enable irqchip crossbar interrupt mapping. These changes
  are based on an immutable irqchip branch set up by Jason
  Cooper to make it easier to merge the related .dts changes.

- Removal of omap2 related static clock data that now comes
  from device tree.

- Enabling of PHY regulators for various omaps

- Enabling of PCIe for dra7

- Add support for am437x starterkit

- Enable audio for for omap5

- Enable display and am335x-evmsk

----------------------------------------------------------------
Ash Charles (1):
      ARM: dts: Add devicetree for Gumstix Pepper board

Darren Etheridge (1):
      ARM: dts: am335x-evmsk: enable display and lcd panel support

Felipe Balbi (2):
      ARM: dts: am4372: let boards access all nodes through labels
      ARM: dts: add support for AM437x StarterKit

Keerthy (6):
      ARM: dts: AM43x: Add TPS65218 device tree nodes
      ARM: dts: AM437x: Fix i2c nodes indentation
      ARM: dts: AM437x: Add TPS65218 device tree nodes
      ARM: omap2plus_defconfig: enable TPS65218 configs
      ARM: dts: dra7xx-clocks: Add divider table to optfclk_pciephy_div clock
      ARM: dts: dra7xx-clocks: Change the parent of apll_pcie_in_clk_mux to dpll_pcie_ref_m2ldo_ck

Kishon Vijay Abraham I (6):
      ARM: dts: dra7xx-clocks: Add missing 32KHz clocks used for PHY
      ARM: dts: dra7xx-clocks: rename pcie clocks to accommodate second PHY instance
      ARM: dts: dra7xx-clocks: Add missing clocks for second PCIe PHY instance
      ARM: dts: dra7: Add dt data for PCIe PHY control module
      ARM: dts: dra7: Add dt data for PCIe PHY
      ARM: dts: dra7: Add dt data for PCIe controller

Nishanth Menon (14):
      irqchip: crossbar: Dont use '0' to mark reserved interrupts
      irqchip: crossbar: Check for premapped crossbar before allocating
      irqchip: crossbar: Introduce ti, irqs-skip to skip irqs that bypass crossbar
      irqchip: crossbar: Initialise the crossbar with a safe value
      irqchip: crossbar: Change allocation logic by reversing search for free irqs
      irqchip: crossbar: Remove IS_ERR_VALUE check
      irqchip: crossbar: Fix sparse and checkpatch warnings
      irqchip: crossbar: Fix kerneldoc warning
      irqchip: crossbar: Return proper error value
      irqchip: crossbar: Change the goto naming
      irqchip: crossbar: Introduce ti, max-crossbar-sources to identify valid crossbar mapping
      irqchip: crossbar: Introduce centralized check for crossbar write
      documentation: dt: omap: crossbar: Add description for interrupt consumer
      irqchip: crossbar: Allow for quirky hardware with direct hardwiring of GIC

Peter Ujfalusi (3):
      ARM: DTS: omap5-uevm: Enable palmas clk32kgaudio clock
      ARM: DTS: omap5-uevm: Add node for twl6040 audio codec
      ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040)

R Sricharan (2):
      ARM: dts: dra7: add routable-irqs property for gic node
      ARM: dts: dra7: add crossbar device binding

Roger Quadros (1):
      ARM: dts: dra7-evm: Add regulator information to USB2 PHYs

Sricharan R (2):
      irqchip: crossbar: Set cb pointer to null in case of error
      irqchip: crossbar: Add kerneldoc for crossbar_domain_unmap callback

Tero Kristo (5):
      ARM: OMAP2: convert sys_ck and osc_ck to standard clock types
      ARM: OMAP2420: clock: get rid of fixed-div property use
      ARM: OMAP2: PRM: add support for OMAP2 specific clock providers
      ARM: OMAP2: clock: use DT clock boot if available
      ARM: OMAP24xx: clock: remove legacy clock data

Tony Lindgren (2):
      Merge branch 'dts-crossbar' into omap-for-v3.17/dt
      Merge branch 'for-v3.17/omap2-use-dt-clks' of http://github.com/t-kristo/linux-pm into omap-for-v3.17/dt

 .../devicetree/bindings/arm/omap/crossbar.txt      |   36 +
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 .../devicetree/bindings/arm/omap/prcm.txt          |   65 +
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  105 +
 arch/arm/boot/dts/am335x-pepper.dts                |  653 +++++++
 arch/arm/boot/dts/am4372.dtsi                      |    8 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   71 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |  613 ++++++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   59 +
 arch/arm/boot/dts/dra7-evm.dts                     |    8 +
 arch/arm/boot/dts/dra7.dtsi                        |  266 ++-
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |   39 +-
 arch/arm/boot/dts/omap2420.dtsi                    |    3 +
 arch/arm/boot/dts/omap2430.dtsi                    |    3 +
 arch/arm/boot/dts/omap5-uevm.dts                   |   68 +-
 arch/arm/configs/omap2plus_defconfig               |    2 +
 arch/arm/mach-omap2/Makefile                       |    6 +-
 arch/arm/mach-omap2/cclock2420_data.c              | 1931 ------------------
 arch/arm/mach-omap2/cclock2430_data.c              | 2048 --------------------
 arch/arm/mach-omap2/clkt2xxx_osc.c                 |   69 -
 arch/arm/mach-omap2/clkt2xxx_sys.c                 |   47 -
 arch/arm/mach-omap2/clock.c                        |   21 -
 arch/arm/mach-omap2/clock.h                        |    3 -
 arch/arm/mach-omap2/clock2xxx.h                    |    2 -
 arch/arm/mach-omap2/cm-regbits-24xx.h              |    1 +
 arch/arm/mach-omap2/io.c                           |    7 +-
 arch/arm/mach-omap2/pm24xx.c                       |    4 +
 arch/arm/mach-omap2/prm_common.c                   |    2 +
 drivers/irqchip/irq-crossbar.c                     |  168 +-
 30 files changed, 2084 insertions(+), 4231 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/prcm.txt
 create mode 100644 arch/arm/boot/dts/am335x-pepper.dts
 create mode 100644 arch/arm/boot/dts/am437x-sk-evm.dts
 delete mode 100644 arch/arm/mach-omap2/cclock2420_data.c
 delete mode 100644 arch/arm/mach-omap2/cclock2430_data.c
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_osc.c
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_sys.c
