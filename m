From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 6/7] rtc: as3722: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:56 +0200
Message-ID: <1456501377-16871-7-git-send-email-grygorii.strashko@ti.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: rtc-linux@googlegroups.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

as3722 RTC IRQ is nested threaded and wired to the as3722 inerrupt
controller. So, this flag is not required for nested irqs anymore,
since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
over system suspend") was merged.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/rtc/rtc-as3722.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-as3722.c b/drivers/rtc/rtc-as3722.c
index 56cc582..6ef0c88 100644
--- a/drivers/rtc/rtc-as3722.c
+++ b/drivers/rtc/rtc-as3722.c
@@ -210,7 +210,7 @@ static int as3722_rtc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "RTC interrupt %d\n", as3722_rtc->alarm_irq);
 
 	ret = devm_request_threaded_irq(&pdev->dev, as3722_rtc->alarm_irq, NULL,
-			as3722_alarm_irq, IRQF_ONESHOT | IRQF_EARLY_RESUME,
+			as3722_alarm_irq, IRQF_ONESHOT,
 			"rtc-alarm", as3722_rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
-- 
2.7.2
