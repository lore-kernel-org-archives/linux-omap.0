From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/5] omap dts changes for v3.18 merge window
Date: Thu, 11 Sep 2014 16:28:58 -0700
Message-ID: <27348.8473416821$1410478171@news.gmane.org>
References: <pull-1410478051-378788>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48992 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaIKX3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 19:29:22 -0400
In-Reply-To: <pull-1410478051-378788>
In-Reply-To: <pull-1410478051-378788>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/dt-for-v3.18

for you to fetch changes up to d27704d1ec2f9ba06247b402c58a6f2febecef78:

  ARM: dts: OMAP2+: Add sub mailboxes device node information (2014-09-11 11:46:30 -0700)

----------------------------------------------------------------
Changes for .dts files for omaps for v3.18 merge window:

- Updates for gta04 to add gta04a3 model
- Add support for Tehnexion TAO3530 boards
- Regulator names for beaglebone
- Pinctrl related updates for omap5, dra7 and am437
- Model name fix for sbc-t54
- Enable mailbox for various omaps

----------------------------------------------------------------
Dmitry Lifshitz (1):
      ARM: dts: sbc-t54: fix model property

Keerthy J (2):
      ARM: dts: dra72-evm: Enable I2C1 node
      ARM: dts: dra72-evm: Add tps65917 PMIC node

Marek Belisko (10):
      ARM: dts: omap3-gta04: Add nand support
      ARM: dts: omap3-gta04: Fix magnetometer model
      ARM: dts: omap3-gta04: Add wifi reset node
      ARM: dts: omap3-gta04: Move spi gpio pins to pmx_core2
      ARM: dts: omap3-gta04: Add USB host support
      ARM: dts: omap3-gta04: Add display alias
      ARM: dts: omap3-gta04: Add twl4030 regulators parameters
      ARM: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and add a4 model
      ARM: dts: Add gta04a3 model
      ARM: dts: Add gta04a5 model

Mark Brown (1):
      ARM: dts: am335x-boneblack: Add names for remaining regulators

Nishanth Menon (6):
      ARM: OMAP2+: board-generic: add support for AM57xx family
      ARM: dts: OMAP5: switch to compatible pinctrl
      ARM: dts: DRA7: switch to compatible pinctrl
      ARM: dts: AM437x: switch to compatible pinctrl
      ARM: dts: OMAP5 / DRA7: switch over to interrupts-extended property for UART
      ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable

Stefan Roese (4):
      ARM: OMAP2+: tao3530: Add pdata-quirk for the mmc2 internal clock
      ARM: dts: omap3: Add Technexion TAO3530 SOM omap3-tao3530.dtsi
      ARM: dts: omap3: Add Technexion Thunder support (TAO3530 SOM based)
      ARM: dts: omap3: Add HEAD acoustics omap3-ha.dts and omap3-ha-lcd.dts (TAO3530 based)

Suman Anna (1):
      ARM: dts: OMAP2+: Add sub mailboxes device node information

Tomi Valkeinen (1):
      ARM: dts: omap5.dtsi: add DSS RFBI node

Tony Lindgren (2):
      Merge branch 'omap-for-v3.17/dt' into omap-for-v3.18/dt
      Merge branch 'pull/v3.18/for-dt-pinctrl-updates' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.18/dt

 .../devicetree/bindings/arm/omap/omap.txt          |  12 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   5 +
 arch/arm/boot/dts/am33xx.dtsi                      |   4 +
 arch/arm/boot/dts/am4372.dtsi                      |   8 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   2 +
 arch/arm/boot/dts/dra7.dtsi                        |  24 +-
 arch/arm/boot/dts/dra72-evm.dts                    | 120 ++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |   8 +
 arch/arm/boot/dts/omap2430.dtsi                    |   4 +
 .../boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} | 150 ++++++++-
 arch/arm/boot/dts/omap3-gta04a3.dts                |  48 +++
 arch/arm/boot/dts/omap3-gta04a4.dts                |  13 +
 arch/arm/boot/dts/omap3-gta04a5.dts                |  17 ++
 arch/arm/boot/dts/omap3-ha-common.dtsi             |  88 ++++++
 arch/arm/boot/dts/omap3-ha-lcd.dts                 | 165 ++++++++++
 arch/arm/boot/dts/omap3-ha.dts                     |  28 ++
 arch/arm/boot/dts/omap3-tao3530.dtsi               | 337 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-thunder.dts                | 129 ++++++++
 arch/arm/boot/dts/omap3.dtsi                       |   4 +
 arch/arm/boot/dts/omap4.dtsi                       |   8 +
 arch/arm/boot/dts/omap5-sbc-t54.dts                |   4 +-
 arch/arm/boot/dts/omap5.dtsi                       |  37 ++-
 arch/arm/mach-omap2/board-generic.c                |   4 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   6 +
 25 files changed, 1204 insertions(+), 28 deletions(-)
 rename arch/arm/boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} (67%)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a3.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a4.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5.dts
 create mode 100644 arch/arm/boot/dts/omap3-ha-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-ha-lcd.dts
 create mode 100644 arch/arm/boot/dts/omap3-ha.dts
 create mode 100644 arch/arm/boot/dts/omap3-tao3530.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-thunder.dts
