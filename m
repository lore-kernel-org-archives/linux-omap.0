From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v4 0/6] Convert twl4030_madc_battery to IIO consumer and add DT aupport
Date: Tue, 10 Mar 2015 22:27:21 +0100
Message-ID: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patches adding support for twl4030_madc_battery to use twl4030_madc iio framework + DT support.
Patches was tested on gta04 board. twl4030_madc_battery driver is converted in
first patch to iio consumer and in next patches is added support for devicetree
+ some small fixes for module autoloading.

Changes from V3:
- added ti prefix for volt-to-capacity-discharging/charging-map properties

Changes from V2:
- fix property names
- add MODULE_DEVICE_TABLE and MODULE_ALIAS

Changes from V1:
- use iio_read_channel_processed instead iio_read_channel_processed
- convert probe to use devm_ as part of adding error handling for iio
- free iio channels on error and on module removal

[1] - https://lkml.org/lkml/2014/2/26/482dd

Marek Belisko (6):
  power: twl4030-madc-battery: Convert to iio consumer.
  power: twl4030_madc_battery: Add device tree support
  Documentation: DT: Document twl4030-madc-battery bindings
  ARM: dts: omap3-gta04: Add battery support
  power: twl4030_madc_battery: Add of_twl4030_madc_match to
    MODULE_DEVICE_TABLE
  power: twl4030_madc_battery: Add missing MODULE_ALIAS

 .../bindings/power_supply/twl4030_madc_battery.txt |  43 +++++
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  30 ++++
 drivers/power/twl4030_madc_battery.c               | 183 +++++++++++++++++----
 3 files changed, 221 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt

-- 
1.9.1

