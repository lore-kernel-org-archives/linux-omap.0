From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 5/6] mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
Date: Tue, 28 Jun 2016 14:52:08 +0530
Message-ID: <1467105729-28249-6-git-send-email-j-keerthy@ti.com>
References: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

mfd_add_devices enables parsing device tree nodes without compatibles
for regulators and gpio modules. Replace of_platform_populate with
mfd_add_devices. mfd_cell currently is populated with regulators,
gpio and powerbutton.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Regrouped the mfd cells better.

 drivers/mfd/tps65218.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index f20a531..f13c8d9 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -33,6 +33,18 @@
 
 #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
 
+static const struct mfd_cell tps65218_cells[] = {
+	{
+		.name = "tps65218-pwrbutton",
+		.of_compatible = "ti,tps65218-pwrbutton",
+	},
+	{
+		.name = "tps65218-gpio",
+		.of_compatible = "ti,tps65218-gpio",
+	},
+	{ .name = "tps65218-regulator", },
+};
+
 /**
  * tps65218_reg_write: Write a single tps65218 register.
  *
@@ -236,8 +248,10 @@ static int tps65218_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
-				   &client->dev);
+	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
+			      ARRAY_SIZE(tps65218_cells), NULL, 0,
+			      regmap_irq_get_domain(tps->irq_data));
+
 	if (ret < 0)
 		goto err_irq;
 
-- 
1.9.1

