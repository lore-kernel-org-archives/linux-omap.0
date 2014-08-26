From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.17-rc2
Date: Tue, 26 Aug 2014 15:14:13 -0700
Message-ID: <20140826221412.GC16006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22849 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbaHZWOT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2014 18:14:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/fixes-against-rc2

for you to fetch changes up to 8fd46439e1f5a7f86d76a08733459b74debd9468:

  ARM: dts: omap54xx-clocks: Fix the l3 and l4 clock rates (2014-08-26 13:04:00 -0700)

----------------------------------------------------------------
Fixes for omaps, mostly to revert NAND back to using software ECC
by default as that's what many boards expect. Also fixes for omap5
clocks, PM wake-up events, GPIO interrupt cells for dra7, and few
other minor fixes.

----------------------------------------------------------------
Hans Wennborg (1):
      ARM: OMAP: fix %d confusingly prefixed with 0x in format string

Mark Brown (1):
      ARM: dts: Remove twl6030 clk32g "regulator"

Markus Pargmann (1):
      ARM: OMAP2+: omap_device: remove warning that clk alias already exists

Nishanth Menon (1):
      ARM: dts: DRA7: fix interrupt-cells for GPIO

Roger Quadros (4):
      mtd: nand: omap: Revert to using software ECC by default
      ARM: OMAP2+: GPMC: Support Software ECC scheme via DT
      ARM: dts: omap3430-sdp: Revert to using software ECC for NAND
      mtd: nand: omap: Fix 1-bit Hamming code scheme, omap_calculate_ecc()

Tero Kristo (1):
      ARM: dts: omap54xx-clocks: Fix the l3 and l4 clock rates

Tony Lindgren (2):
      ARM: dts: Enable UART wake-up events for beagleboard
      ARM: OMAP2+: hwmod: Rearm wake-up interrupts for DT when MUSB is idled

 Documentation/devicetree/bindings/mtd/gpmc-nand.txt |  2 +-
 arch/arm/boot/dts/dra7.dtsi                         | 16 ++++++++--------
 arch/arm/boot/dts/omap3-beagle.dts                  |  1 +
 arch/arm/boot/dts/omap3430-sdp.dts                  |  2 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi              | 16 ++++++++++------
 arch/arm/boot/dts/twl6030.dtsi                      |  4 ----
 arch/arm/mach-omap2/board-flash.c                   |  2 +-
 arch/arm/mach-omap2/gpmc-nand.c                     |  3 ++-
 arch/arm/mach-omap2/gpmc.c                          |  7 +++++--
 arch/arm/mach-omap2/id.c                            |  2 +-
 arch/arm/mach-omap2/omap_device.c                   |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c                    |  4 ++++
 drivers/mtd/nand/omap2.c                            | 16 ++++++++++++----
 include/linux/platform_data/mtd-nand-omap2.h        | 13 +++++++++++--
 14 files changed, 58 insertions(+), 32 deletions(-)
