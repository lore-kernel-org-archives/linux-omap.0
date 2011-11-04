From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 19/21] OMAP2+: UART: Use custom activate func for console uart.
Date: Fri, 04 Nov 2011 16:00:00 -0700
Message-ID: <878vnv334f.fsf@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
	<1318952110-10659-5-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39356 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750891Ab1KDXAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 19:00:07 -0400
In-Reply-To: <1318952110-10659-5-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Tue, 18 Oct 2011 21:05:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Omap-uart can be used as console uart to print early boot
> messages using earlyprintk so for console uart prevent
> hwmod reset or idling during bootup.
>
> Identify the console_uart set the id and use the custom
> pm_latency ops for console uart for the first time
> to idle console uart left enabled from bootup and then enable
> them back and reset pm_latency ops to default ops.
>
> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
> this approach.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   79 ++++++++++++++++++++++++++++-------------
>  1 files changed, 54 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index e1eba7f..55903f0 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -63,6 +63,7 @@ struct omap_uart_state {
>  
>  static LIST_HEAD(uart_list);
>  static u8 num_uarts;
> +static u8 console_uart_id = -1;
>  
>  #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
>  #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
> @@ -87,6 +88,29 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
>  	},
>  };
>  
> +static int console_uart_enable_hwmod(struct omap_device *od)
> +{
> +	/* For early console we prevented hwmod reset and idle
> +	 * So before we enable the uart clocks idle and then
> +	 */

minor: fix multi-line comment style (search for multi-line in
Documentation/CodingStyle).  Another one below.

Notice that you're moving existing code here, but also changing the
functionality without a description as to why.    Based on the existing code:

You need a console_lock() here...

> +	omap_hwmod_idle(od->hwmods[0]);
> +	omap_hwmod_enable(od->hwmods[0]);

...and this should be omap_device_enable().

And  you need a console_unlock() here.

Yes, you're subsequent patches avoid this problem, but we still need a real
fix other than checking for 'debug/loglevel', and when that happens,
we'll need a console lock here.

> +	/* restore the default activate/deactivate funcs,
> +	 * since now we have set the hwmod state machine right
> +	 * with the idle/enable for console uart
> +	 */
> +	od->pm_lats = omap_uart_latency;
> +
> +	return 0;
> +}
> +
> +static struct omap_device_pm_latency console_uart_latency[] = {
> +	{
> +		.activate_func	 = console_uart_enable_hwmod,
> +	},
> +};
> +
>  #ifdef CONFIG_PM
>  static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
>  {
> @@ -251,12 +275,20 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
>  static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
>  #endif
>  
> +char *cmdline_find_option(char *str)

static inline

> +{
> +	extern char *saved_command_line;
> +
> +	return strstr(saved_command_line, str);
> +}
> +
>  static int __init omap_serial_early_init(void)
>  {
>  	do {
>  		char oh_name[MAX_UART_HWMOD_NAME_LEN];
>  		struct omap_hwmod *oh;
>  		struct omap_uart_state *uart;
> +		char uart_name[MAX_UART_HWMOD_NAME_LEN];
>  
>  		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
>  			 "uart%d", num_uarts + 1);
> @@ -271,18 +303,23 @@ static int __init omap_serial_early_init(void)
>  		uart->oh = oh;
>  		uart->num = num_uarts++;
>  		list_add_tail(&uart->node, &uart_list);
> +		snprintf(uart_name, MAX_UART_HWMOD_NAME_LEN,
> +				"%s%d", OMAP_SERIAL_NAME, uart->num);
> +
> +		if (cmdline_find_option(uart_name)) {
> +			console_uart_id = uart->num;
> +			/*
> +			 * omap-uart can be used for earlyprintk logs
> +			 * So if omap-uart is used as console then prevent
> +			 * uart reset and idle to get logs from omap-uart
> +			 * until uart console driver is available to take
> +			 * care for console messages.
> +			 * Idling or resetting omap-uart while printing logs
> +			 * early boot logs can stall the boot-up.
> +			 */
> +			oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
> +		}
>  
> -		/*
> -		 * NOTE: omap_hwmod_setup*() has not yet been called,
> -		 *       so no hwmod functions will work yet.
> -		 */
> -
> -		/*
> -		 * During UART early init, device need to be probed
> -		 * to determine SoC specific init before omap_device
> -		 * is ready.  Therefore, don't allow idle here
> -		 */
> -		uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>  	} while (1);
>  
>  	return 0;
> @@ -311,6 +348,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>  	u32 pdata_size = 0;
>  	char *name;
>  	struct omap_uart_port_info omap_up;
> +	struct omap_device *od;
>  
>  	if (WARN_ON(!bdata))
>  		return;
> @@ -357,6 +395,11 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>  	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
>  	     name, oh->name);
>  
> +	if (console_uart_id == bdata->id) {
> +		od = to_omap_device(pdev);
> +		od->pm_lats = console_uart_latency;
> +	}
> +
>  	omap_device_disable_idle_on_suspend(pdev);
>  	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
>  
> @@ -364,20 +407,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>  
>  	oh->dev_attr = uart;
>  
> -	console_lock(); /* in case the earlycon is on the UART */
> -
> -	/*
> -	 * Because of early UART probing, UART did not get idled
> -	 * on init.  Now that omap_device is ready, ensure full idle
> -	 * before doing omap_device_enable().
> -	 */
> -	omap_hwmod_idle(uart->oh);
> -
> -	omap_device_enable(uart->pdev);
> -	omap_device_idle(uart->pdev);
> -
> -	console_unlock();
> -
>  	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
>  		device_init_wakeup(&pdev->dev, true);
>  }

Kevin
