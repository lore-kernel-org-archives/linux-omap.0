From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.2-rc1][PATCH] gpio: omap: add missed spin_unlock_irqrestore in omap_gpio_irq_type
Date: Wed, 24 Jun 2015 17:54:17 +0300
Message-ID: <1435157657-17843-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, tony@atomide.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Add missed spin_unlock_irqrestore in omap_gpio_irq_type when
omap_set_gpio_triggering() is failed.

It fixes static checker warning:

	drivers/gpio/gpio-omap.c:523 omap_gpio_irq_type()
	warn: inconsistent returns 'spin_lock:&bank->lock'.

This fixes commit:
1562e4618ded ('gpio: omap: fix error handling in omap_gpio_irq_type')

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b0c57d5..a0ad803 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -500,8 +500,10 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
-	if (retval)
+	if (retval) {
+		spin_unlock_irqrestore(&bank->lock, flags);
 		goto error;
+	}
 	omap_gpio_init_irq(bank, offset);
 	if (!omap_gpio_is_input(bank, offset)) {
 		spin_unlock_irqrestore(&bank->lock, flags);
-- 
2.4.4

