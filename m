From: Willis Monroe <willismonroe@gmail.com>
Subject: [PATCH] mfd: palmas: Fixed spelling mistake in error message.
Date: Tue, 11 Apr 2017 09:10:06 -0700
Message-ID: <20170411161006.cp4mdyxxjd5f2ixn@willis-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fixed a small spelling mistake ("updat" -> "update") in an error message.

Signed-off-by: Willis Monroe <willismonroe@gmail.com>
---
 drivers/mfd/palmas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index ee9e9ea..dbb6d42 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -567,7 +567,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 			PALMAS_POLARITY_CTRL, PALMAS_POLARITY_CTRL_INT_POLARITY,
 			reg);
 	if (ret < 0) {
-		dev_err(palmas->dev, "POLARITY_CTRL updat failed: %d\n", ret);
+		dev_err(palmas->dev, "POLARITY_CTRL update failed: %d\n", ret);
 		goto err_i2c;
 	}
 
-- 
2.9.3
