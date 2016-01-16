From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/4] ARM: dts: igep00x0 and sl50 board fixes
Date: Sat, 16 Jan 2016 11:51:09 +0100
Message-ID: <1452941473-6349-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Pau Pajuel <ppajuel@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Please take in consideration the following patches for some of the boards
that I am currently maitaining. The first two patches apply to the IGEP
boards and the latest two apply to the SL50 board.

The patches are rebased on top of your omap-for-v4.5 branch.

Thanks,

Enric Balletbo i Serra (3):
  ARM: dts: igep00x0: Specify the device to be used for boot console
    output.
  ARM: dts: am335x-sl50: Specify the device to be used for boot console
    output.
  ARM: dts: am335x-sl50: Fix audio codec setup.

Pau Pajuel (1):
  ARM: dts: omap3-igep0030-common: Add USB Host support

 arch/arm/boot/dts/am335x-sl50.dts            | 24 ++++++++++++++--
 arch/arm/boot/dts/omap3-igep.dtsi            |  4 +++
 arch/arm/boot/dts/omap3-igep0030-common.dtsi | 41 ++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.1.0
