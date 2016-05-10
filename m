From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/3]  mfd: lp873x: Add lp873x PMIC support
Date: Tue, 10 May 2016 09:34:36 +0530
Message-ID: <1462853079-10708-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The LP873X chip is a power management IC for Portable Navigation Systems
    and Tablet Computing devices. It contains the following components:

     - Regulators.
     - Configurable General Purpose Output Signals(GPO).

PMIC interacts with the main processor through i2c. PMIC has
couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
Converter Cores) and GPOs(General Purpose Output Signals). At this
time only the regulator functionality is made available. 

Keerthy (3):
  Documentation: mfd: LP873X: Add information for the mfd and regulator
    drivers
  mfd: lp873x: Add lp873x PMIC support
  regulator: lp873x: Add support for lp873x PMIC regulators

 Documentation/devicetree/bindings/mfd/lp873x.txt |  55 +++++
 drivers/mfd/Kconfig                              |  15 ++
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/lp873x.c                             |  98 +++++++++
 drivers/regulator/Kconfig                        |   9 +
 drivers/regulator/Makefile                       |   1 +
 drivers/regulator/lp873x-regulator.c             | 241 +++++++++++++++++++++
 include/linux/mfd/lp873x.h                       | 265 +++++++++++++++++++++++
 8 files changed, 686 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 drivers/regulator/lp873x-regulator.c
 create mode 100644 include/linux/mfd/lp873x.h

-- 
1.9.1
