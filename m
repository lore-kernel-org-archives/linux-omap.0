From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 00/23] ARM: dts: omap: Remove skeleton.dtsi usage and fix memory node DTC warning"
Date: Wed, 31 Aug 2016 12:35:14 +0200
Message-ID: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-omap@vger.kernel.org

Hello Tony,

This series removes the usage of the skeleton.dtsi in all the OMAP dts,
which allows to get rid of the DTC warnings about a mismatch between the
memory nodes unit names and reg properties.

Patches are pretty trivial and shouldn't cause functional changes AFAIK,
but have been only built tested.

Best regards,
Javier


Javier Martinez Canillas (23):
  ARM: am335x: Add missing memory node in sl50 board
  ARM: omap3: Add missing memory node in overo and torpedo boards
  ARM: dts: omap2: Remove skeleton.dtsi usage
  ARM: dts: omap3: Remove skeleton.dtsi usage
  ARM: dts: omap4: Remove skeleton.dtsi usage
  ARM: dts: omap5: Remove skeleton.dtsi usage
  ARM: dts: am33xx: Remove skeleton.dtsi usage
  ARM: dts: dm814x: Remove skeleton.dtsi usage
  ARM: dts: dm816x: Remove skeleton.dtsi usage
  ARM: dts: dra7: Remove skeleton.dtsi usage
  ARM: dts: am4372: Remove skeleton.dtsi usage
  ARM: dts: omap2: Add missing unit name to memory nodes
  ARM: dts: omap3: Add missing unit name to memory nodes
  ARM: dts: omap4: Add missing unit name to memory nodes
  ARM: dts: omap5: Add missing unit name to memory nodes
  ARM: dts: am335x: Add missing unit name to memory nodes
  ARM: dts: am3517: Add missing unit name to memory nodes
  ARM: dts: am4372: Add missing unit name to memory nodes
  ARM: dts: am572x: Add missing unit name to memory nodes
  ARM: dts: dm8148: Add missing unit name to memory nodes
  ARM: dts: dm8168: Add missing unit name to memory nodes
  ARM: dts: dra62x: Add missing unit name to memory nodes
  ARM: dts: dra7: Add missing unit name to memory nodes

 arch/arm/boot/dts/am335x-baltos.dtsi           | 2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi      | 2 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi         | 2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts           | 2 +-
 arch/arm/boot/dts/am335x-evm.dts               | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts             | 2 +-
 arch/arm/boot/dts/am335x-icev2.dts             | 2 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi         | 2 +-
 arch/arm/boot/dts/am335x-lxm.dts               | 2 +-
 arch/arm/boot/dts/am335x-nano.dts              | 2 +-
 arch/arm/boot/dts/am335x-pepper.dts            | 2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi      | 2 +-
 arch/arm/boot/dts/am335x-shc.dts               | 2 +-
 arch/arm/boot/dts/am335x-sl50.dts              | 5 +++++
 arch/arm/boot/dts/am33xx.dtsi                  | 4 ++--
 arch/arm/boot/dts/am3517-craneboard.dts        | 2 +-
 arch/arm/boot/dts/am3517-evm.dts               | 2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts        | 2 +-
 arch/arm/boot/dts/am4372.dtsi                  | 8 ++++++--
 arch/arm/boot/dts/am572x-idk.dts               | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts        | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts      | 2 +-
 arch/arm/boot/dts/dm8148-evm.dts               | 2 +-
 arch/arm/boot/dts/dm8148-t410.dts              | 2 +-
 arch/arm/boot/dts/dm814x.dtsi                  | 4 ++--
 arch/arm/boot/dts/dm8168-evm.dts               | 2 +-
 arch/arm/boot/dts/dm816x.dtsi                  | 4 ++--
 arch/arm/boot/dts/dra62x-j5eco-evm.dts         | 2 +-
 arch/arm/boot/dts/dra7-evm.dts                 | 2 +-
 arch/arm/boot/dts/dra7.dtsi                    | 2 --
 arch/arm/boot/dts/dra72-evm-revc.dts           | 2 +-
 arch/arm/boot/dts/dra72-evm.dts                | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     | 5 +++++
 arch/arm/boot/dts/omap2.dtsi                   | 4 ++--
 arch/arm/boot/dts/omap2420-h4.dts              | 2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi    | 2 +-
 arch/arm/boot/dts/omap2430-sdp.dts             | 2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts          | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts             | 2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi            | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi | 2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts           | 2 +-
 arch/arm/boot/dts/omap3-evm.dts                | 2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi             | 2 +-
 arch/arm/boot/dts/omap3-igep.dtsi              | 2 +-
 arch/arm/boot/dts/omap3-ldp.dts                | 2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi        | 2 +-
 arch/arm/boot/dts/omap3-n900.dts               | 2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi        | 6 ++++++
 arch/arm/boot/dts/omap3-pandora-common.dtsi    | 2 +-
 arch/arm/boot/dts/omap3-sniper.dts             | 2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts              | 2 +-
 arch/arm/boot/dts/omap3.dtsi                   | 4 ++--
 arch/arm/boot/dts/omap3430-sdp.dts             | 2 +-
 arch/arm/boot/dts/omap4-duovero.dtsi           | 2 +-
 arch/arm/boot/dts/omap4-kc1.dts                | 2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi      | 2 +-
 arch/arm/boot/dts/omap4-sdp.dts                | 2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi      | 2 +-
 arch/arm/boot/dts/omap4.dtsi                   | 4 ++--
 arch/arm/boot/dts/omap5-cm-t54.dts             | 2 +-
 arch/arm/boot/dts/omap5-igep0050.dts           | 2 +-
 arch/arm/boot/dts/omap5-uevm.dts               | 2 +-
 arch/arm/boot/dts/omap5.dtsi                   | 2 --
 66 files changed, 88 insertions(+), 72 deletions(-)

-- 
2.7.4
