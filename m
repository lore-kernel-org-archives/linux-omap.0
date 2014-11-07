From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/5] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache save
Date: Fri, 7 Nov 2014 11:19:08 +0530
Message-ID: <1415339350-17679-4-git-send-email-vigneshr@ti.com>
References: <1415339350-17679-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415339350-17679-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

In one shot mode, sequencer automatically disables all enabled steps at
the end of each cycle. (both ADC steps and TSC steps) Hence these steps
need not be saved in reg_se_cache for clearing these steps at a later
stage.
Also, when ADC wakes up Sequencer should not be busy executing any of the
config steps except for the charge step. Previously charge step was 1 ADC
clock cycle and hence it was ignored.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/ti_am335x_tscadc.c       | 7 +++++--
 include/linux/mfd/ti_am335x_tscadc.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index d877e777cce6..94ef8992f46b 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -86,8 +86,12 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
 		spin_lock_irq(&tsadc->reg_lock);
 		finish_wait(&tsadc->reg_se_wait, &wait);
 
+		/*
+		 * Sequencer should either be idle or
+		 * busy applying the charge step.
+		 */
 		reg = tscadc_readl(tsadc, REG_ADCFSM);
-		WARN_ON(reg & SEQ_STATUS);
+		WARN_ON(reg & SEQ_STATUS & (!CHARGE_STEP));
 		tsadc->adc_waiting = false;
 	}
 	tsadc->adc_in_use = true;
@@ -96,7 +100,6 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
 void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
 {
 	spin_lock_irq(&tsadc->reg_lock);
-	tsadc->reg_se_cache |= val;
 	am335x_tscadc_need_adc(tsadc);
 
 	tscadc_writel(tsadc, REG_SE, val);
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index c99be5dc0f5c..fcce182e4a35 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -128,6 +128,7 @@
 
 /* Sequencer Status */
 #define SEQ_STATUS BIT(5)
+#define CHARGE_STEP		0x11
 
 #define ADC_CLK			3000000
 #define TOTAL_STEPS		16
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
