From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl6030: remove redundant range check min_uV > 1300000 && min_uV <= 1350000" to the regulator tree
Date: Fri, 24 Mar 2017 19:16:51 +0000
Message-ID: <E1crUhf-0006CY-4j@debutante>
References: <20170324171350.9953-1-colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170324171350.9953-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Alban Auzeill <alban.auzeill@sonarsource.com>, Mark Brown <broonie@kernel.org>alban.auzeill@sonarsource.com, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl6030: remove redundant range check min_uV > 1300000 && min_uV <= 1350000

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

>From c635df496a5c397fd078b4e72a42e1be79632d7d Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 24 Mar 2017 17:13:50 +0000
Subject: [PATCH] regulator: twl6030: remove redundant range check min_uV >
 1300000 && min_uV <= 1350000

It has been pointed out to me that the range for vsel = 58 is actually
dead code as this is covered by an earlier check for (min_uV >= 700000)
&& (min_uV <= 1420000) so remove that check completely.

Reported-by: Alban Auzeill <alban.auzeill@sonarsource.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl6030-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 4864b9d742c0..edaf93cc7823 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -456,8 +456,6 @@ static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
 			vsel = 60;
 		else if ((min_uV > 1350000) && (min_uV <= 1500000))
 			vsel = 59;
-		else if ((min_uV > 1300000) && (min_uV <= 1350000))
-			vsel = 58;
 		else
 			return -EINVAL;
 		break;
-- 
2.11.0

