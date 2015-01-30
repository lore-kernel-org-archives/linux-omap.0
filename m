From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap device tree changes for v3.20, part 3
Date: Fri, 30 Jan 2015 15:55:35 -0800
Message-ID: <20150130235535.GD16250@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.ore.mailhop.org ([54.186.57.195]:41834 "EHLO
	smtp2.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbA3X6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2015 18:58:36 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 1f43c45df7afb706470f7d81d983dd7763a9452f:

  ARM: dts: dra72-evm: Add qspi device (2015-01-20 10:07:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/dt-pt3-v2

for you to fetch changes up to 726806ad9ba10f8ba8d26ba8154d98a7c9b89a12:

  ARM: dts: am57xx-beagle-x15: Fix USB2 mode (2015-01-30 15:48:39 -0800)

----------------------------------------------------------------
Device tree related chages for omaps to fix dm816x syscon,
fix various devices for gta04, and add USB nodes for am57xx
and dra7.

----------------------------------------------------------------
H. Nikolaus Schaller (5):
      ARM: dts: omap3-gta04: Fix backup-battery charging in devicetree file.
      ARM: dts: omap3-gta04: Fix audio node malformatting
      ARM: dts: omap3-gta04: Enable mcbps2 necessary for audio
      ARM: dts: omap3-gta04: Enable twl audio vibra support
      ARM: dts: omap3-gta04: Enable power-off using twl4030

Marek Belisko (2):
      ARM: dts: omap3-gta04: Fix a GPIO line for bma180 node
      ARM: dts: omap3-gta04: Add ramp value for twl4030 audio

NeilBrown (5):
      ARM: dts: omap3-gta04: add comments about gpios
      ARM: dts: omap3-gta04: enable power-off for wifi card.
      ARM: dts: omap3-gta04: add gyroscope
      ARM: dts: omap3-gta04: only power DSS when necessary.
      ARM: dts: omap3-gta04: Disable keypad

Roger Quadros (4):
      ARM: dts: dra7-evm: Add extcon nodes for USB
      ARM: dts: dra72-evm: Add extcon nodes for USB
      ARM: dts: am57xx-beagle-x15: Add extcon nodes for USB
      ARM: dts: am57xx-beagle-x15: Fix USB2 mode

Tony Lindgren (1):
      ARM: dts: Fix dm816x pinctrl and syscon so they are children of SCM

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 37 ++++++++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi           | 35 +++++++++++++----------
 arch/arm/boot/dts/dra7-evm.dts          | 31 ++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts         | 31 ++++++++++++++++++++
 arch/arm/boot/dts/omap3-gta04.dtsi      | 50 +++++++++++++++++++++++----------
 5 files changed, 154 insertions(+), 30 deletions(-)
