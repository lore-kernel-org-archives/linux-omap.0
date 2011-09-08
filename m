From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 04/11] OMAP2+: UART: Remove uart clock handling code from serial.c
Date: Thu, 08 Sep 2011 16:39:21 -0700
Message-ID: <87pqja61ue.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-5-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36568 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755353Ab1IHXj1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 19:39:27 -0400
In-Reply-To: <1315400013-4849-5-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 7 Sep 2011 18:23:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Cleanup serial.c file in preparation to addition of runtime API's in omap-serial
> file. Remove all clock handling mechanism as this will be taken care with
> pm runtime API's in omap-serial.c file itself.
>
> 1.) Remove omap-device enable and disable. We can can use get_sync/put_sync API's
> 2.) Remove context save/restore can be done with runtime_resume callback for
>     get_sync call. No need to save context as all reg details available in
>     uart_port structure can be used for restore, so add missing regs in
>     uart port struct.
> 3.) Add func to identify console uart.

I don't see that as part of this patch.

> 4.) Erratum handling informed as flag to driver and func to handle erratum
>     can be moved to omap-serial driver itself.

OK, but I see two erratum flags removed, but only flag added back.
Also, the erratum handling is completely removed here and not added to
the driver.

In general, this way of moving things makes it very difficult to review.
You remove a bunch of things in this patch (and the previous one) and
imply that some of it is added back to the driver.  However, that's
really difficult to verify with patch review.

If code is being moved, it is customary to remove it and add it to the
new place in the same patch.

> Acked-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c                  |  742 ++-----------------------
>  arch/arm/plat-omap/include/plat/omap-serial.h |   11 +-
>  2 files changed, 53 insertions(+), 700 deletions(-)

[...]

> -static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
> -		sleep_timeout_store);
> -#define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
> -#else
> -static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
> -static void omap_uart_block_sleep(struct omap_uart_state *uart)
> +struct omap_hwmod *omap_uart_hwmod_lookup(int num)

function should be static

[...]

> +	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
> +		oh = omap_uart_hwmod_lookup(i);
>  		if (!oh)
> -			break;
> -
> -		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> -		if (WARN_ON(!uart))
> -			return -ENODEV;
> -
> -		uart->oh = oh;
> -		uart->num = i++;
> -		list_add_tail(&uart->node, &uart_list);
> -		num_uarts++;
> -
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
> -	} while (1);
> +			continue;
>  
> +		oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;

With proper runtime PM in the driver, I did not expect these to be
needed any longer by the end of the series, but I see they are still
there.  Are they really needed?

[...]

> @@ -864,15 +213,14 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>   */
>  void __init omap_serial_init(void)
>  {
> -	struct omap_uart_state *uart;
>  	struct omap_board_data bdata;
> +	u8 i;
>  
> -	list_for_each_entry(uart, &uart_list, node) {
> -		bdata.id = uart->num;
> +	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {

This should probably use the hwmod class iterator.

Kevin
