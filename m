From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH] Serial: Avoid using hwmod lookup using name  string
Date: Tue, 25 May 2010 09:23:18 -0700
Message-ID: <874ohwne6h.fsf@deeprootsystems.com>
References: <39979.192.168.10.88.1274431258.squirrel@dbdmail.itg.ti.com>
	<48383.192.168.10.88.1274706522.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38967 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab0EYQXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 12:23:24 -0400
Received: by pwi2 with SMTP id 2so1126528pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 25 May 2010 09:23:23 -0700 (PDT)
In-Reply-To: <48383.192.168.10.88.1274706522.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Mon\, 24 May 2010 18\:38\:42 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Rebased on latest pm/wip-uart branch.

Still doesn't apply for me, either on pm-wip/uart or on top of your 
series: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.

Please just include in your updates series which should include the
get_resource_byname() change as well as Sergio's UART fixes for 3630.

Thanks,

Kevin


> -- 
> Regards,
> Govindraj.R
>
>
> Avoid using hwmod lookup using name string rather
> retreive port info using the hwmod class interface.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   86 +++++++++++++++++++----------------------
>  1 files changed, 40 insertions(+), 46 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index da9fee6..dc04139 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -55,8 +55,6 @@
>   */
>  #define DEFAULT_TIMEOUT 0
>
> -#define MAX_UART_HWMOD_NAME_LEN		16
> -
>  struct omap_uart_state {
>  	int num;
>  	int can_sleep;
> @@ -568,52 +566,48 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
>  }
>  #endif
>
> -void __init omap_serial_early_init(void)
> +static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
>  {
> -	int i = 0;
> +	struct omap_uart_state *uart;
> +	static int i;
>
> -	do {
> -		char oh_name[MAX_UART_HWMOD_NAME_LEN];
> -		struct omap_hwmod *oh;
> -		struct omap_uart_state *uart;
> +	uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> +	if (WARN_ON(!uart))
> +		return -ENOMEM;
>
> -		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
> -			 "uart%d", i + 1);
> -		oh = omap_hwmod_lookup(oh_name);
> -		if (!oh)
> -			break;
> +	uart->oh = oh;
> +	uart->num = i++;
> +	list_add_tail(&uart->node, &uart_list);
> +	num_uarts++;
>
> -		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> -		if (WARN_ON(!uart))
> -			return;
> +	/*
> +	 * NOTE: omap_hwmod_init() has not yet been called,
> +	 * so no hwmod functions will work yet.
> +	 */
>
> -		uart->oh = oh;
> -		uart->num = i++;
> -		list_add_tail(&uart->node, &uart_list);
> -		num_uarts++;
> +	/*
> +	 * During UART early init, device need to be probed
> +	 * to determine SoC specific init before omap_device
> +	 * is ready.  Therefore, don't allow idle here
> +	 */
> +	uart->oh->flags |= HWMOD_INIT_NO_IDLE;
>
> -		/*
> -		 * NOTE: omap_hwmod_init() has not yet been called,
> -		 *       so no hwmod functions will work yet.
> -		 */
> +	/*
> +	 * Since UART hwmod is idle/enabled inside the
> +	 * idle loop, interrupts are already disabled and
> +	 * thus no locking is needed.  Since the mutex-based
> +	 * locking in hwmod might sleep, allowing locking
> +	 * may introduce problems.
> +	 */
> +	uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
>
> -		/*
> -		 * During UART early init, device need to be probed
> -		 * to determine SoC specific init before omap_device
> -		 * is ready.  Therefore, don't allow idle here
> -		 */
> -		uart->oh->flags |= HWMOD_INIT_NO_IDLE;
> -
> -		/*
> -		 * Since UART hwmod is idle/enabled inside the
> -		 * idle loop, interrupts are already disabled and
> -		 * thus no locking is needed.  Since the mutex-based
> -		 * locking in hwmod might sleep, allowing locking
> -		 * may introduce problems.
> -		 */
> -		uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
> +	return 0;
> +}
>
> -	} while (1);
> +void __init omap_serial_early_init(void)
> +{
> +	omap_hwmod_for_each_by_class("uart",
> +		omap_serial_port_init, NULL);
>  }
>
>  /**
> -- 
> 1.6.3.3
