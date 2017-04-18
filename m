From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65023: Fix inverted core enable logic." to the regulator tree
Date: Tue, 18 Apr 2017 19:00:18 +0100
Message-ID: <E1d0XQI-0007HR-Kg@debutante>
References: <1492417416-1637-1-git-send-email-rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492417416-1637-1-git-send-email-rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Cochran <rcochran@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Jonghwan Choi <jhbird.choi@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65023: Fix inverted core enable logic.

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c90722b54a4f5e21ac59301ed9a6dbaa439bdb16 Mon Sep 17 00:00:00 2001
From: Richard Cochran <rcochran@linutronix.de>
Date: Mon, 17 Apr 2017 10:23:36 +0200
Subject: [PATCH] regulator: tps65023: Fix inverted core enable logic.

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

Fixes: 43530b69d758 ("regulator: Use regmap_read/write(), regmap_update_bits functions directly")
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/tps65023-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
index d2c3d7cc35f5..5ca6d2130593 100644
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
2.11.0
