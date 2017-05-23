From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] iio: adc: cpcap: Remove hung interrupt quirk
Date: Mon, 22 May 2017 17:51:46 -0700
Message-ID: <20170523005146.726-4-tony@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170523005146.726-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is no longer needed as the real problem was interrupt flags
not getting passed properly from device tree to the cpcap-core.c
mfd driver. This got fixed with commit ac89473213c6 ("mfd: cpcap:
Fix interrupt to use level interrupt") So let's remove ADC
interrupt specific the quirk.

Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iio/adc/cpcap-adc.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -89,7 +89,7 @@
 #define ST_ADC_CAL_BATTI_LOW_THRESHOLD	494
 #define ST_ADC_CALIBRATE_DIFF_THRESHOLD	3
 
-#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration and quirk */
+#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration */
 
 /**
  * struct cpcap_adc_ato - timing settings for cpcap adc
@@ -635,27 +635,6 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
 	}
 }
 
-/*
- * Occasionally the ADC does not seem to start and there will be no
- * interrupt. Let's re-init interrupt to prevent the ADC from hanging
- * for the next request. It is unclear why this happens, but the next
- * request will usually work after doing this.
- */
-static void cpcap_adc_quirk_reset_lost_irq(struct cpcap_adc *ddata)
-{
-	int error;
-
-	dev_info(ddata->dev, "lost ADC irq, attempting to reinit\n");
-	disable_irq(ddata->irq);
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-				   CPCAP_BIT_ADTRIG_DIS,
-				   CPCAP_BIT_ADTRIG_DIS);
-	if (error)
-		dev_warn(ddata->dev, "%s reset failed: %i\n",
-			 __func__, error);
-	enable_irq(ddata->irq);
-}
-
 static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
 				struct cpcap_adc_request *req)
 {
@@ -673,7 +652,6 @@ static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
 			return 0;
 
 		if (error == 0) {
-			cpcap_adc_quirk_reset_lost_irq(ddata);
 			error = -ETIMEDOUT;
 			continue;
 		}
-- 
2.13.0
