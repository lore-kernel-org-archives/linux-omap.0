From: Colin Cross <ccross@android.com>
Subject: [PATCH v2 2/2] ARM: omap4: gpio: add locking around calls to _set_gpio_triggering
Date: Mon,  6 Jun 2011 13:38:18 -0700
Message-ID: <1307392698-21170-2-git-send-email-ccross@android.com>
References: <1307392698-21170-1-git-send-email-ccross@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307392698-21170-1-git-send-email-ccross@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tarun.kanti@ti.com, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@android.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

_set_gpio_triggering uses read-modify-write on bank registers,
lock bank->lock around all calls to it to prevent register
corruption if two cpus access gpios in the same bank at the
same time.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/gpio/gpio-omap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8ba6957..b14bfd4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1126,8 +1126,11 @@ static void gpio_irq_shutdown(struct irq_data *d)
 {
 	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
 
+	spin_lock_irqsave(&bank->lock, flags);
 	_reset_gpio(bank, gpio);
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static void gpio_ack_irq(struct irq_data *d)
@@ -1142,9 +1145,12 @@ static void gpio_mask_irq(struct irq_data *d)
 {
 	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
 
+	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_irqenable(bank, gpio, 0);
 	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static void gpio_unmask_irq(struct irq_data *d)
@@ -1153,7 +1159,9 @@ static void gpio_unmask_irq(struct irq_data *d)
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned int irq_mask = 1 << get_gpio_index(gpio);
 	u32 trigger = irqd_get_trigger_type(d);
+	unsigned long flags;
 
+	spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
 		_set_gpio_triggering(bank, get_gpio_index(gpio), trigger);
 
@@ -1165,6 +1173,7 @@ static void gpio_unmask_irq(struct irq_data *d)
 	}
 
 	_set_gpio_irqenable(bank, gpio, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static struct irq_chip gpio_irq_chip = {
-- 
1.7.4.1
