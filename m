From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH 00/17] ARM: dts: am335x: Replace numeric pinmux address w. macro for remaining boards
Date: Fri, 12 Apr 2019 18:26:10 +0200
Message-ID: <20190412162627.24518-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Christina Quast <cquast@hanoverdisplays.com>, Benoit Cousson <bcousson@baylibre.com>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Last patch set of the patch series for the remaining 17 boards.

Depends on the following patch set:
[PATCH v2 0/6] ARM: dts: am335x: Replace numeric pinmux address with macro defines

Christina Quast (17):
  ARM: dts: am335x: igep0033: Replaced register offsets with defines
  ARM: dts: am335x: lxm: Replaced register offsets with defines
  ARM: dts: am335x: moxa-uc-2100-common: Replaced register offsets with
    defines
  ARM: dts: am335x: moxa-uc-2101: Replaced register offsets with defines
  ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with
    defines
  ARM: dts: am335x: nano: Replaced register offsets with defines
  ARM: dts: am335x: osd3358-sm-red: Replaced register offsets with
    defines
  ARM: dts: am335x: osd335x-common: Replaced register offsets with
    defines
  ARM: dts: am335x: pcm-953: Replaced register offsets with defines
  ARM: dts: am335x: pdu001: Replaced register offsets with defines
  ARM: dts: am335x: pepper: Replaced register offsets with defines
  ARM: dts: am335x: phycore-som: Replaced register offsets with defines
  ARM: dts: am335x: sancloud-bbe: Replaced register offsets with defines
  ARM: dts: am335x: sbc-t335: Replaced register offsets with defines
  ARM: dts: am335x: shc: Replaced register offsets with defines
  ARM: dts: am335x: sl50: Replaced register offsets with defines
  ARM: dts: am335x: wega: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-igep0033.dtsi        |  40 ++--
 arch/arm/boot/dts/am335x-lxm.dts              | 120 +++++-----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  |  42 ++--
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  24 +-
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 ++++-----
 arch/arm/boot/dts/am335x-nano.dts             | 132 +++++-----
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts   | 168 ++++++-------
 arch/arm/boot/dts/am335x-osd335x-common.dtsi  |   4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  74 +++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 170 ++++++-------
 arch/arm/boot/dts/am335x-pepper.dts           | 200 ++++++++--------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  60 ++---
 arch/arm/boot/dts/am335x-sancloud-bbe.dts     |  62 ++---
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 152 +++++-------
 arch/arm/boot/dts/am335x-shc.dts              | 226 +++++++++---------
 arch/arm/boot/dts/am335x-sl50.dts             | 208 ++++++++--------
 arch/arm/boot/dts/am335x-wega.dtsi            |  68 +++---
 17 files changed, 912 insertions(+), 954 deletions(-)

-- 
2.20.1
