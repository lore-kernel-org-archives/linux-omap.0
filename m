From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] I2C: TWL4030: Add power button and power IRQ
	support
Date: Fri, 4 Apr 2008 12:44:04 +0300
Message-ID: <20080404094403.GH3505@atomide.com>
References: <1207230264-4629-1-git-send-email-felipe.balbi@nokia.com> <20080403134705.GY7004@gandalf.research.nokia.com> <20080403135733.GE5199@codecarver.research.nokia.com> <20080403140440.GC7004@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61132 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYDDJoI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 05:44:08 -0400
Content-Disposition: inline
In-Reply-To: <20080403140440.GC7004@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080403 17:10]:
> On Thu, Apr 03, 2008 at 04:57:33PM +0300, Peter 'p2' De Schrijver wrote:
> > Felipe,
> > 
> > > +
> > > +		for (module_irq = IH_TWL4030_PWRBASE; pwr_isr != 0;
> > > +			module_irq++, pwr_isr >>= 1) {
> > > +			if (pwr_isr & 1) {
> > > +				irq_desc_t *d = irq_desc + module_irq;
> > > +				d->handle_irq(module_irq, d);
> > 
> > There is a missing } here.
> > 
> > > +		}
> > > +
> > > +		local_irq_disable();
> > > +		desc->chip->unmask(irq);
> > > +	}
> > > +}
> > > +
> > 
> > Cheers,
> > 
> > Peter.
> 
> Ugh, edited by hand and forgot it.
> 
> hopefully the final version:

Pushing this series today.

Tony


