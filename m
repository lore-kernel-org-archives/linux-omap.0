From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 17/20] mfd: tps6507x: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:29 +0530
Message-ID: <1459856912-17859-18-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Todd Fischer <todd.fischer@ridgerun.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Todd Fischer <todd.fischer@ridgerun.com>
---
 drivers/mfd/tps6507x.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index 1ab3dd6..e74239b 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -100,18 +100,10 @@ static int tps6507x_i2c_probe(struct i2c_client *i2c,
 	tps6507x->read_dev = tps6507x_i2c_read_device;
 	tps6507x->write_dev = tps6507x_i2c_write_device;
 
-	return mfd_add_devices(tps6507x->dev, -1, tps6507x_devs,
+	return devm_mfd_add_devices(tps6507x->dev, -1, tps6507x_devs,
 			       ARRAY_SIZE(tps6507x_devs), NULL, 0, NULL);
 }
 
-static int tps6507x_i2c_remove(struct i2c_client *i2c)
-{
-	struct tps6507x_dev *tps6507x = i2c_get_clientdata(i2c);
-
-	mfd_remove_devices(tps6507x->dev);
-	return 0;
-}
-
 static const struct i2c_device_id tps6507x_i2c_id[] = {
        { "tps6507x", 0 },
        { }
@@ -132,7 +124,6 @@ static struct i2c_driver tps6507x_i2c_driver = {
 		   .of_match_table = of_match_ptr(tps6507x_of_match),
 	},
 	.probe = tps6507x_i2c_probe,
-	.remove = tps6507x_i2c_remove,
 	.id_table = tps6507x_i2c_id,
 };
 
-- 
2.1.4
