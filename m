From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio: gpio-omap: take pm_runtime usage while IRQs are claimed
Date: Mon,  8 Apr 2019 12:45:06 -0700
Message-ID: <20190408194506.25821-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm
instead") moved interrupt using GPIO banks to idle with cpu_pm in order
to drop the use of pm_runtime_irq_safe() in a later patch. The GPIO
banks with no interrupts claimed are still being idled based on PM
runtime calls. However this caused a regression for am437x suspend for
rtc+ddr idle mode as reported by Keerthy <j-keerthy@ti.com>. The fix
to this is:

Bump the pm_runtime usage count while interrupts are in use, rather
than failing the pm_runtime callbacks.  The logic here is a little
non-obvious - the calling order will be:

  omap_gpio_irq_bus_lock()
(optionally) raw_spin_lock_irqsave(desc->lock)
  omap_gpio_irq_startup()
(optionally) raw_spin_unlock_irqrestore(desc->lock)
  gpio_irq_bus_sync_unlock()

As the irq_startup method may be called with interrupts disabled, we
must not use pm_runtime_get() here, so as the bus lock takes an initial
pm reference count us, use pm_runtime_get_if_in_use() which will merely
increment the use count.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Fixes: b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")
Reported-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[tony@atomide.com: updated patch description for regression fix]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

AFAIK this is only needed with patches heading to v5.2, so this is based on
Linux next. We can always backport as needed.

---
 drivers/gpio/gpio-omap.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -811,6 +811,9 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
+	/* Take a reference on the runtime PM to prevent RPM suspends */
+	WARN_ON(pm_runtime_get_if_in_use(bank->chip.parent) == 0);
+
 	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	if (!LINE_USED(bank->mod_usage, offset))
@@ -844,6 +847,8 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 		omap_clear_gpio_debounce(bank, offset);
 	omap_disable_gpio_module(bank, offset);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	pm_runtime_put(bank->chip.parent);
 }
 
 static void omap_gpio_irq_bus_lock(struct irq_data *data)
@@ -1719,40 +1724,26 @@ static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
 {
 	struct gpio_bank *bank = dev_get_drvdata(dev);
 	unsigned long flags;
-	int error = 0;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
-	if (bank->irq_usage) {
-		error = -EBUSY;
-		goto unlock;
-	}
 	omap_gpio_idle(bank, true);
 	bank->is_suspended = true;
-unlock:
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-	return error;
+	return 0;
 }
 
 static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
 {
 	struct gpio_bank *bank = dev_get_drvdata(dev);
 	unsigned long flags;
-	int error = 0;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	/* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
-	if (bank->irq_usage) {
-		error = -EBUSY;
-		goto unlock;
-	}
 	omap_gpio_unidle(bank);
 	bank->is_suspended = false;
-unlock:
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-	return error;
+	return 0;
 }
 
 static const struct dev_pm_ops gpio_pm_ops = {
-- 
2.21.0
