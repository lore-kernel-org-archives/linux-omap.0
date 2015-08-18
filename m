From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/7] gpio: omap: remove wrong irq_domain_remove usage in probe
Date: Tue, 18 Aug 2015 14:10:52 +0300
Message-ID: <1439896258-26449-2-git-send-email-grygorii.strashko@ti.com>
References: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1439896258-26449-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

The bank->chip.irqdomain is uninitialized at the moment when
irq_domain_remove() is called, so remove this call.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 466fe70..f38b01b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1219,7 +1219,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	bank->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(bank->base)) {
-		irq_domain_remove(bank->chip.irqdomain);
 		return PTR_ERR(bank->base);
 	}
 
-- 
2.5.0

