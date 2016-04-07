From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 16/20] mfd: stw481x: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:10 +0530
Message-ID: <1460054594-32325-17-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and get
rid of .remove callback to remove MFD child-devices. This is done
by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.
- Collected acks.

 drivers/mfd/stw481x.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
index ca613df..ab949ea 100644
--- a/drivers/mfd/stw481x.c
+++ b/drivers/mfd/stw481x.c
@@ -206,8 +206,8 @@ static int stw481x_probe(struct i2c_client *client,
 		stw481x_cells[i].pdata_size = sizeof(*stw481x);
 	}
 
-	ret = mfd_add_devices(&client->dev, 0, stw481x_cells,
-			ARRAY_SIZE(stw481x_cells), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&client->dev, 0, stw481x_cells,
+				   ARRAY_SIZE(stw481x_cells), NULL, 0, NULL);
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
