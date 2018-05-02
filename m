From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] arm: omap1: ams-delta: fix deferred_fiq handler
Date: Wed,  2 May 2018 20:32:03 +0200
Message-ID: <20180502183203.16034-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

The deferred_fiq handler used to limit hardware operations to IRQ
unmask only, relying on gpio-omap assigned handler performing the ACKs.
Since commit 80ac93c27441 ("gpio: omap: Fix lost edge interrupts") this
is no longer the case as handle_edge_irq() has been replaced with
handle_simmple_irq() which doesn't touch the hardware.

Add single ACK operation per each active IRQ pin to the handler. While
being at it, move unmask operation out of irq_counter loop so it is
also called only once for each active IRQ pin.

Created and tested against linux-4.17-rc2.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 793a24a53c52..d7ca9e2b40d2 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -58,22 +58,24 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 		irq_num = gpio_to_irq(gpio);
 		fiq_count = fiq_buffer[FIQ_CNT_INT_00 + gpio];
 
-		while (irq_counter[gpio] < fiq_count) {
-			if (gpio != AMS_DELTA_GPIO_PIN_KEYBRD_CLK) {
-				struct irq_data *d = irq_get_irq_data(irq_num);
-
-				/*
-				 * It looks like handle_edge_irq() that
-				 * OMAP GPIO edge interrupts default to,
-				 * expects interrupt already unmasked.
-				 */
-				if (irq_chip && irq_chip->irq_unmask)
+		if (irq_counter[gpio] < fiq_count &&
+				gpio != AMS_DELTA_GPIO_PIN_KEYBRD_CLK) {
+			struct irq_data *d = irq_get_irq_data(irq_num);
+
+			/*
+			 * handle_simple_irq() that OMAP GPIO edge
+			 * interrupts default to since commit 80ac93c27441
+			 * requires interrupt already acked and unmasked.
+			 */
+			if (irq_chip) {
+				if (irq_chip->irq_ack)
+					irq_chip->irq_ack(d);
+				if (irq_chip->irq_unmask)
 					irq_chip->irq_unmask(d);
 			}
-			generic_handle_irq(irq_num);
-
-			irq_counter[gpio]++;
 		}
+		for (; irq_counter[gpio] < fiq_count; irq_counter[gpio]++)
+			generic_handle_irq(irq_num);
 	}
 	return IRQ_HANDLED;
 }
-- 
2.16.1
