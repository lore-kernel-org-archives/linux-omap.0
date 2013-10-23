From: Benoit Cousson <bcousson@baylibre.com>
Subject: [GIT PULL] ARM: OMAP: Some more more Device Tree for 3.13
Date: Wed, 23 Oct 2013 11:48:55 +0200
Message-ID: <52679B87.5020108@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:48219 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab3JWJtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 05:49:00 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so190228bkb.0
        for <linux-omap@vger.kernel.org>; Wed, 23 Oct 2013 02:48:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Tony,

Please pull the branch for even more OMAP Device Tree for v3.13 or later.

Thanks,
Benoit


The following changes since commit 6a96867844895008558810853c7838af39dd317c:

  ARM: dts: AM33xx+: Add i2c aliases (2013-10-22 11:05:42 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git tags/for_3.13_super_late/dts_signed

for you to fetch changes up to b306e7b819edd0515e18f5ca7e0d1cb4b0e4e58a:

  ARM: dts: omap5-uevm: Remove pinmux for dmic pins (2013-10-23 11:40:47 +0200)

----------------------------------------------------------------
Add a lot of N900 nodes
Add OPP table to OMAP5/DRA7
Add support for Newflow NanoBone board

----------------------------------------------------------------
Eric Witcher (1):
      ARM: dts: omap5-uevm: fix mcspi node pin descriptions

J Keerthy (3):
      ARM: dts: dra7-evm: add smps123 supply for CPU
      ARM: dts: OMAP5: Add CPU OPP table
      ARM: dts: DRA7: Add CPU OPP table

Mark Jackson (1):
      ARM: dts: Add support for Newflow NanoBone board

Markus Pargmann (1):
      ARM: dts: am33xx, change usb ctrl module label

Nishanth Menon (1):
      ARM: dts: omap5-uevm: add smps123 supply for CPU

Peter Ujfalusi (2):
      ARM: dts: omap5-uevm: Correct twl6040 reset GPIO pinmux
      ARM: dts: omap5-uevm: Remove pinmux for dmic pins

Sebastian Reichel (14):
      ARM: dts: omap3-n900: Add pinctrl for i2c devices
      ARM: dts: omap3-n900: Fix i2c bus speed
      ARM: dts: omap3-n900: Add UART support
      ARM: dts: omap3-n900: Add support for SD cards
      ARM: dts: omap3-n900: GPIO key definitions
      ARM: dts: omap3-n900: Add vibrator device
      ARM: dts: omap3-n900: Add LP5523 support
      ARM: dts: TWL4030: Add missing regulators
      ARM: dts: omap3-n900: Specify regulator info
      ARM: dts: omap3-n900: Add NAND support
      ARM: dts: omap3-n900:: Mux RX51_LCD_RESET_GPIO in DTS
      ARM: dts: omap3-n900: Add TLV320AIC3X support
      ARM: dts: omap3-n900: Add LP5523 support
      ARM: dts: TWL4030: Add power button support

 MAINTAINERS                       |   6 +
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/am335x-nano.dts | 431 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   6 +-
 arch/arm/boot/dts/dra7-evm.dts    |   4 +
 arch/arm/boot/dts/dra7.dtsi       |   8 +-
 arch/arm/boot/dts/omap3-n900.dts  | 396 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap5-uevm.dts  |  34 ++-
 arch/arm/boot/dts/omap5.dtsi      |   9 +-
 arch/arm/boot/dts/twl4030.dtsi    |  49 ++++-
 10 files changed, 912 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-nano.dts
