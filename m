From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 04/10] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
Date: Tue, 28 Jun 2016 11:36:14 +0530
Message-ID: <1467093980-11458-5-git-send-email-j-keerthy@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

mfd_add_devices enables parsing device tree nodes without compatibles
for regulators and gpio modules. Replace of_platform_populate with
mfd_add_devices. mfd_cell currently is populated with regulators,
gpio and powerbutton.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/tps65218.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index f20a531..107d695 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -33,6 +33,15 @@
 
 #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
 
+static const struct mfd_cell tps65218_cells[] = {
+	{ .name = "tps65218-regulator", },
+	{
+		.name = "tps65218-pwrbutton",
+		.of_compatible = "ti,tps65218-pwrbutton",
+	},
+	{ .name = "tps65218-gpio", },
+};
+
 /**
  * tps65218_reg_write: Write a single tps65218 register.
  *
@@ -236,8 +245,10 @@ static int tps65218_probe(struct i2c_client *client,
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
