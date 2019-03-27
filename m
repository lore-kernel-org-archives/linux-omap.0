From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 018/262] gpio: gpio-omap: fix level interrupt idling
Date: Wed, 27 Mar 2019 13:57:53 -0400
Message-ID: <20190327180158.10245-18-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit d01849f7deba81f4959fd9e51bf20dbf46987d1c ]

Tony notes that the GPIO module does not idle when level interrupts are
in use, as the wakeup appears to get stuck.

After extensive investigation, it appears that the wakeup will only be
cleared if the interrupt status register is cleared while the interrupt
is enabled. However, we are currently clearing it with the interrupt
disabled for level-based interrupts.

It is acknowledged that this observed behaviour conflicts with a
statement in the TRM:

CAUTION
  After servicing the interrupt, the status bit in the interrupt status
  register (GPIOi.GPIO_IRQSTATUS_0 or GPIOi.GPIO_IRQSTATUS_1) must be
  reset and the interrupt line released (by setting the corresponding
  bit of the interrupt status register to 1) before enabling an
  interrupt for the GPIO channel in the interrupt-enable register
  (GPIOi.GPIO_IRQSTATUS_SET_0 or GPIOi.GPIO_IRQSTATUS_SET_1) to prevent
  the occurrence of unexpected interrupts when enabling an interrupt
  for the GPIO channel.

However, this does not appear to be a practical problem.

Further, as reported by Grygorii Strashko <grygorii.strashko@ti.com>,
the TI Android kernel tree has an earlier similar patch as "GPIO: OMAP:
Fix the sequence to clear the IRQ status" saying:

 if the status is cleared after disabling the IRQ then sWAKEUP will not
 be cleared and gates the module transition

When we unmask the level interrupt after the interrupt has been handled,
enable the interrupt and only then clear the interrupt. If the interrupt
is still pending, the hardware will re-assert the interrupt status.

Should the caution note in the TRM prove to be a problem, we could
use a clear-enable-clear sequence instead.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[tony@atomide.com: updated comments based on an earlier TI patch]
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-omap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f4e9921fa966..7f33024b6d83 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -883,14 +883,16 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	if (trigger)
 		omap_set_gpio_triggering(bank, offset, trigger);
 
-	/* For level-triggered GPIOs, the clearing must be done after
-	 * the HW source is cleared, thus after the handler has run */
-	if (bank->level_mask & BIT(offset)) {
-		omap_set_gpio_irqenable(bank, offset, 0);
+	omap_set_gpio_irqenable(bank, offset, 1);
+
+	/*
+	 * For level-triggered GPIOs, clearing must be done after the source
+	 * is cleared, thus after the handler has run. OMAP4 needs this done
+	 * after enabing the interrupt to clear the wakeup status.
+	 */
+	if (bank->level_mask & BIT(offset))
 		omap_clear_gpio_irqstatus(bank, offset);
-	}
 
-	omap_set_gpio_irqenable(bank, offset, 1);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-- 
2.19.1
