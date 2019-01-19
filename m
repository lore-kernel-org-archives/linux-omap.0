From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: twl: Use of_device_get_match_data()
Date: Sat, 19 Jan 2019 20:41:35 +0800
Message-ID: <20190119124135.23902-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-omap@vger.kernel.org

Use of_device_get_match_data() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 884c7505ed91..402ea43c77d1 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -576,14 +576,9 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
-	const struct of_device_id	*match;
 	struct regulator_config		config = { };
 
-	match = of_match_device(twl_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	template = match->data;
+	template = of_device_get_match_data(&pdev->dev);
 	if (!template)
 		return -ENODEV;
 
-- 
2.17.1
