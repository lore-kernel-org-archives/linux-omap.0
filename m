From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/1] regulator: tps65218: Fix missing zero typo
Date: Tue, 15 Sep 2015 15:34:22 -0500
Message-ID: <1442349262-32391-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

Add missing zero to value. This will be needed when range checking
is implemented.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/regulator/tps65218-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 7f97223..a02c1b9 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -73,7 +73,7 @@ static const struct regulator_linear_range dcdc4_ranges[] = {
 };
 
 static struct tps_info tps65218_pmic_regs[] = {
-	TPS65218_INFO(DCDC1, "DCDC1", 850000, 167500),
+	TPS65218_INFO(DCDC1, "DCDC1", 850000, 1675000),
 	TPS65218_INFO(DCDC2, "DCDC2", 850000, 1675000),
 	TPS65218_INFO(DCDC3, "DCDC3", 900000, 3400000),
 	TPS65218_INFO(DCDC4, "DCDC4", 1175000, 3400000),
-- 
1.9.1
