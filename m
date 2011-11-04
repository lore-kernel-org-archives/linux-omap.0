From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 18:18:48 +0530
Message-ID: <1320410928-20349-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, sameo@linux.intel.com, nsekhar@ti.com
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>
List-Id: linux-omap@vger.kernel.org

Count of selector voltage is required for regulator_set_voltage
to work via set_voltage_sel. VDD1/2 currently have it as zero,
so regulator_set_voltage won't work for VDD1/2

Update count (n_voltages) for VDD1/2

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/regulator/tps65910-regulator.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index a620e25..81f629f 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -930,6 +930,7 @@ static __devinit int tps65910_probe(struct platform_device *pdev)
 
 		if (i == TPS65910_REG_VDD1 || i == TPS65910_REG_VDD2) {
 			pmic->desc[i].ops = &tps65910_ops_dcdc;
+			pmic->desc[i].n_voltages = VDD1_2_NUM_VOLTS * 3;
 		} else if (i == TPS65910_REG_VDD3) {
 			if (tps65910_chip_id(tps65910) == TPS65910)
 				pmic->desc[i].ops = &tps65910_ops_vdd3;
-- 
1.6.2.4
