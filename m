From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap late prcm clean-up for v4.1
Date: Fri, 3 Apr 2015 16:25:36 -0700
Message-ID: <20150403232536.GC18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41756 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbbDCX3b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 19:29:31 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 209431eff8afb928d72200c79153165c7d860ca0:

  ARM: DRA7: Enable Cortex A15 errata 798181 (2015-03-27 14:38:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.1/prcm-dts

for you to fetch changes up to 21295368367beaa563b310d5492166dba158b884:

  Merge branch '4.0-rc1-prcm-cleanup-v6' of https://github.com/t-kristo/linux-pm into omap-for-v4.1/prcm-cleanup (2015-04-01 12:24:29 -0700)

----------------------------------------------------------------
Clean-up for omap PRCM (Power Reset Clock Management) and interconnects
from Tero Kristo <t-kristo@ti.com>.

This sets gets us into a better position for further clean-up:

- Gets PRCM code closer to being device drivers

- Allows to move the remainig clock code to drivers/clk for v4.2

- Starts enforcing interconnect hierarchy in the SoC specific .dts
  files to enforce device drivers are only accesing registers in
  the related hardware module

This patchset has seen quite a few revisions but did not come into
mergeable shape until recently. As other patchsets for clock specific
device drivers depend on this, it would be good to get this merged
although it's a bit late for the v4.1 merge window.

Note that as the device entries in the .dts files are moved around,
this is based on earlier non-urgent fixes to avoid a non-trivial
merge conflict.

----------------------------------------------------------------
Tero Kristo (35):
      clk: ti: fix ti_clk_get_reg_addr error handling
      ARM: OMAP2+: PRCM: rename of_prcm_init to omap_prcm_init
      ARM: OMAP3: PRM: invert the wkst_mask for the prm_clear_mod_irqs
      ARM: OMAP2+: PRM: add generic API for clear_mod_irqs
      ARM: OMAP3+: PRM: add common APIs for prm_vp_check/clear_txdone
      ARM: OMAP4+: PRM: move omap_prm_base_init under OMAP4 PRM driver
      ARM: OMAP4+: CM: move omap_cm_base_init under OMAP4 CM driver
      ARM: OMAP4: PRM: move omap4xxx_prm_init earlier in init order
      Documentation: DT: document PRCM compatible strings for dm81x SoCs
      ARM: OMAP2+: PRCM: add support for static clock memmap indices
      ARM: OMAP2+: clock: move clock provider infrastructure to clock driver
      ARM: OMAP2+: PRCM: split PRCM module init to their own driver files
      ARM: OMAP2+: CM: determine CM base address from device tree
      ARM: OMAP2+: PRM: determine PRM base address from device tree
      ARM: OMAP2+: control: determine control module base address from DT
      ARM: OMAP2+: PRM: move SoC specific init calls within a generic API
      ARM: OMAP4+: PRM: determine prm_device_inst based on DT compatibility
      ARM: OMAP2+: CM: move SoC specific init calls within a generic API
      ARM: OMAP4+: PRM: setup prm_features from the PRM init time flags
      ARM: OMAP4+: PRM: get rid of cpu_is_omap44xx calls from interrupt init
      ARM: OMAP2+: clock: add low-level support for regmap
      ARM: OMAP2+: control: remove API for getting control module base address
      ARM: OMAP2+: id: cache omap_type value
      ARM: OMAP2+: control: add syscon support for register accesses
      ARM: dts: omap24xx: add minimal l4 bus layout with control module support
      ARM: dts: omap3: add minimal l4 bus layout with control module support
      ARM: dts: am33xx: add minimal l4 bus layout with control module support
      ARM: dts: am43xx-epos-evm: fix pinmux node layout
      ARM: dts: am4372: add minimal l4 bus layout with control module support
      ARM: dts: omap4: add minimal l4 bus layout with control module support
      ARM: OMAP4: display: convert display to use syscon for dsi muxing
      ARM: OMAP4+: control: remove support for legacy pad read/write
      ARM: dts: omap5: add minimal l4 bus layout with control module support
      ARM: dts: dra7: add minimal l4 bus layout with control module support
      ARM: OMAP4+: control: add support for initializing control module via DT

Tony Lindgren (1):
      Merge branch '4.0-rc1-prcm-cleanup-v6' of https://github.com/t-kristo/linux-pm into omap-for-v4.1/prcm-cleanup

 .../devicetree/bindings/arm/omap/ctrl.txt          |  79 +++++++
 Documentation/devicetree/bindings/arm/omap/l4.txt  |  26 +++
 .../devicetree/bindings/arm/omap/prcm.txt          |   6 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi               |   2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  87 +++----
 arch/arm/boot/dts/am3517.dtsi                      |   2 +-
 arch/arm/boot/dts/am35xx-clocks.dtsi               |   2 +-
 arch/arm/boot/dts/am4372.dtsi                      |  85 ++++---
 arch/arm/boot/dts/am43x-epos-evm.dts               |  84 +++----
 arch/arm/boot/dts/am43xx-clocks.dtsi               |   2 +-
 arch/arm/boot/dts/dra7.dtsi                        | 156 ++++++++-----
 arch/arm/boot/dts/omap2420.dtsi                    |  80 ++++---
 arch/arm/boot/dts/omap2430-clocks.dtsi             |   8 +-
 arch/arm/boot/dts/omap2430.dtsi                    | 107 +++++----
 arch/arm/boot/dts/omap24xx-clocks.dtsi             |   6 +-
 arch/arm/boot/dts/omap3.dtsi                       |  96 ++++----
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             |  13 +-
 arch/arm/boot/dts/omap4.dtsi                       | 200 +++++++++-------
 arch/arm/boot/dts/omap5.dtsi                       | 182 +++++++++------
 arch/arm/mach-omap2/clock.c                        | 111 +++++++--
 arch/arm/mach-omap2/clock.h                        |   8 +-
 arch/arm/mach-omap2/cm.h                           |   2 +
 arch/arm/mach-omap2/cm2xxx.c                       |   2 +-
 arch/arm/mach-omap2/cm2xxx.h                       |   2 +-
 arch/arm/mach-omap2/cm33xx.c                       |   2 +-
 arch/arm/mach-omap2/cm33xx.h                       |   3 +-
 arch/arm/mach-omap2/cm3xxx.c                       |   3 +-
 arch/arm/mach-omap2/cm3xxx.h                       |   2 +-
 arch/arm/mach-omap2/cm44xx.h                       |   3 +-
 arch/arm/mach-omap2/cm_common.c                    | 156 +++++++++++++
 arch/arm/mach-omap2/cminst44xx.c                   |   6 +-
 arch/arm/mach-omap2/control.c                      | 201 +++++++++++++---
 arch/arm/mach-omap2/control.h                      |  10 +-
 arch/arm/mach-omap2/display.c                      |  15 +-
 arch/arm/mach-omap2/id.c                           |   5 +-
 arch/arm/mach-omap2/io.c                           | 112 ++++-----
 arch/arm/mach-omap2/pm24xx.c                       |  24 +-
 arch/arm/mach-omap2/pm34xx.c                       |  18 +-
 arch/arm/mach-omap2/prcm-common.h                  |  20 ++
 arch/arm/mach-omap2/prm.h                          |  27 ++-
 arch/arm/mach-omap2/prm2xxx.c                      |   6 +-
 arch/arm/mach-omap2/prm2xxx.h                      |   4 +-
 arch/arm/mach-omap2/prm33xx.c                      |   2 +-
 arch/arm/mach-omap2/prm33xx.h                      |   2 +-
 arch/arm/mach-omap2/prm3xxx.c                      |  20 +-
 arch/arm/mach-omap2/prm3xxx.h                      |   7 +-
 arch/arm/mach-omap2/prm44xx.c                      |  70 +++---
 arch/arm/mach-omap2/prm44xx.h                      |   1 -
 arch/arm/mach-omap2/prm44xx_54xx.h                 |   8 +-
 arch/arm/mach-omap2/prm54xx.h                      |   1 -
 arch/arm/mach-omap2/prm7xx.h                       |   2 +-
 arch/arm/mach-omap2/prm_common.c                   | 258 +++++++++++++++++----
 arch/arm/mach-omap2/prminst44xx.c                  |  18 +-
 arch/arm/mach-omap2/prminst44xx.h                  |   1 +
 arch/arm/mach-omap2/vp.h                           |   9 -
 arch/arm/mach-omap2/vp3xxx_data.c                  |   4 +-
 arch/arm/mach-omap2/vp44xx_data.c                  |   4 +-
 drivers/clk/ti/apll.c                              |   5 +-
 drivers/clk/ti/autoidle.c                          |   2 +-
 drivers/clk/ti/clk.c                               |   7 +-
 drivers/clk/ti/divider.c                           |   4 +-
 drivers/clk/ti/dpll.c                              |   6 +-
 drivers/clk/ti/gate.c                              |   4 +-
 drivers/clk/ti/interface.c                         |   2 +-
 drivers/clk/ti/mux.c                               |   4 +-
 include/linux/clk/ti.h                             |   6 +-
 66 files changed, 1612 insertions(+), 800 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l4.txt
