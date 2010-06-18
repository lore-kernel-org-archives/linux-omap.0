From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 5/5 v2] Serial: Avoid using hwmod lookup using  name string
Date: Fri, 18 Jun 2010 11:27:27 -0700
Message-ID: <87wrtw5h80.fsf@deeprootsystems.com>
References: <2335.10.24.255.18.1276697669.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44719 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0FRS1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 14:27:30 -0400
Received: by pwi1 with SMTP id 1so559294pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Jun 2010 11:27:30 -0700 (PDT)
In-Reply-To: <2335.10.24.255.18.1276697669.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Wed\, 16 Jun 2010 19\:44\:29 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Avoid using hwmod lookup using name string rather
> retreive port info using the hwmod class interface.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   71 ++++++++++++++++++-----------------------
>  1 files changed, 31 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 128e19b..0380ac8 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -56,8 +56,6 @@
>   */
>  #define DEFAULT_TIMEOUT 0
>
> -#define MAX_UART_HWMOD_NAME_LEN		16
> -
>  struct omap_uart_state {
>  	int num;
>  	int can_sleep;
> @@ -601,52 +599,45 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
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

Rather than use a static int for this, you could just use 'num_uarts'

> +	list_add_tail(&uart->node, &uart_list);
> +	num_uarts++;
>
> -		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> -		if (WARN_ON(!uart))
> -			return;
> +	/*
> +	 * During UART early init, device need to be probed
> +	 * to determine SoC specific init before omap_device
> +	 * is ready.  Therefore, don't allow idle here
> +	 */
>

extra blank line

> -		uart->oh = oh;
> -		uart->num = i++;
> -		list_add_tail(&uart->node, &uart_list);
> -		num_uarts++;
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
>

extra blank line

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
> +	uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
>
> -	} while (1);
> +	return 0;
> +}
> +
> +void __init omap_serial_early_init(void)
> +{
> +	omap_hwmod_for_each_by_class("uart",
> +		omap_serial_port_init, NULL);

this could all be on one line

Kevin
