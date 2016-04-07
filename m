From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 18/20] mfd: tps65217: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:12 +0530
Message-ID: <1460054594-32325-19-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Tony Lindgren <tony@atomide.com>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.

 drivers/mfd/tps65217.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index d32b5442..049a6fc 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -205,8 +205,8 @@ static int tps65217_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = mfd_add_devices(tps->dev, -1, tps65217s,
-			      ARRAY_SIZE(tps65217s), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(tps->dev, -1, tps65217s,
+				   ARRAY_SIZE(tps65217s), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
 		return ret;
@@ -235,15 +235,6 @@ static int tps65217_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int tps65217_remove(struct i2c_client *client)
-{
-	struct tps65217 *tps = i2c_get_clientdata(client);
-
-	mfd_remove_devices(tps->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id tps65217_id_table[] = {
 	{"tps65217", TPS65217},
 	{ /* sentinel */ }
@@ -257,7 +248,6 @@ static struct i2c_driver tps65217_driver = {
 	},
 	.id_table	= tps65217_id_table,
 	.probe		= tps65217_probe,
-	.remove		= tps65217_remove,
 };
 
 static int __init tps65217_init(void)
-- 
2.1.4
