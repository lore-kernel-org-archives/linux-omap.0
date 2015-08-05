From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] gpio: omap: Fix missing raw locks conversion
Date: Wed, 05 Aug 2015 22:37:41 +0800
Message-ID: <1438785461.9624.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix below build warning:
  CC      drivers/gpio/gpio-omap.o
drivers/gpio/gpio-omap.c: In function 'omap_gpio_irq_type':
drivers/gpio/gpio-omap.c:504:3: warning: passing argument 1 of 'spin_unlock_irqrestore' from incompatible pointer type [enabled by default]
include/linux/spinlock.h:360:29: note: expected 'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'

Fixes: commit 4dbada2be460 ("gpio: omap: use raw locks for locking")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dba67b2..466fe70 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -501,7 +501,7 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
 	if (retval) {
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		goto error;
 	}
 	omap_gpio_init_irq(bank, offset);
-- 
2.1.0



