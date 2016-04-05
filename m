From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 06/20] mfd: bcm590xx: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:18 +0530
Message-ID: <1459856912-17859-7-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Matt Porter <mporter@linaro.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Matt Porter <mporter@linaro.org>
---
 drivers/mfd/bcm590xx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 320aaef..eeb8bdf 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -82,7 +82,7 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri,
 		goto err;
 	}
 
-	ret = mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
+	ret = devm_mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
 			      ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&i2c_pri->dev, "failed to add sub-devices: %d\n", ret);
@@ -96,12 +96,6 @@ err:
 	return ret;
 }
 
-static int bcm590xx_i2c_remove(struct i2c_client *i2c)
-{
-	mfd_remove_devices(&i2c->dev);
-	return 0;
-}
-
 static const struct of_device_id bcm590xx_of_match[] = {
 	{ .compatible = "brcm,bcm59056" },
 	{ }
@@ -120,7 +114,6 @@ static struct i2c_driver bcm590xx_i2c_driver = {
 		   .of_match_table = of_match_ptr(bcm590xx_of_match),
 	},
 	.probe = bcm590xx_i2c_probe,
-	.remove = bcm590xx_i2c_remove,
 	.id_table = bcm590xx_i2c_id,
 };
 module_i2c_driver(bcm590xx_i2c_driver);
-- 
2.1.4

