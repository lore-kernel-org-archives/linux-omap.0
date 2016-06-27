From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65218: force set power-up/down strobe to 3 for dcdc3" to the regulator tree
Date: Mon, 27 Jun 2016 18:00:46 +0100
Message-ID: <E1bHZtu-0006DV-AL@debutante>
References: <1466412218-5906-6-git-send-email-j-keerthy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466412218-5906-6-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@kernel.org>, tony@atomide.combroonie@kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.comj-keerthy@ti.com, linux@armlinux.org.ukDave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65218: force set power-up/down strobe to 3 for dcdc3

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

>From 3fb2ef111d6f799f3da8860c1a90ef3d9c36ea55 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 24 Jun 2016 13:58:09 +0530
Subject: [PATCH] regulator: tps65218: force set power-up/down strobe to 3 for
 dcdc3

The reset value for this register seems broken on certain versions of
tps65218 chip, so make sure the dcdc3 settings is proper. Needed for
proper functionality of rtc+ddr / rtc-only modes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 8eca1eb4f219..d1e631d64a20 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -180,8 +180,12 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 	if (rid < TPS65218_DCDC_1 || rid > TPS65218_LDO_1)
 		return -EINVAL;
 
-	if (!tps->info[rid]->strobe)
-		return -EINVAL;
+	if (!tps->info[rid]->strobe) {
+		if (rid == TPS65218_DCDC_3)
+			tps->info[rid]->strobe = 3;
+		else
+			return -EINVAL;
+	}
 
 	return tps65218_set_bits(tps, dev->desc->bypass_reg,
 				 dev->desc->bypass_mask,
-- 
2.8.1
