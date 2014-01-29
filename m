From: Matt Porter <mporter@linaro.org>
Subject: [PATCH 1/5] iio: add support for pulse width capture devices
Date: Wed, 29 Jan 2014 15:59:55 -0500
Message-ID: <1391029199-3670-2-git-send-email-mporter@linaro.org>
References: <1391029199-3670-1-git-send-email-mporter@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1391029199-3670-1-git-send-email-mporter@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linaro Patches <patches@linaro.org>
List-Id: linux-omap@vger.kernel.org

Add a channel type to support pulse width capture devices.
These devices capture the timing of a PWM signal based on a
configurable trigger

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index acc911a..6ea0cf8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CCT] = "cct",
 	[IIO_PRESSURE] = "pressure",
 	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
+	[IIO_PULSE] = "pulse",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 084d882..4fa8840 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -30,6 +30,7 @@ enum iio_chan_type {
 	IIO_CCT,
 	IIO_PRESSURE,
 	IIO_HUMIDITYRELATIVE,
+	IIO_PULSE,
 };
 
 enum iio_modifier {
-- 
1.8.4

