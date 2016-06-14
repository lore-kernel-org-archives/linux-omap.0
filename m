From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 0/5] mfd: tps65217: Add power-button and IRQ support
Date: Tue, 14 Jun 2016 15:29:22 +0200
Message-ID: <20160614132927.3309-1-m.niestroj@grinn-global.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>
List-Id: linux-omap@vger.kernel.org

Hi,

the following patches add tps65217 power button support and make it usable
with am335x boards. They also fix a NULL dereference in tps65217 charger
subsystem and add possibility to use IRQs instead of polling task to
update AC power state.

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
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/tps65217-pwrbutton.c            | 131 ++++++++++++++
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/tps65217.c                             | 192 ++++++++++++++++++++-
 drivers/power/tps65217_charger.c                   |  46 ++++-
 include/linux/mfd/tps65217.h                       |  11 ++
 8 files changed, 399 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
 create mode 100644 drivers/input/misc/tps65217-pwrbutton.c

-- 
2.8.3

