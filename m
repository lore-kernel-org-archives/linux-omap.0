From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 22/22] iio/ti_am335x_adc: check if we found the value
Date: Tue, 11 Jun 2013 13:31:08 +0200
Message-ID: <1370950268-7224-23-git-send-email-bigeasy@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Usually we get all the values we wanted but it is possible, that te ADC
unit is busy performing the conversation for the HW events. In that case
-EBUSY is returned and the user may re-call the function.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 8ffe52d..4427e8e 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -145,6 +145,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	int i;
 	unsigned int fifo1count, read;
 	u32 step = UINT_MAX;
+	bool found = false;
 
 	/*
 	 * When the sub-system is first enabled,
@@ -169,11 +170,14 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++) {
 		read = tiadc_readl(adc_dev, REG_FIFO1);
-		if (read >> 16 == step)
+		if (read >> 16 == step) {
 			*val = read & 0xfff;
+			found = true;
+		}
 	}
 	am335x_tsc_se_update(adc_dev->mfd_tscadc);
-
+	if (found == false)
+		return -EBUSY;
 	return IIO_VAL_INT;
 }
 
-- 
1.7.10.4
