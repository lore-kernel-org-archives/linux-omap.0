From: Imre Deak <imre.deak@nokia.com>
Subject: [RFC] ARM: OMAP: handle lazy IRQ disable properly
Date: Sun, 02 Apr 2006 23:04:27 +0300
Message-ID: <1144008267.8058.58.camel@bitbox.mine.nu>
Reply-To: imre.deak@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-v6+lA/ACcIw3RDnCd9Gh"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
Cc: linux-omap <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


--=-v6+lA/ACcIw3RDnCd9Gh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

GPIO IRQs can't be disabled at the moment, since the ARM lazy IRQ
masking is not handled properly by the current GPIO IRQ handler.

Implementing it properly would solve the following issues, which the
standard do_edge_IRQ, do_level_IRQ handlers already do:

- Account for disable_irq delaying the IRQ masking till the next
  interrupt. The IRQ dispatcher should check whether the IRQ line is
  disabled through irq_desc.disable_depth and if so it should not call
  the IRQ handler and should leave the IRQ masked. enable_irq will do
  later the unmasking.

- Try to avoid lost edge triggered interrupts. We won't reenter an
  already running IRQ handler, but will call it again in the next
  iteration of the IRQ dispatch loop.

- Avoid a possible stack overflow. This can happen when the next 
  interrupt is generated before the device driver gets the chance to
  act upon the first interrupt. Since we run edge triggered IRQ handlers
  unmasked this could lead to an unbounded recursion in the IRQ 
  dispatcher. This is at least the case with the ads7846 touchscreen
  controller.

--Imre


--=-v6+lA/ACcIw3RDnCd9Gh
Content-Disposition: attachment; filename=omap-gpio_disable_lazy-patch.diff
Content-Type: text/x-patch; name=omap-gpio_disable_lazy-patch.diff;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d3c8ea7..642f5eb 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -736,6 +736,7 @@ static void gpio_irq_handler(unsigned in
 	u32 isr;
 	unsigned int gpio_irq;
 	struct gpio_bank *bank;
+	u32 retrigger = 0;
 
 	desc->chip->ack(irq);
 
@@ -785,16 +786,49 @@ static void gpio_irq_handler(unsigned in
 		if (!level_mask)
 			desc->chip->unmask(irq);
 
+		isr |= retrigger;
+		retrigger = 0;
 		if (!isr)
 			break;
 
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
 			struct irqdesc *d;
+			int irq_mask;
 			if (!(isr & 1))
 				continue;
 			d = irq_desc + gpio_irq;
+			/* Don't run the handler if it's already running
+			 * or was disabled lazely.
+			 */
+			if (unlikely((d->disable_depth || d->running))) {
+				irq_mask = 1 <<
+					(gpio_irq - bank->virtual_irq_start);
+				/* The unmasking will be done by
+				 * enable_irq in case it is disabled or
+				 * after returning from the handler if
+				 * it's already running.
+				 */
+				_enable_gpio_irqbank(bank, irq_mask, 0);
+				if (!d->disable_depth) {
+					/* Level triggered interrupts
+					 * won't ever be reentered
+					 */
+					BUG_ON(level_mask & irq_mask);
+					d->pending = 1;
+				}
+				continue;
+			}
+			d->running = 1;
 			desc_handle_irq(gpio_irq, d, regs);
+			d->running = 0;
+			if (unlikely(d->pending && !d->disable_depth)) {
+				irq_mask = 1 <<
+					(gpio_irq - bank->virtual_irq_start);
+				d->pending = 0;
+				_enable_gpio_irqbank(bank, irq_mask, 1);
+				retrigger |= irq_mask;
+			}
 		}
 
 		if (cpu_is_omap24xx()) {

--=-v6+lA/ACcIw3RDnCd9Gh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-v6+lA/ACcIw3RDnCd9Gh--
