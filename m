From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65917/palmas: Add bypass "On" value" to the regulator tree
Date: Tue, 26 Apr 2016 19:25:02 +0100
Message-ID: <E1av7fS-00082z-3t@debutante>
References: <1461688602-19996-1-git-send-email-nm@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461688602-19996-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orgKeerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65917/palmas: Add bypass "On" value

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

>From e0341f1732237777d65bdda7184ea4b11fb31d53 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Tue, 26 Apr 2016 11:36:42 -0500
Subject: [PATCH] regulator: tps65917/palmas: Add bypass "On" value

When commit b554e1450658 ("regulator: tps65917/palmas: Add bypass
ops for LDOs with bypass capability") introduced bypass capability
to palmas regulator, it went with the assumption that regulator
regmap helpers just check val against the bypass_mask.

Unfortunately, this ignored the explicit "on" and "off" values when
the register value is masked with bypass_mask in commit ca5d1b3524b4
("regulator: helpers: Modify helpers enabling multi-bit control").

With the recent commit dd1a571daee7 ("regulator: helpers: Ensure
bypass register field matches ON value"), this issue gets highlighted
and fails tps65917/palmas based platforms which need regulators/ldos
that have bypass capability.

Introduce the bypass_on value appropriately for tps65917/palmas
regulator.

Fixes: b554e1450658 ("regulator: tps65917/palmas: Add bypass ops for LDOs with bypass capability")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/palmas-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 6efc7ee8aea3..c83e06b2cedb 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -944,6 +944,8 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
 			if (id == PALMAS_REG_LDO9) {
 				desc->ops = &palmas_ops_ldo9;
 				desc->bypass_reg = desc->enable_reg;
+				desc->bypass_val_on =
+						PALMAS_LDO9_CTRL_LDO_BYPASS_EN;
 				desc->bypass_mask =
 						PALMAS_LDO9_CTRL_LDO_BYPASS_EN;
 			}
@@ -1055,6 +1057,8 @@ static int tps65917_ldo_registration(struct palmas_pmic *pmic,
 			    id == TPS65917_REG_LDO2) {
 				desc->ops = &tps65917_ops_ldo_1_2;
 				desc->bypass_reg = desc->enable_reg;
+				desc->bypass_val_on =
+						TPS65917_LDO1_CTRL_BYPASS_EN;
 				desc->bypass_mask =
 						TPS65917_LDO1_CTRL_BYPASS_EN;
 			}
@@ -1206,6 +1210,7 @@ static int palmas_smps_registration(struct palmas_pmic *pmic,
 				desc->enable_mask = SMPS10_BOOST_EN;
 			desc->bypass_reg = PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE,
 							    PALMAS_SMPS10_CTRL);
+			desc->bypass_val_on = SMPS10_BYPASS_EN;
 			desc->bypass_mask = SMPS10_BYPASS_EN;
 			desc->min_uV = 3750000;
 			desc->uV_step = 1250000;
-- 
2.8.0.rc3
