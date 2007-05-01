From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Resubmitting TWL4030 GPIO driver
Date: Tue, 1 May 2007 14:49:01 +0530
Message-ID: <5d5443650705010219p17ccb899j1be55fc0df1159ad@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47C8EC6C@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47C8EC6C@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Khasim,

On 4/27/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> This adds TWL4030 GPIO driver support. Required for TWL4030 Keypad and other
> TWL4030 GPIO dependent modules.
>
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>

Just added comments for code which require few cosmetic changes
related to coding style.

> +
> +/*
> + * These are the irqchip methods for the TWL4030 GPIO interrupts.
> + * Our IRQ handle method doesn't call these, but they will be called by
> + * other routines such as setup_irq() and enable_irq().  They are called
> + * with cpu interrupts disabled and with a lock on the irq_controller_lock
> + * spinlock.  This complicates matters, because accessing the TWL4030 GPIO
> + * interrupt controller requires I2C bus transactions that can't be initiated
> + * in this context.  Our solution is to defer accessing the interrupt
> + * controller to a kernel thread.  We only need to support the unmask method.
> + */
> +
> +static void twl4030_gpio_mask_and_ack_irqchip(unsigned int irq) {}
> +static void twl4030_gpio_mask_irqchip(unsigned int irq) {}
> +
> +static void twl4030_gpio_unmask_irqchip(unsigned int irq)
> +{
> +       int gpio = irq - IH_TWL4030_GPIO_BASE;
> +
> +       gpio_pending_unmask |= (1 << gpio);
> +       if (gpio_unmask_thread && gpio_unmask_thread->state != TASK_RUNNING)
> +               wake_up_process(gpio_unmask_thread);
> +}
> +
> +static struct irq_chip twl4030_gpio_irq_chip = {
> +       .ack    = twl4030_gpio_mask_and_ack_irqchip,
> +       .mask   = twl4030_gpio_mask_irqchip,
> +       .unmask = twl4030_gpio_unmask_irqchip,
> +};
> +
> +/*
> + * These are the irqchip methods for the TWL4030 PIH GPIO module interrupt.
> + * The PIH module doesn't have interrupt masking capability, so these
> + * methods are NULL.
> + */
> +static void twl4030_gpio_module_ack(unsigned int irq) {}
> +static void twl4030_gpio_module_mask(unsigned int irq) {}
> +static void twl4030_gpio_module_unmask(unsigned int irq) {}
> +static struct irq_chip twl4030_gpio_module_irq_chip = {
> +       .ack    = twl4030_gpio_module_ack,
> +       .mask   = twl4030_gpio_module_mask,
> +       .unmask = twl4030_gpio_module_unmask,
> +};
> +

You don't want to fill "name" field for entry in /proc/interrupts ?


