From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 16/20] mfd: stw481x: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:28 +0530
Message-ID: <1459856912-17859-17-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and get
rid of .remove callback to remove mfd devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/stw481x.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
index ca613df..3f7ef6a 100644
--- a/drivers/mfd/stw481x.c
+++ b/drivers/mfd/stw481x.c
@@ -206,7 +206,7 @@ static int stw481x_probe(struct i2c_client *client,
 		stw481x_cells[i].pdata_size = sizeof(*stw481x);
 	}
 
-	ret = mfd_add_devices(&client->dev, 0, stw481x_cells,
+	ret = devm_mfd_add_devices(&client->dev, 0, stw481x_cells,
 			ARRAY_SIZE(stw481x_cells), NULL, 0, NULL);
 	if (ret)
 		return ret;
@@ -216,12 +216,6 @@ static int stw481x_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int stw481x_remove(struct i2c_client *client)
-{
-	mfd_remove_devices(&client->dev);
-	return 0;
-}
-
 /*
  * This ID table is completely unused, as this is a pure
  * device-tree probed driver, but it has to be here due to
@@ -246,7 +240,6 @@ static struct i2c_driver stw481x_driver = {
 		.of_match_table = stw481x_match,
 	},
 	.probe		= stw481x_probe,
-	.remove		= stw481x_remove,
 	.id_table	= stw481x_id,
 };
 
-- 
2.1.4
