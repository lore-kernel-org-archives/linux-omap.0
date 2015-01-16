From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap device tree changes for v3.20
Date: Fri, 16 Jan 2015 15:21:22 -0800
Message-ID: <16444.0957051285$1421450715@news.gmane.org>
References: <pull-1421450357-648499>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19550 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751502AbbAPXZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 18:25:06 -0500
In-Reply-To: <pull-1421450357-648499>
In-Reply-To: <pull-1421450357-648499>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/dt-pt1

for you to fetch changes up to 7300bfff886a1340cfeb252035303e265cd556d9:

  ARM: dts: omap3-gta04: Add handling for tv output (2015-01-13 08:02:21 -0800)

----------------------------------------------------------------
Device tree changes for omaps. Mostly to add support for new
am437x-idk and update am437x-sk boards. Also enabling new
devices for multiple boards.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: dts: N950/N9: add twl_power

Benoit Parrot (3):
      ARM: dts: am4372: add VPFE DT node entries
      ARM: dts: am43x-epos-evm: add VPFE device tree data
      ARM: dts: am437x-gp-evm: add VPFE device tree data

Darren Etheridge (1):
      ARM: dts: am437x-sk-evm: add VPFE device tree data

Dave Gerlach (1):
      ARM: dts: am437x-sk-evm: Hook dcdc2 as the cpu0-supply

Dmitry Lifshitz (1):
      ARM: dts: cm-t3x: add NAND support

Felipe Balbi (10):
      ARM: dts: am437x-sk: remove internal pulls from QSPI
      ARM: dts: am437x-sk: add explicit MMC0 pinmux
      ARM: dts: am437x-sk: remove ethernet pulls
      ARM: dts: am437x-sk: add explicit pinmux for both USB instances
      ARM: dts: am437x-sk: remove internal i2c pullups
      ARM: dts: am437x-sk: remove DSS pulls
      ARM: dts: am57xx-beagle-x15: Add dual ethernet
      ARM: dts: add support for AM437x IDK
      ARM: dts: am437x-sk: add power button binding
      ARM: dts: am437x-idk: add gpio-based power key

Marek Belisko (1):
      ARM: dts: omap3-gta04: Add handling for tv output

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan node

Pavel Machek (1):
      ARM: dts: omap3-n900: cleanup english

Vignesh R (1):
      ARM: dts: DRA7X: drop id property in pcie_phy

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/am4372.dtsi           |  16 ++
 arch/arm/boot/dts/am437x-gp-evm.dts     | 106 +++++++++
 arch/arm/boot/dts/am437x-idk-evm.dts    | 405 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am437x-sk-evm.dts     | 217 ++++++++++++-----
 arch/arm/boot/dts/am43x-epos-evm.dts    |  53 +++++
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 120 ++++++++++
 arch/arm/boot/dts/dra7.dtsi             |   2 -
 arch/arm/boot/dts/omap3-cm-t3x.dtsi     |  58 +++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi   |   3 +-
 arch/arm/boot/dts/omap3-gta04.dtsi      |  49 ++++
 arch/arm/boot/dts/omap3-n900.dts        |   3 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi    |   5 +
 arch/arm/boot/dts/omap3-sbc-t3517.dts   |   4 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts   |  10 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts   |   5 +-
 16 files changed, 979 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/boot/dts/am437x-idk-evm.dts
