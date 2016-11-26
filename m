From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/5] mfd: twl: improvements and new regulator driver
Date: Sat, 26 Nov 2016 20:13:21 +0200
Message-ID: <20161126181326.14951-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

The current TWL MFD driver has a number of problems which are
very well described by Russell King [0].
This series attemps to fix this by making the driver's private
structure available to child nodes.
A regulator driver for TWL6032 which makes use of the private
drvdata is introduced.
A driver for TWL6032 PMIC already exists in mainline,
twl-regulator, but it has the following drawbacks:
* has no mainline users
* it does not follow the recommended regulators binding since
it uses a compatible string for every regulator;
* it is broken
** the features flag is not set, hence the TWL6032
support is broken since it depends on TWL6032_SUBCLASS flag;
** even with that fixed, bit manipulations are wrong

If this receives positive feedback, I could convert all TWL drivers
to use drvdata, then get rid of the exported symbols.

[0] https://www.spinics.net/lists/linux-omap/msg133387.html

Nicolae Rosia (5):
  mfd: twl-core: make driver DT only
  mfd: twl: remove useless header
  mfd: twl: move structure definitions to a public header
  regulator: Add support for TI TWL6032
  mfd: twl: use mfd_add_devices for TWL6032 regulator

 .../bindings/regulator/twl6032-regulator.txt       | 109 ++++
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/twl-core.c                             | 444 ++--------------
 drivers/mfd/twl-core.h                             |  10 -
 drivers/mfd/twl4030-irq.c                          |   2 -
 drivers/mfd/twl6030-irq.c                          |   2 -
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/twl6032-regulator.c              | 582 +++++++++++++++++++++
 include/linux/mfd/twl-core.h                       |  35 ++
 10 files changed, 768 insertions(+), 425 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/twl6032-regulator.txt
 delete mode 100644 drivers/mfd/twl-core.h
 create mode 100644 drivers/regulator/twl6032-regulator.c
 create mode 100644 include/linux/mfd/twl-core.h

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
