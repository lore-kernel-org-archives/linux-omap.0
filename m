From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 12/20] mfd: rk808: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:06 +0530
Message-ID: <1460054594-32325-13-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Chris Zhong <zyw@rock-chips.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and remove
the call of mfd_remove_devices() from .remove callback to remove
MFD child-devices. This is done by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Chris Zhong <zyw@rock-chips.com>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.

 drivers/mfd/rk808.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 4b1e439..49d7f62 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -213,9 +213,9 @@ static int rk808_probe(struct i2c_client *client,
 	rk808->i2c = client;
 	i2c_set_clientdata(client, rk808);
 
-	ret = mfd_add_devices(&client->dev, -1,
-			      rk808s, ARRAY_SIZE(rk808s),
-			      NULL, 0, regmap_irq_get_domain(rk808->irq_data));
+	ret = devm_mfd_add_devices(&client->dev, -1,
+				   rk808s, ARRAY_SIZE(rk808s), NULL, 0,
+				   regmap_irq_get_domain(rk808->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
 		goto err_irq;
@@ -240,7 +240,6 @@ static int rk808_remove(struct i2c_client *client)
 	struct rk808 *rk808 = i2c_get_clientdata(client);
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
-	mfd_remove_devices(&client->dev);
 	pm_power_off = NULL;
 
 	return 0;
-- 
2.1.4
