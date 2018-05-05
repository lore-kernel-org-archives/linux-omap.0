From: Christina Quast <cquast@baylibre.com>
Subject: [PATCH v2 0/2] Add macro defines for AM335x
Date: Sat,  5 May 2018 10:59:19 +0200
Message-ID: <20180505085921.5513-1-cquast@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Christina Quast <cquast@baylibre.com>
List-Id: linux-omap@vger.kernel.org

This patchset replaces the register offsets for am335x with macro defines.
The values are extraced from the "AM335x SitaraTM Processors Technical
Reference Manual".

The TRM lists AM3351, AM3352, AM3354, AM3356, AM3357, AM3358 and AM3359 on page 173.
So I would assume the registers are the same for all of those.

Furthermore, one register was eliminated in revision M in the datasheet,
but I added it to to the table of defines.

Christina Quast (2):
  ARM: dts: am335x: Replace numeric pinmux address with macro defines
  ARM: dts: am335x: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  17 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  39 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  43 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   7 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 141 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  49 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi     | 105 +++----
 .../arm/boot/dts/am335x-boneblack-common.dtsi |  55 ++--
 .../boot/dts/am335x-boneblack-wireless.dts    |  29 +-
 arch/arm/boot/dts/am335x-boneblue.dts         | 105 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   5 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  29 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  67 ++---
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  35 +--
 arch/arm/boot/dts/am335x-cm-t335.dts          | 155 +++++-----
 arch/arm/boot/dts/am335x-evm.dts              | 221 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 279 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 117 ++++----
 arch/arm/boot/dts/am335x-igep0033.dtsi        |  41 +--
 arch/arm/boot/dts/am335x-lxm.dts              | 121 ++++----
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 117 ++++----
 arch/arm/boot/dts/am335x-nano.dts             | 141 ++++-----
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  75 ++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 171 +++++------
 arch/arm/boot/dts/am335x-pepper.dts           | 201 ++++++-------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  61 ++--
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 113 +++----
 arch/arm/boot/dts/am335x-shc.dts              | 225 +++++++-------
 arch/arm/boot/dts/am335x-sl50.dts             | 153 +++++-----
 arch/arm/boot/dts/am335x-wega.dtsi            |  69 ++---
 include/dt-bindings/pinctrl/am335x.h          | 147 +++++++++
 31 files changed, 1655 insertions(+), 1478 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am335x.h

-- 
2.17.0
