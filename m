From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 2/3] regulator: twl6030: use variable for device node
Date: Thu, 25 Jul 2019 11:45:41 +0200
Message-ID: <20190725094542.16547-3-gregory.clement@bootlin.com>
References: <20190725094542.16547-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725094542.16547-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>
List-Id: linux-omap@vger.kernel.org

Instead of refering the full pdev->dev.of_node use a local variable.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/regulator/twl6030-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 5fe208b381eb..d73c81542ceb 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -665,14 +665,14 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
 	struct regulator_config		config = { };
+	struct device_node		*np = pdev->dev.of_node;
 
 	template = of_device_get_match_data(&pdev->dev);
 	if (!template)
 		return -ENODEV;
 
 	id = template->desc.id;
-	initdata = of_get_regulator_init_data(&pdev->dev, pdev->dev.of_node,
-						&template->desc);
+	initdata = of_get_regulator_init_data(&pdev->dev, np, &template->desc);
 	if (!initdata)
 		return -EINVAL;
 
@@ -713,7 +713,7 @@ static int twlreg_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
 	config.driver_data = info;
-	config.of_node = pdev->dev.of_node;
+	config.of_node = np;
 
 	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
 	if (IS_ERR(rdev)) {
-- 
2.20.1
