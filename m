From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/8] mfd/regulator: tps65218: Clean ups
Date: Mon, 27 Jun 2016 16:31:37 +0530
Message-ID: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series cleans up mainly the regulator driver and implements
the device tree parsing using the regulator framework. Removes
all the redundant compatibles for the individual regulators.

One of the patch removes redundant read wrapper and makes
use of regmap_read wherever necessary.

The series is checked for all the regulator registrations on
am437x-gp-evm and am437x-sk-evm.

Keerthy (8):
  mfd: tps65218: Remove redundant read wrapper
  Documentation: regulator: tps65218: Updates according to changes with
    parsing
  mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
  regulator: tps65218: Remove all the compatibles
  ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
  ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles

 .../devicetree/bindings/regulator/tps65218.txt     |  88 +++++++++++---
 arch/arm/boot/dts/am437x-cm-t43.dts                |   6 -
 arch/arm/boot/dts/am437x-gp-evm.dts                |   6 -
 arch/arm/boot/dts/am437x-sk-evm.dts                |   5 -
 arch/arm/boot/dts/am43x-epos-evm.dts               |   7 --
 drivers/mfd/tps65218.c                             |  24 ++--
 drivers/regulator/tps65218-regulator.c             | 134 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   2 -
 8 files changed, 127 insertions(+), 145 deletions(-)

-- 
1.9.1
