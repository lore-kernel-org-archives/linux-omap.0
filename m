From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] regulator: tps65218: remove unused tps_info structure
Date: Fri, 10 Nov 2017 17:22:44 +0530
Message-ID: <1510314764-1940-2-git-send-email-j-keerthy@ti.com>
References: <1510314764-1940-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510314764-1940-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

remove unused tps_info structure.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 include/linux/mfd/tps65218.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index bccd2d6..f069c51 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -246,24 +246,6 @@ enum tps65218_irqs {
 };
 
 /**
- * struct tps_info - packages regulator constraints
- * @id:			Id of the regulator
- * @name:		Voltage regulator name
- * @min_uV:		minimum micro volts
- * @max_uV:		minimum micro volts
- * @strobe:		sequencing strobe value for the regulator
- *
- * This data is used to check the regualtor voltage limits while setting.
- */
-struct tps_info {
-	int id;
-	const char *name;
-	int min_uV;
-	int max_uV;
-	int strobe;
-};
-
-/**
  * struct tps65218 - tps65218 sub-driver chip access routines
  *
  * Device data may be used to access the TPS65218 chip
@@ -280,7 +262,6 @@ struct tps65218 {
 	u32 irq_mask;
 	struct regmap_irq_chip_data *irq_data;
 	struct regulator_desc desc[TPS65218_NUM_REGULATOR];
-	struct tps_info *info[TPS65218_NUM_REGULATOR];
 	struct regmap *regmap;
 	u8 *strobes;
 };
-- 
1.9.1
