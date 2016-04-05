From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 07/20] mfd: hi6421-pmic: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:19 +0530
Message-ID: <1459856912-17859-8-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/mfd/hi6421-pmic-core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index f9ded45..74ffff6 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -76,7 +76,7 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmic);
 
-	ret = mfd_add_devices(&pdev->dev, 0, hi6421_devs,
+	ret = devm_mfd_add_devices(&pdev->dev, 0, hi6421_devs,
 			ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "add mfd devices failed: %d\n", ret);
@@ -86,13 +86,6 @@ static int hi6421_pmic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi6421_pmic_remove(struct platform_device *pdev)
-{
-	mfd_remove_devices(&pdev->dev);
-
-	return 0;
-}
-
 static const struct of_device_id of_hi6421_pmic_match_tbl[] = {
 	{ .compatible = "hisilicon,hi6421-pmic", },
 	{ },
@@ -105,7 +98,6 @@ static struct platform_driver hi6421_pmic_driver = {
 		.of_match_table = of_hi6421_pmic_match_tbl,
 	},
 	.probe	= hi6421_pmic_probe,
-	.remove	= hi6421_pmic_remove,
 };
 module_platform_driver(hi6421_pmic_driver);
 
-- 
2.1.4

