From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Thu, 14 Feb 2013 09:12:53 -0800
Message-ID: <20130214171253.GC7144@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46667 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755903Ab3BNRM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 12:12:57 -0500
Content-Disposition: inline
In-Reply-To: <1360840554-26901-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [130214 03:19]:
> Currently the omap-serial driver will not
> work properly if booted via DT with CPUIDLE
> enabled because it depends on function pointers
> provided by hwmod to change its own SYSCONFIG
> register.
> 
> Remove that relyance on hwmod by moving SYSCONFIG
> handling to driver itself. Note that this also
> fixes a possible corner case bug where we could
> be putting UART in Force Idle mode if we called
> omap_serial_enable_wakeup(up, false) after setting
> NOIDLE to the idle mode. This is because hwmod
> has no protection against that situation.

I agree the sysconfig stuff should be handled in the drivers.
But considering that we need to also reset or idle hardware
that may not have a driver loaded, it's best to put the
reset/idle function in to the driver specific header as
an inline function.

This way the hwmod code can idle or reset the unclaimed
hardware in a late_initcall.

And probably the handling of sysconfig bits should be
done using a common header in include/linux/omap-hwmod.h
or something so it can be shared between drivers.

Regards,

Tony
 
> NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c | 67 +++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 57d6b29..078beb1 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -96,6 +96,18 @@
>  
>  #define OMAP_UART_TCR_TRIG	0x0F
>  
> +#define OMAP_UART_SYSC		0x54
> +#define OMAP_UART_AUTOIDLE	(1 << 0)
> +#define OMAP_UART_SOFTRESET	(1 << 1)
> +#define OMAP_UART_ENAWAKEUP	(1 << 2)
> +
> +#define OMAP_UART_IDLEMODE(n)	(((n) & 3) << 3)
> +#define OMAP_UART_FORCE_IDLE	OMAP_UART_IDLEMODE(0)
> +#define OMAP_UART_NO_IDLE	OMAP_UART_IDLEMODE(1)
> +#define OMAP_UART_SMART_IDLE	OMAP_UART_IDLEMODE(2)
> +#define OMAP_UART_SMART_IDLE_WKUP OMAP_UART_IDLEMODE(3)
> +#define OMAP_UART_IDLEMODE_MASK	OMAP_UART_SMART_IDLE_WKUP
> +
>  struct uart_omap_dma {
>  	u8			uart_dma_tx;
>  	u8			uart_dma_rx;
> @@ -191,44 +203,39 @@ static inline void serial_omap_clear_fifos(struct uart_omap_port *up)
>  	serial_out(up, UART_FCR, 0);
>  }
>  
> -static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
> -{
> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
> -
> -	if (!pdata || !pdata->get_context_loss_count)
> -		return 0;
> -
> -	return pdata->get_context_loss_count(up->dev);
> -}
> -
>  static void serial_omap_set_forceidle(struct uart_omap_port *up)
>  {
> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
> -
> -	if (!pdata || !pdata->set_forceidle)
> -		return;
> +	u32 reg;
>  
> -	pdata->set_forceidle(up->dev);
> +	reg = serial_in(up, OMAP_UART_SYSC);
> +	reg &= ~OMAP_UART_IDLEMODE_MASK;
> +	reg |= OMAP_UART_FORCE_IDLE;
> +	serial_out(up, OMAP_UART_SYSC, reg);
>  }
>  
>  static void serial_omap_set_noidle(struct uart_omap_port *up)
>  {
> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
> +	u32 reg;
>  
> -	if (!pdata || !pdata->set_noidle)
> -		return;
> -
> -	pdata->set_noidle(up->dev);
> +	reg = serial_in(up, OMAP_UART_SYSC);
> +	reg &= ~OMAP_UART_IDLEMODE_MASK;
> +	reg |= OMAP_UART_NO_IDLE;
> +	serial_out(up, OMAP_UART_SYSC, reg);
>  }
>  
>  static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
>  {
> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
> +	u32 reg;
>  
> -	if (!pdata || !pdata->enable_wakeup)
> -		return;
> +	reg = serial_in(up, OMAP_UART_SYSC);
> +	reg &= ~OMAP_UART_IDLEMODE_MASK;
> +
> +	if (enable)
> +		reg |= OMAP_UART_SMART_IDLE_WKUP;
> +	else
> +		reg |= OMAP_UART_SMART_IDLE;
>  
> -	pdata->enable_wakeup(up->dev, enable);
> +	serial_out(up, OMAP_UART_SYSC, reg);
>  }
>  
>  /*
> @@ -1596,8 +1603,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	if (!pdata)
>  		return 0;
>  
> -	up->context_loss_cnt = serial_omap_get_context_loss_count(up);
> -
>  	if (device_may_wakeup(dev)) {
>  		if (!up->wakeups_enabled) {
>  			serial_omap_enable_wakeup(up, true);
> @@ -1620,15 +1625,7 @@ static int serial_omap_runtime_resume(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
>  
> -	int loss_cnt = serial_omap_get_context_loss_count(up);
> -
> -	if (loss_cnt < 0) {
> -		dev_err(dev, "serial_omap_get_context_loss_count failed : %d\n",
> -			loss_cnt);
> -		serial_omap_restore_context(up);
> -	} else if (up->context_loss_cnt != loss_cnt) {
> -		serial_omap_restore_context(up);
> -	}
> +	serial_omap_restore_context(up);
>  	up->latency = up->calc_latency;
>  	schedule_work(&up->qos_work);
>  
> -- 
> 1.8.1.rc1.5.g7e0651a
> 
