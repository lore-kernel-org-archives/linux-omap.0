From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc/rft 2.6.27-rc8-omap-git] twl4030-pwrirq
	simplification, cleanup
Date: Fri, 10 Oct 2008 14:56:13 +0300
Message-ID: <20081010115611.GY3044@atomide.com>
References: <200810060119.18848.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57942 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbYJJL4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:56:17 -0400
Content-Disposition: inline
In-Reply-To: <200810060119.18848.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081006 11:20]:
> I can't test the pwrbutton stuff, but rtc and musb behave...
> 
> With one issue:  the usb transceiver glue misbehaves on
> startup if the device is connected.  (Again.)  I looked at
> this a bit, and I think the issue is probably caused by
> not actually using key USB registers ... IRQ trigger
> mode state transitions are at best a fragile proxy for the
> real state.
> 
> (This is similar to the GPIO patch I just sent, but simpler
> except for the impact on the few drivers thinking oddly
> about IRQs.  Those patches cover the key SIH modules, and
> a similar one affects the PIH in twl4030-core.)

Pushing this, looks like we should have the remaining I2C
issues sorted out soon.

Tony

> 
> - Dave
> 
> 
> ================================
> Streamline the "power irq" code, and some of the mechanisms
> it uses:
> 
>  - Support IRQ masking, not just unmasking; simpler code.
>  - Use the standard handle_edge_irq() handler for these edge IRQs.
>  - Use generic_handle_irq() instead of a manual expansion thereof.
>  - Provide a missing spinlock for the shared data.
> 
> In short, use more of the standard genirq code ... more correctly.
> 
> Also, update the drivers using the "power IRQ" accordingly:
> 
>  - Don't request IRQF_DISABLED if the handler makes I2C calls;
>    and defend against lockdep forcing it on us.
> 
>  - Let the irq_chip handle IRQ mask/unmask; it handles mutual
>    exclusion between drivers, among other things.
> 
>  - (Unrelated) remove useless MODULE_ALIAS in pwrbutton.
> 
> The USB transceiver driver still places some dodgey games with IRQ
> enable/disable, and IRQ trigger flags.  At least some of them seem
> like they'd be simplified by using USB transceiver registers ...
> notably, startup code, which doesn't seem to check state before
> it enters an irq-driven mode.
> 
> For the moment, these drivers still (wrongly) try to configure IRQ
> trigger modes themselves ... again, that's something that an irq_chip
> handles (but not yet, for this one).
> 
> NOTE:  tested (MUSB and RTC only) along with the init/retry hack
> to make twl4030-pwrirq work around the i2c-omap timeout problems.
> 
> ---
>  drivers/i2c/chips/twl4030-pwrbutton.c |   33 ++++------
>  drivers/i2c/chips/twl4030-pwrirq.c    |   98 ++++++++++----------------------
>  drivers/i2c/chips/twl4030-usb.c       |   57 ++++++++----------
>  drivers/rtc/rtc-twl4030.c             |    8 ++
>  4 files changed, 80 insertions(+), 116 deletions(-)
> 
> --- a/drivers/i2c/chips/twl4030-pwrbutton.c
> +++ b/drivers/i2c/chips/twl4030-pwrbutton.c
> @@ -49,6 +49,14 @@ static irqreturn_t powerbutton_irq(int i
>  	int err;
>  	u8 value;
>  
> +#ifdef CONFIG_LOCKDEP
> +	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
> +	 * we don't want and can't tolerate.  Although it might be
> +	 * friendlier not to borrow this thread context...
> +	 */
> +	local_irq_enable();
> +#endif
> +
>  	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
>  				  STS_HW_CONDITIONS);
>  	if (!err)  {
> @@ -67,6 +75,7 @@ static int __init twl4030_pwrbutton_init
>  	int err = 0;
>  	u8 value;
>  
> +	/* PWRBTN == PWRON */
>  	if (request_irq(TWL4030_PWRIRQ_PWRBTN, powerbutton_irq, 0,
>  			"PwrButton", NULL) < 0) {
>  		printk(KERN_ERR "Unable to allocate IRQ for power button\n");
> @@ -92,22 +101,9 @@ static int __init twl4030_pwrbutton_init
>  		goto free_irq_and_out;
>  	}
>  
> -	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_IMR1);
> -	if (err) {
> -		printk(KERN_WARNING "I2C error %d while reading TWL4030"
> -					" INT PWR_IMR1 register\n", err);
> -
> -		goto free_input_dev;
> -	}
> -
> -	err = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> -				   value & (~PWR_PWRON_IRQ), PWR_IMR1);
> -	if (err) {
> -		printk(KERN_WARNING "I2C error %d while writing TWL4030"
> -				    " INT PWR_IMR1 register\n", err);
> -		goto free_input_dev;
> -	}
> -
> +	/* FIXME just pass IRQF_EDGE_FALLING | IRQF_EDGE_RISING
> +	 * to request_irq(), once MODULE_INT supports them...
> +	 */
>  	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_EDR1);
>  	if (err) {
>  		printk(KERN_WARNING "I2C error %d while reading TWL4030"
> @@ -136,19 +132,16 @@ free_irq_and_out:
>  out:
>  	return err;
>  }
> +module_init(twl4030_pwrbutton_init);
>  
>  static void __exit twl4030_pwrbutton_exit(void)
>  {
>  	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
>  	input_unregister_device(powerbutton_dev);
>  	input_free_device(powerbutton_dev);
> -
>  }
> -
> -module_init(twl4030_pwrbutton_init);
>  module_exit(twl4030_pwrbutton_exit);
>  
> -MODULE_ALIAS("i2c:twl4030-pwrbutton");
>  MODULE_DESCRIPTION("Triton2 Power Button");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Peter De Schrijver");
> --- a/drivers/i2c/chips/twl4030-pwrirq.c
> +++ b/drivers/i2c/chips/twl4030-pwrirq.c
> @@ -29,21 +29,35 @@
>  #include <linux/i2c/twl4030.h>
>  
>  
> +static DEFINE_SPINLOCK(pwr_lock);
>  static u8 twl4030_pwrirq_mask;
> -static u8 twl4030_pwrirq_pending_unmask;
>  
>  static struct task_struct *twl4030_pwrirq_unmask_thread;
>  
>  static void twl4030_pwrirq_ack(unsigned int irq) {}
>  
> -static void twl4030_pwrirq_disableint(unsigned int irq) {}
> +static void twl4030_pwrirq_disableint(unsigned int irq)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pwr_lock, flags);
> +	twl4030_pwrirq_mask |= 1 << (irq - TWL4030_PWR_IRQ_BASE);
> +	if (twl4030_pwrirq_unmask_thread
> +			&& twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
> +		wake_up_process(twl4030_pwrirq_unmask_thread);
> +	spin_unlock_irqrestore(&pwr_lock, flags);
> +}
>  
>  static void twl4030_pwrirq_enableint(unsigned int irq)
>  {
> -	twl4030_pwrirq_pending_unmask |= 1 << (irq - TWL4030_PWR_IRQ_BASE);
> -	if (twl4030_pwrirq_unmask_thread &&
> -		twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pwr_lock, flags);
> +	twl4030_pwrirq_mask &= ~(1 << (irq - TWL4030_PWR_IRQ_BASE));
> +	if (twl4030_pwrirq_unmask_thread
> +			&& twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
>  		wake_up_process(twl4030_pwrirq_unmask_thread);
> +	spin_unlock_irqrestore(&pwr_lock, flags);
>  }
>  
>  static struct irq_chip twl4030_pwrirq_chip = {
> @@ -53,48 +67,6 @@ static struct irq_chip twl4030_pwrirq_ch
>  	.unmask	= twl4030_pwrirq_enableint,
>  };
>  
> -static void do_twl4030_pwrmodule_irq(unsigned int irq, irq_desc_t *desc)
> -{
> -	struct irqaction *action;
> -	const unsigned int cpu = smp_processor_id();
> -
> -	desc->status |= IRQ_LEVEL;
> -
> -	if (!desc->depth) {
> -		kstat_cpu(cpu).irqs[irq]++;
> -
> -		action = desc->action;
> -		if (action) {
> -			int ret;
> -			int status = 0;
> -			int retval = 0;
> -
> -			do {
> -				ret = action->handler(irq, action->dev_id);
> -				if (ret == IRQ_HANDLED)
> -					status |= action->flags;
> -				retval |= ret;
> -				action = action->next;
> -			} while (action);
> -
> -			if (status & IRQF_SAMPLE_RANDOM)
> -				add_interrupt_randomness(irq);
> -
> -			if (retval != IRQ_HANDLED)
> -				printk(KERN_ERR "ISR for TWL4030 power module"
> -					" irq %d can't handle interrupt\n",
> -					irq);
> -		} else {
> -			local_irq_disable();
> -			twl4030_pwrirq_mask |= 1 << (irq - TWL4030_PWR_IRQ_BASE);
> -			local_irq_enable();
> -			twl4030_i2c_write_u8(TWL4030_MODULE_INT,
> -					     twl4030_pwrirq_mask,
> -					     TWL4030_INT_PWR_IMR1);
> -		}
> -	}
> -}
> -
>  static void do_twl4030_pwrirq(unsigned int irq, irq_desc_t *desc)
>  {
>  	const unsigned int cpu = smp_processor_id();
> @@ -113,6 +85,7 @@ static void do_twl4030_pwrirq(unsigned i
>  		local_irq_enable();
>  		ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &pwr_isr,
>  					  TWL4030_INT_PWR_ISR1);
> +		local_irq_disable();
>  		if (ret) {
>  			printk(KERN_WARNING
>  				"I2C error %d while reading TWL4030"
> @@ -122,13 +95,10 @@ static void do_twl4030_pwrirq(unsigned i
>  
>  		for (module_irq = TWL4030_PWR_IRQ_BASE; pwr_isr != 0;
>  			module_irq++, pwr_isr >>= 1) {
> -			if (pwr_isr & 1) {
> -				irq_desc_t *d = irq_desc + module_irq;
> -				d->handle_irq(module_irq, d);
> -			}
> +			if (pwr_isr & 1)
> +				generic_handle_irq(module_irq);
>  		}
>  
> -		local_irq_disable();
>  		desc->chip->unmask(irq);
>  	}
>  }
> @@ -138,22 +108,19 @@ static int twl4030_pwrirq_thread(void *d
>  	current->flags |= PF_NOFREEZE;
>  
>  	while (!kthread_should_stop()) {
> -		u8 local_unmask;
> -
> -		local_irq_disable();
> -		local_unmask = twl4030_pwrirq_pending_unmask;
> -		twl4030_pwrirq_pending_unmask = 0;
> -		local_irq_enable();
> +		u8 local_mask;
>  
> -		twl4030_pwrirq_mask &= ~local_unmask;
> +		spin_lock_irq(&pwr_lock);
> +		local_mask = twl4030_pwrirq_mask;
> +		spin_unlock_irq(&pwr_lock);
>  
> -		twl4030_i2c_write_u8(TWL4030_MODULE_INT, twl4030_pwrirq_mask,
> +		twl4030_i2c_write_u8(TWL4030_MODULE_INT, local_mask,
>  				     TWL4030_INT_PWR_IMR1);
>  
> -		local_irq_disable();
> -		if (!twl4030_pwrirq_pending_unmask)
> +		spin_lock_irq(&pwr_lock);
> +		if (local_mask == twl4030_pwrirq_mask)
>  			set_current_state(TASK_INTERRUPTIBLE);
> -		local_irq_enable();
> +		spin_unlock_irq(&pwr_lock);
>  
>  		schedule();
>  	}
> @@ -168,7 +135,6 @@ static int __init twl4030_pwrirq_init(vo
>  	int i, err;
>  
>  	twl4030_pwrirq_mask = 0xff;
> -	twl4030_pwrirq_pending_unmask = 0;
>  
>  /* HEY:  core already did this.
>   * But that's surely not why we
> @@ -201,8 +167,8 @@ msleep(10);
>  	}
>  
>  	for (i = TWL4030_PWR_IRQ_BASE; i < TWL4030_PWR_IRQ_END; i++) {
> -		set_irq_chip(i, &twl4030_pwrirq_chip);
> -		set_irq_handler(i, do_twl4030_pwrmodule_irq);
> +		set_irq_chip_and_handler(i, &twl4030_pwrirq_chip,
> +				handle_edge_irq);
>  		set_irq_flags(i, IRQF_VALID);
>  	}
>  
> --- a/drivers/i2c/chips/twl4030-usb.c
> +++ b/drivers/i2c/chips/twl4030-usb.c
> @@ -237,14 +237,9 @@
>  #define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
>  
>  /* In module TWL4030_MODULE_INT */
> -#define REG_PWR_ISR1			0x00
> -#define REG_PWR_IMR1			0x01
> -#define USB_PRES			(1 << 2)
>  #define REG_PWR_EDR1			0x05
>  #define USB_PRES_FALLING		(1 << 4)
>  #define USB_PRES_RISING			(1 << 5)
> -#define REG_PWR_SIH_CTRL		0x07
> -#define COR				(1 << 2)
>  
>  /* bits in OTG_CTRL */
>  #define	OTG_XCEIV_OUTPUTS \
> @@ -274,6 +269,7 @@ struct twl4030_usb {
>  	unsigned		vbus:1;
>  	int			irq;
>  	u8			asleep;
> +	bool			irq_enabled;
>  };
>  
>  /* internal define on top of container_of */
> @@ -417,6 +413,8 @@ static void usb_irq_enable(struct twl403
>  {
>  	u8 val;
>  
> +	/* FIXME use set_irq_type(...) when that (soon) works */
> +
>  	/* edge setup */
>  	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
>  				&val, REG_PWR_EDR1) < 0);
> @@ -429,34 +427,18 @@ static void usb_irq_enable(struct twl403
>  	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
>  				val, REG_PWR_EDR1) < 0);
>  
> -	/* un-mask interrupt */
> -	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
> -				&val, REG_PWR_IMR1) < 0);
> -
> -	val &= ~USB_PRES;
> -
> -	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
> -				val, REG_PWR_IMR1) < 0);
> +	if (!twl->irq_enabled) {
> +		enable_irq(twl->irq);
> +		twl->irq_enabled = true;
> +	}
>  }
>  
>  static void usb_irq_disable(struct twl4030_usb *twl)
>  {
> -	u8 val;
> -
> -	/* undo edge setup */
> -	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
> -				&val, REG_PWR_EDR1) < 0);
> -	val &= ~(USB_PRES_RISING | USB_PRES_FALLING);
> -	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
> -				val, REG_PWR_EDR1) < 0);
> -
> -	/* mask interrupt */
> -	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
> -				&val, REG_PWR_IMR1) < 0);
> -	val |= USB_PRES;
> -
> -	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
> -				val, REG_PWR_IMR1) < 0);
> +	if (twl->irq_enabled) {
> +		disable_irq(twl->irq);
> +		twl->irq_enabled = false;
> +	}
>  }
>  
>  static void twl4030_phy_power(struct twl4030_usb *twl, int on)
> @@ -565,6 +547,21 @@ static irqreturn_t twl4030_usb_irq(int i
>  	struct twl4030_usb *twl = _twl;
>  	u8 val;
>  
> +#ifdef CONFIG_LOCKDEP
> +	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
> +	 * we don't want and can't tolerate.  Although it might be
> +	 * friendlier not to borrow this thread context...
> +	 */
> +	local_irq_enable();
> +#endif
> +
> +	/* FIXME stop accessing PWR_EDR1 ... if nothing else, we
> +	 * know which edges we told the IRQ to trigger on.  And
> +	 * there seem to be OTG_specific registers and irqs that
> +	 * provide the right info without guessing like this:
> +	 * USB_INT_STS, ID_STATUS, STS_HW_CONDITIONS, etc.
> +	 */
> +
>  	/* action based on cable attach or detach */
>  	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
>  				&val, REG_PWR_EDR1) < 0);
> @@ -697,7 +694,7 @@ static int __init twl4030_usb_probe(stru
>  	/* init irq workqueue before request_irq */
>  	INIT_WORK(&twl->irq_work, twl4030_usb_irq_work);
>  
> -	usb_irq_disable(twl);
> +	twl->irq_enabled = true;
>  	status = request_irq(twl->irq, twl4030_usb_irq, 0, "twl4030_usb", twl);
>  	if (status < 0) {
>  		dev_dbg(&pdev->dev, "can't get IRQ %d, err %d\n",
> --- a/drivers/rtc/rtc-twl4030.c
> +++ b/drivers/rtc/rtc-twl4030.c
> @@ -347,6 +347,14 @@ static irqreturn_t twl4030_rtc_interrupt
>  	int res;
>  	u8 rd_reg;
>  
> +#ifdef CONFIG_LOCKDEP
> +	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
> +	 * we don't want and can't tolerate.  Although it might be
> +	 * friendlier not to borrow this thread context...
> +	 */
> +	local_irq_enable();
> +#endif
> +
>  	res = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
>  	if (res)
>  		goto out;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
