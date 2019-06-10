From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 03/20] gpio: gpio-omap: remove remainder of list management
Date: Mon, 10 Jun 2019 20:10:46 +0300
Message-ID: <20190610171103.30903-4-grygorii.strashko@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list") removed the
list head and addition to the list head of each gpio bank, but failed
to remove the list_del() call and the node inside struct gpio_bank.
Remove these too.

Fixes: c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 44b214e5cefb..708a135e2f0c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -47,7 +47,6 @@ struct gpio_regs {
 };
 
 struct gpio_bank {
-	struct list_head node;
 	void __iomem *base;
 	int irq;
 	u32 non_wakeup_gpios;
@@ -1641,7 +1640,6 @@ static int omap_gpio_remove(struct platform_device *pdev)
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 
 	cpu_pm_unregister_notifier(&bank->nb);
-	list_del(&bank->node);
 	gpiochip_remove(&bank->chip);
 	pm_runtime_disable(&pdev->dev);
 	if (bank->dbck_flag)
-- 
2.17.1
