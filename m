From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] mfd: twl-core: Fix clock initialization
Date: Mon, 9 Apr 2018 11:45:39 +0300
Message-ID: <20180409084539.14365-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When looking up the clock we must use the client->dev as device since that
is the one which is probed via DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org # 4.16+
---
Hi,

Changes since v1:
- Removed the Fixes line and add tag only for v4.16 to avoid possible breakage
  in pre v4.16.
 
Regards,
Peter

 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d3133a371e27..c649344fd7f2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1177,7 +1177,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	twl_priv->ready = true;
 
 	/* setup clock framework */
-	clocks_init(&pdev->dev, pdata ? pdata->clock : NULL);
+	clocks_init(&client->dev, pdata ? pdata->clock : NULL);
 
 	/* read TWL IDCODE Register */
 	if (twl_class_is_4030()) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
