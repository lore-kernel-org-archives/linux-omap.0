From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v4 0/5] mfd: tps65217: Add power-button and IRQ support
Date: Mon, 20 Jun 2016 12:50:51 +0200
Message-ID: <20160620105056.25843-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Marcin Niestroj <m.niestroj@grinn-global.com>
List-Id: linux-omap@vger.kernel.org

Hi,

the following patches add tps65217 power button support and make it usable
with am335x boards. They also fix a NULL dereference in tps65217 charger
subsystem and add possibility to use IRQs instead of polling task to
update AC power state.

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

Marcin Niestroj (5):
  mfd: tps65217: Add support for IRQs
  power_supply: tps65217-charger: Fix NULL deref during property export
  power_supply: tps65217-charger: Add support for IRQs
  mfd: tps65217: Add power button as subdevice
  Input: Add tps65217 power button driver

 .../bindings/input/tps65217-pwrbutton.txt          |  17 ++
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/tps65217.c                             | 205 ++++++++++++++++++++-
 drivers/power/tps65217_charger.c                   |  46 ++++-
 include/linux/mfd/tps65217.h                       |  12 ++
 8 files changed, 407 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
 create mode 100644 drivers/input/misc/tps65217-pwrbutton.c

-- 
2.9.0

