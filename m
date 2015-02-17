From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 0/3] ARM: dts: add openpandora device support
Date: Tue, 17 Feb 2015 20:52:20 +0100
Message-ID: <1424202743-26387-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, marek@goldelico.com
List-Id: linux-omap@vger.kernel.org

changes from v1:
- add new boards to makefile in patch 2,3 (don't add them
in separate commit together), fix gpmc issues (reported by Tony Lindgren)

- fix various issues reported by Grazvydas Ignotas
(drop internal pullups from pinmux as external are in place,
fix gpio buttons active state ...)

This series of patches adds initial device tree support for the
OpenPandora. The most important parts are working (display, keyboard,
touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.

First patch add common dtsi file which is then used in 600mhz and 1ghz
variants of openpandora which support is added in patches 2 and 3.


H. Nikolaus Schaller (3):
  ARM: dts: omap3-pandora: add common device tree
  ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
  ARM: dts: omap3-pandora: add DM3730 1 GHz version

 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/omap3-pandora-1ghz.dts    |  70 +++
 arch/arm/boot/dts/omap3-pandora-600mhz.dts  |  65 +++
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 640 ++++++++++++++++++++++++++++
 4 files changed, 777 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-600mhz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi

-- 
1.9.1
