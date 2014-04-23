From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.15-rc1
Date: Wed, 23 Apr 2014 15:34:00 -0700
Message-ID: <20140423223400.GD6053@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10538 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751401AbaDWWeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 18:34:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

Apologies if you see a duplicate of this pull request, looks like my
scripts have become flakey with sending out the mails since I updated
them.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-v2-signed

for you to fetch changes up to fb677ef70b65e22cd4401d31b700a8b4041efae1:

  ARM: OMAP2+: Fix GPMC remap for devices using an offset (2014-04-23 11:09:22 -0700)

----------------------------------------------------------------
Fixes for omaps, mostly to fix some GPMC, DSS and USB issues for
device tree based booting. And turns out BeagleBoard xM A/B
needs it's own minimal dts in addition to the related u-boot
changes. Also few minor documentation and typo fixes are merged
to get them out of the way.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: dts: Grammar /is uses/ is used/
      ARM: dts: Grammar /that will/it will/

Johan Hovold (1):
      ARM: dts: OMAP2+: remove uses of obsolete gpmc,device-nand

Kishon Vijay Abraham I (1):
      ARM: OMAP2+: Fix config name for USB3 PHY

Leigh Brown (1):
      ARM: dts: am335x: update USB DT references

Peter Ujfalusi (1):
      ARM: dts: dra7xx-clocks: Correct mcasp2_ahclkx_mux bit-shift

Robert Nelson (1):
      ARM: dts: Add support for the BeagleBoard xM A/B

Roger Quadros (2):
      ARM: OMAP3: hwmod data: Correct clock domains for USB modules
      ARM: dts: omap5: Add clocks to USB3 PHY node

Sebastian Reichel (1):
      ARM: OMAP2+: N900: remove omapdss init for DT boot

Suman Anna (1):
      ARM: OMAP2+: hwmod: fix missing braces in _init()

Tero Kristo (1):
      ARM: OMAP3: PM: remove access to PRM_VOLTCTRL register

Tomi Valkeinen (1):
      ARM: AM43xx: fix dpll init in bypass mode

Tony Lindgren (4):
      Merge branch 'fixes-v3.15-rc1'; commit '390403fd79821bbd0c3a0d83307df2be87047b36' into omap-for-v3.15/fixes
      Merge tag 'for-v3.15-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.15/fixes
      ARM: OMAP2+: Fix oops for GPMC free
      ARM: OMAP2+: Fix GPMC remap for devices using an offset

Wolfram Sang (1):
      ARM: AM335X: EVM: fix pinmux documentation in devicetree

 arch/arm/boot/dts/Makefile                 |  1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi  |  4 ++--
 arch/arm/boot/dts/am335x-evm.dts           |  8 ++++----
 arch/arm/boot/dts/am335x-evmsk.dts         |  4 ++--
 arch/arm/boot/dts/am335x-igep0033.dtsi     |  5 ++---
 arch/arm/boot/dts/am33xx.dtsi              |  6 +++---
 arch/arm/boot/dts/dra7.dtsi                |  4 ++--
 arch/arm/boot/dts/dra7xx-clocks.dtsi       |  2 +-
 arch/arm/boot/dts/omap3-beagle-xm-ab.dts   | 16 ++++++++++++++++
 arch/arm/boot/dts/omap3-devkit8000.dts     |  1 -
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi    |  1 -
 arch/arm/boot/dts/omap3.dtsi               |  2 +-
 arch/arm/boot/dts/omap4.dtsi               |  4 ++--
 arch/arm/boot/dts/omap5.dtsi               | 10 ++++++++--
 arch/arm/configs/omap2plus_defconfig       |  2 +-
 arch/arm/mach-omap2/board-rx51-video.c     |  2 +-
 arch/arm/mach-omap2/clkt_dpll.c            |  4 ++--
 arch/arm/mach-omap2/gpmc.c                 | 15 +++++++++++++--
 arch/arm/mach-omap2/omap_hwmod.c           |  3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  4 ++--
 arch/arm/mach-omap2/pm34xx.c               |  4 ----
 21 files changed, 65 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-beagle-xm-ab.dts
