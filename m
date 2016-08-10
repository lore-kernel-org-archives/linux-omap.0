From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 0/2] regulator: Enable suspend configuration
Date: Wed, 10 Aug 2016 17:53:53 +0530
Message-ID: <1470831835-22352-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc: t-kristo@ti.com, russ.dill@ti.com, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series adds suspend configuration for tps65218 and tps65217 PMICs.
Boot tested on am437x-gp-evm.

Changes in v3:

Patch 1,2,3 of the previous version are already pulled by Mark.
Posting the mfd and dependent patch with respective Acks rebased
to latest linux-next.

Changes from v2:

  * All device tree patches will be sent as a separate series once the
    driver patches are in.
  * Patch 2 of v1 is already pulled to linux-next.

Tero Kristo (2):
  mfd: tps65218: add version check to the PMIC probe
  regulator: tps65218: do not disable DCDC3 during poweroff on broken
    PMICs

 drivers/mfd/tps65218.c                 | 9 +++++++++
 drivers/regulator/tps65218-regulator.c | 8 ++++++++
 include/linux/mfd/tps65218.h           | 6 ++++++
 3 files changed, 23 insertions(+)

-- 
1.9.1
