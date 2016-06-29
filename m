From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 0/3]  mfd: lp873x: Add lp873x PMIC support
Date: Wed, 29 Jun 2016 15:00:01 +0530
Message-ID: <1467192604-29149-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org, j-keerthy@ti.com, tony@atomide.com
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

Chnages in v4:

Added GPO driver support. 

Keerthy (3):
  Documentation: mfd: LP873X: Add information for the mfd driver
  mfd: lp873x: Add lp873x PMIC support
  gpio: lp873x: Add support for General Purpose Outputs

 Documentation/devicetree/bindings/mfd/lp873x.txt |  59 +++++
 drivers/gpio/Kconfig                             |  10 +
 drivers/gpio/Makefile                            |   1 +
 drivers/gpio/gpio-lp873x.c                       | 188 ++++++++++++++++
 drivers/mfd/Kconfig                              |  14 ++
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/lp873x.c                             |  99 +++++++++
 include/linux/mfd/lp873x.h                       | 264 +++++++++++++++++++++++
 8 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 drivers/gpio/gpio-lp873x.c
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 include/linux/mfd/lp873x.h

-- 
1.9.1
