From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] twl6030: Fix vsel calculations in set/get voltage api's
Date: Tue, 16 Feb 2010 21:11:31 +0530
Message-ID: <1266334896-30686-19-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-9-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-10-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-11-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-13-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-14-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-15-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-16-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-17-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-18-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51857 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932756Ab0BPPmE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:42:04 -0500
In-Reply-To: <1266334896-30686-18-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

TWL6030 has a formula to be used to calculate the vsel values
to be programmed in the VREG_VOLTAGE registers.

Voltage(in mV) = 1000mv + 100mv * (vsel - 1)

Ex: if vsel = 0x9, mV = 1000 + 100 * (9 -1) = 1800mV.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/regulator/twl-regulator.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 7e67485..a5ca794 100644
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
+				vsel = (mV - 1000)/100 + 1;
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
1.6.0.4

