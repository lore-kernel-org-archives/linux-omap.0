From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: lp87565: Enable LP87565_BUCK_CTRL_1_FPWM_MP_0_2" to the regulator tree
Date: Tue, 17 Apr 2018 12:29:13 +0100
Message-ID: <E1f8OnR-0000R1-Hj@debutante>
References: <1523955115-30164-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523955115-30164-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.comlinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: lp87565: Enable LP87565_BUCK_CTRL_1_FPWM_MP_0_2

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From 2f51a26041f2c192dfcf426c04a0753f3e68db95 Mon Sep 17 00:00:00 2001
From: Keerthy <j-keerthy@ti.com>
Date: Tue, 17 Apr 2018 14:21:55 +0530
Subject: [PATCH] regulator: lp87565: Enable LP87565_BUCK_CTRL_1_FPWM_MP_0_2

Buck10 is a multi(dual) phase regulator. So as part of enabling it
turn on the LP87565_BUCK_CTRL_1_FPWM_MP_0_2 bit which forces it to
operate always in multiphase and forced-PWM operation mode.
This helps improve the transient voltage response while switching OPP.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 5a4ea996e1dc..c192357d1dea 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -178,7 +178,8 @@ static const struct lp87565_regulator regulators[] = {
 	LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
-			  LP87565_BUCK_CTRL_1_EN, 3230,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
-- 
2.17.0
