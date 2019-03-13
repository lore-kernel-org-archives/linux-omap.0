From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 0/2] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Date: Wed, 13 Mar 2019 15:27:22 +0100
Message-ID: <20190313142724.27446-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, mpfj@newflow.co.uk, cquast@hanoverdisplays.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patchset replaces the register offsets for am335x with macro defines.
The values are extraced from the "AM335x SitaraTM Processors Technical
Reference Manual".

Updated AM33XX_IOPAD to take three instead of two parameters, to make
future changes to #pinctrl-cells easier.

Christina Quast (2):
  ARM: dts: am335x: Replace numeric pinmux address with macro defines
  ARM: dts: am335x: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  38 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  42 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 140 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  48 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi     | 116 +++----
 .../arm/boot/dts/am335x-boneblack-common.dtsi |  54 ++--
 .../boot/dts/am335x-boneblack-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-boneblue.dts         | 104 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   4 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  66 ++--
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  34 +-
 arch/arm/boot/dts/am335x-cm-t335.dts          | 154 ++++-----
 arch/arm/boot/dts/am335x-evm.dts              | 234 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 292 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 116 +++----
 arch/arm/boot/dts/am335x-igep0033.dtsi        |  40 +--
 arch/arm/boot/dts/am335x-lxm.dts              | 120 +++----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  |  42 +--
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  24 +-
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 +++----
 arch/arm/boot/dts/am335x-nano.dts             | 140 ++++-----
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts   | 168 +++++-----
 arch/arm/boot/dts/am335x-osd335x-common.dtsi  |   4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  74 ++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 170 +++++-----
 arch/arm/boot/dts/am335x-pepper.dts           | 200 ++++++------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  60 ++--
 arch/arm/boot/dts/am335x-pocketbeagle.dts     |  56 ++--
 arch/arm/boot/dts/am335x-sancloud-bbe.dts     |  62 ++--
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 112 +++----
 arch/arm/boot/dts/am335x-shc.dts              | 224 +++++++-------
 arch/arm/boot/dts/am335x-sl50.dts             | 208 ++++++-------
 arch/arm/boot/dts/am335x-wega.dtsi            |  68 ++--
 arch/arm/boot/dts/am33xx.dtsi                 |   1 +
 include/dt-bindings/pinctrl/am335x.h          | 236 ++++++++++++++
 include/dt-bindings/pinctrl/omap.h            |   2 +-
 39 files changed, 1942 insertions(+), 1705 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am335x.h

-- 
2.20.1
