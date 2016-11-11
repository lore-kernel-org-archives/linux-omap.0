From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 2/9] drivers:input:tsc2007: send pendown and penup only once like ads7846(+tsc2046) driver does
Date: Fri, 11 Nov 2016 20:01:59 +0100
Message-ID: <2c0c66456fbb971db8a3785d82747c2699eaa99c.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

this should reduce unnecessary input events.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/tsc2007.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index c1d9593..e9d5086 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -94,6 +94,7 @@ struct tsc2007 {
 
 	wait_queue_head_t	wait;
 	bool			stopped;
+	bool			pendown;
 
 	int			(*get_pendown_state)(struct device *);
 	void			(*clear_penirq)(void);
@@ -227,7 +228,11 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 				sx, sy, rt);
 
 			/* report event */
-			input_report_key(input, BTN_TOUCH, 1);
+			if (!ts->pendown) {
+				input_report_key(input, BTN_TOUCH, 1);
+				ts->pendown = true;
+			}
+
 			touchscreen_report_pos(ts->input, &ts->prop,
 						(unsigned int) sx,
 						(unsigned int) sy,
@@ -250,9 +255,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 
 	dev_dbg(&ts->client->dev, "UP\n");
 
-	input_report_key(input, BTN_TOUCH, 0);
-	input_report_abs(input, ABS_PRESSURE, 0);
-	input_sync(input);
+	if (ts->pendown) {
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_sync(input);
+
+		ts->pendown = false;
+	}
 
 	if (ts->clear_penirq)
 		ts->clear_penirq();
-- 
2.7.3
