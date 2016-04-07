From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 09/20] mfd: menf21bmc: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:03 +0530
Message-ID: <1460054594-32325-10-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Andreas Werner <andreas.werner@men.de>
Reviewed-by: Andreas Werner <andreas.werner@men.de>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.
- Collected reviewed by.

 drivers/mfd/menf21bmc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
index 1c27434..3ad2def 100644
--- a/drivers/mfd/menf21bmc.c
+++ b/drivers/mfd/menf21bmc.c
@@ -96,8 +96,8 @@ menf21bmc_probe(struct i2c_client *client, const struct i2c_device_id *ids)
 		return ret;
 	}
 
-	ret = mfd_add_devices(&client->dev, 0, menf21bmc_cell,
-			      ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&client->dev, 0, menf21bmc_cell,
+				   ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to add BMC sub-devices\n");
 		return ret;
@@ -106,12 +106,6 @@ menf21bmc_probe(struct i2c_client *client, const struct i2c_device_id *ids)
 	return 0;
 }
 
-static int menf21bmc_remove(struct i2c_client *client)
-{
-	mfd_remove_devices(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id menf21bmc_id_table[] = {
 	{ "menf21bmc" },
 	{ }
@@ -122,7 +116,6 @@ static struct i2c_driver menf21bmc_driver = {
 	.driver.name	= "menf21bmc",
 	.id_table	= menf21bmc_id_table,
 	.probe		= menf21bmc_probe,
-	.remove		= menf21bmc_remove,
 };
 
 module_i2c_driver(menf21bmc_driver);
-- 
2.1.4

