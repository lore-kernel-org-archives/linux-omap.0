From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] Allow disabling wakeup for serial ports, including during off mode.
Date: Fri, 22 May 2009 15:43:21 -0700
Message-ID: <87r5yg3gja.fsf@deeprootsystems.com>
References: <1240860456-14937-1-git-send-email-Russ.Dill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f109.google.com ([209.85.222.109]:57345 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542AbZEVWnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:43:23 -0400
Received: by pzk7 with SMTP id 7so1529403pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 15:43:24 -0700 (PDT)
In-Reply-To: <1240860456-14937-1-git-send-email-Russ.Dill@gmail.com> (Russ Dill's message of "Mon\, 27 Apr 2009 12\:27\:36 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: linux-omap@vger.kernel.org

Russ Dill <russ.dill@gmail.com> writes:

> This patch causes the OMAP uarts to honor the sysfs power/wakeup file for
> IOPADs. Before the OMAP was always woken up from off mode on a rs232 signal
> change.
>
> This patch also creates a different platform device for each serial
> port so that the wakeup properties can be control per port.
>
> The patch is not in a complete state, but for my testing it was necessary
> to disable rs232 wakeup as allowing the signals to float in off mode by
> powering off the level converters was causing a wakeup event.
> ---
>  arch/arm/mach-omap2/serial.c |  165 ++++++++++++++++++++++++++++++++----------

In the process of playing with this I found some bugs the sysfs
implementation in this code that was exposed byt these patches.

Russ, I'll take these changes and incorporate them into my serial
fixes.

Thanks,

Kevin

>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 0762165..95b047a 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -49,6 +49,7 @@ struct omap_uart_state {
>  
>  	struct plat_serial8250_port *p;
>  	struct list_head node;
> +	struct platform_device pdev;
>  
>  #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>  	int context_valid;
> @@ -63,10 +64,9 @@ struct omap_uart_state {
>  #endif
>  };
>  
> -static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS];
>  static LIST_HEAD(uart_list);
>  
> -static struct plat_serial8250_port serial_platform_data[] = {
> +static struct plat_serial8250_port serial_platform_data0[] = {
>  	{
>  		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
>  		.mapbase	= OMAP_UART1_BASE,
> @@ -76,6 +76,12 @@ static struct plat_serial8250_port serial_platform_data[] = {
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
>  	}, {
> +		.flags		= 0
> +	}
> +};
> +
> +static struct plat_serial8250_port serial_platform_data1[] = {
> +	{
>  		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
>  		.mapbase	= OMAP_UART2_BASE,
>  		.irq		= 73,
> @@ -84,6 +90,12 @@ static struct plat_serial8250_port serial_platform_data[] = {
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
>  	}, {
> +		.flags		= 0
> +	}
> +};
> +
> +static struct plat_serial8250_port serial_platform_data2[] = {
> +	{
>  		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
>  		.mapbase	= OMAP_UART3_BASE,
>  		.irq		= 74,
> @@ -197,6 +209,40 @@ static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
>  static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
>  #endif /* CONFIG_ARCH_OMAP3 */
>  
> +static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
> +{
> +	/* Set wake-enable bit */
> +	if (uart->wk_en && uart->wk_mask) {
> +		u32 v = __raw_readl(uart->wk_en);
> +		v |= uart->wk_mask;
> +		__raw_writel(v, uart->wk_en);
> +	}
> +
> +	/* Ensure IOPAD wake-enables are set */
> +	if (cpu_is_omap34xx() && uart->padconf) {
> +		u16 v = omap_ctrl_readw(uart->padconf);
> +		v |= OMAP3_PADCONF_WAKEUPENABLE0;
> +		omap_ctrl_writew(v, uart->padconf);
> +	}
> +}
> +
> +static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
> +{
> +	/* Clear wake-enable bit */
> +	if (uart->wk_en && uart->wk_mask) {
> +		u32 v = __raw_readl(uart->wk_en);
> +		v &= ~uart->wk_mask;
> +		__raw_writel(v, uart->wk_en);
> +	}
> +
> +	/* Ensure IOPAD wake-enables are cleared */
> +	if (cpu_is_omap34xx() && uart->padconf) {
> +		u16 v = omap_ctrl_readw(uart->padconf);
> +		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
> +		omap_ctrl_writew(v, uart->padconf);
> +	}
> +}
> +
>  static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
>  					  int enable)
>  {
> @@ -220,6 +266,11 @@ static inline void omap_uart_restore(struct omap_uart_state *uart)
>  
>  static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
>  {
> +	if (device_may_wakeup(&uart->pdev.dev))
> +		omap_uart_enable_wakeup(uart);
> +	else
> +		omap_uart_disable_wakeup(uart);
> +
>  	if (!uart->clocked)
>  		return;
>  
> @@ -290,6 +341,7 @@ void omap_uart_resume_idle(int num)
>  			if (__raw_readl(uart->wk_st) & uart->wk_mask)
>  				omap_uart_block_sleep(uart);
>  
> +			omap_uart_enable_wakeup(uart);
>  			return;
>  		}
>  	}
> @@ -300,6 +352,7 @@ void omap_uart_prepare_suspend(void)
>  	struct omap_uart_state *uart;
>  
>  	list_for_each_entry(uart, &uart_list, node) {
> +		omap_uart_enable_wakeup(uart);
>  		omap_uart_allow_sleep(uart);
>  	}
>  }
> @@ -343,16 +396,13 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> -static u32 sleep_timeout = DEFAULT_TIMEOUT;
> -
>  static void omap_uart_idle_init(struct omap_uart_state *uart)
>  {
> -	u32 v;
>  	struct plat_serial8250_port *p = uart->p;
>  	int ret;
>  
>  	uart->can_sleep = 0;
> -	uart->timeout = sleep_timeout;
> +	uart->timeout = DEFAULT_TIMEOUT;
>  	setup_timer(&uart->timer, omap_uart_idle_timer,
>  		    (unsigned long) uart);
>  	mod_timer(&uart->timer, jiffies + uart->timeout);
> @@ -410,22 +460,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  		uart->padconf = 0;
>  	}
>  
> -	/* Set wake-enable bit */
> -	if (uart->wk_en && uart->wk_mask) {
> -		v = __raw_readl(uart->wk_en);
> -		v |= uart->wk_mask;
> -		__raw_writel(v, uart->wk_en);
> -	}
> -
> -	/* Ensure IOPAD wake-enables are set */
> -	if (cpu_is_omap34xx() && uart->padconf) {
> -		u16 v;
> -
> -		v = omap_ctrl_readw(uart->padconf);
> -		v |= OMAP3_PADCONF_WAKEUPENABLE0;
> -		omap_ctrl_writew(v, uart->padconf);
> -	}
> -
>  	p->flags |= UPF_SHARE_IRQ;
>  	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
>  			  "serial idle", (void *)uart);
> @@ -450,23 +484,30 @@ static ssize_t sleep_timeout_show(struct kobject *kobj,
>  				  struct kobj_attribute *attr,
>  				  char *buf)
>  {
> -	return sprintf(buf, "%u\n", sleep_timeout / HZ);
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct platform_device *pdev = container_of(dev,
> +					struct platform_device, dev);
> +	struct omap_uart_state *uart = container_of(pdev,
> +					struct omap_uart_state, pdev);
> +	return sprintf(buf, "%u\n", uart->timeout / HZ);
>  }
>  
>  static ssize_t sleep_timeout_store(struct kobject *kobj,
>  				   struct kobj_attribute *attr,
>  				   const char *buf, size_t n)
>  {
> -	struct omap_uart_state *uart;
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct platform_device *pdev = container_of(dev,
> +					struct platform_device, dev);
> +	struct omap_uart_state *uart = container_of(pdev,
> +					struct omap_uart_state, pdev);
>  	unsigned int value;
>  
>  	if (sscanf(buf, "%u", &value) != 1) {
>  		printk(KERN_ERR "sleep_timeout_store: Invalid value\n");
>  		return -EINVAL;
>  	}
> -	sleep_timeout = value * HZ;
> -	list_for_each_entry(uart, &uart_list, node)
> -		uart->timeout = sleep_timeout;
> +	uart->timeout = value * HZ;
>  	return n;
>  }
>  
> @@ -477,6 +518,34 @@ static struct kobj_attribute sleep_timeout_attr =
>  static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
>  #endif /* CONFIG_PM */
>  
> +static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
> +	{
> +		.pdev = {
> +			.name			= "serial8250",
> +			.id			= PLAT8250_DEV_PLATFORM,
> +			.dev			= {
> +				.platform_data	= serial_platform_data0,
> +			},
> +		},
> +	}, {
> +		.pdev = {
> +			.name			= "serial8250",
> +			.id			= PLAT8250_DEV_PLATFORM1,
> +			.dev			= {
> +				.platform_data	= serial_platform_data1,
> +			},
> +		},
> +	}, {
> +		.pdev = {
> +			.name			= "serial8250",
> +			.id			= PLAT8250_DEV_PLATFORM2,
> +			.dev			= {
> +				.platform_data	= serial_platform_data2,
> +			},
> +		},
> +	},
> +};
> +
>  void __init omap_serial_init(void)
>  {
>  	int i;
> @@ -495,8 +564,8 @@ void __init omap_serial_init(void)
>  		return;
>  
>  	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> -		struct plat_serial8250_port *p = serial_platform_data + i;
>  		struct omap_uart_state *uart = &omap_uart[i];
> +		struct plat_serial8250_port *p = uart->pdev.dev.platform_data;
>  
>  		if (!(info->enabled_uarts & (1 << i))) {
>  			p->membase = NULL;
> @@ -532,25 +601,43 @@ void __init omap_serial_init(void)
>  	}
>  }
>  
> -static struct platform_device serial_device = {
> -	.name			= "serial8250",
> -	.id			= PLAT8250_DEV_PLATFORM,
> -	.dev			= {
> -		.platform_data	= serial_platform_data,
> -	},
> -};
> -
>  static int __init omap_init(void)
>  {
>  	int ret;
> +	int i;
>  
> -	ret = platform_device_register(&serial_device);
> +	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> +		ret = platform_device_register(&omap_uart[i].pdev);
> +		if (ret < 0)
> +			goto device_err;
> +		if ((cpu_is_omap34xx() && omap_uart[i].padconf) ||
> +		    (omap_uart[i].wk_en && omap_uart[i].wk_mask)) {
> +			printk(KERN_ERR "%s: Setting init_wakeup\n", __func__);
> +			device_init_wakeup(&omap_uart[i].pdev.dev, true);
> +		}
> +	}
>  
>  #ifdef CONFIG_PM
> -	if (!ret)
> -		ret = sysfs_create_file(&serial_device.dev.kobj,
> +	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> +		ret = sysfs_create_file(&omap_uart[i].pdev.dev.kobj,
>  					&sleep_timeout_attr.attr);
> +		if (ret < 0)
> +			goto sysfs_err;
> +	}
> +#endif
> +	return ret;
> +
> +#ifdef CONFIG_PM
> +sysfs_err:
> +	for (i--; i >= 0; i--)
> +		sysfs_remove_file(&omap_uart[i].pdev.dev.kobj,
> +				&sleep_timeout_attr.attr);
> +	i = ARRAY_SIZE(omap_uart);
>  #endif
> +
> +device_err:
> +	for (i--; i >= 0; i--)
> +		platform_device_unregister(&omap_uart[i].pdev);
>  	return ret;
>  }
>  arch_initcall(omap_init);
> -- 
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
