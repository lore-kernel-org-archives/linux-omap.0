From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl: make driver DT only" to the regulator tree
Date: Fri, 18 Nov 2016 12:02:03 +0000
Message-ID: <E1c7hrn-0005MG-8U@debutante>
References: <1478954535-17325-2-git-send-email-Nicolae_Rosia@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-2-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl: make driver DT only

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

>From 25d82337705e24203b27e23762144950f87a1016 Mon Sep 17 00:00:00 2001
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Date: Sat, 12 Nov 2016 14:42:12 +0200
Subject: [PATCH] regulator: twl: make driver DT only

All users are DT only, remove unused code.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl-regulator.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 23f7b31f6355..a777c9d0d2df 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1175,37 +1175,20 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
-	struct twl_regulator_driver_data	*drvdata;
 	const struct of_device_id	*match;
 	struct regulator_config		config = { };
 
 	match = of_match_device(twl_of_match, &pdev->dev);
-	if (match) {
-		template = match->data;
-		id = template->desc.id;
-		initdata = of_get_regulator_init_data(&pdev->dev,
-						      pdev->dev.of_node,
-						      &template->desc);
-		drvdata = NULL;
-	} else {
-		id = pdev->id;
-		initdata = dev_get_platdata(&pdev->dev);
-		for (i = 0, template = NULL; i < ARRAY_SIZE(twl_of_match); i++) {
-			template = twl_of_match[i].data;
-			if (template && template->desc.id == id)
-				break;
-		}
-		if (i == ARRAY_SIZE(twl_of_match))
-			return -ENODEV;
-
-		drvdata = initdata->driver_data;
-		if (!drvdata)
-			return -EINVAL;
-	}
+	if (!match)
+		return -ENODEV;
 
+	template = match->data;
 	if (!template)
 		return -ENODEV;
 
+	id = template->desc.id;
+	initdata = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
+						&template->desc);
 	if (!initdata)
 		return -EINVAL;
 
@@ -1213,14 +1196,6 @@ static int twlreg_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	if (drvdata) {
-		/* copy the driver data into regulator data */
-		info->features = drvdata->features;
-		info->data = drvdata->data;
-		info->set_voltage = drvdata->set_voltage;
-		info->get_voltage = drvdata->get_voltage;
-	}
-
 	/* Constrain board-specific capabilities according to what
 	 * this driver and the chip itself can actually do.
 	 */
-- 
2.10.2
