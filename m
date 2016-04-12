From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Tue, 12 Apr 2016 13:52:31 +0300
Message-ID: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, tony@atomide.com
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Now GPIO IRQ loss is observed on dra7-evm after suspend/resume cycle
in the following case:
  extcon_usb1(id_irq) ->  pcf8575.gpio1 -> omapgpio6.gpio11 -> gic

the extcon_usb1 is wake up source and it enables IRQ wake up for
id_irq by calling enable/disable_irq_wake() during suspend/resume
which, in turn, causes execution of omap_gpio_wake_enable(). And
omap_gpio_wake_enable() will set/clear corresponding bit in
GPIO_IRQWAKEN_x register.

omapgpio6 configuration after boot - wakeup is enabled for GPIO IRQs
by default from  omap_gpio_irq_type:
GPIO_IRQSTATUS_SET_0    | 0x00000400
GPIO_IRQSTATUS_CLR_0    | 0x00000400
GPIO_IRQWAKEN_0         | 0x00000400
GPIO_RISINGDETECT       | 0x00000000
GPIO_FALLINGDETECT      | 0x00000400

omapgpio6 configuration after after suspend/resume cycle:
GPIO_IRQSTATUS_SET_0    | 0x00000400
GPIO_IRQSTATUS_CLR_0    | 0x00000400
GPIO_IRQWAKEN_0         | 0x00000000 <---
GPIO_RISINGDETECT       | 0x00000000
GPIO_FALLINGDETECT      | 0x00000400

As result, system will start to lose interrupts from pcf8575 GPIO
expander, because when OMAP GPIO IP is in smart-idle wakeup mode, there
is no guarantee that transition(s) on input non wake up GPIO pin will
trigger asynchronous wake-up request to PRCM and then IRQ generation.
IRQ will be generated when GPIO is in active mode - for example, some
time after accessing GPIO bank registers IRQs will be generated
normally, but issue will happen again once PRCM will put GPIO in low
power smart-idle wakeup mode.

Note 1. Issue is not reproduced if debounce clk is enabled for GPIO
bank.

Note 2. Issue hardly reproducible if GPIO pins group contains both
wakeup/non-wakeup gpios - for example, it will be hard to reproduce
issue with pin2 if GPIO_IRQWAKEN_0=0x1 GPIO_IRQSTATUS_SET_0=0x3
GPIO_FALLINGDETECT = 0x3 (TRM "Power Saving by Grouping the Edge/Level
Detection").

Note 3. There nothing common bitween System wake up and OMAP GPIO bank
IP wake up logic - the last one defines how the GPIO bank ON-IDLE-ON
transition will happen inside SoC under control of PRCM.

Hence, fix the problem by removing omap_set_gpio_wakeup() function
completely and so keeping always in sync GPIO IRQ mask/unmask
(IRQSTATUS_SET) and wake up enable (GPIO_IRQWAKEN) bits; and adding
IRQCHIP_MASK_ON_SUSPEND flag in OMAP GPIO irqchip. That way non wakeup
GPIO IRQs will be properly masked/unmask by IRQ PM core during
suspend/resume cycle.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 551dfa9..b98ede7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -611,51 +611,12 @@ static inline void omap_set_gpio_irqenable(struct gpio_bank *bank,
 		omap_disable_gpio_irqbank(bank, BIT(offset));
 }
 
-/*
- * Note that ENAWAKEUP needs to be enabled in GPIO_SYSCONFIG register.
- * 1510 does not seem to have a wake-up register. If JTAG is connected
- * to the target, system will wake up always on GPIO events. While
- * system is running all registered GPIO interrupts need to have wake-up
- * enabled. When system is suspended, only selected GPIO interrupts need
- * to have wake-up enabled.
- */
-static int omap_set_gpio_wakeup(struct gpio_bank *bank, unsigned offset,
-				int enable)
-{
-	u32 gpio_bit = BIT(offset);
-	unsigned long flags;
-
-	if (bank->non_wakeup_gpios & gpio_bit) {
-		dev_err(bank->chip.parent,
-			"Unable to modify wakeup on non-wakeup GPIO%d\n",
-			offset);
-		return -EINVAL;
-	}
-
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	if (enable)
-		bank->context.wake_en |= gpio_bit;
-	else
-		bank->context.wake_en &= ~gpio_bit;
-
-	writel_relaxed(bank->context.wake_en, bank->base + bank->regs->wkup_en);
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
 static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned offset = d->hwirq;
-	int ret;
 
-	ret = omap_set_gpio_wakeup(bank, offset, enable);
-	if (!ret)
-		ret = irq_set_irq_wake(bank->irq, enable);
-
-	return ret;
+	return irq_set_irq_wake(bank->irq, enable);
 }
 
 static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -1187,6 +1148,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
 	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
+	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
-- 
2.8.1

