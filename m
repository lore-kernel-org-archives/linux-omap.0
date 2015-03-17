From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] regulator: TPS659038: Fixes for REGEN2 and REGEN3
Date: Tue, 17 Mar 2015 15:56:03 +0530
Message-ID: <1426587965-23553-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The series fixes couple of issues in the driver w.r.t TPS659038 PMICs.
1) Correcting the REGEN2_CTRL address.
2) REGEN3 is not present hence adding a check not to register for TPS659038.

Tested for the regulator enumerations on DRA7 and BEAGLE-X15 boards. 

Keerthy (2):
  regulator: palmas: Correct TPS659038 register definition for REGEN2
  regulator: Palmas: Add has_regen3 check for TPS659038

 drivers/regulator/palmas-regulator.c | 11 +++++++++++
 include/linux/mfd/palmas.h           |  4 ++++
 2 files changed, 15 insertions(+)

-- 
1.9.1
