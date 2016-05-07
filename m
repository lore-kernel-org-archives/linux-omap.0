From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/7] pwm: omap-dmtimer: Allow for setting dmtimer clock source
Date: Sat,  7 May 2016 18:21:43 +0300
Message-ID: <1462634508-24961-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP GP timers can have different input clocks that allow different PWM
frequencies. However, there is no other way of setting the clock source but
through clocks or clock-names properties of the timer itself. This limits
PWM functionality to only the frequencies allowed by the particular clock
source. Allowing setting the clock source by PWM rather than by timer
allows different PWMs to have different ranges by not hard-wiring the clock
source to the timer.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt |  4 ++++
 drivers/pwm/pwm-omap-dmtimer.c                             | 12 +++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
index 5befb53..2e53324 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
@@ -9,6 +9,10 @@ Required properties:
 
 Optional properties:
 - ti,prescaler: Should be a value between 0 and 7, see the timers datasheet
+- ti,clock-source: Set dmtimer parent clock, values between 0 and 2:
+  - 0x00 - high-frequency system clock (timer_sys_ck)
+  - 0x01 - 32-kHz always-on clock (timer_32k_ck)
+  - 0x02 - external clock (timer_ext_ck, OMAP2 only)
 
 Example:
 	pwm9: dmtimer-pwm@9 {
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index b7e6ecb..95964c6 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -245,7 +245,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct pwm_omap_dmtimer_chip *omap;
 	struct pwm_omap_dmtimer_pdata *pdata;
 	pwm_omap_dmtimer *dm_timer;
-	u32 prescaler;
+	u32 v;
 	int status;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -306,10 +306,12 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
 
-	/* setup dmtimer prescaler */
-	if (!of_property_read_u32(pdev->dev.of_node, "ti,prescaler",
-				&prescaler))
-		omap->pdata->set_prescaler(omap->dm_timer, prescaler);
+	if (!of_property_read_u32(pdev->dev.of_node, "ti,prescaler", &v))
+		omap->pdata->set_prescaler(omap->dm_timer, v);
+
+	/* setup dmtimer clock source */
+	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
+		omap->pdata->set_source(omap->dm_timer, v);
 
 	omap->chip.dev = &pdev->dev;
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
