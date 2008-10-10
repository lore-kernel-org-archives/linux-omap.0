From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 4/6] remove twl4030-pwrirq.c
Date: Fri, 10 Oct 2008 14:21:53 -0700
Message-ID: <200810101421.53886.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44654 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760045AbYJJV3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:51 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Replace twl4030-pwrirq with the more capable generic TWL SIH
support.

"More capable" includes standard support for IRQ trigger modes;
so make the RTC and USB transceiver drivers use genirq for that.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/Makefile         |    2 
 drivers/i2c/chips/twl4030-pwrirq.c |  191 -----------------------------------
 drivers/i2c/chips/twl4030-usb.c    |   23 ----
 drivers/mfd/twl4030-irq.c          |    7 +
 drivers/rtc/rtc-twl4030.c          |   19 ---
 5 files changed, 15 insertions(+), 227 deletions(-)

--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
-obj-$(CONFIG_TWL4030_CORE)	+= twl4030-pwrirq.o twl4030-power.o
+obj-$(CONFIG_TWL4030_CORE)	+= twl4030-power.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
--- a/drivers/i2c/chips/twl4030-pwrirq.c
+++ /dev/null
@@ -1,191 +0,0 @@
-/*
- * twl4030-pwrirq.c - handle power interrupts from TWL3040
- *
- * Copyright (C) 2008 Nokia Corporation
- *
- * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/i2c.h>
-#include <linux/random.h>
-#include <linux/kthread.h>
-#include <linux/i2c/twl4030.h>
-
-
-static DEFINE_SPINLOCK(pwr_lock);
-static u8 twl4030_pwrirq_mask;
-
-static struct task_struct *twl4030_pwrirq_unmask_thread;
-
-static void twl4030_pwrirq_ack(unsigned int irq) {}
-
-static void twl4030_pwrirq_disableint(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pwr_lock, flags);
-	twl4030_pwrirq_mask |= 1 << (irq - TWL4030_PWR_IRQ_BASE);
-	if (twl4030_pwrirq_unmask_thread
-			&& twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
-		wake_up_process(twl4030_pwrirq_unmask_thread);
-	spin_unlock_irqrestore(&pwr_lock, flags);
-}
-
-static void twl4030_pwrirq_enableint(unsigned int irq)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pwr_lock, flags);
-	twl4030_pwrirq_mask &= ~(1 << (irq - TWL4030_PWR_IRQ_BASE));
-	if (twl4030_pwrirq_unmask_thread
-			&& twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
-		wake_up_process(twl4030_pwrirq_unmask_thread);
-	spin_unlock_irqrestore(&pwr_lock, flags);
-}
-
-static struct irq_chip twl4030_pwrirq_chip = {
-	.name	= "twl4030-pwr",
-	.ack	= twl4030_pwrirq_ack,
-	.mask	= twl4030_pwrirq_disableint,
-	.unmask	= twl4030_pwrirq_enableint,
-};
-
-static void do_twl4030_pwrirq(unsigned int irq, irq_desc_t *desc)
-{
-	const unsigned int cpu = smp_processor_id();
-
-	desc->status |= IRQ_LEVEL;
-
-	desc->chip->ack(irq);
-
-	if (!desc->depth) {
-		int ret;
-		int module_irq;
-		u8 pwr_isr;
-
-		kstat_cpu(cpu).irqs[irq]++;
-
-		local_irq_enable();
-		ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &pwr_isr,
-					  TWL4030_INT_PWR_ISR1);
-		local_irq_disable();
-		if (ret) {
-			printk(KERN_WARNING
-				"I2C error %d while reading TWL4030"
-				"INT PWR_ISR1 register\n", ret);
-			return;
-		}
-
-		for (module_irq = TWL4030_PWR_IRQ_BASE; pwr_isr != 0;
-			module_irq++, pwr_isr >>= 1) {
-			if (pwr_isr & 1)
-				generic_handle_irq(module_irq);
-		}
-
-		desc->chip->unmask(irq);
-	}
-}
-
-static int twl4030_pwrirq_thread(void *data)
-{
-	current->flags |= PF_NOFREEZE;
-
-	while (!kthread_should_stop()) {
-		u8 local_mask;
-
-		spin_lock_irq(&pwr_lock);
-		local_mask = twl4030_pwrirq_mask;
-		spin_unlock_irq(&pwr_lock);
-
-		twl4030_i2c_write_u8(TWL4030_MODULE_INT, local_mask,
-				     TWL4030_INT_PWR_IMR1);
-
-		spin_lock_irq(&pwr_lock);
-		if (local_mask == twl4030_pwrirq_mask)
-			set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock_irq(&pwr_lock);
-
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-	return 0;
-}
-
-static int __init twl4030_pwrirq_init(void)
-{
-	int i, err;
-
-	twl4030_pwrirq_mask = 0xff;
-
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
-					TWL4030_INT_PWR_IMR1);
-	if (err)
-		return err;
-
-	/* Enable clear on read */
-
-	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
-				TWL4030_SIH_CTRL_COR_MASK,
-				TWL4030_INT_PWR_SIH_CTRL);
-	if (err)
-		return err;
-
-	twl4030_pwrirq_unmask_thread = kthread_create(twl4030_pwrirq_thread,
-		NULL, "twl4030 pwrirq");
-	if (!twl4030_pwrirq_unmask_thread) {
-		printk(KERN_ERR
-			"%s: could not create twl4030 pwrirq unmask thread!\n",
-				__func__);
-		return -ENOMEM;
-	}
-
-	for (i = TWL4030_PWR_IRQ_BASE; i < TWL4030_PWR_IRQ_END; i++) {
-		set_irq_chip_and_handler(i, &twl4030_pwrirq_chip,
-				handle_edge_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
-
-	set_irq_chained_handler(TWL4030_MODIRQ_PWR, do_twl4030_pwrirq);
-
-	return 0;
-}
-subsys_initcall(twl4030_pwrirq_init);
-
-static void __exit twl4030_pwrirq_exit(void)
-{
-
-	int i;
-
-	/* FIXME the irqs are left enabled; trouble when they arrive... */
-
-	set_irq_handler(TWL4030_MODIRQ_PWR, NULL);
-	set_irq_flags(TWL4030_MODIRQ_PWR, 0);
-
-	for (i = TWL4030_PWR_IRQ_BASE; i < TWL4030_PWR_IRQ_END; i++) {
-		set_irq_handler(i, NULL);
-		set_irq_flags(i, 0);
-	}
-
-	if (twl4030_pwrirq_unmask_thread) {
-		kthread_stop(twl4030_pwrirq_unmask_thread);
-		twl4030_pwrirq_unmask_thread = NULL;
-	}
-}
-module_exit(twl4030_pwrirq_exit);
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -409,23 +410,9 @@ static void twl4030_i2c_access(struct tw
 	}
 }
 
