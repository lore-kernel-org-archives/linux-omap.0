From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65218: Fix strobe assignment" to the regulator tree
Date: Fri, 10 Nov 2017 21:29:54 +0000
Message-ID: <E1eDGs6-0004cI-2Q@debutante>
References: <1510314764-1940-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510314764-1940-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.comlinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: tps65218: Fix strobe assignment

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

>From efeb88c68bd0dbd317c4d24a1b5b58c5e5bd68aa Mon Sep 17 00:00:00 2001
From: Keerthy <j-keerthy@ti.com>
Date: Fri, 10 Nov 2017 17:22:43 +0530
Subject: [PATCH] regulator: tps65218: Fix strobe assignment

Currentlly tps_info structure is no longer used. So use the
strobes parameter in tps65218 structure to capture the info.

Fixes: 2dc4940360d4c0c (regulator: tps65218: Remove all the compatibles)
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 9aafbb03482d..bc489958fed7 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -154,7 +154,7 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 
 	if (!tps->strobes[rid]) {
 		if (rid == TPS65218_DCDC_3)
-			tps->info[rid]->strobe = 3;
+			tps->strobes[rid] = 3;
 		else
 			return -EINVAL;
 	}
-- 
2.15.0
