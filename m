From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 06/20] mfd: bcm590xx: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:00 +0530
Message-ID: <1460054594-32325-7-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Matt Porter <mporter@linaro.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Matt Porter <mporter@linaro.org>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.

 drivers/mfd/bcm590xx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 320aaef..0d76d69 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -82,8 +82,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri,
 		goto err;
 	}
 
-	ret = mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
-			      ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
+				   ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&i2c_pri->dev, "failed to add sub-devices: %d\n", ret);
 		goto err;
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
