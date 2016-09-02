From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [RESEND PATCH v4 0/3] mfd: tps65217: Add power-button and IRQ support
Date: Fri,  2 Sep 2016 12:35:23 +0200
Message-ID: <20160902103526.5050-1-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This is a resend of v4, rebased on v4.8-rc4, with dropped two patches:
 * "power_supply: tps65217-charger: Fix NULL deref during property export"
   (already in mainline)
 * "power_supply: tps65217-charger: Add support for IRQs" (queued into
   power-supply's -next branch)

The following patches add tps65217 power button support and make it usable
with am335x boards.

Changes v3 -> v4:
 * Add irq_set_parent() during irq init (suggested by Grygorii)
 * Remove hardcoded IRQ trigger type, rely on DT bindings instead
   (suggested by Grygorii)
 * Rebased and tested on top of v4.7-rc4

Changes v2 -> v3 (suggested by Lee):
 * Alphabetical reorder of includes
 * Rename enum tps65217_irqs -> tps65217_irq_type, so we won't confuse
   it with structure object with the same name.
 * Fix inconsistent order of irq_enable and irq_disable
 * Remove redundant 'else' when returning from tps65217_irq_thread

Changes v1 -> v2:
 * Added information about parent device in tps65217 power button
   device-tree binding documentation (suggested by Rob)
 * Rebased and tested on top of v4.7-rc3

Marcin Niestroj (3):
  mfd: tps65217: Add support for IRQs
  mfd: tps65217: Add power button as subdevice
  Input: Add tps65217 power button driver

 .../bindings/input/tps65217-pwrbutton.txt          |  17 ++
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/tps65217.c                             | 205 ++++++++++++++++++++-
 include/linux/mfd/tps65217.h                       |  12 ++
 7 files changed, 369 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
 create mode 100644 drivers/input/misc/tps65217-pwrbutton.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
