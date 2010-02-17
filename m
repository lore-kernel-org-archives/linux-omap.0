From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in set/get voltage apis
Date: Wed, 17 Feb 2010 20:54:14 +0530
Message-ID: <1266420255-4307-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154Ab0BQPY2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 10:24:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

TWL6030 has a formula to be used to calculate the vsel values
to be programmed in the VREG_VOLTAGE registers.

Voltage(in mV) = 1000mv + 100mv * (vsel - 1)

Ex: if vsel = 0x9, mV = 1000 + 100 * (9 -1) = 1800mV.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/twl-regulator.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 7e67485..e7871d6 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -367,11 +367,17 @@ twlldo_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 		/* REVISIT for VAUX2, first match may not be best/lowest */
 
 		/* use the first in-range value */
-		if (min_uV <= uV && uV <= max_uV)
+		if (min_uV <= uV && uV <= max_uV) {
+			if (twl_class_is_6030())
+				/*
+				 * Use the below formula to calculate vsel
+				 * mV = 1000mv + 100mv * (vsel - 1)
+				 */
+				vsel = (LDO_MV(mV) - 1000)/100 + 1;
 			return twlreg_write(info, TWL_MODULE_PM_RECEIVER,
 							VREG_VOLTAGE, vsel);
+		}
 	}
-
 	return -EDOM;
 }
 
@@ -384,8 +390,17 @@ static int twlldo_get_voltage(struct regulator_dev *rdev)
 	if (vsel < 0)
 		return vsel;
 
-	vsel &= info->table_len - 1;
-	return LDO_MV(info->table[vsel]) * 1000;
+	if (twl_class_is_4030()) {
+		vsel &= info->table_len - 1;
+		return LDO_MV(info->table[vsel]) * 1000;
+	} else if (twl_class_is_6030()) {
+		/*
+		 * Use the below formula to calculate vsel
+		 * mV = 1000mv + 100mv * (vsel - 1)
+		 */
+		return (1000 + (100 * (vsel - 1))) * 1000;
+	}
+	return -EDOM;
 }
 
 static struct regulator_ops twlldo_ops = {
-- 
1.5.4.7

