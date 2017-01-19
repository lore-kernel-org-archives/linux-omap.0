From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl6030: fix range comparison, allowing vsel = 59" to the regulator tree
Date: Thu, 19 Jan 2017 18:04:08 +0000
Message-ID: <E1cUH4C-00052y-KL@debutante>
References: <20170111153620.20342-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170111153620.20342-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl6030: fix range comparison, allowing vsel = 59

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

>From b98acbff9a05b371c5f0ca6e44a3af8ce9274379 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 11 Jan 2017 15:36:20 +0000
Subject: [PATCH] regulator: twl6030: fix range comparison, allowing vsel = 59

The range min_uV > 1350000 && min_uV <= 150000 is never reachable
because of a typo in the previous range check and hence vsel = 59
is never reached.  Fix the previous range check to enable the
vsel = 59 setting.

Fixes CoverityScan CID#728454 ("Logially dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl6030-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 4864b9d742c0..716191046a70 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -452,7 +452,7 @@ static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
 			vsel = 62;
 		else if ((min_uV > 1800000) && (min_uV <= 1900000))
 			vsel = 61;
-		else if ((min_uV > 1350000) && (min_uV <= 1800000))
+		else if ((min_uV > 1500000) && (min_uV <= 1800000))
 			vsel = 60;
 		else if ((min_uV > 1350000) && (min_uV <= 1500000))
 			vsel = 59;
-- 
2.11.0