> +/*
> + * twl4030 GPIO request function
> + */
> +int twl4030_request_gpio(int gpio)
> +{
> +       int ret = 0;
> +
> +       if (unlikely(gpio >= TWL4030_GPIO_MAX)) {
> +               return -EPERM;
> +       }
> +
> +       down(&gpio_sem);
> +       if (gpio_usage_count & (0x1 << gpio)) {
> +               ret = -EBUSY;
> +       } else {
> +               u8 clear_pull[6] = { 0, 0, 0, 0, 0, 0 };
> +               /* First time usage? - switch on GPIO module */
> +               if (!gpio_usage_count) {
> +                       ret =
> +                       gpio_twl4030_write(REG_GPIO_CTRL,
> +                                       MASK_GPIO_CTRL_GPIO_ON);
> +                       ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
> +               }
> +               if (!ret) {
> +                       gpio_usage_count |= (0x1 << gpio);
> +               }
> +               ret =
> +               twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
> +                               REG_GPIOPUPDCTR1, 5);
> +       }
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/*
> + * TWL4030 GPIO free module
> + */
> +int twl4030_free_gpio(int gpio)
> +{
> +       int ret = 0;
> +       if (unlikely(gpio >= TWL4030_GPIO_MAX)) {
> +               return -EPERM;
> +       }
> +       down(&gpio_sem);
> +       if ((gpio_usage_count & (0x1 << gpio)) == 0) {
> +               ret = -EPERM;
> +       } else {
> +               gpio_usage_count &= ~(0x1 << gpio);
> +       }
> +       /* Last time usage? - switch off GPIO module */
> +       if (!gpio_usage_count) {
> +               ret = gpio_twl4030_write(REG_GPIO_CTRL, 0x0);
> +       }
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_set_gpio_direction
> + *
> + * @param gpio
> + * @param is_input
> + *
> + * @return
> + */
> +int twl4030_set_gpio_direction(int gpio, int is_input)
> +{
> +       u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
> +       u8 d_msk = MASK_GPIODATADIR_GPIOxDIR(GET_GPIO_DATA_OFF(gpio));
> +       u8 reg = 0;
> +       u8 base = 0;
> +       int ret = 0;
> +       if (unlikely((gpio >= TWL4030_GPIO_MAX)
> +               || !(gpio_usage_count & (0x1 << gpio)))) {
> +               return -EPERM;
> +       }
> +       base = REG_GPIODATADIR1 + d_bnk;
> +
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_read(base);
> +       if (ret >= 0) {
> +               if (is_input) {
> +                       reg = (u8) ((ret) & ~(d_msk));
> +               } else {
> +                       reg = (u8) ((ret) | (d_msk));
> +               }
> +               ret = gpio_twl4030_write(base, reg);
> +       }
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_set_gpio_dataout
> + *
> + * @param gpio
> + * @param enable
> + *
> + * @return
> + */
> +int twl4030_set_gpio_dataout(int gpio, int enable)
> +{
> +       u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
> +       u8 d_msk = MASK_GPIODATAOUT_GPIOxOUT(GET_GPIO_DATA_OFF(gpio));
> +       u8 base = 0;
> +       int ret = 0;
> +       if (unlikely((gpio >= TWL4030_GPIO_MAX)
> +               || !(gpio_usage_count & (0x1 << gpio)))) {
> +               return -EPERM;
> +       }
> +       if (enable) {
> +               base = REG_SETGPIODATAOUT1 + d_bnk;
> +       } else {
> +               base = REG_CLEARGPIODATAOUT1 + d_bnk;
> +       }
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_write(base, d_msk);
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_get_gpio_datain
> + *
> + * @param gpio
> + *
> + * @return
> + */
> +int twl4030_get_gpio_datain(int gpio)
> +{
> +       u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
> +       u8 d_off = BIT_GPIODATAIN_GPIOxIN(GET_GPIO_DATA_OFF(gpio));
> +       u8 base = 0;
> +       int ret = 0;
> +       if (unlikely((gpio >= TWL4030_GPIO_MAX)
> +               || !(gpio_usage_count & (0x1 << gpio)))) {
> +               return -EPERM;
> +       }
> +       base = REG_GPIODATAIN1 + d_bnk;
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_read(base);
> +       up(&gpio_sem);
> +       if (ret > 0) {
> +               ret = (ret >> d_off) & 0x1;
> +       }
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_set_gpio_pull
> + *
> + * @param gpio
> + * @param pull_dircn
> + *
> + * @return
> + */
> +int twl4030_set_gpio_pull(int gpio, int pull_dircn)
> +{
> +       u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
> +       u8 c_off = GET_GPIO_CTL_OFF(gpio);
> +       u8 c_msk = 0;
> +       u8 reg = 0;
> +       u8 base = 0;
> +       int ret = 0;
> +       if (unlikely((gpio >= TWL4030_GPIO_MAX) ||
> +               !(gpio_usage_count & (0x1 << gpio)))) {
> +               return -EPERM;
> +       }
> +       base = REG_GPIOPUPDCTR1 + c_bnk;
> +       if (pull_dircn == TWL4030_GPIO_PULL_DOWN) {
> +               c_msk = MASK_GPIOPUPDCTR1_GPIOxPD(c_off);
> +       } else if (pull_dircn == TWL4030_GPIO_PULL_UP) {
> +               c_msk = MASK_GPIOPUPDCTR1_GPIOxPU(c_off);
> +       }
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_read(base);
> +       if (ret >= 0) {
> +               /* clear the previous up/down values */
> +               reg = (u8) (ret);
> +               reg &= ~(MASK_GPIOPUPDCTR1_GPIOxPU(c_off) |
> +                       MASK_GPIOPUPDCTR1_GPIOxPD(c_off));
> +               reg |= c_msk;
> +               ret = gpio_twl4030_write(base, reg);
> +       }
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_set_gpio_edge_ctrl
> + *
> + * @param gpio
> + * @param edge
> + *
> + * @return
> + */
> +int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
> +{
> +       u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
> +       u8 c_off = GET_GPIO_CTL_OFF(gpio);
> +       u8 c_msk = 0;
> +       u8 reg = 0;
> +       u8 base = 0;
> +       int ret = 0;
> +       if (unlikely((gpio >= TWL4030_GPIO_MAX)
> +               || !(gpio_usage_count & (0x1 << gpio)))) {
> +               return -EPERM;
> +       }
> +       base = REG_GPIO_EDR1 + c_bnk;
> +       if (edge & TWL4030_GPIO_EDGE_RISING) {
> +               c_msk |= MASK_GPIO_EDR1_GPIOxRISING(c_off);
> +       }
> +       if (edge & TWL4030_GPIO_EDGE_FALLING) {
> +               c_msk |= MASK_GPIO_EDR1_GPIOxFALLING(c_off);
> +       }
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_read(base);
> +       if (ret >= 0) {
> +               /* clear the previous rising/falling values */
> +               reg =
> +               (u8) (ret &
> +                       ~(MASK_GPIO_EDR1_GPIOxFALLING(c_off) |
> +                       MASK_GPIO_EDR1_GPIOxRISING(c_off)));
> +               reg |= c_msk;
> +               ret = gpio_twl4030_write(base, reg);
> +       }
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_set_gpio_debounce
> + *
> + * @param gpio
> + * @param enable
> + *
> + * @return
> + */
> +int twl4030_set_gpio_debounce(int gpio, int enable)
> +{
> +       u8 d_bnk = GET_GPIO_DATA_BANK(gpio);
> +       u8 d_msk = MASK_GPIO_DEBEN_GPIOxDEB(GET_GPIO_DATA_OFF(gpio));
> +       u8 reg = 0;
> +       u8 base = 0;
> +       int ret = 0;
> +       if (unlikely((gpio >= TWL4030_GPIO_MAX)

Add one empty line above.

> +               || !(gpio_usage_count & (0x1 << gpio)))) {
> +               return -EPERM;
> +       }
> +       base = REG_GPIO_DEBEN1 + d_bnk;
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_read(base);
> +       if (ret >= 0) {
> +               if (enable) {
> +                       reg = (u8) ((ret) | (d_msk));
> +               } else {
> +                       reg = (u8) ((ret) & ~(d_msk));
> +               }
> +               ret = gpio_twl4030_write(base, reg);
> +       }
> +       up(&gpio_sem);
> +       return ret;
> +}
> +
> +/**
> + * @brief twl4030_set_gpio_card_detect
> + *
> + * @param gpio
> + * @param cd
> + * @param enable
> + *
> + * @return
> + */
> +int twl4030_set_gpio_card_detect(int gpio, int enable)
> +{
> +       u8 reg = 0;
> +       u8 msk = (1 << gpio);
> +       int ret = 0;
> +       /* Only GPIO 0 or 1 can be used for CD feature.. */

Add one empty line above.

> +       if (unlikely((gpio >= TWL4030_GPIO_MAX)
> +               || !(gpio_usage_count & (0x1 << gpio))
> +               || (gpio >= TWL4030_GPIO_MAX_CD))) {
> +               return -EPERM;
> +       }
> +
> +       down(&gpio_sem);
> +       ret = gpio_twl4030_read(REG_GPIO_CTRL);
> +       if (ret >= 0) {
> +               if (enable) {
> +                       reg = (u8) (ret | msk);
> +               } else {
> +                       reg = (u8) (ret & ~msk);
> +               }
> +               ret = gpio_twl4030_write(REG_GPIO_CTRL, reg);
> +       }
> +       up(&gpio_sem);
> +       return (ret);
> +}
> +
> +/**** MODULE FUNCTIONS ***/
> +
> +/**
> + * @brief gpio_twl4030_write
> + *
> + * @param address
> + * @param data
> + *
> + * @return  0 if successful
> + */
> +static inline int gpio_twl4030_write(u8 address, u8 data)
> +{
> +       int ret = 0;
> +       ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);

Add one empty line above.

> +       return ret;
> +}
> +
> +/**
> + * @brief gpio_twl4030_read
> + *
> + * @param address
> + *
> + * @return  data if successful else return negative error value
> + */
> +static inline int gpio_twl4030_read(u8 address)
> +{
> +       u8 data;
> +       int ret = 0;
> +       ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);

Add one empty line above.

> +       if (ret >= 0)
> +               ret = data;
> +       return ret;
> +}
> +
> +/*
> + * gpio_unmask_thread() runs as a kernel thread.  It is awakened by the unmask
> + * method for the GPIO interrupts.  It unmasks all of the GPIO interrupts
> + * specified in the gpio_pending_unmask bitmask.  We have to do the unmasking
> + * in a kernel thread rather than directly in the unmask method because of the
> + * need to access the TWL4030 via the I2C bus.  Note that we don't need to be
> + * concerned about race conditions where the request to unmask a GPIO interrupt
> + * has already been cancelled before this thread does the unmasking.  If a GPIO
> + * interrupt is improperly unmasked, then the IRQ handler for it will mask it
> + * when an interrupt occurs.
> + */
> +static int twl4030_gpio_unmask_thread(void *data)
> +{
> +       current->flags |= PF_NOFREEZE;
> +
> +       while (!kthread_should_stop()) {
> +               int irq;
> +               unsigned int gpio_unmask;
> +
> +               local_irq_disable();
> +               gpio_unmask = gpio_pending_unmask;
> +               gpio_pending_unmask = 0;
> +               local_irq_enable();
> +
> +               for (irq = IH_TWL4030_GPIO_BASE; 0 != gpio_unmask;
> +                               gpio_unmask >>= 1, irq++) {
> +                       if (gpio_unmask & 0x1)
> +                               twl4030_gpio_unmask(irq);
> +               }
> +
> +               local_irq_disable();
> +               if (!gpio_pending_unmask)
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +               local_irq_enable();
> +
> +               schedule();
> +       }
> +       set_current_state(TASK_RUNNING);
> +       return 0;
> +}
> +
> +/*
> + * do_twl4030_gpio_irq() is the desc->handle method for each of the twl4030
> + * gpio interrupts.  It executes in kernel thread context.
> + * On entry, cpu interrupts are enabled.
> + */
> +static void do_twl4030_gpio_irq(unsigned int irq, irq_desc_t *desc)
> +{
> +       struct irqaction *action;
> +       const unsigned int cpu = smp_processor_id();
> +
> +       desc->status |= IRQ_LEVEL;
> +
> +       /*
> +        * Acknowledge, clear _AND_ disable the interrupt.
> +        */
> +       twl4030_gpio_mask_and_ack(irq);
> +
> +       if (!desc->depth) {
> +               kstat_cpu(cpu).irqs[irq]++;
> +
> +               action = desc->action;
> +               if (action) {
> +                       int ret;
> +                       int status = 0;
> +                       int retval = 0;
> +                       do {
> +                               /* Call the ISR with cpu interrupts enabled. */
> +                               ret = action->handler(irq, action->dev_id);
> +                               if (ret == IRQ_HANDLED)
> +                                       status |= action->flags;
> +                               retval |= ret;
> +                               action = action->next;
> +                       } while (action);
> +
> +                       if (retval != IRQ_HANDLED) {
> +                               printk(KERN_ERR "ISR for TWL4030 GPIO"
> +                                       " irq %d can't handle interrupt\n",
> +                                       irq);
> +                       }
> +
> +                       if (!desc->depth)
> +                               twl4030_gpio_unmask(irq);
> +               }
> +       }
> +}
> +
> +/*
> + * do_twl4030_gpio_module_irq() is the desc->handle method for the twl4030 gpio
> + * module interrupt.  It executes in kernel thread context.
> + * This is a chained interrupt, so there is no desc->action method for it.
> + * We query the gpio module interrupt controller in the twl4030 to determine
> + * which gpio lines are generating interrupt requests, and then call the
> + * desc->handle method for each gpio that needs service.
> + * On entry, cpu interrupts are disabled.
> + */
> +static void do_twl4030_gpio_module_irq(unsigned int irq, irq_desc_t *desc)
> +{
> +       const unsigned int cpu = smp_processor_id();
> +
> +       desc->status |= IRQ_LEVEL;
> +       /*
> +       * The desc->handle method would normally call the desc->chip->ack
> +       * method here, but we won't bother since our ack method is NULL.
> +       */
> +       if (!desc->depth) {
> +               int gpio_irq;
> +               unsigned int gpio_isr;
> +
> +               kstat_cpu(cpu).irqs[irq]++;
> +               local_irq_enable();
> +
> +               down(&gpio_sem);
> +               if (gpio_read_isr(&gpio_isr))
> +                       gpio_isr = 0;
> +               up(&gpio_sem);
> +
> +               for (gpio_irq = IH_TWL4030_GPIO_BASE; 0 != gpio_isr;
> +                       gpio_isr >>= 1, gpio_irq++)
> +               {
> +                       if (gpio_isr & 0x1) {
> +                               irq_desc_t *d = irq_desc + gpio_irq;
> +                               d->handle_irq(gpio_irq, d);
> +                       }
> +               }

Coding style not correct for curly brackets around for loop.

> +
> +               local_irq_disable();
> +               /*
> +                * Here is where we should call the unmask method, but again we
> +                * won't bother since it is NULL.
> +                */
> +       }
> +}
> +
> +/* TWL4030 Initialization module */
> +static int __init gpio_twl4030_init(void)
> +{
> +       int ret;
> +       int irq = 0;
> +
> +       /* init the global locking sem */
> +       sema_init(&gpio_sem, 1);
> +
> +       /* All GPIO interrupts are initially masked */
> +       gpio_pending_unmask = 0;
> +       gpio_imr_shadow = GPIO_32_MASK;
> +       ret = gpio_write_imr(gpio_imr_shadow);
> +       if (!ret) {
> +               /*
> +               * Create a kernel thread to handle deferred unmasking of gpio
> +               * interrupts.
> +               */
> +               gpio_unmask_thread = kthread_create(twl4030_gpio_unmask_thread,
> +                       NULL, "twl4030 gpio");
> +               if (!gpio_unmask_thread) {
> +                       printk(KERN_ERR
> +                               "%s: could not create twl4030 gpio unmask thread!\n",
> +                               __FUNCTION__);
> +                       ret = -ENOMEM;
> +               }
> +       }
> +
> +       if (!ret) {
> +               /* install an irq handler for each of the gpio interrupts */
> +               for (irq = IH_TWL4030_GPIO_BASE; irq < IH_TWL4030_GPIO_END;
> +                       irq++)
> +               {
> +                       set_irq_chip(irq, &twl4030_gpio_irq_chip);
> +                       set_irq_handler(irq, do_twl4030_gpio_irq);
> +                       set_irq_flags(irq, IRQF_VALID);
> +               }

Coding style not correct for curly brackets.

> +
> +               /*
> +                * Install an irq handler to demultiplex the gpio module
> +                * interrupt.
> +                */
> +               set_irq_chip(TWL4030_MODIRQ_GPIO,
> +                       &twl4030_gpio_module_irq_chip);
> +               set_irq_chained_handler(TWL4030_MODIRQ_GPIO,
> +                       do_twl4030_gpio_module_irq);
> +       }
> +
> +       printk(KERN_INFO "TWL4030 GPIO Demux: IRQ Range %d to %d,"
> +               " Initialization %s\n", IH_TWL4030_GPIO_BASE,
> +               IH_TWL4030_GPIO_END, (ret) ? "Failed" : "Success");
> +       return ret;
> +}
> +
> +/* TWL GPIO exit module */
> +static void __exit gpio_twl4030_exit(void)
> +{
> +       int irq;
> +
> +       /* uninstall the gpio demultiplexing interrupt handler */
> +       set_irq_handler(TWL4030_MODIRQ_GPIO, NULL);
> +       set_irq_flags(TWL4030_MODIRQ_GPIO, 0);
> +
> +       /* uninstall the irq handler for each of the gpio interrupts */
> +       for (irq = IH_TWL4030_GPIO_BASE; irq < IH_TWL4030_GPIO_END; irq++)
> +       {
> +               set_irq_handler(irq, NULL);
> +               set_irq_flags(irq, 0);
> +       }

Coding style not correct for curly brackets.

> +
> +       /* stop the gpio unmask kernel thread */
> +       if (gpio_unmask_thread) {
> +               kthread_stop(gpio_unmask_thread);
> +               gpio_unmask_thread = NULL;
> +       }
> +
> +       return;

"return" is not required above.

> +}
> +
> +module_init(gpio_twl4030_init);
> +module_exit(gpio_twl4030_exit);
> +
> +EXPORT_SYMBOL(twl4030_request_gpio);
> +EXPORT_SYMBOL(twl4030_free_gpio);
> +EXPORT_SYMBOL(twl4030_set_gpio_direction);
> +EXPORT_SYMBOL(twl4030_set_gpio_dataout);
> +EXPORT_SYMBOL(twl4030_get_gpio_datain);
> +EXPORT_SYMBOL(twl4030_set_gpio_pull);
> +EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
> +EXPORT_SYMBOL(twl4030_set_gpio_debounce);
> +EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
> +
> +MODULE_AUTHOR("Texas Instruments, Inc.");
> +MODULE_DESCRIPTION("GPIO interface for TWL4030");
> +MODULE_LICENSE("GPL");
>

-- 
--Trilok Soni
