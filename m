From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] OMAP3 temperature sensor
Date: Fri, 26 Dec 2014 13:34:51 +0100
Message-ID: <1419597294-21487-1-git-send-email-sre@kernel.org>
References: <20141226102933.GA28778@amd>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141226102933.GA28778@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Pali Rohar <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I've prepared an updated variant of the omap34xx temperature monitor driver.
It's based on the N9 driver instead of the N900 driver (and thus has omap36xx
support).

The differences compared to the original driver are:

 * DT based
 * No includes from arch, instead uses syscon DT node + regmap
 * Removed support for raw temperature reading
  - I assume this was used for debugging and regmap can be used
    instead with newer kernels.
 * Introduction of managed resources where possible
 * Usage of module_platform_driver() macro
 * Added some comments referencing the TRM

So far the patchset is _compile-tested only_. I will test it on my N900 in
the next days.

-- Sebastian

Sebastian Reichel (3):
  DT Binding for omap3 temperature sensor
  hwmon: Driver for OMAP3 temperature sensor
  ARM: dts: OMAP34xx/36xx: Add temperature sensor

 .../bindings/hwmon/omap3-temperature.txt           |  25 ++
 arch/arm/boot/dts/omap34xx.dtsi                    |   7 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   7 +
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/omap3-temp.c                         | 307 +++++++++++++++++++++
 6 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
 create mode 100644 drivers/hwmon/omap3-temp.c

-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
