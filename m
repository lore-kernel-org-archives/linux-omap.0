From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] iio: adc: cpcap: Fix die temperature
Date: Thu, 18 May 2017 20:40:34 -0700
Message-ID: <20170519034035.16795-3-tony@atomide.com>
References: <20170519034035.16795-1-tony@atomide.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170519034035.16795-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

It seems that "MC13783 Power Management and Audio Ciruit User's Guide"
MC1378UG.pdf documents several similar components as in the CPCAP PMIC.

Chapter "9.5.5 Die Temperature and UID" says that the die temperature
value is 282 at 25C with LSB of -1.14C. Converting CPCAP PMIC channel3
values with following seems to produce values that make sense for a
PMIC die:

temperature = 25000 + ((regval - 282) * 114)

As we don't have any other documentation, let's assume the die
temperature is unconfigured in the Motorola mapphone Linux kernel
and the current temperature conversion table should be only used
for the battery thermistor and not for the die temperature.

Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iio/adc/cpcap-adc.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -875,6 +875,22 @@ static int cpcap_adc_init_request(struct cpcap_adc_request *req,
 	return 0;
 }
 
+static int cpcap_adc_read_st_die_temp(struct cpcap_adc *ddata,
+				      int addr, int *val)
+{
+	int error;
+
+	error = regmap_read(ddata->reg, addr, val);
+	if (error)
+		return error;
+
+	*val -= 282;
+	*val *= 114;
+	*val += 25000;
+
+	return 0;
+}
+
 static int cpcap_adc_read(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
@@ -906,9 +922,18 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
 		error = cpcap_adc_start_bank(ddata, &req);
 		if (error)
 			goto err_unlock;
-		error = cpcap_adc_read_bank_scaled(ddata, &req);
-		if (error)
-			goto err_unlock;
+		if ((ddata->vendor == CPCAP_VENDOR_ST) &&
+		    (chan->channel == CPCAP_ADC_AD3)) {
+			error = cpcap_adc_read_st_die_temp(ddata,
+							   chan->address,
+							   &req.result);
+			if (error)
+				goto err_unlock;
+		} else {
+			error = cpcap_adc_read_bank_scaled(ddata, &req);
+			if (error)
+				goto err_unlock;
+		}
 		error = cpcap_adc_stop_bank(ddata);
 		if (error)
 			goto err_unlock;
-- 
2.13.0
