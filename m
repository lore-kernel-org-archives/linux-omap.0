From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 8/8] input: twl-pwrbutton: Rename interrupt routine for better consistency
Date: Tue, 29 Mar 2016 21:22:21 +0200
Message-ID: <1459279341-17389-8-git-send-email-contact@paulk.fr>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279341-17389-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This renames the twl-pwrbutton interrupt routing from powerbutton_irq to
twl_pwrbutton_irq, for better consistency with the driver name.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/input/misc/twl-pwrbutton.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/twl-pwrbutton.c b/drivers/input/misc/twl-pwrbutton.c
index a7bc8ad..ced702a 100644
--- a/drivers/input/misc/twl-pwrbutton.c
+++ b/drivers/input/misc/twl-pwrbutton.c
@@ -34,7 +34,7 @@
 #define TWL4030_STS_HW_CONDITIONS 0x0f
 #define TWL6030_STS_HW_CONDITIONS 0x21
 
-static irqreturn_t powerbutton_irq(int irq, void *_pwr)
+static irqreturn_t twl_pwrbutton_irq(int irq, void *_pwr)
 {
 	struct input_dev *pwr = _pwr;
 	int err;
@@ -84,7 +84,7 @@ static int twl_pwrbutton_probe(struct platform_device *pdev)
 			REG_INT_MSK_STS_A);
 	}
 
-	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
+	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, twl_pwrbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
 			"twl_pwrbutton", pwr);
-- 
2.7.4
