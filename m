From: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/2] iio: adc: ti_am335x_adc: revert info_mask removal
Date: Mon,  6 May 2013 14:48:58 +0200
Message-ID: <1367844539-6812-2-git-send-email-jlu@pengutronix.de>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com>
 <1367844539-6812-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367844539-6812-1-git-send-email-jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: rachna-l0cyMroinI0@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit "ti_tscadc: Update with IIO map interface & deal with partial activation"
by Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> removed this line.
Without it, the in_voltage?_raw entries are missing from sysfs.

Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/iio/adc/ti_am335x_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index ee20c0c..620cc0c 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -107,6 +107,7 @@ static int tiadc_channel_init(struct iio_dev *indio_dev,
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
 		chan->channel = i;
+		chan->info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT;
 		chan->datasheet_name = s;
 		chan->scan_type.sign = 'u';
 		chan->scan_type.realbits = 12;
-- 
1.8.2.rc2
