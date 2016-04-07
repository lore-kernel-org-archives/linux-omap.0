From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 13/20] mfd: rn5t618: Use devm_mfd_add_devices() for mfd_device registration
Date: Fri, 8 Apr 2016 00:13:07 +0530
Message-ID: <1460054594-32325-14-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>, Beniamino Galvani <b.galvani@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use devm_mfd_add_devices() for MFD devices registration and remove
the call of mfd_remove_devices() from .remove callback to remove
MFD child-devices. This is done by managed device framework.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Beniamino Galvani <b.galvani@gmail.com>

---
Changes from V1:
- Convert mfd to MFD.
- Run checkpatch with --strict option and fix warning.

 drivers/mfd/rn5t618.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 6668571..0ad51d7 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -78,8 +78,8 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
-			      ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
+				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
 		return ret;
@@ -102,7 +102,6 @@ static int rn5t618_i2c_remove(struct i2c_client *i2c)
 		pm_power_off = NULL;
 	}
 
-	mfd_remove_devices(&i2c->dev);
 	return 0;
 }
 
-- 
2.1.4
