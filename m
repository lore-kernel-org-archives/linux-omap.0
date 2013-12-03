From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/4] mfd: TPS65218: Add support for TPS65218 PMIC
Date: Tue, 3 Dec 2013 12:13:21 +0530
Message-ID: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: j-keerthy@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The TPS65218 chip is a power management IC for Portable Navigation Systems
and Tablet Computing devices. It contains the following components:

 - Regulators.
 - Over Temperature warning and Shut down.

This patch adds support for TPS65218 mfd device. At this time only
the regulator functionality is made available.

The patch series is dependent on:

http://www.spinics.net/lists/arm-kernel/msg289361.html

The series is boot tested on am43x-epos-evm board.

Keerthy (4):
  mfd: DT bindings for TPS65218 PMIC
  MFD: TPS65218: Add driver for the TPS65218 PMIC
  Regulators: TPS65218: Add Regulator driver for TPS65218 PMIC
  ARM: dts: AM437x: Add TPS65218 device tree nodes

 Documentation/devicetree/bindings/mfd/tps65218.txt |   27 ++
 .../devicetree/bindings/regulator/tps65218.txt     |   22 ++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   41 ++
 drivers/mfd/Kconfig                                |   14 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/tps65218.c                             |  281 ++++++++++++++
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/tps65218-regulator.c             |  393 ++++++++++++++++++++
 include/linux/mfd/tps65218.h                       |  288 ++++++++++++++
 10 files changed, 1077 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65218.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65218.txt
 create mode 100644 drivers/mfd/tps65218.c
 create mode 100644 drivers/regulator/tps65218-regulator.c
 create mode 100644 include/linux/mfd/tps65218.h

-- 
1.7.9.5

