From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: pbias-regulator: constify regulator_ops structure" to the regulator tree
Date: Tue, 31 Jan 2017 21:18:52 +0000
Message-ID: <E1cYfpE-0001Ua-GU@debutante>
References: <1485615321-30623-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485615321-30623-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, lgirdwood@gmail.combroonie@kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: pbias-regulator: constify regulator_ops structure

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

>From a180df71e7b3f40cc867accc41ac172ceda6c95a Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Sat, 28 Jan 2017 20:25:21 +0530
Subject: [PATCH] regulator: pbias-regulator: constify regulator_ops structure

Declare regulator_ops structure as const as it is only stored in the ops
field of a regulator_desc structure. This field is of type const, so
regulator_ops structures having this property can be made const too.

File size before: drivers/regulator/pbias-regulator.o
   text	   data	    bss	    dec	    hex	filename
   2545	    624	      0	   3169	    c61 regulator/pbias-regulator.o

File size after: drivers/regulator/pbias-regulator.o
   text	   data	    bss	    dec	    hex	filename
   2801	    368	      0	   3169	    c61 regulator/pbias-regulator.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pbias-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index f9d74d63be7c..0cb76ba29e84 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -54,7 +54,7 @@ static const unsigned int pbias_volt_table[] = {
 	3000000
 };
 
-static struct regulator_ops pbias_regulator_voltage_ops = {
+static const struct regulator_ops pbias_regulator_voltage_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-- 
2.11.0
