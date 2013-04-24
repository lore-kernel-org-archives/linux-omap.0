From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 2/5] driver: serial: omap: prevent runtime PM for "no_console_suspend"
Date: Wed, 24 Apr 2013 14:34:58 -0700
Message-ID: <87sj2f394t.fsf@linaro.org>
References: <1366809353-19435-1-git-send-email-sourav.poddar@ti.com>
	<1366809353-19435-3-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1366809353-19435-3-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Wed, 24 Apr 2013 18:45:50 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Sourav Poddar <sourav.poddar@ti.com> writes:

> The driver manages "no_console_suspend" by preventing runtime PM
> during the suspend path, which forces the console UART to stay awake.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c |   29 ++++++++++++++++++++++++++++-
>  1 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 08332f3..468e7ad 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -161,6 +161,7 @@ struct uart_omap_port {
>  	u32			calc_latency;
>  	struct work_struct	qos_work;
>  	struct pinctrl		*pins;
> +	bool			is_suspending;
>  };
>  
>  #define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> @@ -1278,6 +1279,24 @@ static struct uart_driver serial_omap_reg = {
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> +static int serial_omap_prepare(struct device *dev)
> +{
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
> +
> +	if (!console_suspend_enabled && uart_console(&up->port))
> +		up->is_suspending = true;

This flag should be set unconditionally.  IOW, the system is suspending
independently of the values of those flags.  And then...

> +	return 0;
> +}
> +
> +static void serial_omap_complete(struct device *dev)
> +{
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
> +
> +	if (!console_suspend_enabled && uart_console(&up->port))
> +		up->is_suspending = false;
> +}
> +
>  static int serial_omap_suspend(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
> @@ -1296,7 +1315,10 @@ static int serial_omap_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
> +#else
> +#define serial_omap_prepare NULL
> +#define serial_omap_prepare NULL
> +#endif /* CONFIG_PM_SLEEP */
>  
>  static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
>  {
> @@ -1582,6 +1604,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
>  	struct omap_uart_port_info *pdata = dev->platform_data;
>  
> +	if (up->is_suspending)
> +		return -EBUSY;

... the console checks should be here.

>  	if (!up)
>  		return -EINVAL;
>  
> @@ -1632,6 +1657,8 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
>  	SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
>  				serial_omap_runtime_resume, NULL)
> +	.prepare        = serial_omap_prepare,
> +	.complete       = serial_omap_complete,
>  };
>  
>  #if defined(CONFIG_OF)

Kevin
