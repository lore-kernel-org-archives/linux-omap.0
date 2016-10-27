From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v6 2/8] drivers:input:tsc2007: send pendown and penup only once like ads7846(+tsc2046) driver does
Date: Thu, 27 Oct 2016 10:44:15 +0200
Message-ID: <5e961a92f11b1509bd0effb96ef560f19839aa9d.1477557860.git.hns@goldelico.com>
References: <cover.1477557860.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1477557860.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1477557860.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1477557860.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

this should reduce unnecessary input events.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
