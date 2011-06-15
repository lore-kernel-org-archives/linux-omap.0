From: Ambresh K <ambresh@ti.com>
Subject: [PATCH] OMAP4: GPIO: Fix missing interrupts during device wakeup due to IOPAD.
Date: Wed, 15 Jun 2011 13:40:45 -0700
Message-ID: <1308170445-30665-1-git-send-email-ambresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Philippe Mazet <p-mazet@ti.com>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Colin Cross <ccross@android.com>, linux omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Ambresh K <ambresh@ti.com>

If gpio pins from bank[2-5] are marked as wakeup enable and if the wake is
through gpio IO pad wakeup, then that wakeup gpio interrupt is lost.

In the current implementation, GPIO driver stores the context of DATAIN of
all the gpio in the bank. During GPIO resuming, it checks DATAIN with wakeup
enabled pins of gpio bank. If there is status change, then manually toggle
GPIO_LEVELDETECT to generate pseudo interrupt.

Reported-by: Philippe Mazet <p-mazet@ti.com>
Tested-by: Philippe Mazet <p-mazet@ti.com>
Signed-off-by: Ambresh K <ambresh@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 6c51191..eaf3d78 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -477,8 +477,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 					+ OMAP24XX_GPIO_CLEARWKUENA);
 		}
 	}
-	/* This part needs to be executed always for OMAP34xx */
-	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
+	/* This part needs to be executed always for OMAP{34xx, 44xx} */
+	if (cpu_is_omap34xx() || cpu_is_omap44xx() ||
+			(bank->non_wakeup_gpios & gpio_bit)) {
 		/*
 		 * Log the edge gpio and manually trigger the IRQ
 		 * after resume if the input level changes
-- 
1.7.0.4
