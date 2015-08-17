From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 1/2] gpiolib: irqchip: use different lockdep class for each gpio irqchip
Date: Mon, 17 Aug 2015 15:35:23 +0300
Message-ID: <1439814924-11881-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, lars@metafoo.de, Grygorii Strashko <grygorii.strashko@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Since IRQ chip helpers were introduced drivers lose ability to
register separate lockdep classes for each registered GPIO IRQ
chip and the gpiolib now is using shared lockdep class for
all GPIO IRQ chips (gpiochip_irq_lock_class).
As result, lockdep will produce warning when there are min two
stacked GPIO chips and all of them are interrupt controllers.

HW configuration which generates lockdep warning (TI dra7-evm):

[SOC GPIO bankA.gpioX]
  <- irq - [pcf875x.gpioY]
            <- irq - DevZ.enable_irq_wake(pcf_gpioY_irq);
The issue was reported in [1] and discussed [2].

=============================================
[ INFO: possible recursive locking detected ]
4.2.0-rc6-00013-g5d050ed-dirty #55 Not tainted
---------------------------------------------
sh/63 is trying to acquire lock:
 (class){......}, at: [<c009b91c>] __irq_get_desc_lock+0x50/0x94

but task is already holding lock:
 (class){......}, at: [<c009b91c>] __irq_get_desc_lock+0x50/0x94

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(class);
  lock(class);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by sh/63:
 #0:  (sb_writers#4){.+.+.+}, at: [<c016bbb8>] vfs_write+0x13c/0x164
 #1:  (&of->mutex){+.+.+.}, at: [<c01debf4>] kernfs_fop_write+0x4c/0x1a0
 #2:  (s_active#36){.+.+.+}, at: [<c01debfc>] kernfs_fop_write+0x54/0x1a0
 #3:  (pm_mutex){+.+.+.}, at: [<c009758c>] pm_suspend+0xec/0x4c4
 #4:  (&dev->mutex){......}, at: [<c03f77f8>] __device_suspend+0xd4/0x398
 #5:  (&gpio->lock){+.+.+.}, at: [<c009b940>] __irq_get_desc_lock+0x74/0x94
 #6:  (class){......}, at: [<c009b91c>] __irq_get_desc_lock+0x50/0x94

stack backtrace:
CPU: 0 PID: 63 Comm: sh Not tainted 4.2.0-rc6-00013-g5d050ed-dirty #55
Hardware name: Generic DRA74X (Flattened Device Tree)
[<c0016e24>] (unwind_backtrace) from [<c0013338>] (show_stack+0x10/0x14)
[<c0013338>] (show_stack) from [<c05f6b24>] (dump_stack+0x84/0x9c)
[<c05f6b24>] (dump_stack) from [<c00903f4>] (__lock_acquire+0x19c0/0x1e20)
[<c00903f4>] (__lock_acquire) from [<c0091098>] (lock_acquire+0xa8/0x128)
[<c0091098>] (lock_acquire) from [<c05fd61c>] (_raw_spin_lock_irqsave+0x38/0x4c)
[<c05fd61c>] (_raw_spin_lock_irqsave) from [<c009b91c>] (__irq_get_desc_lock+0x50/0x94)
[<c009b91c>] (__irq_get_desc_lock) from [<c009c4f4>] (irq_set_irq_wake+0x20/0xfc)
[<c009c4f4>] (irq_set_irq_wake) from [<c0393ac4>] (pcf857x_irq_set_wake+0x24/0x54)
[<c0393ac4>] (pcf857x_irq_set_wake) from [<c009c560>] (irq_set_irq_wake+0x8c/0xfc)
[<c009c560>] (irq_set_irq_wake) from [<c04a02ac>] (gpio_keys_suspend+0x70/0xd4)
[<c04a02ac>] (gpio_keys_suspend) from [<c03f6a00>] (dpm_run_callback+0x50/0x124)
[<c03f6a00>] (dpm_run_callback) from [<c03f7830>] (__device_suspend+0x10c/0x398)
[<c03f7830>] (__device_suspend) from [<c03f90f0>] (dpm_suspend+0x134/0x2f4)
[<c03f90f0>] (dpm_suspend) from [<c0096e20>] (suspend_devices_and_enter+0xa8/0x728)
[<c0096e20>] (suspend_devices_and_enter) from [<c00977cc>] (pm_suspend+0x32c/0x4c4)
[<c00977cc>] (pm_suspend) from [<c0096060>] (state_store+0x64/0xb8)
[<c0096060>] (state_store) from [<c01dec64>] (kernfs_fop_write+0xbc/0x1a0)
[<c01dec64>] (kernfs_fop_write) from [<c016b280>] (__vfs_write+0x20/0xd8)
[<c016b280>] (__vfs_write) from [<c016bb0c>] (vfs_write+0x90/0x164)
[<c016bb0c>] (vfs_write) from [<c016c330>] (SyS_write+0x44/0x9c)
[<c016c330>] (SyS_write) from [<c000f500>] (ret_fast_syscall+0x0/0x54)

Lets fix it by using separate lockdep class for each registered GPIO
IRQ Chip. This is done by wrapping gpiochip_irqchip_add call into macros.

