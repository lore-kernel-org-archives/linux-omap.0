From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: drop omap_gpio_list
Date: Thu, 27 Sep 2018 18:38:44 -0500
Message-ID: <20180927233844.18443-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

omap_gpio_list is unused so drop it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c0d7ae7..287c933 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -34,8 +34,6 @@
 #define OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER	BIT(2)
 #define OMAP_GPIO_QUIRK_DEFERRED_WKUP_EN	BIT(1)
 
-static LIST_HEAD(omap_gpio_list);
-
 struct gpio_regs {
 	u32 irqenable1;
 	u32 irqenable2;
@@ -1493,8 +1491,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
-	list_add_tail(&bank->node, &omap_gpio_list);
-
 	return 0;
 }
 
-- 
2.10.5