> From 10b0fa72ded443a8d89ef3676f9ea08b3b87f8c0 Mon Sep 17 00:00:00 2001
> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> Date: Wed, 2 Apr 2008 20:57:58 +0300
> Subject: [PATCH 1/3] I2C: TWL4030: Add power button and power IRQ support
> 
> The following patch implements power button and IRQ support
> for triton2 power block.
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-pwrbutton.c     |  160 ++++++++++++++++++++
>  drivers/i2c/chips/twl4030-pwrirq.c        |  224 +++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/board-3430sdp.h |    9 +-
>  3 files changed, 390 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/i2c/chips/twl4030-pwrbutton.c
>  create mode 100644 drivers/i2c/chips/twl4030-pwrirq.c
> 
> diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
> new file mode 100644
> index 0000000..a541ed6
> --- /dev/null
> +++ b/drivers/i2c/chips/twl4030-pwrbutton.c
> @@ -0,0 +1,160 @@
> +/**
> + * drivers/i2c/chips/twl4030-pwrbutton.c
> + *
> + * Driver for sending triton2 power button event to input-layer
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/timer.h>
> +#include <linux/jiffies.h>
> +#include <linux/kthread.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#define PWR_ISR1 0
> +#define PWR_IMR1 1
> +#define PWR_PWRON_IRQ (1<<0)
> +
> +#define PWR_EDR1 5
> +#define PWR_PWRON_RISING (1<<1)
> +#define PWR_PWRON_FALLING  (1<<0)
> +#define PWR_PWRON_BOTH (PWR_PWRON_RISING | PWR_PWRON_FALLING)
> +
> +#define PWR_SIH_CTRL 7
> +
> +#define STS_HW_CONDITIONS 0xf
> +
> +static struct input_dev *powerbutton_dev;
> +
> +/*
> + * Note : the following function runs in kernel thread context
> + * with IRQs enabled
> + */
> +
> +static irqreturn_t powerbutton_irq(int irq, void *dev_id)
> +{
> +	int err;
> +	u8 value;
> +
> +	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
> +				  STS_HW_CONDITIONS);
> +	if (!err)  {
> +		input_report_key(powerbutton_dev, KEY_POWER,
> +				 value & PWR_PWRON_IRQ);
> +	} else {
> +		printk(KERN_WARNING "I2C error %d while reading TWL4030"
> +			"PM_MASTER STS_HW_CONDITIONS register\n", err);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init twl4030_pwrbutton_init(void)
> +{
> +	int err = 0;
> +	u8 value;
> +
> +	if (request_irq(TWL4030_PWRIRQ_PWRBTN, powerbutton_irq, 0,
> +			"PwrButton", NULL) < 0) {
> +		printk(KERN_ERR "Unable to allocate IRQ for power button\n");
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	powerbutton_dev = input_allocate_device();
> +	if (!powerbutton_dev) {
> +		printk(KERN_ERR
> +			"Unable to allocate input device for power button\n");
> +		err = -ENOMEM;
> +		goto free_irq_and_out;
> +	}
> +
> +	powerbutton_dev->evbit[0] = BIT_MASK(EV_KEY);
> +	powerbutton_dev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
> +	powerbutton_dev->name = "triton2-pwrbutton";
> +
> +	err = input_register_device(powerbutton_dev);
> +	if (err)
> +		goto free_input_dev;
> +
> +	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_IMR1);
> +	if (err) {
> +		printk(KERN_WARNING "I2C error %d while reading TWL4030"
> +					"INT PWR_IMR1 register\n", err);
> +
> +		goto free_input_dev;
> +	}
> +
> +	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> +				   value & (~PWR_PWRON_IRQ), PWR_IMR1);
> +	if (err) {
> +		printk(KERN_WARNING "I2C error %d while writing TWL4030"
> +				    "INT PWR_IMR1 register\n", err);
> +		goto free_input_dev;
> +	}
> +
> +	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_EDR1);
> +	if (err) {
> +		printk(KERN_WARNING "I2C error %d while reading TWL4030"
> +					"INT PWR_EDR1 register\n", err);
> +		goto free_input_dev;
> +	}
> +
> +	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> +				   value | PWR_PWRON_BOTH , PWR_EDR1);
> +
> +	if (err) {
> +		printk(KERN_WARNING "I2C error %d while writing TWL4030"
> +					"INT PWR_EDR1 register\n", err);
> +		goto free_input_dev;
> +	}
> +
> +	printk(KERN_INFO "triton2 power button driver initialized\n");
> +
> +	return 0;
> +
> +
> +free_input_dev:
> +	input_free_device(powerbutton_dev);
> +free_irq_and_out:
> +	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
> +out:
> +	return err;
> +}
> +
> +static void __exit twl4030_pwrbutton_exit(void)
> +{
> +	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
> +	input_unregister_device(powerbutton_dev);
> +	input_free_device(powerbutton_dev);
> +
> +}
> +
> +module_init(twl4030_pwrbutton_init);
> +module_exit(twl4030_pwrbutton_exit);
> +
> +MODULE_DESCRIPTION("Triton2 Power Button");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Peter De Schrijver");
> +
> diff --git a/drivers/i2c/chips/twl4030-pwrirq.c b/drivers/i2c/chips/twl4030-pwrirq.c
> new file mode 100644
> index 0000000..d6098ad
> --- /dev/null
> +++ b/drivers/i2c/chips/twl4030-pwrirq.c
> @@ -0,0 +1,224 @@
> +/*
> + * twl4030-pwrirq.c - handle power interrupts from TWL3040
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel_stat.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/i2c.h>
> +#include <linux/random.h>
> +#include <linux/kthread.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#define PWR_ISR1 0
> +#define PWR_IMR1 1
> +#define PWR_SIH_CTRL 7
> +#define PWR_SIH_CTRL_COR (1<<2)
> +
> +static u8 twl4030_pwrirq_mask;
> +static u8 twl4030_pwrirq_pending_unmask;
> +
> +static struct task_struct *twl4030_pwrirq_unmask_thread;
> +
> +static void twl4030_pwrirq_ack(unsigned int irq) {}
> +
> +static void twl4030_pwrirq_disableint(unsigned int irq) {}
> +
> +static void twl4030_pwrirq_enableint(unsigned int irq)
> +{
> +	twl4030_pwrirq_pending_unmask |= 1 << (irq - IH_TWL4030_PWRBASE);
> +	if (twl4030_pwrirq_unmask_thread &&
> +		twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
> +		wake_up_process(twl4030_pwrirq_unmask_thread);
> +}
> +
> +static struct irq_chip twl4030_pwrirq_chip = {
> +	.name	= "twl4030-pwr",
> +	.ack	= twl4030_pwrirq_ack,
> +	.mask	= twl4030_pwrirq_disableint,
> +	.unmask	= twl4030_pwrirq_enableint,
> +};
> +
> +static void do_twl4030_pwrmodule_irq(unsigned int irq, irq_desc_t *desc)
> +{
> +	struct irqaction *action;
> +	const unsigned int cpu = smp_processor_id();
> +
> +	desc->status |= IRQ_LEVEL;
> +
> +	if (!desc->depth) {
> +		kstat_cpu(cpu).irqs[irq]++;
> +
> +		action = desc->action;
> +		if (action) {
> +			int ret;
> +			int status = 0;
> +			int retval = 0;
> +
> +			do {
> +				ret = action->handler(irq, action->dev_id);
> +				if (ret == IRQ_HANDLED)
> +					status |= action->flags;
> +				retval |= ret;
> +				action = action->next;
> +			} while (action);
> +
> +			if (status & IRQF_SAMPLE_RANDOM)
> +				add_interrupt_randomness(irq);
> +
> +			if (retval != IRQ_HANDLED)
> +				printk(KERN_ERR "ISR for TWL4030 power module"
> +					" irq %d can't handle interrupt\n",
> +					irq);
> +		} else {
> +			local_irq_disable();
> +			twl4030_pwrirq_mask |= 1 << (irq - IH_TWL4030_PWRBASE);
> +			local_irq_enable();
> +			twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> +						twl4030_pwrirq_mask, PWR_IMR1);
> +		}
> +	}
> +}
> +
> +static void do_twl4030_pwrirq(unsigned int irq, irq_desc_t *desc)
> +{
> +	const unsigned int cpu = smp_processor_id();
> +
> +	desc->status |= IRQ_LEVEL;
> +
> +	desc->chip->ack(irq);
> +
> +	if (!desc->depth) {
> +		int ret;
> +		int module_irq;
> +		u8 pwr_isr;
> +
> +		kstat_cpu(cpu).irqs[irq]++;
> +
> +		local_irq_enable();
> +		ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &pwr_isr,
> +						PWR_ISR1);
> +		if (ret) {
> +			printk(KERN_WARNING
> +				"I2C error %d while reading TWL4030"
> +				"INT PWR_ISR1 register\n", ret);
> +			return;
> +		}
> +
> +		for (module_irq = IH_TWL4030_PWRBASE; pwr_isr != 0;
> +			module_irq++, pwr_isr >>= 1) {
> +			if (pwr_isr & 1)
> +				irq_desc_t *d = irq_desc + module_irq;
> +		}
> +
> +		local_irq_disable();
> +		desc->chip->unmask(irq);
> +	}
> +}
> +
> +static int twl4030_pwrirq_thread(void *data)
> +{
> +	current->flags |= PF_NOFREEZE;
> +
> +	while (!kthread_should_stop()) {
> +		u8 local_unmask;
> +
> +		local_irq_disable();
> +		local_unmask = twl4030_pwrirq_pending_unmask;
> +		twl4030_pwrirq_pending_unmask = 0;
> +		local_irq_enable();
> +
> +		twl4030_pwrirq_mask &= ~local_unmask;
> +
> +		twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
> +					PWR_IMR1);
> +
> +		local_irq_disable();
> +		if (!twl4030_pwrirq_pending_unmask)
> +			set_current_state(TASK_INTERRUPTIBLE);
> +		local_irq_enable();
> +
> +		schedule();
> +	}
> +	set_current_state(TASK_RUNNING);
> +	return 0;
> +}
> +
> +static int __init twl4030_pwrirq_init(void)
> +{
> +	int i, err;
> +
> +	twl4030_pwrirq_mask = 0xff;
> +	twl4030_pwrirq_pending_unmask = 0;
> +
> +	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
> +					PWR_IMR1);
> +	if (err)
> +		return err;
> +
> +	/* Enable clear on read */
> +
> +	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT, PWR_SIH_CTRL_COR,
> +					PWR_SIH_CTRL);
> +	if (err)
> +		return err;
> +
> +	twl4030_pwrirq_unmask_thread = kthread_create(twl4030_pwrirq_thread,
> +		NULL, "twl4030 pwrirq");
> +	if (!twl4030_pwrirq_unmask_thread) {
> +		printk(KERN_ERR
> +			"%s: could not create twl4030 pwrirq unmask thread!\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = IH_TWL4030_PWRBASE; i < IH_TWL4030_PWRBASE_END; i++) {
> +		set_irq_chip(i, &twl4030_pwrirq_chip);
> +		set_irq_handler(i, do_twl4030_pwrmodule_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(TWL4030_MODIRQ_PWR, do_twl4030_pwrirq);
> +
> +	return 0;
> +}
> +
> +static void __exit twl4030_pwrirq_exit(void)
> +{
> +
> +	int i;
> +
> +	set_irq_handler(TWL4030_MODIRQ_PWR, NULL);
> +	set_irq_flags(TWL4030_MODIRQ_PWR, 0);
> +
> +	for (i = IH_TWL4030_PWRBASE; i < IH_TWL4030_PWRBASE_END; i++) {
> +		set_irq_handler(i, NULL);
> +		set_irq_flags(i, 0);
> +	}
> +
> +	if (twl4030_pwrirq_unmask_thread) {
> +		kthread_stop(twl4030_pwrirq_unmask_thread);
> +		twl4030_pwrirq_unmask_thread = NULL;
> +	}
> +}
> +
> +subsys_initcall(twl4030_pwrirq_init);
> +module_exit(twl4030_pwrirq_exit);
> diff --git a/include/asm-arm/arch-omap/board-3430sdp.h b/include/asm-arm/arch-omap/board-3430sdp.h
> index 06379cf..87f47e5 100644
> --- a/include/asm-arm/arch-omap/board-3430sdp.h
> +++ b/include/asm-arm/arch-omap/board-3430sdp.h
> @@ -75,14 +75,17 @@ extern void sdp_mmc_init(void);
>  #define	IH_TWL4030_BASE		IH_BOARD_BASE
>  #define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
>  
> +#define IH_TWL4030_PWRBASE     (IH_TWL4030_END)
> +#define IH_TWL4030_PWRBASE_END (IH_TWL4030_PWRBASE+8)
> +
>  #ifdef CONFIG_TWL4030_GPIO
>  
>  /* TWL4030 GPIO Interrupts */
> -#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_END)
> -#define IH_TWL4030_GPIO_END	(IH_TWL4030_BASE+18)
> +#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
> +#define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
>  #define NR_IRQS			(IH_TWL4030_GPIO_END)
>  #else
> -#define NR_IRQS			(IH_TWL4030_END)
> +#define NR_IRQS			(IH_TWL4030_PWRBASE_END)
>  #endif /* CONFIG_I2C_TWL4030_GPIO */
>  #endif /* End of support for TWL4030 */
>  #endif /*  __ASM_ARCH_OMAP_3430SDP_H */
> -- 
> 1.5.5.rc2.25.g5fbd
> 
> 
> 
> -- 
> 	- Balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
