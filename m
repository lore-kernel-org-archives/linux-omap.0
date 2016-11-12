From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 2/4] regulator: twl: kill unused functions
Date: Sat, 12 Nov 2016 14:42:13 +0200
Message-ID: <1478954535-17325-3-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

This code was used by OMAP platform based boards
which are now DT only.
Proper support for SMPS is missing in this driver.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/regulator/twl-regulator.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index f92b13a..e0d81f8 100644
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
 
@@ -1159,7 +1134,7 @@ MODULE_DEVICE_TABLE(of, twl_of_match);
 
 static int twlreg_probe(struct platform_device *pdev)
 {
-	int				i, id;
+	int id;
 	struct twlreg_info		*info;
 	const struct twlreg_info	*template;
 	struct regulator_init_data	*initdata;
-- 
2.5.5
