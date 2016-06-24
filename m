From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/5] regulator: Enable suspend configuration
Date: Fri, 24 Jun 2016 13:58:12 +0530
Message-ID: <1466756892-17015-6-git-send-email-j-keerthy@ti.com>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, tony@atomide.com, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series adds suspend configuration for tps65218 and tps65217 PMICs.
Boot tested on am437x-sk-evm, am437x-gp-evm, am335x-bone, am335x-boneblack.

Changes from v2:

  * All device tree patches will be sent as a separate series once the
    driver patches are in.
  * Patch 2 of v1 is already pulled to linux-next.

Russ Dill (1):
  regulator: tps65217: Enable suspend configuration

Tero Kristo (4):
  regulator: tps65218: Enable suspend configuration
  regulator: tps65218: force set power-up/down strobe to 3 for dcdc3
  mfd: tps65218: add version check to the PMIC probe
  regulator: tps65218: do not disable DCDC3 during poweroff on broken
    PMICs

 drivers/mfd/tps65218.c                 |  9 ++++
 drivers/regulator/tps65217-regulator.c | 69 ++++++++++++++++++++++++----
 drivers/regulator/tps65218-regulator.c | 84 +++++++++++++++++++++++++++++-----
 include/linux/mfd/tps65217.h           |  1 +
 include/linux/mfd/tps65218.h           |  8 ++++
 5 files changed, 151 insertions(+), 20 deletions(-)

-- 
1.9.1
