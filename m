From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM] OMAP: UART: Add sysfs interface for adjusting UART sleep timeout
Date: Tue, 09 Dec 2008 17:09:36 -0800
Message-ID: <87bpvk7s4v.fsf@deeprootsystems.com>
References: <1228822610-13193-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:21939 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbYLJBJm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 20:09:42 -0500
Received: by yx-out-2324.google.com with SMTP id 8so128416yxm.1
        for <linux-omap@vger.kernel.org>; Tue, 09 Dec 2008 17:09:41 -0800 (PST)
In-Reply-To: <1228822610-13193-1-git-send-email-jouni.hogander@nokia.com> (Jouni Hogander's message of "Tue\,  9 Dec 2008 13\:36\:50 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Jouni Hogander <jouni.hogander@nokia.com> writes:

> This patch makes it possible to change uart sleep timeout. New sysfs
> entry is added (/sys/devices/platform/serial8250.0/sleep_timeout)
>
> Also default timeout is increased to 5 second to make serial console
> more usable.
>
> Original patch was written by Tero Kristo some time ago.
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Thanks, pulling into PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/serial.c |   45 +++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 7635038..c0a913a 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -31,7 +31,7 @@
>  #include "pm.h"
>  #include "prm-regbits-34xx.h"
>  
> -#define DEFAULT_TIMEOUT (2 * HZ)
> +#define DEFAULT_TIMEOUT (5 * HZ)
>  
>  struct omap_uart_state {
>  	int num;
> @@ -330,6 +330,8 @@ static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
>  	return IRQ_NONE;
>  }
>  
> +static u32 sleep_timeout = DEFAULT_TIMEOUT;
> +
>  static void omap_uart_idle_init(struct omap_uart_state *uart)
>  {
>  	u32 v;
> @@ -337,7 +339,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	int ret;
>  
>  	uart->can_sleep = 0;
> -	uart->timeout = DEFAULT_TIMEOUT;
> +	uart->timeout = sleep_timeout;
>  	setup_timer(&uart->timer, omap_uart_idle_timer,
>  		    (unsigned long) uart);
>  	mod_timer(&uart->timer, jiffies + uart->timeout);
> @@ -418,6 +420,34 @@ static void omap_uart_pm(struct uart_port *port,
>  		break;
>  	}
>  }
> +
> +static ssize_t sleep_timeout_show(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  char *buf)
> +{
> +	return sprintf(buf, "%u\n", sleep_timeout / HZ);
> +}
> +
> +static ssize_t sleep_timeout_store(struct kobject *kobj,
> +				   struct kobj_attribute *attr,
> +				   const char *buf, size_t n)
> +{
> +	struct omap_uart_state *uart;
> +	unsigned int value;
> +
> +	if (sscanf(buf, "%u", &value) != 1) {
> +		printk(KERN_ERR "sleep_timeout_store: Invalid value\n");
> +		return -EINVAL;
> +	}
> +	sleep_timeout = value * HZ;
> +	list_for_each_entry(uart, &uart_list, node)
> +		uart->timeout = sleep_timeout;
> +	return n;
> +}
> +
> +static struct kobj_attribute sleep_timeout_attr =
> +	__ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
> +
>  #else
>  static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
>  static inline void omap_uart_pm(struct uart_port *port,
> @@ -490,6 +520,15 @@ static struct platform_device serial_device = {
>  
>  static int __init omap_init(void)
>  {
> -	return platform_device_register(&serial_device);
> +	int ret;
> +
> +	ret = platform_device_register(&serial_device);
> +
> +#ifdef CONFIG_PM
> +	if (!ret)
> +		ret = sysfs_create_file(&serial_device.dev.kobj,
> +					&sleep_timeout_attr.attr);
> +#endif
> +	return ret;
>  }
>  arch_initcall(omap_init);
> -- 
> 1.6.0.1
