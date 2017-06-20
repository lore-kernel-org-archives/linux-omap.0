From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: lp87565: Fix the initial voltage range" to the regulator tree
Date: Tue, 20 Jun 2017 18:40:27 +0100
Message-ID: <E1dNN8d-000865-MW@debutante>
References: <1497929815-4565-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497929815-4565-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.comlinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: lp87565: Fix the initial voltage range

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

>From 42f1ea48efd99394a4790e8ab956f1fb8e0a931e Mon Sep 17 00:00:00 2001
From: Keerthy <j-keerthy@ti.com>
Date: Tue, 20 Jun 2017 09:06:55 +0530
Subject: [PATCH] regulator: lp87565: Fix the initial voltage range

The latest documentation reveals that initial voltage range that is
supported is starting from 0.6V for all the PMICs belonging to lp87565
family. Fix the same.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regulators")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 6d92c3fe39a3..cfdbe294fb6a 100644
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
2.11.0
