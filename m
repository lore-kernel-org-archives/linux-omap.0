From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 10/20] mfd: mt6397: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:22 +0530
Message-ID: <1459856912-17859-11-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, John Crispin <blogic@openwrt.org>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: John Crispin <blogic@openwrt.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/mfd/mt6397-core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 8e8d932..2ea7788 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -276,7 +276,7 @@ static int mt6397_probe(struct platform_device *pdev)
 		pmic->int_con[1] = MT6323_INT_CON1;
 		pmic->int_status[0] = MT6323_INT_STATUS0;
 		pmic->int_status[1] = MT6323_INT_STATUS1;
-		ret = mfd_add_devices(&pdev->dev, -1, mt6323_devs,
+		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
 				ARRAY_SIZE(mt6323_devs), NULL, 0, NULL);
 		break;
 
@@ -286,7 +286,7 @@ static int mt6397_probe(struct platform_device *pdev)
 		pmic->int_con[1] = MT6397_INT_CON1;
 		pmic->int_status[0] = MT6397_INT_STATUS0;
 		pmic->int_status[1] = MT6397_INT_STATUS1;
-		ret = mfd_add_devices(&pdev->dev, -1, mt6397_devs,
+		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
 				ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
 		break;
 
@@ -312,13 +312,6 @@ fail_irq:
 	return ret;
 }
 
-static int mt6397_remove(struct platform_device *pdev)
-{
-	mfd_remove_devices(&pdev->dev);
-
-	return 0;
-}
-
 static const struct of_device_id mt6397_of_match[] = {
 	{ .compatible = "mediatek,mt6397" },
 	{ .compatible = "mediatek,mt6323" },
@@ -334,7 +327,6 @@ MODULE_DEVICE_TABLE(platform, mt6397_id);
 
 static struct platform_driver mt6397_driver = {
 	.probe = mt6397_probe,
-	.remove = mt6397_remove,
 	.driver = {
 		.name = "mt6397",
 		.of_match_table = of_match_ptr(mt6397_of_match),
-- 
2.1.4
