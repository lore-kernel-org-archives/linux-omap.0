From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/8] drivers:input:tsc2007: send pendown and penup only once like ads7846(+tsc2046) driver does
Date: Fri, 23 Sep 2016 14:41:10 +0200
Message-ID: <9eab7072cf800efa30de74ba308ef5a1f943b045.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474634475.git.hns@goldelico.com>
In-Reply-To: <cover.1474634475.git.hns@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

this should reduce unnecessary input events.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/touchscreen/tsc2007.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 9a11509..e9d5086 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -94,6 +94,7 @@ struct tsc2007 {
 
 	wait_queue_head_t	wait;
 	bool			stopped;
+	bool			pendown;
 
 	int			(*get_pendown_state)(struct device *);
 	void			(*clear_penirq)(void);
@@ -254,9 +255,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 
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
