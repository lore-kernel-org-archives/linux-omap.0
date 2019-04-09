From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 00/15] ARM: dts: am335x: Replace numeric pinmux address w. macro for more boards
Date: Tue,  9 Apr 2019 18:03:31 +0200
Message-ID: <20190409160346.25599-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Depends on the following patch set:
[PATCH v2 0/6] ARM: dts: am335x: Replace numeric pinmux address with macro defines

Replace the numeric pinmux address with the macro defines for an additional 15 boards.

Christina Quast (15):
  ARM: dts: am335x: baltos-ir2110: Replaced register offsets with
    defines
  ARM: dts: am335x: baltos-ir3220: Replaced register offsets with
    defines
  ARM: dts: am335x: baltos-ir5221: Replaced register offsets with
    defines
  ARM: dts: am335x: baltos-leds: Replaced register offsets with defines
  ARM: dts: am335x: baltos: Replaced register offsets with defines
  ARM: dts: am335x: base0033: Replaced register offsets with defines
  ARM: dts: am335x: bonegreen-wireless: Replaced register offsets with
    defines
  ARM: dts: am335x: boneblue: Replaced register offsets with defines
  ARM: dts: am335x: bonegreen-common: Replaced register offsets with
    defines
  ARM: dts: am335x: chiliboard: Replaced register offsets with defines
  ARM: dts: am335x: chilisom: Replaced register offsets with defines
  ARM: dts: am335x: cm-t335: Replaced register offsets with defines
  ARM: dts: am335x: evm: Replaced register offsets with defines
  ARM: dts: am335x: evmsk: Replaced register offsets with defines
  ARM: dts: am335x: icev2: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  36 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  40 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 140 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  48 +--
 arch/arm/boot/dts/am335x-boneblue.dts         | 104 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   4 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  66 ++--
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  32 +-
 arch/arm/boot/dts/am335x-cm-t335.dts          | 190 +++++-------
 arch/arm/boot/dts/am335x-evm.dts              | 234 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 292 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 116 +++----
 15 files changed, 658 insertions(+), 694 deletions(-)

-- 
2.20.1
