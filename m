From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 0/7] arm: dts: oma3-gta04: Various updates
Date: Tue, 22 Jul 2014 21:30:13 +0200
Message-ID: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Following patchset add various improvements to gta04 devicetree.

Changes from v1:
- added description to all patches

Marek Belisko (7):
  arm: dts: omap3-gta04: Add nand support
  arm: dts: omap3-gta04: Fix magnetometer model
  arm: dts: omap3-gta04: Add wifi reset node
  arm: dts: omap3-gta04: Move spi gpio pins to pmx_core2
  arm: dts: omap3-gta04: Add USB host support
  arm: dts: omap3-gta04: Add display alias
  arm: dts: omap3-gta04: Add twl4030 regulators parameters

 arch/arm/boot/dts/omap3-gta04.dts | 150 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 5 deletions(-)

-- 
1.9.1
