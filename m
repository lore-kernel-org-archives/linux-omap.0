From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v3 0/6] Convert twl4030_madc_battery to IIO consumer and add DT aupport
Date: Wed,  4 Feb 2015 23:14:29 +0100
Message-ID: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patches adding support for twl4030_madc_battery to use twl4030_madc iio framework + DT support.
Patches was tested on gta04 board. twl4030_madc_battery driver is converted in
first patch to iio consumer and in next patches is added support for devicetree
+ some small fixes for module autoloading.

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
