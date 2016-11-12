From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 1/4] regulator: twl: make driver DT only
Date: Sat, 12 Nov 2016 14:42:12 +0200
Message-ID: <1478954535-17325-2-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

All users are DT only, remove unused code.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
 drivers/regulator/twl-regulator.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 210681d..f92b13a 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1165,37 +1165,20 @@ static int twlreg_probe(struct platform_device *pdev)
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
 
@@ -1203,14 +1186,6 @@ static int twlreg_probe(struct platform_device *pdev)
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
2.5.5
