From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 0/4]  mfd: lp873x: Add lp873x PMIC support
Date: Mon, 8 Aug 2016 11:16:54 +0530
Message-ID: <1470635218-15951-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc: j-keerthy@ti.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

The LP873X chip is a power management IC for Portable Navigation Systems
    and Tablet Computing devices. It contains the following components:

     - Regulators.
     - Configurable General Purpose Output Signals(GPO).

PMIC interacts with the main processor through i2c. PMIC has
couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
Converter Cores) and GPOs(General Purpose Output Signals).

The regulator patch is already queued:
http://marc.info/?l=linux-kernel&m=146298767110771&w=2

Hence posting the remaining patches of the series with
the comments fixed on mfd driver.

Changes in v6:

Series depends on: http://www.gossamer-threads.com/lists/linux/kernel/2457552
probe_new used.

Chnages in v4:

Added GPO driver support.

Keerthy (4):
  Documentation: mfd: LP873X: Add information for the mfd driver
  mfd: lp873x: Add lp873x PMIC support
  gpio: lp873x: Add support for General Purpose Outputs
  regulator: lp873x: Change the MFD config option as per latest naming

 Documentation/devicetree/bindings/mfd/lp873x.txt |  59 +++++
 drivers/gpio/Kconfig                             |  10 +
 drivers/gpio/Makefile                            |   1 +
 drivers/gpio/gpio-lp873x.c                       | 185 ++++++++++++++++
 drivers/mfd/Kconfig                              |  14 ++
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/lp873x.c                             |  89 ++++++++
 drivers/regulator/Kconfig                        |   2 +-
 include/linux/mfd/lp873x.h                       | 264 +++++++++++++++++++++++
 9 files changed, 625 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 drivers/gpio/gpio-lp873x.c
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 include/linux/mfd/lp873x.h

-- 
1.9.1

