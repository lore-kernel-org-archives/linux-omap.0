From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/9] regulator: Enable suspend configuration
Date: Mon, 20 Jun 2016 14:13:29 +0530
Message-ID: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, j-keerthy@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

The series adds suspend configuration for tps65218 and tps65217 PMICs.

Boot tested on am437x-sk-evm, am437x-gp-evm, am335x-bone, am335x-boneblack

Keerthy (2):
  regulator: of: setup initial suspend state
  ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6
    enable during suspend

Russ Dill (1):
  regulator: tps65217: Enable suspend configuration

Tero Kristo (6):
  regulator: tps65218: Enable suspend configuration
  regulator: tps65218: force set power-up/down strobe to 3 for dcdc3
  ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff
    mode
  mfd: tps65218: add version check to the PMIC probe
  regulator: tps65218: do not disable DCDC3 during poweroff on broken
    PMICs
  ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff
    mode

 arch/arm/boot/dts/am437x-gp-evm.dts    | 13 ++++++
 arch/arm/boot/dts/am437x-sk-evm.dts    | 30 ++++++++++++
 drivers/mfd/tps65218.c                 |  9 ++++
 drivers/regulator/of_regulator.c       |  3 ++
 drivers/regulator/tps65217-regulator.c | 74 ++++++++++++++++++++++++++----
 drivers/regulator/tps65218-regulator.c | 84 +++++++++++++++++++++++++++++-----
 include/linux/mfd/tps65218.h           |  8 ++++
 7 files changed, 201 insertions(+), 20 deletions(-)

-- 
1.9.1
