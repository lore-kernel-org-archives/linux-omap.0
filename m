From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mfd: tps65217: Drop call to irq_set_parent()
Date: Fri, 14 Oct 2016 14:18:06 -0700
Message-ID: <1476479886-10208-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Marcin Niestroj <m.niestroj@grinn-global.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

The call to irq_set_parent() causes the following build error if tps65217
is built as module.

ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

The problem was introduced with commit 6556bdacf646f ("mfd: tps65217: Add
support for IRQs").

The author states: "I have added irq_set_parent() similarly as in
drivers/base/regmap/regmap-irq.c. But to be honest I am not sure what it
really does in case of tps65217."

So let's drop it.

Fixes: 6556bdacf646f ("mfd: tps65217: Add support for IRQs")
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/tps65217.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 9a4d8684dd32..2a57b444859c 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -170,7 +170,6 @@ static int tps65217_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, tps);
 	irq_set_chip_and_handler(virq, &tps65217_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-	irq_set_parent(virq, tps->irq);
 	irq_set_noprobe(virq);
 
 	return 0;
-- 
2.5.0