-static void usb_irq_enable(struct twl4030_usb *twl, int rising, int falling)
+static void usb_irq_enable(struct twl4030_usb *twl, int trigger)
 {
-	u8 val;
-
-	/* FIXME use set_irq_type(...) when that (soon) works */
-
-	/* edge setup */
-	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
-				&val, REG_PWR_EDR1) < 0);
-
-	val &= ~(USB_PRES_RISING | USB_PRES_FALLING);
-	if (rising)
-		val = val | USB_PRES_RISING;
-	if (falling)
-		val = val | USB_PRES_FALLING;
-	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
-				val, REG_PWR_EDR1) < 0);
+	set_irq_type(twl->irq, trigger);
 
 	if (!twl->irq_enabled) {
 		enable_irq(twl->irq);
@@ -469,7 +456,7 @@ static void twl4030_phy_suspend(struct t
 
 	if (!controller_off)
 		/* enable rising edge interrupt to detect cable attach */
-		usb_irq_enable(twl, 1, 0);
+		usb_irq_enable(twl, IRQ_TYPE_EDGE_RISING);
 
 	twl4030_phy_power(twl, 0);
 	twl->asleep = 1;
@@ -481,7 +468,7 @@ static void twl4030_phy_resume(struct tw
 		return;
 
 	/* enable falling edge interrupt to detect cable detach */
-	usb_irq_enable(twl, 0, 1);
+	usb_irq_enable(twl, IRQ_TYPE_EDGE_FALLING);
 
 	twl4030_phy_power(twl, 1);
 	twl4030_i2c_access(twl, 1);
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -704,6 +704,13 @@ int twl_init_irq(int irq_num, unsigned i
 	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
 			irq_num, irq_base, twl4030_irq_next - 1);
 
+	/* ... and the PWR_INT module ... */
+	status = twl4030_sih_setup(TWL4030_MODULE_INT);
+	if (status < 0) {
+		pr_err("twl4030: sih_setup PWR INT --> %d\n", status);
+		goto fail;
+	}
+
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
 	task = start_twl4030_irq_thread(irq_num);
 	if (!task) {
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -447,7 +447,8 @@ static int __devinit twl4030_rtc_probe(s
 		goto out1;
 
 	ret = request_irq(irq, twl4030_rtc_interrupt,
-				0, rtc->dev.bus_id, rtc);
+				IRQF_TRIGGER_RISING,
+				rtc->dev.bus_id, rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
 		goto out1;
@@ -466,22 +467,6 @@ static int __devinit twl4030_rtc_probe(s
 			goto out2;
 	}
 
-	/* FIXME stop touching MODULE_INT registers; there's already
-	 * driver code responsible for them.
-	 */
-
-	/* use rising edge detection for RTC alarm */
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT,
-			&rd_reg, TWL4030_INT_PWR_EDR1);
-	if (ret < 0)
-		goto out2;
-
-	rd_reg |= BIT(3);
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
-			rd_reg, TWL4030_INT_PWR_EDR1);
-	if (ret < 0)
-		goto out2;
-
 	/* init cached IRQ enable bits */
 	ret = twl4030_rtc_read_u8(&rtc_irq_bits, REG_RTC_INTERRUPTS_REG);
 	if (ret < 0)
