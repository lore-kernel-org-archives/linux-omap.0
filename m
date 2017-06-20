From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] regulator: lp87565: Fix the initial voltage range
Date: Tue, 20 Jun 2017 09:06:55 +0530
Message-ID: <1497929815-4565-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

The latest documentation reveals that initial voltage range that is
supported is starting from 0.6V for all the PMICs belonging to lp87565
family. Fix the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regulators")
---
 drivers/regulator/lp87565-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 6d92c3f..cfdbe29 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -46,7 +46,7 @@ struct lp87565_regulator {
 static const struct lp87565_regulator regulators[];
 
 static const struct regulator_linear_range buck0_1_2_3_ranges[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x17, 10000),
+	REGULATOR_LINEAR_RANGE(600000, 0xA, 0x17, 10000),
 	REGULATOR_LINEAR_RANGE(735000, 0x18, 0x9d, 5000),
 	REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
 };
-- 
1.9.1