The implementation of this patch inspired by solution done by Nicolas
Boichat for regmap [3]

[1] http://www.spinics.net/lists/linux-gpio/msg05844.html
[2] http://www.spinics.net/lists/linux-gpio/msg06021.html
[3] http://www.spinics.net/lists/arm-kernel/msg429834.html

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roger Quadros <rogerq@ti.com>
Reported-by: Roger Quadros <rogerq@ti.com>
Tested-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v2:
- removed accidental change in gpio chip structure description.

 drivers/gpio/gpiolib.c      | 27 ++++++++++++++-------------
 include/linux/gpio/driver.h | 26 +++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 34f95fb..b562dd3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -462,12 +462,6 @@ void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
 }
 EXPORT_SYMBOL_GPL(gpiochip_set_chained_irqchip);
 
-/*
- * This lock class tells lockdep that GPIO irqs are in a different
- * category than their parents, so it won't report false recursion.
- */
-static struct lock_class_key gpiochip_irq_lock_class;
-
 /**
  * gpiochip_irq_map() - maps an IRQ into a GPIO irqchip
  * @d: the irqdomain used by this irqchip
@@ -484,7 +478,11 @@ static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 	struct gpio_chip *chip = d->host_data;
 
 	irq_set_chip_data(irq, chip);
-	irq_set_lockdep_class(irq, &gpiochip_irq_lock_class);
+	/*
+	 * This lock class tells lockdep that GPIO irqs are in a different
+	 * category than their parents, so it won't report false recursion.
+	 */
+	irq_set_lockdep_class(irq, chip->lock_key);
 	irq_set_chip_and_handler(irq, chip->irqchip, chip->irq_handler);
 	/* Chips that can sleep need nested thread handlers */
 	if (chip->can_sleep && !chip->irq_not_threaded)
@@ -589,6 +587,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip)
  * @handler: the irq handler to use (often a predefined irq core function)
  * @type: the default type for IRQs on this irqchip, pass IRQ_TYPE_NONE
  * to have the core avoid setting up any default type in the hardware.
+ * @lock_key: lockdep class
  *
  * This function closely associates a certain irqchip with a certain
  * gpiochip, providing an irq domain to translate the local IRQs to
@@ -604,11 +603,12 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip)
  * the pins on the gpiochip can generate a unique IRQ. Everything else
  * need to be open coded.
  */
-int gpiochip_irqchip_add(struct gpio_chip *gpiochip,
-			 struct irq_chip *irqchip,
-			 unsigned int first_irq,
-			 irq_flow_handler_t handler,
-			 unsigned int type)
+int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
+			  struct irq_chip *irqchip,
+			  unsigned int first_irq,
+			  irq_flow_handler_t handler,
+			  unsigned int type,
+			  struct lock_class_key *lock_key)
 {
 	struct device_node *of_node;
 	unsigned int offset;
@@ -634,6 +634,7 @@ int gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 	gpiochip->irq_handler = handler;
 	gpiochip->irq_default_type = type;
 	gpiochip->to_irq = gpiochip_to_irq;
+	gpiochip->lock_key = lock_key;
 	gpiochip->irqdomain = irq_domain_add_simple(of_node,
 					gpiochip->ngpio, first_irq,
 					&gpiochip_domain_ops, gpiochip);
@@ -671,7 +672,7 @@ int gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(gpiochip_irqchip_add);
+EXPORT_SYMBOL_GPL(_gpiochip_irqchip_add);
 
 #else /* CONFIG_GPIOLIB_IRQCHIP */
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c8393cd..0c7004d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -6,6 +6,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/lockdep.h>
 #include <linux/pinctrl/pinctrl.h>
 
 struct device;
@@ -126,6 +127,7 @@ struct gpio_chip {
 	irq_flow_handler_t	irq_handler;
 	unsigned int		irq_default_type;
 	int			irq_parent;
+	struct lock_class_key	*lock_key;
 #endif
 
 #if defined(CONFIG_OF_GPIO)
@@ -171,11 +173,25 @@ void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
 		int parent_irq,
 		irq_flow_handler_t parent_handler);
 
-int gpiochip_irqchip_add(struct gpio_chip *gpiochip,
-		struct irq_chip *irqchip,
-		unsigned int first_irq,
-		irq_flow_handler_t handler,
-		unsigned int type);
+int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
+			  struct irq_chip *irqchip,
+			  unsigned int first_irq,
+			  irq_flow_handler_t handler,
+			  unsigned int type,
+			  struct lock_class_key *lock_key);
+
+#ifdef CONFIG_LOCKDEP
+#define gpiochip_irqchip_add(...)				\
+(								\
+	({							\
+		static struct lock_class_key _key;		\
+		_gpiochip_irqchip_add(__VA_ARGS__, &_key);	\
+	})							\
+)
+#else
+#define gpiochip_irqchip_add(...)				\
+	_gpiochip_irqchip_add(__VA_ARGS__, NULL)
+#endif
 
 #endif /* CONFIG_GPIOLIB_IRQCHIP */
 
-- 
2.5.0

