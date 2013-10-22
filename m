From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 00/14] DTS: ARM: OMAP3-N900: Add misc. HW
Date: Wed, 23 Oct 2013 00:49:29 +0200
Message-ID: <1382482183-14426-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

This patchset adds misc. hardware elements to the Nokia N900 DTS
file. Apart from the last two patches the kernel drivers in 3.12
are already capable of handling the DT entries.

The series is based on bcousson/linux-omap-dt.git:for_3.13/dts.

Additional notes:

* LP5523 support depends on [0], which goes through the
  Bryan Wu's tree.
* TWL4030 supports depends on [1], which is not yet queued.
* Apart from those two I did not include any patches, which
  also need changes in the drivers.

[0] https://lkml.org/lkml/2013/10/22/166
[1] https://lkml.org/lkml/2013/10/22/147

-- Sebastian

Sebastian Reichel (14):
  DTS: ARM: OMAP3-N900: Add pinctrl for i2c devices
  DTS: ARM: OMAP3-N900: Fix i2c bus speed
  DTS: ARM: OMAP3-N900: Add UART support
  DTS: ARM: OMAP3-N900: Add support for SD cards
  DTS: ARM: OMAP3-N900: GPIO key definitions
  DTS: ARM: OMAP3-N900: Add vibrator device
  DTS: ARM: OMAP3-N900: Add LP5523 support
  DTS: TWL4030: Add missing regulators
  DTS: ARM: OMAP3-N900: Specify regulator info
  DTS: ARM: OMAP3-N900: Add NAND support
  DTS: ARM: OMAP3-N900: Mux RX51_LCD_RESET_GPIO in DTS
  DTS: ARM: OMAP3-N900: Add TLV320AIC3X support
  DTS: ARM: OMAP3-N900: Add LP5523 support
  DTS: TWL4030: Add power button support

 arch/arm/boot/dts/omap3-n900.dts | 396 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/twl4030.dtsi   |  49 ++++-
 2 files changed, 438 insertions(+), 7 deletions(-)

-- 
1.8.4.rc3
