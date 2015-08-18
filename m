From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/7] gpio: omap: switch to use platform_get_irq
Date: Tue, 18 Aug 2015 14:10:53 +0300
Message-ID: <1439896258-26449-3-git-send-email-grygorii.strashko@ti.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Switch OMAP GPIO driver to use platform_get_irq(), because
it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ, ..)
for requesting IRQ resources any more, as they can be not ready yet
in case of DT-boot.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f38b01b..03fd111 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1178,13 +1178,16 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_set_wake = omap_gpio_wake_enable,
 	irqc->name = dev_name(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!res)) {
-		dev_err(dev, "Invalid IRQ resource\n");
-		return -ENODEV;
+	bank->irq = platform_get_irq(pdev, 0);
+	if (bank->irq <= 0) {
+		if (!bank->irq)
+			bank->irq = -ENXIO;
+		if (bank->irq != -EPROBE_DEFER)
+			dev_err(dev,
+				"can't get irq resource ret=%d\n", bank->irq);
+		return bank->irq;
 	}
 
-	bank->irq = res->start;
 	bank->dev = dev;
 	bank->chip.dev = dev;
 	bank->chip.owner = THIS_MODULE;
-- 
2.5.0
