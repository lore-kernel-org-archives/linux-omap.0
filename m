From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH v3] Serial: Avoid using hwmod lookup using  name string
Date: Thu, 24 Jun 2010 15:33:29 -0700
Message-ID: <87zkykxdqe.fsf@deeprootsystems.com>
References: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47166 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0FXWde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 18:33:34 -0400
Received: by pxi8 with SMTP id 8so417341pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 15:33:34 -0700 (PDT)
In-Reply-To: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
	(Govindraj R.'s message of "Thu, 24 Jun 2010 18:25:56 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Avoid using hwmod lookup using name string rather
> retreive port info using the hwmod class interface.
> Aviod populating uart_list in early init phase,
> leave the uart_list empty and keep the omap hwmod info
> in a seperate uart_oh list and if board file calls
> serial init use this uart_oh list info to fill uart_list.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   90 ++++++++++++++++++++---------------------
>  1 files changed, 44 insertions(+), 46 deletions(-)

Hi Govindraj,

Thanks for this update.

> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 38a74d0..68cbd16 100644
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
> @@ -96,6 +94,12 @@ struct omap_uart_state {
>  #endif
>  };
>
> +struct uart_oh {
> +	struct list_head node;
> +	struct omap_hwmod *oh;
> +};
> +
> +static LIST_HEAD(uart_oh_list);
>  static LIST_HEAD(uart_list);
>  static u8 num_uarts;
>
> @@ -568,52 +572,37 @@ static void serial_out_override(struct uart_port *up, int offset, int value)
>  }
>  #endif
>
> -void __init omap_serial_early_init(void)
> +static int omap_serial_port_init(struct omap_hwmod *oh, void *user)
>  {
> -	int i = 0;
> -
> -	do {
> -		char oh_name[MAX_UART_HWMOD_NAME_LEN];
> -		struct omap_hwmod *oh;
> -		struct omap_uart_state *uart;
> -
> -		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
> -			 "uart%d", i + 1);
> -		oh = omap_hwmod_lookup(oh_name);
> -		if (!oh)
> -			break;
> -
> -		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> -		if (WARN_ON(!uart))
> -			return;
> -
> -		uart->oh = oh;
> -		uart->num = i++;
> -		list_add_tail(&uart->node, &uart_list);
> -		num_uarts++;
> -
> -		/*
> -		 * NOTE: omap_hwmod_init() has not yet been called,
> -		 *       so no hwmod functions will work yet.
> -		 */
> +	struct uart_oh *uoh;
>
> -		/*
> -		 * During UART early init, device need to be probed
> -		 * to determine SoC specific init before omap_device
> -		 * is ready.  Therefore, don't allow idle here
> -		 */
> -		uart->oh->flags |= HWMOD_INIT_NO_IDLE;

Minor issue... in the current pm-wip/uart (just changed today), this
part has been removed, so please refresh this against current
pm-wip/uart. 

> -
> -		/*
> -		 * Since UART hwmod is idle/enabled inside the
> -		 * idle loop, interrupts are already disabled and
> -		 * thus no locking is needed.  Since the mutex-based
> -		 * locking in hwmod might sleep, allowing locking
> -		 * may introduce problems.
> -		 */
> -		uart->oh->flags |= HWMOD_NO_IDLE_LOCKING;
> +	uoh = kzalloc(sizeof(struct uart_oh), GFP_KERNEL);
> +	if (WARN_ON(!uoh))
> +		return -ENOMEM;
> +	/*
> +	 * During UART early init, device need to be probed
> +	 * to determine SoC specific init before omap_device
> +	 * is ready.  Therefore, don't allow idle here
> +	 */
> +	oh->flags |= HWMOD_INIT_NO_IDLE;
> +	/*
> +	 * Since UART hwmod is idle/enabled inside the
> +	 * idle loop, interrupts are already disabled and
> +	 * thus no locking is needed.  Since the mutex-based
> +	 * locking in hwmod might sleep, allowing locking
> +	 * may introduce problems.
> +	 */
> +	oh->flags |= HWMOD_NO_IDLE_LOCKING;
> +	list_add_tail(&uoh->node, &uart_oh_list);
> +	uoh->oh = oh;
> +	num_uarts++;
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
> @@ -769,7 +758,16 @@ void __init omap_serial_init_port(int port)
>  void __init omap_serial_init(void)
>  {
>  	struct omap_uart_state *uart;
> +	struct uart_oh *uoh;
> +	int i = 0;
>
> -	list_for_each_entry(uart, &uart_list, node)
> +	list_for_each_entry(uoh, &uart_oh_list, node) {
> +		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> +		if (WARN_ON(!uart))
> +			return;
> +		list_add_tail(&uart->node, &uart_list);
> +		uart->num = i++;
> +		uart->oh = uoh->oh;
>  		omap_serial_init_port(uart->num);
> +	}
>  }

This works if a board calls omap_serial_init(), but doesn't work if a
board only wants to init a single UART and calls omap_serial_init_port()
directly.

I think you have to move the kzalloc, list_add etc. into
omap_serial_init_port()

Then, you'll have to add a 'num' field to the 'struct uart_oh' so you
can call omap_serial_init_port() with a valid number.

If we have to add a number to 'struct uart_oh', then it makes more sense
(to me) to just keep the hwmod lookup by name, since knowing the UART
number is rather important in this case.

So maybe just leave the hwmod lookup by name, but fix the problems with
empty lists that this patch also addresses.

Kevin

