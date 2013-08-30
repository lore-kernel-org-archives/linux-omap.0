From: Benoit Cousson <bcousson@baylibre.com>
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.12 take #2
Date: Fri, 30 Aug 2013 22:30:55 +0200
Message-ID: <522100FF.5030204@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:47877 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab3H3UbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 16:31:04 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so2019724wes.32
        for <linux-omap@vger.kernel.org>; Fri, 30 Aug 2013 13:31:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@linaro.org" <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Kevin & Olof,

Here is the updated version without the conflicting patch (ARM: dts: AM33XX: don't redefine OCP bus and device nodes) and with the signed tag.
There is still a small conflict with usb-next, but it is easily fixable, and already fixed by Stephen.

Thanks,
Benoit


The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git tags/for_3.12/dts_signed

for you to fetch changes up to 4843be165c10f9886c87eeb20acf19a3ddec6653:

  ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-08-30 21:33:13 +0200)

----------------------------------------------------------------
Add the minimal DTS support for DRA7xx based SoC core.
Add the initial support for N900 and gta04 phones.
Enable USB3 on OMAP5 evm board.
Do a lot of various cleanups.

----------------------------------------------------------------
Afzal Mohammed (2):
      ARM: dts: AM4372: cpu(s) node per latest binding
      ARM: dts: AM4372: add few nodes

Alexandre Belloni (1):
      ARM: dts: AM33XX: Add PMU support

Benoit Cousson (1):
      ARM: OMAP5: hwmod: add missing ocp2scp hwmod data

Felipe Balbi (4):
      ARM: OMAP5: dts: fix reg property size
      ARM: OMAP5: dts: fix ocp2scp DTS data
      ARM: OMAP5: dts: add palmas-usb node
      ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies

Javier Martinez Canillas (4):
      ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
      ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
      ARM: dts: omap3-igep0030: add mux conf for GPIO LED
      ARM: dts: AM33XX: use pinmux node defined in included file

Kishon Vijay Abraham I (1):
      ARM: dts: omap5-uevm: Split SMPS10 in two nodes

Lars Poeschel (1):
      ARM: dts: AM33xx: Correct gpio #interrupt-cells property

Lee Jones (7):
      ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
      ARM: dts: Remove '0x's from OMAP3 IGEP0020 DTS file
      ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
      ARM: dts: Remove '0x's from OMAP3 DTS file
      ARM: dts: Remove '0x's from OMAP3430 SDP DTS file
      ARM: dts: Remove '0x's from OMAP4 DTS file
      ARM: dts: Remove '0x's from OMAP5 DTS file

Marek Belisko (1):
      ARM: dts: Add devicetree for gta04 board.

Pavel Machek (1):
      ARM: dts: N900: Add device tree

R Sricharan (1):
      ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board

Robert Nelson (1):
      ARM: dts: omap3-beagle-xm: fix string error in compatible property

Roger Quadros (1):
      ARM: dts: omap3-beagle: Make USB host pin naming consistent

Ruslan Bilovol (1):
      ARM: dts: twl6030: Move common configuration for OMAP4 boards in a separate dtsi file

 arch/arm/boot/dts/Makefile                 |   5 +-
 arch/arm/boot/dts/am335x-bone.dts          | 176 ++++-----
 arch/arm/boot/dts/am335x-evm.dts           | 254 ++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts         | 258 ++++++-------
 arch/arm/boot/dts/am33xx.dtsi              |  13 +-
 arch/arm/boot/dts/am4372.dtsi              | 347 +++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts             | 140 +++++++
 arch/arm/boot/dts/dra7.dtsi                | 575 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap2420-h4.dts          |   6 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts      |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts         |  24 +-
 arch/arm/boot/dts/omap3-gta04.dts          | 168 +++++++++
 arch/arm/boot/dts/omap3-igep.dtsi          |   2 +
 arch/arm/boot/dts/omap3-igep0020.dts       |  19 +-
 arch/arm/boot/dts/omap3-igep0030.dts       |  17 +-
 arch/arm/boot/dts/omap3-n900.dts           |  92 +++++
 arch/arm/boot/dts/omap3.dtsi               |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts         |  22 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi  |  21 +-
 arch/arm/boot/dts/omap4-sdp.dts            |  21 +-
 arch/arm/boot/dts/omap4.dtsi               |   2 +-
 arch/arm/boot/dts/omap5-uevm.dts           |  25 +-
 arch/arm/boot/dts/omap5.dtsi               |  13 +-
 arch/arm/boot/dts/twl6030_omap4.dtsi       |  38 ++
 arch/arm/configs/omap2plus_defconfig       |   9 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  45 +++
 include/dt-bindings/pinctrl/dra.h          |  50 +++
 27 files changed, 1912 insertions(+), 434 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-evm.dts
 create mode 100644 arch/arm/boot/dts/dra7.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-gta04.dts
 create mode 100644 arch/arm/boot/dts/omap3-n900.dts
 create mode 100644 arch/arm/boot/dts/twl6030_omap4.dtsi
 create mode 100644 include/dt-bindings/pinctrl/dra.h
