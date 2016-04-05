From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 13/20] mfd: rn5t618: Use devm_mfd_add_devices() for mfd_device registration
Date: Tue, 5 Apr 2016 17:18:25 +0530
Message-ID: <1459856912-17859-14-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Beniamino Galvani <b.galvani@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for mfd devices registration and remove
the call of mfd_remove_devices() from .remove callback to remove
mfd devices. This is done by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/mfd/rn5t618.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 6668571..bbc7eca 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -78,7 +78,7 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
+	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
 			      ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
@@ -102,7 +102,6 @@ static int rn5t618_i2c_remove(struct i2c_client *i2c)
 		pm_power_off = NULL;
 	}
 
-	mfd_remove_devices(&i2c->dev);
 	return 0;
 }
 
-- 
2.1.4
