From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for omap-serial driver
Date: Mon, 10 Oct 2011 16:42:07 -0700
Message-ID: <8739f0ct2o.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380495-584-9-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:35 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Adapts omap-serial driver to use pm_runtime API's.

[...]

> @@ -1065,19 +1123,18 @@ static struct uart_driver serial_omap_reg = {
>  	.cons		= OMAP_CONSOLE,
>  };
>  
> -static int
> -serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
> +static int serial_omap_suspend(struct device *dev)
>  {
> -	struct uart_omap_port *up = platform_get_drvdata(pdev);
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
>  
>  	if (up)
>  		uart_suspend_port(&serial_omap_reg, &up->port);
>  	return 0;
>  }
>  
> -static int serial_omap_resume(struct platform_device *dev)
> +static int serial_omap_resume(struct device *dev)
>  {
> -	struct uart_omap_port *up = platform_get_drvdata(dev);
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
>  
>  	if (up)
>  		uart_resume_port(&serial_omap_reg, &up->port);

These functions need to be wrapped in #ifdef CONFIG_SUSPEND, otherwise,
when building with !CONFIG_SUSPEND you'll get :

/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1134:12: warning: 'serial_omap_suspend' defined but not used
/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1150:12: warning: 'serial_omap_resume' defined but not used


[...]

> +static int serial_omap_runtime_suspend(struct device *dev)
> +{
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
> +	struct omap_uart_port_info *pdata = dev->platform_data;
> +
> +	if (!up)
> +		return -EINVAL;
> +
> +	if (!pdata->enable_wakeup || !pdata->get_context_loss_count)
> +		return 0;
> +
> +	if (pdata->get_context_loss_count)
> +		up->context_loss_cnt = pdata->get_context_loss_count(dev);
> +
> +	if (device_may_wakeup(dev)) {
> +		if (!up->wakeups_enabled) {
> +			pdata->enable_wakeup(up->pdev, true);
> +			up->wakeups_enabled = true;
> +		}
> +	} else {
> +		if (up->wakeups_enabled) {
> +			pdata->enable_wakeup(up->pdev, false);
> +			up->wakeups_enabled = false;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int serial_omap_runtime_resume(struct device *dev)
> +{
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
> +	struct omap_uart_port_info *pdata = dev->platform_data;
> +
> +	if (up) {
> +		if (pdata->get_context_loss_count) {
> +			u32 loss_cnt = pdata->get_context_loss_count(dev);
> +
> +			if (up->context_loss_cnt != loss_cnt)
> +				serial_omap_restore_context(up);
> +		}
> +	}
> +
>  	return 0;
>  }

Similarily, thse need to be wrapped with #ifdef CONFIG_PM_RUNTIME,
otherwise, when !CONFIG_PM_RUNTIME:

/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1498:12: warning: 'serial_omap_runtime_suspend' defined but not used
/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:1531:12: warning: 'serial_omap_runtime_resume' defined but not used

> +static const struct dev_pm_ops serial_omap_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
> +	SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
> +				serial_omap_runtime_resume, NULL)
> +};
> +

Note that you don't need #else parts to the above #ifdefs since
the SET_*_OPS() macros used here take care of that.

Kevin
