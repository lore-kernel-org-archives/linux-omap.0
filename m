From: balajitk@ti.com
Subject: [RFC][PATCH] mfd: twl4030: Check for i2c error code in protect_pm_master function
Date: Fri, 11 Dec 2009 21:59:18 +0530
Message-ID: <1260548958-27317-1-git-send-email-balajitk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbZLKQ3T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 11:29:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, amit.kucheria@verdurent.com, Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

        Warn about error messages immediately after i2c write to R_PROTECT_KEY
	in functions protect_pm_master/unprotect_pm_master

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mfd/twl-core.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 42af794..74f93ed 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -804,6 +804,9 @@ static inline int __init protect_pm_master(void)
 
 	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_LOCK,
 			R_PROTECT_KEY);
+	if (e < 0)
+		pr_err("twl_core: Could not write value : %x to TWL"
+		       " register %x err %d\n", KEY_LOCK, R_PROTECT_KEY, e);
 	return e;
 }
 
@@ -811,10 +814,17 @@ static inline int __init unprotect_pm_master(void)
 {
 	int e = 0;
 
-	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK1,
+	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK1,
 			R_PROTECT_KEY);
-	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK2,
+	if (e < 0)
+		pr_err("twl_core: Could not write value : %x to TWL"
+		       " register %x err %d\n", KEY_UNLOCK1, R_PROTECT_KEY, e);
+
+	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, KEY_UNLOCK2,
 			R_PROTECT_KEY);
+	if (e < 0)
+		pr_err("twl_core: Could not write value : %x to TWL"
+		       " register %x err %d\n", KEY_UNLOCK1, R_PROTECT_KEY, e);
 	return e;
 }
 
@@ -865,10 +875,13 @@ static void clocks_init(struct device *dev)
 	}
 
 	ctrl |= HIGH_PERF_SQ;
-	e |= unprotect_pm_master();
+	e = unprotect_pm_master();
 	/* effect->MADC+USB ck en */
-	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
-	e |= protect_pm_master();
+	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
+	if (e < 0)
+		pr_err("twl_core: Could not write value : %x to TWL"
+		       " register %x err %d\n", ctrl, R_CFG_BOOT, e);
+	e = protect_pm_master();
 
 	if (e < 0)
 		pr_err("%s: clock init err [%d]\n", DRIVER_NAME, e);
-- 
1.5.4.7

