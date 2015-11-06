From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 2/7] drivers:input:tsc2007: send pendown and penup only once like ads7846(+tsc2046) driver does
Date: Fri,  6 Nov 2015 16:14:44 +0100
Message-ID: <fb7daf0f65e122b62e3149316849a3aeb3c8e5c3.1446822887.git.hns@goldelico.com>
References: <cover.1446822887.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1446822887.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1446822887.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1446822887.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

this should reduce unnecessary input events.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
