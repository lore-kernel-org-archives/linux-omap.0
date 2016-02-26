From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/7] extcon: palmas: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:51 +0200
Message-ID: <1456501377-16871-2-git-send-email-grygorii.strashko@ti.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: rtc-linux@googlegroups.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Palams extcon IRQs are nested threaded and wired to the Palmas
inerrupt controller. So, this flag is not required for nested irqs
anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
nested_thread irqs over system suspend") was merged.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/extcon/extcon-palmas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 93c30a8..0a861b3 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -266,7 +266,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 				palmas_usb->id_irq,
 				NULL, palmas_id_irq_handler,
 				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
-				IRQF_ONESHOT | IRQF_EARLY_RESUME,
+				IRQF_ONESHOT,
 				"palmas_usb_id", palmas_usb);
 		if (status < 0) {
 			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
@@ -304,7 +304,7 @@ static int palmas_usb_probe(struct platform_device *pdev)
 				palmas_usb->vbus_irq, NULL,
 				palmas_vbus_irq_handler,
 				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
-				IRQF_ONESHOT | IRQF_EARLY_RESUME,
+				IRQF_ONESHOT,
 				"palmas_usb_vbus", palmas_usb);
 		if (status < 0) {
 			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
-- 
2.7.2
