From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: twl6030: use variable for device node" to the regulator tree
Date: Mon, 12 Aug 2019 14:10:09 +0100 (BST)
Message-ID: <20190812131009.3E5682740CBD@ypsilon.sirena.org.uk>
References: <20190725094542.16547-3-gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725094542.16547-3-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The patch

   regulator: twl6030: use variable for device node

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

>From 621d3ce830649d56ef1c9611e370d05ceaffd7fc Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 25 Jul 2019 11:45:41 +0200
Subject: [PATCH] regulator: twl6030: use variable for device node

Instead of refering the full pdev->dev.of_node use a local variable.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20190725094542.16547-3-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
