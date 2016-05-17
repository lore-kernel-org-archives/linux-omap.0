From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 0/5] ARM: dts: omap3-gta04: Various updates
Date: Tue, 17 May 2016 21:48:46 +0200
Message-ID: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Add various improvements for gta04 device (wifi, backlight, irq lines for sensors)

H. Nikolaus Schaller (4):
  ARM: dts: omap3-gta04: Define and use bma180 irq pin
  ARM: dta: omap3-gta04: Define and use itg3200  irq pin
  ARM: dta: omap3-gta04: Define and use hmc5843 irq pin
  ARM: dts: omap3-gat04: Fix wifi handling

Marek Belisko (1):
  ARM: dts: omap3-gta04: Add backlight support

 arch/arm/boot/dts/omap3-gta04.dtsi | 60 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

-- 
2.5.0
