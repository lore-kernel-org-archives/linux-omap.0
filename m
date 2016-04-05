From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 12/20] mfd: rk808: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:24 +0530
Message-ID: <1459856912-17859-13-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Chris Zhong <zyw@rock-chips.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and remove
the call of mfd_remove_devices() from .remove callback to remove
mfd devices. This is done by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Chris Zhong <zyw@rock-chips.com>
---
 drivers/mfd/rk808.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 4b1e439..a3026ca 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -213,7 +213,7 @@ static int rk808_probe(struct i2c_client *client,
 	rk808->i2c = client;
 	i2c_set_clientdata(client, rk808);
 
-	ret = mfd_add_devices(&client->dev, -1,
+	ret = devm_mfd_add_devices(&client->dev, -1,
 			      rk808s, ARRAY_SIZE(rk808s),
 			      NULL, 0, regmap_irq_get_domain(rk808->irq_data));
 	if (ret) {
@@ -240,7 +240,6 @@ static int rk808_remove(struct i2c_client *client)
 	struct rk808 *rk808 = i2c_get_clientdata(client);
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
-	mfd_remove_devices(&client->dev);
 	pm_power_off = NULL;
 
 	return 0;
-- 
2.1.4
