From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 12/17 2/4] mfd: tps65910: Delete an unnecessary variable
 initialisation in four functions
Date: Fri, 9 Mar 2018 17:37:08 +0100
Message-ID: <f28c7c19-ece1-87c2-6304-6226015bbdd1@users.sourceforge.net>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:06:14 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

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
2.16.2
