From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v5 0/3] mfd: tps65217: Add power-button and IRQ support
Date: Thu,  8 Sep 2016 11:58:57 +0200
Message-ID: <20160908095900.30975-1-m.niestroj@grinn-global.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This is a resend of v4, rebased on v4.8-rc4, with dropped two patches:
 * "power_supply: tps65217-charger: Fix NULL deref during property export"
   (already in mainline)
 * "power_supply: tps65217-charger: Add support for IRQs" (queued into
   power-supply's -next branch)

The following patches add tps65217 power button support and make it usable
with am335x boards. It was developed and rebased on v4.8-rc4.

Changes v4 -> v5:
 * Dropped two patches (they were already dropped in v4 resend):
   * "power_supply: tps65217-charger: Fix NULL deref during property export"
     (already in mainline)
   * "power_supply: tps65217-charger: Add support for IRQs" (queued into
     power-supply's -next branch)
 * Combine tps65217 and tps65218 power button drivers (as suggested by Dmitry)
 * Combine device-tree documentation for tps65217 and tps65218 power buttons

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
  Input: Add support for tps65217 power button

 .../bindings/input/tps65218-pwrbutton.txt          |  17 +-
 drivers/input/misc/Kconfig                         |   4 +-
 drivers/input/misc/tps65218-pwrbutton.c            | 102 +++++++---
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/tps65217.c                             | 205 ++++++++++++++++++++-
 include/linux/mfd/tps65217.h                       |  12 ++
 6 files changed, 298 insertions(+), 43 deletions(-)

-- 
2.9.3

