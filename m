From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.0-rc2
Date: Fri, 6 Mar 2015 16:27:05 -0800
Message-ID: <20150307002704.GA5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:35417 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbbCGAcY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 19:32:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-v4.0-rc2

for you to fetch changes up to 5b7610f235627878617648a99dd1442997f1c889:

  ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot (2015-03-06 10:37:34 -0800)

----------------------------------------------------------------
Fixes for various omap variants, mostly minor fixes for various SoCs
with the bigger changes being for the dra7 clocks and hwmod data:

- Fix wl12xx for dm3730-evm

- Fix omap4 prm save and clea

- Fix hwmod clkdm use count

- Fix hwmod data for pcie on dra7

- Fix lockdep for hwmod

- Fix USB on most omap3 boars by enabling it in the defconfig

- Fix the bypass clock source for omap5 and dra7

- Fix the ehrpwm clock for am33xx and am43xx

- Enable AES and SHAM for BeagleBone white

- Use rmii clock for am335x-lxm

- Fix polling intervals for omap5 thermal zones

- Fix slewctrl for am33xx and am43xx

- Fix dra7-evm dcan pinctrl

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: enable TWL4030_USB in omap2plus_defconfig

Dave Gerlach (2):
      ARM: dts: am33xx: fix SLEWCTRL_FAST pinctrl binding
      ARM: dts: am43xx: fix SLEWCTRL_FAST pinctrl binding

George McCollister (1):
      ARM: dts: am335x-lxm: Use rmii-clock-ext

Kishon Vijay Abraham I (1):
      ARM: DRA7: hwmod_data: Fix hwmod data for pcie

Matt Porter (1):
      ARM: dts: am335x-bone-common: enable aes and sham

Peter Ujfalusi (1):
      ARM: omap2+: omap_hwmod: Set unique lock_class_key per hwmod

Ravikumar Kattekola (2):
      ARM: dts: DRA7x: Fix the bypass clock source for dpll_iva and others
      ARM: dts: OMAP5: Fix the bypass clock source for dpll_iva and others

Roger Quadros (2):
      ARM: dts: dra7x-evm: Don't use dcan1_rx.gpio1_15 in DCAN pinctrl
      ARM: dts: dra7x-evm: avoid possible contention while muxing on CAN lines

Tero Kristo (3):
      ARM: OMAP2+: hwmod: fix deassert hardreset clkdm usecounting
      ARM: OMAP4+: PRM: fix omap4 version of prm_save_and_clear_irqen
      ARM: dts: OMAP5: fix polling intervals for thermal zones

Tony Lindgren (2):
      Merge tag 'for-v4.0-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.0/fixes
      ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot

Vignesh R (2):
      ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
      ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx

 arch/arm/boot/dts/am335x-bone-common.dtsi |   8 +++
 arch/arm/boot/dts/am335x-bone.dts         |   8 ---
 arch/arm/boot/dts/am335x-lxm.dts          |   4 ++
 arch/arm/boot/dts/am33xx-clocks.dtsi      |   6 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi      |  12 ++--
 arch/arm/boot/dts/dra7-evm.dts            |  10 ++-
 arch/arm/boot/dts/dra72-evm.dts           |  10 ++-
 arch/arm/boot/dts/dra7xx-clocks.dtsi      |  90 +++++++++++++++++++++++---
 arch/arm/boot/dts/omap5-core-thermal.dtsi |   2 +-
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi  |   2 +-
 arch/arm/boot/dts/omap5.dtsi              |   4 ++
 arch/arm/boot/dts/omap54xx-clocks.dtsi    |  41 ++++++++++--
 arch/arm/configs/omap2plus_defconfig      |   1 +
 arch/arm/mach-omap2/omap_hwmod.c          |  10 +--
 arch/arm/mach-omap2/omap_hwmod.h          |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 103 +++++++-----------------------
 arch/arm/mach-omap2/pdata-quirks.c        |   1 +
 arch/arm/mach-omap2/prm44xx.c             |   4 +-
 include/dt-bindings/pinctrl/am33xx.h      |   3 +-
 include/dt-bindings/pinctrl/am43xx.h      |   3 +-
 20 files changed, 191 insertions(+), 132 deletions(-)
