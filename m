From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 00/10] ARM: dts: omap: another round of DTC warning fixes
Date: Mon,  1 Aug 2016 12:46:54 -0400
Message-ID: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

This is yet another series with fixes for DTC warnings caused by mismatches
between device nodes' unit names and reg properties.

The patches should not cause a functional change but were only build tested.

Best regards,
Javier


Javier Martinez Canillas (10):
  ARM: dts: omap3/am4372: add missing unit name to ocp node
  ARM: dts: omap3: overo: add missing unit name for lcd35 display
  ARM: dts: am335x/am437x: remove unneeded unit name for
    gpio-matrix-keypad
  ARM: dts: am335x/am437x: remove unneeded unit name for fixed
    regulators
  ARM: dts: da850/dm81x: remove unneeded unit name for fixed regulators
  ARM: dts: omap3/dra62x: remove unneeded unit name for fixed regulators
  ARM: dts: am335x/am437x: remove unneeded unit name for gpio-keys nodes
  ARM: dts: omap3/4: remove unneeded unit name for gpio-keys nodes
  ARM: dts: am335x/437x/57xx: remove unneeded unit name for gpio-leds
    nodes
  ARM: dts: omap3/4/5/dra7: remove unneeded unit name for gpio-leds
    nodes

 arch/arm/boot/dts/am335x-baltos.dtsi               |  4 +--
 arch/arm/boot/dts/am335x-base0033.dts              |  4 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 10 +++---
 arch/arm/boot/dts/am335x-cm-t335.dts               |  6 ++--
 arch/arm/boot/dts/am335x-evm.dts                   | 14 ++++-----
 arch/arm/boot/dts/am335x-evmsk.dts                 | 26 ++++++++--------
 arch/arm/boot/dts/am335x-icev2.dts                 | 36 +++++++++++-----------
 arch/arm/boot/dts/am335x-igep0033.dtsi             |  6 ++--
 arch/arm/boot/dts/am335x-lxm.dts                   |  4 +--
 arch/arm/boot/dts/am335x-nano.dts                  |  2 +-
 arch/arm/boot/dts/am335x-pepper.dts                | 16 +++++-----
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  2 +-
 arch/arm/boot/dts/am335x-shc.dts                   | 14 ++++-----
 arch/arm/boot/dts/am335x-sl50.dts                  | 10 +++---
 arch/arm/boot/dts/am335x-wega.dtsi                 |  2 +-
 arch/arm/boot/dts/am3517.dtsi                      |  2 +-
 arch/arm/boot/dts/am4372.dtsi                      |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |  2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                | 10 +++---
 arch/arm/boot/dts/am43x-epos-evm.dts               |  4 +--
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |  8 ++---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |  2 +-
 arch/arm/boot/dts/da850-evm.dts                    |  2 +-
 arch/arm/boot/dts/dm8148-evm.dts                   |  2 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |  2 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |  2 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |  2 +-
 arch/arm/boot/dts/dra7-evm.dts                     |  8 ++---
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  4 +--
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |  2 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |  4 +--
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |  4 +--
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |  4 +--
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |  4 +--
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  8 ++---
 arch/arm/boot/dts/omap3.dtsi                       |  2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |  2 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 +-
 43 files changed, 125 insertions(+), 125 deletions(-)

-- 
2.5.5
