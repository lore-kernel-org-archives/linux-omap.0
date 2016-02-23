From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 0/9] ARM: dts: omap2+: GPMC NAND node fixes
Date: Tue, 23 Feb 2016 18:37:16 +0200
Message-ID: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

These patches are a preparatory step towards the NAND DT cleanup
done in [1].

They mostly deal with adding the missing compatible property and
interrupt resources and fixing up register resources for the
NAND nodes.

Patches based on v4.5-rc1.

Tested on dra7-evm, am437x-gp-evm and omap3-beagle.

cheers,
-roger

[1] - http://article.gmane.org/gmane.linux.kernel/2156857

--
Roger Quadros (9):
  ARM: dts: dra7: Fix NAND device nodes.
  ARM: dts: dra7: Remove redundant nand property
  ARM: dts: am437x: Fix NAND device nodes
  ARM: dts: am437x: Disable wait pin monitoring for NAND
  ARM: dts: am335x: Fix NAND device nodes
  ARM: dts: am335x: Disable wait pin monitoring for NAND
  ARM: dts: dm816x: Fix NAND device nodes
  ARM: dts: dm8168-evm: ARM: dts: Disable wait pin monitoring for NAND
  ARM: dts: omap3: Fix NAND device nodess

 arch/arm/boot/dts/am335x-baltos-ir5221.dts        |  9 +++++----
 arch/arm/boot/dts/am335x-chilisom.dtsi            |  8 +++++---
 arch/arm/boot/dts/am335x-cm-t335.dts              | 10 ++++++----
 arch/arm/boot/dts/am335x-evm.dts                  |  7 ++++---
 arch/arm/boot/dts/am335x-igep0033.dtsi            |  8 +++++---
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |  8 +++++---
 arch/arm/boot/dts/am33xx.dtsi                     |  2 ++
 arch/arm/boot/dts/am4372.dtsi                     |  2 ++
 arch/arm/boot/dts/am437x-cm-t43.dts               | 11 +++++------
 arch/arm/boot/dts/am437x-gp-evm.dts               |  8 +++++---
 arch/arm/boot/dts/am43x-epos-evm.dts              |  8 +++++---
 arch/arm/boot/dts/dm8168-evm.dts                  |  8 +++++---
 arch/arm/boot/dts/dm816x.dtsi                     |  2 ++
 arch/arm/boot/dts/dra7-evm.dts                    |  7 +++++--
 arch/arm/boot/dts/dra7.dtsi                       |  2 ++
 arch/arm/boot/dts/dra72-evm.dts                   |  7 +++++--
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts |  3 ++-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        |  8 ++++++--
 arch/arm/boot/dts/omap3-beagle.dts                |  5 ++++-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi               |  6 +++++-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi    |  4 ++++
 arch/arm/boot/dts/omap3-evm-37xx.dts              |  8 ++++++--
 arch/arm/boot/dts/omap3-gta04.dtsi                |  4 ++++
 arch/arm/boot/dts/omap3-igep.dtsi                 |  6 +++++-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi      |  4 ++--
 arch/arm/boot/dts/omap3-igep0030-common.dtsi      |  4 ++++
 arch/arm/boot/dts/omap3-ldp.dts                   | 10 +++++++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi           |  6 +++++-
 arch/arm/boot/dts/omap3-overo-base.dtsi           |  6 +++++-
 arch/arm/boot/dts/omap3-pandora-common.dtsi       |  4 ++++
 arch/arm/boot/dts/omap3-tao3530.dtsi              |  6 +++++-
 arch/arm/boot/dts/omap3.dtsi                      |  2 ++
 arch/arm/boot/dts/omap3430-sdp.dts                |  6 +++++-
 33 files changed, 143 insertions(+), 56 deletions(-)

-- 
2.5.0
