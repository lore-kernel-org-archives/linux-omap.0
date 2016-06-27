From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 00/27] ARM: dts: omap: More fixes for DTC warnings
Date: Mon, 27 Jun 2016 15:20:41 -0400
Message-ID: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org


Hello Tony,

This is another series with trivial fixes for DTC warnings about mismatches
between unit names and reg properties in different device nodes. The series
fixes only some of the reported warning and there are still a lot remaining.

The patches should not cause a functional change but were only build tested.

Best regards,
Javier


Javier Martinez Canillas (27):
  ARM: dts: omap2: add missing unit name to func_96m_ck
  ARM: dts: am3517-craneboard: remove unneeded unit name for
    fixedregulator
  ARM: dts: dm3730-torpedo-devkit: remove unneeded unit names
  ARM: dts: n900: remove unneeded unit name for dmtimer-pwm
  ARM: dts: omap3-beagle: remove unneeded unit names
  ARM: dts: omap3-beagle-xm: remove unneeded unit names
  ARM: dts: cm-t3x: remove unneeded unit name in connector
  ARM: dts: omap3-devkit8000: remove unneeded unit names
  ARM: dts: omap3-devkit8000-lcd-common: remove unneeded unit names
  ARM: dts: omap3-gta04: remove unneeded unit names
  ARM: dts: omap3-ha-lcd: remove unneeded unit name
  ARM: dts: omap3: overo: remove unneded unit names in display nodes
  ARM: dts: omap3-igep0020-common: remove unneded unit names
  ARM: dts: omap3-overo-common-dvi: remove unneded unit names
  ARM: dts: omap3-pandora-common: remove unneded unit name
  ARM: dts: sbc-t3x30: remove unneded unit names
  ARM: dts: omap3-thunder: remove unneded unit name
  ARM: dts: omap4-duovero-parlor: remove unneded unit name
  ARM: dts: omap4-panda-common: remove unneded unit names
  ARM: dts: omap4-sdp: remove unneded unit names
  ARM: dts: omap4-var-om44customboard: remove unneded unit name
  ARM: dts: am43xx-epos-evm: remove unneded unit name
  ARM: dts: am437x-gp-evm: remove unneded unit name
  ARM: dts: am437x: cm-t43: remove unneded unit names
  ARM: dts: omap5-cm-t54: remove unneded unit names and add reg
    properties
  ARM: dts: omap5-board-common: remove unneded unit names
  ARM: dts: am57xx: sbc-am57x: remove unneded unit name

 arch/arm/boot/dts/am3517-craneboard.dts            |  2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |  2 +-
 arch/arm/boot/dts/am437x-sbc-t43.dts               |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/boot/dts/am57xx-sbc-am57x.dts             |  2 +-
 arch/arm/boot/dts/compulab-sb-som.dtsi             |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  4 ++--
 arch/arm/boot/dts/omap24xx-clocks.dtsi             |  2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              | 10 +++++-----
 arch/arm/boot/dts/omap3-beagle.dts                 | 10 +++++-----
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     | 12 ++++++------
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  4 ++--
 arch/arm/boot/dts/omap3-devkit8000-lcd43.dts       |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd70.dts       |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  8 ++++----
 arch/arm/boot/dts/omap3-ha-lcd.dts                 |  2 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       |  8 ++++----
 arch/arm/boot/dts/omap3-n900.dts                   |  2 +-
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi      |  8 ++++----
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |  8 ++++----
 arch/arm/boot/dts/omap3-thunder.dts                |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 16 ++++++++--------
 arch/arm/boot/dts/omap4-sdp.dts                    |  8 ++++----
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |  2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |  8 ++++----
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 15 ++++++++++-----
 31 files changed, 80 insertions(+), 75 deletions(-)

-- 
2.5.5
