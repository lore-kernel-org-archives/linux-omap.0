From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/3] Add support for tps65217 charger
Date: Tue,  8 Sep 2015 10:09:36 +0200
Message-ID: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, lee.jones@linaro.org, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

Hi all,

The following series add initial support for tps65217 battery charger. This
series is a first attempt and will have mistake so all comments and
suggestions are welcomed.

Best regards,

Enric Balletbo i Serra (3):
  devicetree: Add TPS65217 charger binding.
  power_supply: Add support for tps65217-charger.
  mfd: Add battery charger as subdevice to the tps65217.

 .../bindings/power_supply/tps65217_charger.txt     |  12 +
 drivers/mfd/tps65217.c                             |   4 +
 drivers/power/Kconfig                              |   7 +
 drivers/power/Makefile                             |   1 +
 drivers/power/tps65217_charger.c                   | 269 +++++++++++++++++++++
 5 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/tps65217_charger.txt
 create mode 100644 drivers/power/tps65217_charger.c

-- 
2.1.0
