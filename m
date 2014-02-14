From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.14-rc1
Date: Fri, 14 Feb 2014 09:50:43 -0800
Message-ID: <20140214175042.GD21592@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29962 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751538AbaBNRvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 12:51:00 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-against-rc1

for you to fetch changes up to 8842446ac74263f1330f46e11ed649e2b0ed6545:

  Documentation: dt: OMAP: Update Overo/Tobi (2014-02-14 08:37:53 -0800)

----------------------------------------------------------------
Fixes for omaps, mostly to deal with the 34xx vs 36xx SoC
configuration for overo boards.

----------------------------------------------------------------
Aaro Koskinen (3):
      ARM: OMAP1: nokia770: enable tahvo-usb
      ARM: dts: N9/N950: fix boot hang with 3.14-rc1
      ARM: dts: N900: add missing compatible property

Florian Vaussard (4):
      ARM: dts: omap3-tobi: Fix boot with OMAP36xx-based Overo
      ARM: dts: omap3-tobi: Use the correct vendor prefix
      ARM: dts: Add support for both OMAP35xx and OMAP36xx Overo/Tobi
      Documentation: dt: OMAP: Update Overo/Tobi

Marek Belisko (2):
      ARM: dts: omap3-gta04: Add EOC irq gpio line handling.
      ARM: dts: omap3-gta04: Fix mmc1 properties.

NeilBrown (1):
      ARM: dts: omap3-gta04: Fix 'aux' gpio key flags.

Nishanth Menon (1):
      ARM: OMAP2+: add missing ARCH_HAS_OPP

Paul Bolle (2):
      ARM: OMAP2+: Remove MACH_NOKIA_N800
      ARM: OMAP2+: Remove legacy macros for zoom platforms

Pekon Gupta (2):
      ARM: OMAP2+: gpmc: fix: DT NAND child nodes not probed when MTD_NAND is built as module
      ARM: OMAP2+: gpmc: fix: DT ONENAND child nodes not probed when MTD_ONENAND is built as module

Peter Ujfalusi (2):
      ARM: DTS: am335x-evmsk: Correct audio clock frequency
      ARM: dts: am335x-evmsk: Fix mmc1 support

 .../devicetree/bindings/arm/omap/omap.txt          |  2 +-
 arch/arm/boot/dts/Makefile                         |  3 ++-
 arch/arm/boot/dts/am335x-evmsk.dts                 | 11 ++++++++++-
 arch/arm/boot/dts/omap3-gta04.dts                  |  6 ++++--
 arch/arm/boot/dts/omap3-n9.dts                     |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |  4 ++--
 arch/arm/boot/dts/omap3-n950.dts                   |  2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 22 ++++++++++++++++++++++
 ...omap3-tobi.dts => omap3-overo-tobi-common.dtsi} |  3 ---
 arch/arm/boot/dts/omap3-overo-tobi.dts             | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi                 |  3 ---
 arch/arm/mach-omap1/board-nokia770.c               |  1 +
 arch/arm/mach-omap2/Kconfig                        |  8 ++++----
 arch/arm/mach-omap2/gpmc.c                         |  4 ++--
 arch/arm/mach-omap2/io.c                           |  9 ---------
 15 files changed, 72 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi-common.dtsi} (94%)
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts
