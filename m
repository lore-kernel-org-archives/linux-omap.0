From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 10/20] mfd: mt6397: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:04 +0530
Message-ID: <1460054594-32325-11-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, John Crispin <blogic@openwrt.org>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: John Crispin <blogic@openwrt.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Changes from V1:
- Convert mfd to MFD.
- Collected reviewed by.

 drivers/mfd/mt6397-core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 8e8d932..5a3ffa3 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -276,8 +276,9 @@ static int mt6397_probe(struct platform_device *pdev)
 		pmic->int_con[1] = MT6323_INT_CON1;
 		pmic->int_status[0] = MT6323_INT_STATUS0;
 		pmic->int_status[1] = MT6323_INT_STATUS1;
-		ret = mfd_add_devices(&pdev->dev, -1, mt6323_devs,
-				ARRAY_SIZE(mt6323_devs), NULL, 0, NULL);
+		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
+					   ARRAY_SIZE(mt6323_devs), NULL,
+					   0, NULL);
 		break;
 
 	case MT6397_CID_CODE:
@@ -286,8 +287,9 @@ static int mt6397_probe(struct platform_device *pdev)
 		pmic->int_con[1] = MT6397_INT_CON1;
 		pmic->int_status[0] = MT6397_INT_STATUS0;
 		pmic->int_status[1] = MT6397_INT_STATUS1;
-		ret = mfd_add_devices(&pdev->dev, -1, mt6397_devs,
-				ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
+		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
+					   ARRAY_SIZE(mt6397_devs), NULL,
+					   0, NULL);
 		break;
 
 	default:
@@ -312,13 +314,6 @@ fail_irq:
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
@@ -334,7 +329,6 @@ MODULE_DEVICE_TABLE(platform, mt6397_id);
 
 static struct platform_driver mt6397_driver = {
 	.probe = mt6397_probe,
-	.remove = mt6397_remove,
 	.driver = {
 		.name = "mt6397",
 		.of_match_table = of_match_ptr(mt6397_of_match),
-- 
2.1.4
