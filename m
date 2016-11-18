From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl: kill unused functions" to the regulator tree
Date: Fri, 18 Nov 2016 12:02:00 +0000
Message-ID: <E1c7hrk-0005LN-Aw@debutante>
References: <1478954535-17325-3-git-send-email-Nicolae_Rosia@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-3-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl: kill unused functions

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

>From 8313a4fb66b15816883792c9beed45b8978b1c8b Mon Sep 17 00:00:00 2001
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Date: Sat, 12 Nov 2016 14:42:13 +0200
Subject: [PATCH] regulator: twl: kill unused functions

This code was used by OMAP platform based boards
which are now DT only.
Proper support for SMPS is missing in this driver.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index a777c9d0d2df..3f9f53d98ef0 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -60,13 +60,6 @@ struct twlreg_info {
 	/* chip specific features */
 	unsigned long		features;
 
-	/*
-	 * optional override functions for voltage set/get
-	 * these are currently only used for SMPS regulators
-	 */
-	int			(*get_voltage)(void *data);
-	int			(*set_voltage)(void *data, int target_uV);
-
 	/* data passed from board for external get/set voltage */
 	void			*data;
 };
@@ -565,12 +558,7 @@ twl4030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
 	struct twlreg_info *info = rdev_get_drvdata(rdev);
 	int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
 
-	if (info->set_voltage) {
-		return info->set_voltage(info->data, min_uV);
-	} else {
-		twlreg_write(info, TWL_MODULE_PM_RECEIVER,
-			VREG_VOLTAGE_SMPS_4030, vsel);
-	}
+	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS_4030, vsel);
 
 	return 0;
 }
@@ -580,9 +568,6 @@ static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 	struct twlreg_info *info = rdev_get_drvdata(rdev);
 	int vsel;
 
-	if (info->get_voltage)
-		return info->get_voltage(info->data);
-
 	vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
 		VREG_VOLTAGE_SMPS_4030);
 
@@ -597,21 +582,11 @@ static struct regulator_ops twl4030smps_ops = {
 static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
 	int max_uV, unsigned *selector)
 {
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	if (info->set_voltage)
-		return info->set_voltage(info->data, min_uV);
-
 	return -ENODEV;
 }
 
 static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
 {
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	if (info->get_voltage)
-		return info->get_voltage(info->data);
-
 	return -ENODEV;
 }
 
@@ -1169,7 +1144,7 @@ MODULE_DEVICE_TABLE(of, twl_of_match);
 
 static int twlreg_probe(struct platform_device *pdev)
 {
-	int				i, id;
+	int id;
 	struct twlreg_info		*info;
 	const struct twlreg_info	*template;
 	struct regulator_init_data	*initdata;
-- 
2.10.2
