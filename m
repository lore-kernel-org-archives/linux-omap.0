From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH] regulator: tps65023: Fix inverted core enable logic.
Date: Mon, 17 Apr 2017 10:23:36 +0200
Message-ID: <1492417416-1637-1-git-send-email-rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Jonghwan Choi <jhbird.choi@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Commit 43530b69d758328d3ffe6ab98fd640463e8e3667 ("regulator: Use
regmap_read/write(), regmap_update_bits functions directly") intended
to replace working inline helper functions with standard regmap
calls.  However, it also inverted the set/clear logic of the "CORE ADJ
Allowed" bit.  That patch was clearly never tested, since without that
bit cleared, the core VDCDC1 voltage output does not react to I2C
configuration changes.

This patch fixes the issue by clearing the bit as in the original,
correct implementation.  Note for stable back porting that, due to
subsequent driver churn, this patch will not apply on every kernel
version.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Fixes: 43530b69d758 ("regulator: Use regmap_read/write(), regmap_update_bits functions directly")
---
 drivers/regulator/tps65023-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
index d2c3d7c..5ca6d21 100644
--- a/drivers/regulator/tps65023-regulator.c
+++ b/drivers/regulator/tps65023-regulator.c
@@ -311,8 +311,7 @@ static int tps_65023_probe(struct i2c_client *client,
 
 	/* Enable setting output voltage by I2C */
 	regmap_update_bits(tps->regmap, TPS65023_REG_CON_CTRL2,
-					TPS65023_REG_CTRL2_CORE_ADJ,
-					TPS65023_REG_CTRL2_CORE_ADJ);
+			   TPS65023_REG_CTRL2_CORE_ADJ, 0);
 
 	return 0;
 }
-- 
2.1.4
