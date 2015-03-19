From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap device tree changes for v4.1, part1
Date: Thu, 19 Mar 2015 16:13:59 -0700
Message-ID: <14003.38126482$1426807144@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i354.relay.mailchannels.net ([174.136.5.215]:34336 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750932AbbCSXSt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 19:18:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42c=
df8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
v4.1-dt

for you to fetch changes up to 10709c0858d89716b10b7bbf6d825044f2f59602=
:

  ARM: dts: Update Nanobone dts file (2015-03-19 10:59:28 -0700)

----------------------------------------------------------------
Device tree related changes for omaps:

- Add support for ChiliSOM

- Add support for OpenPandora

- Add support for BeagleBoard NAND

- Enable crypto devices for omap3 devices

- Add bindings for omap3 camera support

- Updates for am437x and dra7x and dm816x SoCs

----------------------------------------------------------------
=46elipe Balbi (1):
      ARM: dts: am437x-idk: enable i2c2

H. Nikolaus Schaller (3):
      ARM: dts: omap3-pandora: add common device tree
      ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
      ARM: dts: omap3-pandora: add DM3730 1 GHz version

Marek Belisko (2):
      ARM: dts: omap3: Remove all references to ti,codec property
      Documentation: omap-twl4030: Move ti,codec property to optional

Mark Jackson (1):
      ARM: dts: Update Nanobone dts file

Matt Porter (1):
      Documentation: DT: omap_serial: document missing properties and a=
dd an example

Pali Roh=C3=A1r (4):
      ARM: dts: n9/n950: Enable omap crypto support
      ARM: dts: n900: Enable omap sham and include directly omap34xx.dt=
si
      ARM: dts: omap3-tao3530: Include directly omap34xx.dtsi
      ARM: dts: Remove files omap34xx-hs.dtsi and omap36xx-hs.dtsi

Peter Ujfalusi (2):
      ARM: dts: dra7xx-clocks: Add gate clock for CLKOUT2
      ARM: dts: am57xx-beagle-x15: Do not include the atl header

Roger Quadros (2):
      ARM: dts: omap3-beagle: Add NAND device
      ARM: dts: dra7x-evm: beagle-x15: Fix USB Peripheral

Rostislav Lisovy (3):
      ARM: dts: Add vendor prefix for Grinn
      ARM: dts: am335x: Add DTS for ChiliSOM module
      ARM: dts: am335x: Add Chiliboard DTS

Sakari Ailus (3):
      Documentation: DT: Add bindings for omap3isp
      ARM: dts: omap3: Add DT entries for OMAP 3 ISP
      ARM: dts: n950, n9: Add primary camera support

Suman Anna (1):
      ARM: dts: DRA7: Remove ti,timer-dsp and ti,timer-pwm properties

Tony Lindgren (3):
      ARM: dts: Fix typo for dm816x usb0_pins
      ARM: dts: Add cppi41 support for dm816x MUSB
      ARM: dts: Remove PIN_INPUT for dm816x McSPI

Vignesh R (1):
      ARM: dts: AM4372: update hdq compatible property

 .../devicetree/bindings/media/ti,omap3isp.txt      |  71 +++
 .../devicetree/bindings/serial/omap_serial.txt     |  20 +
 .../devicetree/bindings/sound/omap-twl4030.txt     |   3 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            | 112 ++++
 arch/arm/boot/dts/am335x-chilisom.dtsi             | 239 ++++++++
 arch/arm/boot/dts/am335x-nano.dts                  |  18 +-
 arch/arm/boot/dts/am4372.dtsi                      |   2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |  22 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   9 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |  14 +-
 arch/arm/boot/dts/dm816x.dtsi                      |  60 ++
 arch/arm/boot/dts/dra7-evm.dts                     |   8 +
 arch/arm/boot/dts/dra7.dtsi                        |   7 -
 arch/arm/boot/dts/dra72-evm.dts                    |   8 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |   8 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   1 -
 arch/arm/boot/dts/omap3-beagle.dts                 |  53 +-
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi              |   1 -
 arch/arm/boot/dts/omap3-devkit8000.dts             |   1 -
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   1 -
 arch/arm/boot/dts/omap3-igep.dtsi                  |   1 -
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   1 -
 arch/arm/boot/dts/omap3-n9.dts                     |  37 ++
 arch/arm/boot/dts/omap3-n900.dts                   |  16 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |   2 +-
 arch/arm/boot/dts/omap3-n950.dts                   |  37 ++
 arch/arm/boot/dts/omap3-overo-base.dtsi            |   1 -
 arch/arm/boot/dts/omap3-pandora-1ghz.dts           |  70 +++
 arch/arm/boot/dts/omap3-pandora-600mhz.dts         |  65 +++
 arch/arm/boot/dts/omap3-pandora-common.dtsi        | 640 +++++++++++++=
++++++++
 arch/arm/boot/dts/omap3-tao3530.dtsi               |  12 +-
 arch/arm/boot/dts/omap34xx-hs.dtsi                 |  16 -
 arch/arm/boot/dts/omap34xx.dtsi                    |  17 +
 arch/arm/boot/dts/omap36xx-hs.dtsi                 |  16 -
 arch/arm/boot/dts/omap36xx.dtsi                    |  17 +
 include/dt-bindings/media/omap3-isp.h              |  22 +
 39 files changed, 1565 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,omap3isp=
=2Etxt
 create mode 100644 arch/arm/boot/dts/am335x-chiliboard.dts
 create mode 100644 arch/arm/boot/dts/am335x-chilisom.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-600mhz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi
 delete mode 100644 arch/arm/boot/dts/omap34xx-hs.dtsi
 delete mode 100644 arch/arm/boot/dts/omap36xx-hs.dtsi
 create mode 100644 include/dt-bindings/media/omap3-isp.h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
