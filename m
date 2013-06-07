From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] serial: omap: Fix device tree based PM runtime
Date: Fri, 07 Jun 2013 15:47:05 -0700
Message-ID: <87k3m5k07q.fsf@linaro.org>
References: <20130607215835.GL3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57840 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FGWrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 18:47:09 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5344973pdj.29
        for <linux-omap@vger.kernel.org>; Fri, 07 Jun 2013 15:47:08 -0700 (PDT)
In-Reply-To: <20130607215835.GL3331@atomide.com> (Tony Lindgren's message of
	"Fri, 7 Jun 2013 14:58:35 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> In the runtime_suspend function pdata is not being used, and
> also blocks the function in device tree based booting. Fix it
> by removing the unused pdata from the runtime_suspend function.
>
> Further, context loss count is not being passed in pdata, so
> let's just reinitialize the port every time for those case.
> This can be further optimized later on for the device tree
> case by adding detection for the hardware state and possibly
> by adding a driver specific autosuspend timeout.
>
> And doing this, we can then make the related dev_err into a
> dev_dbg message instead of an error.
>
> In order for the wake-up events to work, we also need to set
> autosuspend_timeout to -1 if 0, and also device_init_wakeup()
> as that's not being done by the platform init code for the
> device tree case.
>
> Note that this does not affect legacy booting, and in fact
> might make it work for the cases where the context loss info
> is not being passed in pdata.
>
> Thanks to Kevin Hilman <khilman@linaro.org> for debugging
> and suggesting fixes for the autosuspend_timeout and
> device_init_wakeup() related initializiation.
>
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

There's a stray whitespace change in the patch, and also, maybe it
should be broken up into a few different patches:

1) stray pdata
2) context_loss: -EINVAL + dev_dbg change
3) device_init_wakeup
4) autosuspend timeout defaults

but otherwise the content is right.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Also, tested on OMAP3/4

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin

> ---
>
> This can wait for v3.11 merge window as the related PM patches
> have not yet been merged.
>
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -197,7 +197,7 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
>  	struct omap_uart_port_info *pdata = up->dev->platform_data;
>  
>  	if (!pdata || !pdata->get_context_loss_count)
> -		return 0;
> +		return -EINVAL;
>  
>  	return pdata->get_context_loss_count(up->dev);
>  }
> @@ -1482,6 +1482,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, up);
>  	pm_runtime_enable(&pdev->dev);
> +	if (omap_up_info->autosuspend_timeout == 0)
> +		omap_up_info->autosuspend_timeout = -1;
> +	device_init_wakeup(up->dev, true);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev,
>  			omap_up_info->autosuspend_timeout);
> @@ -1500,6 +1503,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>  
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
> +
>  	return 0;
>  
>  err_add_port:
> @@ -1591,14 +1595,10 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
>  static int serial_omap_runtime_suspend(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
> -	struct omap_uart_port_info *pdata = dev->platform_data;
>  
>  	if (!up)
>  		return -EINVAL;
>  
> -	if (!pdata)
> -		return 0;
> -
>  	up->context_loss_cnt = serial_omap_get_context_loss_count(up);
>  
>  	if (device_may_wakeup(dev)) {
> @@ -1626,7 +1626,7 @@ static int serial_omap_runtime_resume(struct device *dev)
>  	int loss_cnt = serial_omap_get_context_loss_count(up);
>  
>  	if (loss_cnt < 0) {
> -		dev_err(dev, "serial_omap_get_context_loss_count failed : %d\n",
> +		dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
>  			loss_cnt);
>  		serial_omap_restore_context(up);
>  	} else if (up->context_loss_cnt != loss_cnt) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
