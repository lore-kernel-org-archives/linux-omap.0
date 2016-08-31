From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v9 0/3] mfd: lp873x: Add lp873x PMIC support
Date: Wed, 31 Aug 2016 14:28:09 +0530
Message-ID: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: j-keerthy@ti.com, broonie@kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

DT patch also queued.

Hence posting the remaining patches of the series with
the comments fixed on mfd driver.

Changes in v9:

Fixed comments on spacing, indentation and '\n' adding in the mfd
driver patch.
 
Changes in v8:

Defined Macros for hardcoded bit definitions in gpio driver.
Added Mark's ack for the regulator config change patch.

Chages in v7:

Reverted the dependency on http://www.gossamer-threads.com/lists/linux/kernel/2457552.

Changes in v6:

Series depends on: http://www.gossamer-threads.com/lists/linux/kernel/2457552
probe_new used.

Chnages in v4:

Added GPO driver support.

Keerthy (3):
  mfd: lp873x: Add lp873x PMIC support
  gpio: lp873x: Add support for General Purpose Outputs
  regulator: lp873x: Change the MFD config option as per latest naming

 drivers/gpio/Kconfig       |  10 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-lp873x.c | 193 ++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig        |  14 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/lp873x.c       |  99 +++++++++++++++++
 drivers/regulator/Kconfig  |   2 +-
 include/linux/mfd/lp873x.h | 269 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 589 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-lp873x.c
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 include/linux/mfd/lp873x.h

-- 
1.9.1
