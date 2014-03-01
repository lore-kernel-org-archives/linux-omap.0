From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 0/7] ARM: dts: omap3-gta04: Various devicetree updates
Date: Sat,  1 Mar 2014 14:58:47 +0100
Message-ID: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This updated series fix issue with proper gta04 booting in 3.14 kernel
and add various devices to devicetree.

Changes from V1: 
- removed fixes which was merged to 3.14 already
- add bma180 accelerometer + booting fix

Marek Belisko (2):
  ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid
    problems with booting
  ARM: dts: omap3-gta04: Add touchscreen properties

NeilBrown (5):
  ARM: dts: omap3-gta04: Add support for magnetometer
  ARM: dts: omap3-gta04: Add twl4030 charger
  ARM: dts: omap3-gta04: Add basic sound support
  ARM: dts: omap3-gta04: Enable mmc2 for wifi
  ARM: dts: omap3-gta04: Add bma180 accelerometer

 arch/arm/boot/dts/omap3-gta04.dts | 53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

-- 
1.8.3.2
