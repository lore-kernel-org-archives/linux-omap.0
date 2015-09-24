From: Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv3 0/2] Add support for tps65217 charger
Date: Thu, 24 Sep 2015 21:44:19 +0200
Message-ID: <1443123861-3473-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

The following series add initial support for tps65217 battery charger.

Changes since v2:
  - Requested by Sebastian Reichel
    - Assign prev_ac_online to ac_online is no longer needed at this place.
    - Remove power_supply_unregistersince it wouldb be called by managed resources.

Changes since v1:
  - Requested by Sebastian Reichel
    - Set prev_ac_online at the beginning of the tps56217_charger_irq()
    - Use devm_power_supply_register call.
  - Fix style problems reported by checkpatch.pl --strict

Best regards,

Enric Balletbo i Serra (2):
  devicetree: Add TPS65217 charger binding.
  power_supply: Add support for tps65217-charger.

 .../bindings/power_supply/tps65217_charger.txt     |  12 +
 drivers/power/Kconfig                              |   7 +
 drivers/power/Makefile                             |   1 +
 drivers/power/tps65217_charger.c                   | 264 +++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/tps65217_charger.txt
 create mode 100644 drivers/power/tps65217_charger.c

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
