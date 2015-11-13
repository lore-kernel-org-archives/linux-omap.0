From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/8] drivers:input:tsc2007: send pendown and penup only once like ads7846(+tsc2046) driver does
Date: Fri, 13 Nov 2015 21:35:53 +0100
Message-ID: <fb7daf0f65e122b62e3149316849a3aeb3c8e5c3.1447446957.git.hns@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447446957.git.hns@goldelico.com>
In-Reply-To: <cover.1447446957.git.hns@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

this should reduce unnecessary input events.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/tsc2007.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index e0c7173..1a8a79d 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -94,6 +94,7 @@ struct tsc2007 {
 
 	wait_queue_head_t	wait;
 	bool			stopped;
+	bool			pendown;
 
 	int			(*get_pendown_state)(struct device *);
 	void			(*clear_penirq)(void);
@@ -251,7 +252,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 			dev_dbg(&ts->client->dev,
 					"shaped point(%4d,%4d), pressure (%4u)\n",
 					tc.x, tc.y, rt);
-			input_report_key(input, BTN_TOUCH, 1);
+			if (!ts->pendown) {
+				input_report_key(input, BTN_TOUCH, 1);
+				ts->pendown = true;
+			}
 			input_report_abs(input, ABS_X, tc.x);
 			input_report_abs(input, ABS_Y, tc.y);
 			input_report_abs(input, ABS_PRESSURE, rt);
@@ -272,9 +276,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 
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
2.5.1
