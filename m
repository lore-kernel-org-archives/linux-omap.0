From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for optional wakeup interrupt
Date: Fri, 17 Jul 2015 12:10:40 +0530
Message-ID: <1437115241-17859-2-git-send-email-vigneshr@ti.com>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: Roger Quadros <rogerq@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On am437x-gp-evm, pixcir touchscreen can wake the system from low power
state by generating wake-up interrupt via pinctrl and IO daisy chain.
Add support for optional wakeup interrupt source by regsitering to
automated wake IRQ framework introduced by commit 4990d4fe327b ("PM /
Wakeirq: Add automated device wake IRQ handling").
This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
support for optional wake-up")

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 8f3e243a62bf..f7c602027fbd 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -29,6 +29,8 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pm_wakeirq.h>
 
 #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
 
@@ -38,6 +40,7 @@ struct pixcir_i2c_ts_data {
 	const struct pixcir_ts_platform_data *pdata;
 	bool running;
 	int max_fingers;	/* Max fingers supported in this instance */
+	int wakeirq;
 };
 
 struct pixcir_touch {
@@ -564,11 +567,22 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, tsdata);
 	device_init_wakeup(&client->dev, 1);
 
+	/* Register wakeirq, if available */
+	tsdata->wakeirq = of_irq_get(dev->of_node, 1);
+	if (tsdata->wakeirq) {
+		error = dev_pm_set_dedicated_wake_irq(dev,
+						      tsdata->wakeirq);
+		if (error)
+			dev_dbg(dev, "unable to get wakeirq %d\n",
+				error);
+	}
+
 	return 0;
 }
 
 static int pixcir_i2c_ts_remove(struct i2c_client *client)
 {
+	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, 0);
 
 	return 0;
-- 
2.4.5
