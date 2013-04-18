From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 3/6] driver: serial: omap: add prepare/complete callback for "no_console_suspend" case
Date: Thu, 18 Apr 2013 10:56:58 -0700
Message-ID: <874nf367th.fsf@linaro.org>
References: <1366198467-6757-1-git-send-email-sourav.poddar@ti.com>
	<1366198467-6757-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366198467-6757-4-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Wed, 17 Apr 2013 17:04:24 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Sourav Poddar <sourav.poddar@ti.com> writes:

> The patch adapt the serial core/driver to take care of the case when "no_console_suspend"
> is used in the bootargs. The patch will remove dependency to set od->flags to
> "OMAP_DEVICE_NO_IDLE_ON_SUSPEND" in serial.c(non dt case) and omap_device.c(dt case).
>
> Prepare and complete callbacks will ensure that clocks remain active for the console
> uart when "no_console_suspend" is used in the bootargs.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

This changelog needs a rework.  The driver itself was not aware of
od->flags and omap_device stuff in general, so it's not really
relevant.  The driver is also not directly managing clocks, int's only
doing runtime PM callbacks.

What you want to say in the changelog is that the driver manages
"no_console_suspend" by preventing runtime PM during the suspend path,
which forces the console UART to stay awake.

> ---
>  drivers/tty/serial/omap-serial.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 08332f3..9ef80cf 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1278,6 +1278,24 @@ static struct uart_driver serial_omap_reg = {
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> +static int serial_omap_prepare(struct device *dev)
> +{
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
> +
> +	if (!console_suspend_enabled && uart_console(&up->port))
> +		pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
> +static void serial_omap_complete(struct device *dev)
> +{
> +	struct uart_omap_port *up = dev_get_drvdata(dev);
> +
> +	if (!console_suspend_enabled && uart_console(&up->port))
> +		pm_runtime_enable(dev);
> +}
> +

For compilation with !CONFIG_PM_SLEEP, you'll also need:

#else 
#define serial_omap_prepare NULL
#define serial_omap_prepare NULL
#endif /* CONFIG_PM_SLEEP */

>  static int serial_omap_suspend(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
> @@ -1632,6 +1650,8 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
>  	SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
>  				serial_omap_runtime_resume, NULL)
> +	.prepare        = serial_omap_prepare,
> +	.complete       = serial_omap_complete,
>  };
>  
>  #if defined(CONFIG_OF)

Kevin
