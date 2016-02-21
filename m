From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/6] Small fixes for Nokia N900 power supply drivers
Date: Sun, 21 Feb 2016 12:28:17 +0100
Message-ID: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch series add debug error output for isp1704 driver and fix
module aliases for power supply drivers uses on Nokia N900.

Pali Roh=C3=A1r (6):
  power_supply: isp1704_charger: Error messages when probe fail
  power_supply: isp1704_charger: Add compatible of match for
    nxp,isp1707
  power_supply: bq2415x_charger: Do not add acpi modalias when
    CONFIG_ACPI is not enabled
  power_supply: bq2415x_charger: Add of modalias and match table when
    CONFIG_OF is enabled
  power_supply: bq27xxx_battery: Add of modalias and match table when
    CONFIG_OF is enabled
  ARM: dts: n900: Rename isp1704 to isp1707 to match correct name

 arch/arm/boot/dts/omap3-n900.dts    |    6 +++---
 drivers/power/bq2415x_charger.c     |   22 ++++++++++++++++++++++
 drivers/power/bq27xxx_battery.c     |   12 ++++++++++++
 drivers/power/bq27xxx_battery_i2c.c |   24 ++++++++++++++++++++++++
 drivers/power/isp1704_charger.c     |   19 +++++++++++++++----
 5 files changed, 76 insertions(+), 7 deletions(-)

--=20
1.7.9.5

