From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] mfd/tps65910: Delete an unnecessary variable
 initialisation in four functions
Date: Tue, 16 Jan 2018 13:00:06 +0100
Message-ID: <4cb93571-498f-bafa-0efc-30ebc1dab3fe@users.sourceforge.net>
References: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a524388f-a56d-c2f3-9ec3-fd6343062aad@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 Jan 2018 11:40:28 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/tps65910.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 555bd394efc3..80ea1474c654 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -229,7 +229,7 @@ static struct regmap_irq_chip tps65910_irq_chip = {
 static int tps65910_irq_init(struct tps65910 *tps65910, int irq,
 		    struct tps65910_platform_data *pdata)
 {
-	int ret = 0;
+	int ret;
 	static struct regmap_irq_chip *tps6591x_irqs_chip;
 
 	if (!irq) {
@@ -313,7 +313,7 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 		struct tps65910_board *pmic_pdata)
 {
 	struct device *dev = NULL;
-	int ret = 0;
+	int ret;
 
 	dev = tps65910->dev;
 
@@ -383,7 +383,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 	struct tps65910_board *board_info;
 	unsigned int prop;
 	const struct of_device_id *match;
-	int ret = 0;
+	int ret;
 
 	match = of_match_device(tps65910_of_match, &client->dev);
 	if (!match) {
@@ -460,7 +460,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c,
 	struct tps65910_board *of_pmic_plat_data = NULL;
 	struct tps65910_platform_data *init_data;
 	unsigned long chip_id = id->driver_data;
-	int ret = 0;
+	int ret;
 
 	pmic_plat_data = dev_get_platdata(&i2c->dev);
 
-- 
2.15.1
