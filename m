From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Date: Thu, 6 Dec 2018 10:57:59 +0100
Message-ID: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Free allocated IRQ if reading the device ID fails.

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/mfd/tps65218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 910f569..19270bc 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -244,7 +244,7 @@ static int tps65218_probe(struct i2c_client *client,
 	ret = regmap_read(tps->regmap, TPS65218_REG_CHIPID, &chipid);
 	if (ret) {
 		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
-		return ret;
+		goto err_irq;
 	}
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
-- 
2.7.4
