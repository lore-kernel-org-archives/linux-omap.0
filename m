From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 7/7] iio: adc: palmas: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:57 +0200
Message-ID: <1456501377-16871-8-git-send-email-grygorii.strashko@ti.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: rtc-linux@googlegroups.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Palmas gpadc IRQs are nested threaded and this flag is not required for nested
irqs anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread
irqs over system suspend") was merged.

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/iio/adc/palmas_gpadc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f42eb8a..2bbf0c5 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -534,7 +534,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 	}
 	ret = request_threaded_irq(adc->irq, NULL,
 		palmas_gpadc_irq,
-		IRQF_ONESHOT | IRQF_EARLY_RESUME, dev_name(adc->dev),
+		IRQF_ONESHOT, dev_name(adc->dev),
 		adc);
 	if (ret < 0) {
 		dev_err(adc->dev,
@@ -549,7 +549,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
 		ret = request_threaded_irq(adc->irq_auto_0, NULL,
 				palmas_gpadc_irq_auto,
-				IRQF_ONESHOT | IRQF_EARLY_RESUME,
+				IRQF_ONESHOT,
 				"palmas-adc-auto-0", adc);
 		if (ret < 0) {
 			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
@@ -565,7 +565,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
 		ret = request_threaded_irq(adc->irq_auto_1, NULL,
 				palmas_gpadc_irq_auto,
-				IRQF_ONESHOT | IRQF_EARLY_RESUME,
+				IRQF_ONESHOT,
 				"palmas-adc-auto-1", adc);
 		if (ret < 0) {
 			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
-- 
2.7.2
