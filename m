From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [pm-wip/uart][PATCH] Serial: Avoid populating uart_list in
 early      init phase
Date: Sat, 26 Jun 2010 21:38:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366B505@dbde02.ent.ti.com>
References: <61551.192.168.10.88.1277384156.squirrel@dbdmail.itg.ti.com>
    <87zkykxdqe.fsf@deeprootsystems.com>
 <17901.10.24.255.17.1277473301.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab0FZQIK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Jun 2010 12:08:10 -0400
In-Reply-To: <17901.10.24.255.17.1277473301.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Govindraj.R
> Sent: Friday, June 25, 2010 7:12 PM
> To: linux-omap@vger.kernel.org
> Cc: Kevin Hilman
> Subject: [pm-wip/uart][PATCH] Serial: Avoid populating uart_list in early
> init phase
> 
> Leave the uart_list empty and keep the omap hwmod info
> in a seperate uart_oh list and if board file calls
> serial init use this uart_oh list info to fill uart_list.
> The board file can also call just init_port to initialise
> a single uart instance, so make init_port flexible to handle
> individual uart instance by avoiding filling uart_list
> in any non port_init function.
> 
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> As per earlier dicussion:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31157.html
> 
>  arch/arm/mach-omap2/serial.c |   60 +++++++++++++++++++++++++------------
> ----
>  1 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 24b8c60..246ae02 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -97,6 +97,13 @@ struct omap_uart_state {
>  #endif
>  };
> 
> +struct uart_oh {
> +	struct list_head node;
> +	struct omap_hwmod *oh;
> +	int uart_num;
> +};
> +
> +static LIST_HEAD(uart_oh_list);
>  static LIST_HEAD(uart_list);
>  static u8 num_uarts;
> 
> @@ -593,39 +600,32 @@ static void serial_out_override(struct uart_port
> *up, int offset, int value)
> 
>  void __init omap_serial_early_init(void)
>  {
> -	int i = 0;
> +	struct omap_hwmod *oh;
> +	struct uart_oh *uoh;
> +	char oh_name[MAX_UART_HWMOD_NAME_LEN];
> 
>  	do {
> -		char oh_name[MAX_UART_HWMOD_NAME_LEN];
> -		struct omap_hwmod *oh;
> -		struct omap_uart_state *uart;
> +		uoh = kzalloc(sizeof(struct uart_oh), GFP_KERNEL);
> +		if (WARN_ON(!uoh))
> +			return;
> 
>  		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
> -			 "uart%d", i + 1);
> +			 "uart%d", num_uarts + 1);
>  		oh = omap_hwmod_lookup(oh_name);
>  		if (!oh)
>  			break;

[Tarun Kanti DebBarma] 
What happens to the successfully allocated memory (uoh)? Are we not supposed to free it before breaking?

In fact, is there any problem if we do the allocation at this point? 
+		uoh = kzalloc(sizeof(struct uart_oh), GFP_KERNEL);
+		if (WARN_ON(!uoh))
+			return;

This would mean that we allocate and do the rest of initialization only when omap_hwmod_lookup() is successful.

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
>  		/*
>  		 * NOTE: omap_hwmod_init() has not yet been called,
> -		 *       so no hwmod functions will work yet.
> -		 */
> -
> -		/*
> +		 * so no hwmod functions will work yet.
>  		 * During UART early init, device need to be probed
>  		 * to determine SoC specific init before omap_device
> -		 * is ready.  Therefore, don't allow idle here
> +		 * is ready. Therefore, don't allow idle here
>  		 */
> -		uart->oh->flags |= HWMOD_INIT_NO_IDLE;
> +		oh->flags |= HWMOD_INIT_NO_IDLE;
> +		uoh->oh = oh;
> +		uoh->uart_num = num_uarts;
> +		list_add_tail(&uoh->node, &uart_oh_list);
> +		num_uarts++;
>  	} while (1);
>  }
> 
> @@ -645,6 +645,7 @@ void __init omap_serial_init_port(int port)
>  	struct omap_uart_state *uart;
>  	struct omap_hwmod *oh;
>  	struct omap_device *od;
> +	struct uart_oh *uoh;
>  	void *pdata = NULL;
>  	u32 pdata_size = 0;
>  	char *name;
> @@ -663,6 +664,17 @@ void __init omap_serial_init_port(int port)
>  	if (WARN_ON(port >= num_uarts))
>  		return;
[Tarun Kanti DebBarma]
I am not sure if this check is needed at all since this is called for all valid ports in uart_oh_list. In other words validation of port number has happened already while creating the uart_oh_list. 

> 
> +	uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> +	if (WARN_ON(!uart))
> +		return;
> +
> +	uart->num = port;
> +	list_add_tail(&uart->node, &uart_list);
> +	list_for_each_entry(uoh, &uart_oh_list, node)
> +		if (port == uoh->uart_num)
> +			break;
> +
[Tarun Kanti DebBarma] 
BTW, why can't we pass (uoh) to this function instead of port number? In that case we would any way get the port number using uoh->uart_num as well as avoid the above loop for parsing the uart_oh_list for identifying the respective uoh just for making the below assignment.

> +	uart->oh = uoh->oh;
>  	list_for_each_entry(uart, &uart_list, node)
>  		if (port == uart->num)
>  			break;
> @@ -781,8 +793,8 @@ void __init omap_serial_init_port(int port)
>   */
>  void __init omap_serial_init(void)
>  {
> -	struct omap_uart_state *uart;
> +	struct uart_oh *uoh;
> 
> -	list_for_each_entry(uart, &uart_list, node)
> -		omap_serial_init_port(uart->num);
> +	list_for_each_entry(uoh, &uart_oh_list, node)
> +		omap_serial_init_port(uoh->uart_num);
[Tarun Kanti DebBarma] 
As mentioned above, can we pass (uoh) directly instead of (uoh->uart_num) ?

>  }
> --
> 1.6.3.3
