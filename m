From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/13] mfd: twl-core: Change TWL4030_MODULE_* ids to TWL_MODULE_*
Date: Tue, 13 Nov 2012 09:28:54 +0100
Message-ID: <1352795334-7406-14-git-send-email-peter.ujfalusi@ti.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

To facilitate upcoming cleanup in twl stack.
No functional changes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f857097..43c7b4c 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1077,8 +1077,8 @@ static inline int __init protect_pm_master(void)
 {
 	int e = 0;
 
-	e = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0,
-			TWL4030_PM_MASTER_PROTECT_KEY);
+	e = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, 0,
+			     TWL4030_PM_MASTER_PROTECT_KEY);
 	return e;
 }
 
@@ -1086,12 +1086,10 @@ static inline int __init unprotect_pm_master(void)
 {
 	int e = 0;
 
-	e |= twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
-			TWL4030_PM_MASTER_KEY_CFG1,
-			TWL4030_PM_MASTER_PROTECT_KEY);
-	e |= twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
-			TWL4030_PM_MASTER_KEY_CFG2,
-			TWL4030_PM_MASTER_PROTECT_KEY);
+	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG1,
+			      TWL4030_PM_MASTER_PROTECT_KEY);
+	e |= twl_i2c_write_u8(TWL_MODULE_PM_MASTER, TWL4030_PM_MASTER_KEY_CFG2,
+			      TWL4030_PM_MASTER_PROTECT_KEY);
 
 	return e;
 }
-- 
1.8.0
