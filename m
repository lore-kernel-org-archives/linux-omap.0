From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap device tree changes for v4.2, part 1
Date: Fri, 22 May 2015 13:20:28 -0700
Message-ID: <20150522202028.GE10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53128 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbbEVUUb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 May 2015 16:20:31 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/dt-pt1

for you to fetch changes up to 52dfcbfc94833b0192d439127ee9ff46023cdbb2:

  ARM: dts: am335x-evm: add mmc3 and wlan definitions to dts (2015-05-21 12:05:59 -0700)

----------------------------------------------------------------
Device tree related changes for omaps:

- Configure MMC data lines 4..8 for 1.8V IO on boards that
  are using them as GPIOs instead of MMC data lines

- Add support for Baltos IR5221

- Add device tree support for LogicPD Torpedo devkit

- Add 3717 core pinctrl region

- Add gta04 1w and GSM audio support

- Add wilink and ov2659 support for am437x-gp-evm

- Add am335x-evm bluetooth and mmc3 support

- Enable omap5-uevm uart wakeup interrupt

- Enable I2C2 on BeagleBone as it's used for the capes

- Use defines for LDP GPIO keys

----------------------------------------------------------------
Andrey Skvortsov (1):
      ARM: dts: add core2 padconf region for am3517

Eliad Peller (1):
      ARM: dts: am335x-evm: add bluetooth support

Eyal Reizer (2):
      ARM: dts: am437x-gp-evm: add wilink8 support
      ARM: dts: am335x-evm: add mmc3 and wlan definitions to dts

Lad, Prabhakar (1):
      ARM: dts: am437x-gp-evm: add DT nodes for ov2659 sensor

Marek Belisko (2):
      ARM: dts: omap3-gta04: Add hdqw1 support
      ARM: dts: omap3-gta04: Add GSM audio support

Nishanth Menon (1):
      ARM: dts: omap5-uevm: Add Uart wakeup interrupt

Pantelis Antoniou (1):
      ARM: dts: Beaglebone i2c definitions

Tony Lindgren (4):
      ARM: OMAP3: Add support for configuring MMC pins as GPIO pins
      ARM: dts: Add minimal support for LogicPD Torpedo DM3730 devkit
      ARM: dts: Fix ldp gpio keys to use defines
      ARM: dts: Enable SDIO card interrupt for 37xx-evm

Yegor Yefremov (1):
      ARM: dts: add DTS for Baltos IR5221

 arch/arm/boot/dts/Makefile                        |   2 +
 arch/arm/boot/dts/am335x-baltos-ir5221.dts        | 532 ++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone-common.dtsi         |  66 +++
 arch/arm/boot/dts/am335x-evm.dts                  |  81 ++++
 arch/arm/boot/dts/am3517.dtsi                     |  11 +
 arch/arm/boot/dts/am437x-gp-evm.dts               | 144 +++++-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 157 +++++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        | 162 +++++++
 arch/arm/boot/dts/omap3-evm-common.dtsi           |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                |  37 ++
 arch/arm/boot/dts/omap3-ldp.dts                   |  18 +-
 arch/arm/boot/dts/omap5-uevm.dts                  |  14 +-
 arch/arm/mach-omap2/control.c                     |   3 +
 arch/arm/mach-omap2/control.h                     |   3 +
 arch/arm/mach-omap2/pdata-quirks.c                |  22 +
 include/dt-bindings/pinctrl/am43xx.h              |   1 +
 16 files changed, 1237 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-baltos-ir5221.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-som.dtsi
