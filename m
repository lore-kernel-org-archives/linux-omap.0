From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 4/4] Input: tsc2005 - convert to gpiod
Date: Wed, 15 Jul 2015 14:13:28 +0200
Message-ID: <1436962408-5206-5-git-send-email-sre@kernel.org>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436962408-5206-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Convert driver to descriptor based GPIO API. Also
fix the after-probe reset GPIO state, so that the
device is not kept in reset state.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/tsc2005.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 83508d8..cb08dc8 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -30,11 +30,11 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2005.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 /*
  * The touchscreen interface operates as follows:
@@ -179,7 +179,7 @@ struct tsc2005 {
 
 	struct regulator	*vio;
 
-	int			reset_gpio;
+	struct gpio_desc	*reset_gpio;
 	void			(*set_reset)(bool enable);
 };
 
@@ -317,8 +317,8 @@ static void tsc2005_stop_scan(struct tsc2005 *ts)
 
 static void tsc2005_set_reset(struct tsc2005 *ts, bool enable)
 {
-	if (ts->reset_gpio >= 0)
-		gpio_set_value(ts->reset_gpio, enable);
+	if (ts->reset_gpio)
+		gpiod_set_value_cansleep(ts->reset_gpio, enable);
 	else if (ts->set_reset)
 		ts->set_reset(enable);
 }
@@ -611,19 +611,11 @@ static int tsc2005_probe(struct spi_device *spi)
 	ts->esd_timeout = esd_timeout;
 
 	if (np) {
-		ts->reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
-		if (ts->reset_gpio == -EPROBE_DEFER)
-			return ts->reset_gpio;
-		if (ts->reset_gpio < 0) {
+		ts->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
+						GPIOD_OUT_HIGH);
+		if (IS_ERR(ts->reset_gpio)) {
+			error = PTR_ERR(ts->reset_gpio);
 			dev_err(&spi->dev, "error acquiring reset gpio: %d\n",
-				ts->reset_gpio);
-			return ts->reset_gpio;
-		}
-
-		error = devm_gpio_request_one(&spi->dev, ts->reset_gpio, 0,
-					      "reset-gpios");
-		if (error) {
-			dev_err(&spi->dev, "error requesting reset gpio: %d\n",
 				error);
 			return error;
 		}
@@ -635,7 +627,6 @@ static int tsc2005_probe(struct spi_device *spi)
 			return error;
 		}
 	} else {
-		ts->reset_gpio = -1;
 		ts->set_reset = pdata->set_reset;
 	}
 
-- 
2.1.4
