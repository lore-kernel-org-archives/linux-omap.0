From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] tty: omap-serial: configure wakeup mechanism based on port usage.
Date: Mon, 23 Apr 2012 16:54:28 -0700
Message-ID: <87fwbugg23.fsf@ti.com>
References: <1335186937-24822-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1335186937-24822-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Mon, 23 Apr 2012 18:45:37 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> With set_wakeup port ops availability from serial_core layer
> which will be called when port is opened with state as true
> indicating the wakeups can be enabled for this port and state
> as false while port shutdown where we can disable the wakeups.
>
> But wakeup can be also enabled/disabled when requested from sysfs.
> If disabled wakeup will be disabled while entering suspend and be
> enabled back based on pm state while resuming.

Nice, this is definitely the right direction.  Thanks.

> Thanks to Kevin Hilman <khilman@ti.com> for suggesting this.
> Discussion References:
> http://www.spinics.net/lists/linux-omap/msg67764.html
> http://www.spinics.net/lists/linux-omap/msg67838.html
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> [suggestion and modification to enable and disable wakeup
> capability based on port usage]

I haven't signed-off on this, and technically since I'm not on the
delivery path, I shouldn't have a sign-off either.  See 
Documenation/SubmittingPatches for all the details on s-o-b tags.

I will give it an ack or tested-by after I've gone through it, but for
now I have a few minor comments below.  Also just reported that l-o
master has broken UART wakeups due to the default mux settings change
earlier, so that has to be sorted out in order to properly test this.

> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>
> Patch is tested using the patch as in here[1]
> Tested on beagle-XM by enabling and disabling wakeups
> from sysfs and opening and closing a uart port.
>
> [1]: http://marc.info/?l=linux-omap&m=133518614022144&w=2
>
>
>  arch/arm/plat-omap/include/plat/omap-serial.h |    1 -
>  drivers/tty/serial/omap-serial.c              |   45 +++++++++++++++----------
>  2 files changed, 27 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 9ff4444..8e6d734 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -130,7 +130,6 @@ struct uart_omap_port {
>  	unsigned long		port_activity;
>  	u32			context_loss_cnt;
>  	u32			errata;
> -	u8			wakeups_enabled;
>  
>  	struct pm_qos_request	pm_qos_request;
>  	u32			latency;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index d00b38e..b8f328e 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -525,6 +525,7 @@ static int serial_omap_startup(struct uart_port *port)
>  	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
>  
>  	pm_runtime_get_sync(&up->pdev->dev);
> +

stray whitespace change?

>  	/*
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
> @@ -910,11 +911,27 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>  	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
>  }
>  
> +static int serial_omap_set_wake(struct uart_port *port, unsigned int state)
> +{
> +	struct uart_omap_port *up = (struct uart_omap_port *)port;
> +	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
> +	u8 enable_wakeup = false;

s/u8/bool/ 

> +
> +	if (state)
> +		enable_wakeup = true;
> +
> +	if (pdata->enable_wakeup)
> +		pdata->enable_wakeup(up->pdev, enable_wakeup);

but actually, the above 7 lines could be more concisely written:

	if (pdata->enable_wakeup)
		pdata->enable_wakeup(up->pdev, state ? true : false);

> +
> +	return 0;
> +}
> +
>  static void
>  serial_omap_pm(struct uart_port *port, unsigned int state,
>  	       unsigned int oldstate)
>  {
>  	struct uart_omap_port *up = (struct uart_omap_port *)port;
> +	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
>  	unsigned char efr;
>  
>  	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->port.line);
> @@ -930,12 +947,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
>  	serial_out(up, UART_EFR, efr);
>  	serial_out(up, UART_LCR, 0);
>  
> -	if (!device_may_wakeup(&up->pdev->dev)) {
> -		if (!state)
> -			pm_runtime_forbid(&up->pdev->dev);
> -		else
> -			pm_runtime_allow(&up->pdev->dev);
> -	}
> +	if (!state && pdata->enable_wakeup)
> +		pdata->enable_wakeup(up->pdev, true);
>  
>  	pm_runtime_put(&up->pdev->dev);
>  }
> @@ -1161,6 +1174,7 @@ static struct uart_ops serial_omap_pops = {
>  	.shutdown	= serial_omap_shutdown,
>  	.set_termios	= serial_omap_set_termios,
>  	.pm		= serial_omap_pm,
> +	.set_wake	= serial_omap_set_wake,
>  	.type		= serial_omap_type,
>  	.release_port	= serial_omap_release_port,
>  	.request_port	= serial_omap_request_port,
> @@ -1184,10 +1198,14 @@ static struct uart_driver serial_omap_reg = {
>  static int serial_omap_suspend(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
> +	struct omap_uart_port_info *pdata = dev->platform_data;
>  
>  	if (up) {
>  		uart_suspend_port(&serial_omap_reg, &up->port);
>  		flush_work_sync(&up->qos_work);
> +
> +		if (!device_may_wakeup(dev))
> +			pdata->enable_wakeup(up->pdev, false);

If wakeups are disabled in suspend, where are they re-enabled?  I don't
see anything added to the ->resume() method.

Is serial_omap_pm() called during resume to ensure wakeups are
(re)enabled?

If so this should be well described in the changelog.

Kevin

>  	}
>  
>  	return 0;
> @@ -1476,6 +1494,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	if (ret != 0)
>  		goto err_add_port;
>  
> +	if (omap_up_info->enable_wakeup)
> +		omap_up_info->enable_wakeup(pdev, false);
> +
>  	pm_runtime_put(&pdev->dev);
>  	platform_set_drvdata(pdev, up);
>  	return 0;
> @@ -1582,18 +1603,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	if (pdata->get_context_loss_count)
>  		up->context_loss_cnt = pdata->get_context_loss_count(dev);
>  
> -	if (device_may_wakeup(dev)) {
> -		if (!up->wakeups_enabled) {
> -			pdata->enable_wakeup(up->pdev, true);
> -			up->wakeups_enabled = true;
> -		}
> -	} else {
> -		if (up->wakeups_enabled) {
> -			pdata->enable_wakeup(up->pdev, false);
> -			up->wakeups_enabled = false;
> -		}
> -	}
> -
>  	/* Errata i291 */
>  	if (up->use_dma && pdata->set_forceidle &&
>  			(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
