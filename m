From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 0/4] add openpandora device support
Date: Thu, 12 Feb 2015 14:03:42 +0100
Message-ID: <1423746226-700-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, marek@goldelico.com
List-Id: linux-omap@vger.kernel.org

This series of patches adds initial device tree support for the
OpenPandora. The most important parts are working (display, keyboard,
touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.

First patch add common dtsi file which is then used in 600mhz and 1ghz
variants of openpandora which support is added in patches 2 and 3.

H. Nikolaus Schaller (4):
  ARM: dts: omap3-pandora: add common device tree
  ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
  ARM: dts: omap3-pandora: add DM3730 1 GHz version
  ARM: dts: omap3-pandora: include in dts Makefile

 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/omap3-pandora-1ghz.dts    |  65 +++
 arch/arm/boot/dts/omap3-pandora-600mhz.dts  |  65 +++
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 641 ++++++++++++++++++++++++++++
 4 files changed, 773 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-600mhz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi

-- 
1.9.1
