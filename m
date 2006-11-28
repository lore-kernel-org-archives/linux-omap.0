From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc6-omap1] MPUIO wake updates
Date: Mon, 27 Nov 2006 23:32:25 -0800
Message-ID: <20061128073226.0816C1E1937@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

GPIO and MPUIO wake updates:

 - Hook MPUIOs into the irq wakeup framework too.  This uses a platform
   device to update irq enables during system sleep states, instead of
   a sys_device, since the latter is no longer needed for such things.

 - Also forward enable/disable irq wake requests to the relevant GPIO
   controller, so the top level IRQ dispatcher can (eventually) handle
   these wakeup events automatically if more than one GPIO pin needs to
   be a wakeup event source.

 - Minor tweak to the 24xx non-wakeup gpio stuff: no need to check such
   read-only data under the spinlock.

This assumes (maybe wrongly?) that only 16xx can do GPIO wakeup; without
a 15xx I can't test such stuff.

Also this expects the top level IRQ dispatcher to properly handle requests
to enable/disable irq wake, which is currently known to be wrong:  omap1
saves the flags but ignores them, omap2 doesn't even save it.  (Wakeup
events are, wrongly, hardwired in the relevant mach-omapX/pm.c file ...)
So MPUIO irqs won't yet trigger system wakeup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk2/arch/arm/plat-omap/gpio.c
===================================================================
--- osk2.orig/arch/arm/plat-omap/gpio.c	2006-11-27 22:49:59.000000000 -0800
+++ osk2/arch/arm/plat-omap/gpio.c	2006-11-27 22:50:30.000000000 -0800
@@ -774,29 +774,35 @@ static int _set_gpio_wakeup(struct gpio_
 {
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP16XX
+	case METHOD_MPUIO:
 	case METHOD_GPIO_1610:
 		spin_lock(&bank->lock);
-		if (enable)
+		if (enable) {
 			bank->suspend_wakeup |= (1 << gpio);
-		else
+			enable_irq_wake(bank->irq);
+		} else {
+			disable_irq_wake(bank->irq);
 			bank->suspend_wakeup &= ~(1 << gpio);
+		}
 		spin_unlock(&bank->lock);
 		return 0;
 #endif
 #ifdef CONFIG_ARCH_OMAP24XX
 	case METHOD_GPIO_24XX:
+		if (bank->non_wakeup_gpios & (1 << gpio)) {
+			printk(KERN_ERR "Unable to modify wakeup on "
+			       "non-wakeup GPIO%d\n",
+			       (bank - gpio_bank) * 32 + gpio);
+			return -EINVAL;
+		}
 		spin_lock(&bank->lock);
 		if (enable) {
-			if (bank->non_wakeup_gpios & (1 << gpio)) {
-				printk(KERN_ERR "Unable to enable wakeup on "
-				       "non-wakeup GPIO%d\n",
-				       (bank - gpio_bank) * 32 + gpio);
-				spin_unlock(&bank->lock);
-				return -EINVAL;
-			}
 			bank->suspend_wakeup |= (1 << gpio);
-		} else
+			enable_irq_wake(bank->irq);
+		} else {
+			disable_irq_wake(bank->irq);
 			bank->suspend_wakeup &= ~(1 << gpio);
+		}
 		spin_unlock(&bank->lock);
 		return 0;
 #endif
@@ -1112,16 +1118,81 @@ static struct irq_chip mpuio_irq_chip = 
 	.mask		= mpuio_mask_irq,
 	.unmask		= mpuio_unmask_irq,
 	.set_type	= gpio_irq_type,
+#ifdef CONFIG_ARCH_OMAP16XX
+	/* REVISIT: assuming only 16xx supports MPUIO wake events */
+	.set_wake	= gpio_wake_enable,
+#endif
 };
 
 
 #define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
 
+
+#ifdef CONFIG_ARCH_OMAP16XX
+
+#include <linux/platform_device.h>
+
+static int omap_mpuio_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
+
+	spin_lock(&bank->lock);
+	bank->saved_wakeup = __raw_readl(mask_reg);
+	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
+	spin_unlock(&bank->lock);
+
+	return 0;
+}
+
+static int omap_mpuio_resume_early(struct platform_device *pdev)
+{
+	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
+
+	spin_lock(&bank->lock);
+	__raw_writel(bank->saved_wakeup, mask_reg);
+	spin_unlock(&bank->lock);
+
+	return 0;
+}
+
+/* use platform_driver for this, now that there's no longer any
+ * point to sys_device (other than not disturbing old code).
+ */
+static struct platform_driver omap_mpuio_driver = {
+	.suspend_late	= omap_mpuio_suspend_late,
+	.resume_early	= omap_mpuio_resume_early,
+	.driver		= {
+		.name	= "mpuio",
+	},
+};
+
+static struct platform_device omap_mpuio_device = {
+	.name		= "mpuio",
+	.id		= -1,
+	.dev = {
+		.driver = &omap_mpuio_driver.driver,
+	}
+	/* could list the /proc/iomem resources */
+};
+
+static inline void mpuio_init(void)
+{
+	if (platform_driver_register(&omap_mpuio_driver) == 0)
+		(void) platform_device_register(&omap_mpuio_device);
+}
+
+#else
+static inline void mpuio_init(void) {}
+#endif	/* 16xx */
+
 #else
 
 extern struct irq_chip mpuio_irq_chip;
 
 #define bank_is_mpuio(bank)	0
+static inline void mpuio_init(void) {}
 
 #endif
 
@@ -1487,6 +1558,8 @@ static int __init omap_gpio_sysinit(void
 	if (!initialized)
 		ret = _omap_gpio_init();
 
+	mpuio_init();
+
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX)
 	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		if (ret == 0) {
