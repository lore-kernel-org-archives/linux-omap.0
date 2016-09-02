From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] ARM: dts: Introduce support for rev BeagleBoard-X15 B1
Date: Fri, 2 Sep 2016 12:14:43 -0500
Message-ID: <20160902171445.27757-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, robertcnelson@gmail.com, nsekhar@ti.com, jkridner@beagleboard.org, beagleboard-x15@googlegroups.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Please find the series to cleanup and support Production version of
Beagleboard-X15 rev B1 support.

More  details can be found at https://github.com/beagleboard/beagleboard-x15

Bootlog on B1:  http://pastebin.ubuntu.com/23124704/ (sd and hdmi hpd tested)

Based on:
https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.9/dt
omap-for-v4.9/dt  5c4d9f0d49b0 ARM: dts: dra7: Add missing unit name to memory nodes

Changes listed in context of each of the patches.

Nishanth Menon (2):
  ARM: dts: am57xx-beagle-x15: Remove pinmux configurations for erratum
    i869
  ARM: dts: am57xx-beagle-x15: Add support for rev B1

 arch/arm/boot/dts/Makefile                         |   1 +
 ...eagle-x15.dts => am57xx-beagle-x15-common.dtsi} | 230 +-----
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |  24 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 812 +--------------------
 4 files changed, 34 insertions(+), 1033 deletions(-)
 copy arch/arm/boot/dts/{am57xx-beagle-x15.dts => am57xx-beagle-x15-common.dtsi} (60%)
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts

-- 
2.9.1.200.gb1ec08f
