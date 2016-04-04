From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 0/5] mfd: tps65217: Add power-button and IRQ support
Date: Mon,  4 Apr 2016 19:10:59 +0200
Message-ID: <1459789865-3704-1-git-send-email-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

the following patches add tps65217 power button support and make it usable
with am335x boards. They also fix a NULL dereference in tps65217 charger
subsystem and add possibility to use IRQs instead of polling task to
update AC power state.

Developed and tested on top of v4.6-rc2.

Marcin Niestroj (5):
  mfd: tps65217: Add support for IRQs
  power_supply: tps65217-charger: Fix NULL deref during property export
  power_supply: tps65217-charger: Add support for IRQs
  mfd: tps65217: Add power button as subdevice
  Input: Add tps65217 power button driver

 .../bindings/input/tps65217-pwrbutton.txt          |  14 ++
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/tps65217-pwrbutton.c            | 131 ++++++++++++++
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/tps65217.c                             | 192 ++++++++++++++++++++-
 drivers/power/tps65217_charger.c                   |  46 ++++-
 include/linux/mfd/tps65217.h                       |  11 ++
 8 files changed, 396 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
 create mode 100644 drivers/input/misc/tps65217-pwrbutton.c

-- 
2.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
