From: Pramod <pramod.gurav@ti.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 12:43:03 +0530
Message-ID: <4CAACFFF.9040702@ti.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com> <4CA9C5F6.7060902@ti.com> <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com> <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com> <87wrpy0xp3.fsf@deeprootsystems.com> <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com> <87iq1hzt3u.fsf@deeprootsystems.com> <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com> <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60188 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab0JEHM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 03:12:59 -0400
In-Reply-To: <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 05 October 2010 11:44 AM, Paul Walmsley wrote:
> Hello Lei,
>
> On Tue, 5 Oct 2010, Ming Lei wrote:
>
>> 2010/10/5 Kevin Hilman<khilman@deeprootsystems.com>:
>>> Ming Lei<tom.leiming@gmail.com>  writes:
>>>
>>>> 2010/10/4 Kevin Hilman<khilman@deeprootsystems.com>:
>>>>>
>>>>> Why?  What do you need from the PM branch that is not in l-o master?
>>>>
>>>> Seems master branch works fine for me, my beagle board doesn't hang
>>>> uart3 disabling clocks.
>>>
>>> Master branch and PM branch have exactly the same functionality for
>>> UART hwmods.  The problem was that you manually enabled DEBUG in
>>> omap_hwmod.c.
>>
>> Yes, you are correct. If DEBUG in omap_hwmod.c is enabled manually,
>> and pass the parameter of 'earlyprintk loglevel=8' to kernel from bootloader,
>> this issue can be triggered even with master branch.
>
> Does this experimental patch solve the problem, even if DEBUG is enabled
> in the hwmod code?
>
>
> - Paul

Hi Paul,

I applied this patch on my kernel which is based on android-2.6.32 
enabling dynamic printks. I still see the console hang after enabling 
the logs in hwmod.

I am using zoom3 board. Can you please let me know which defconfig from 
lo master branch can be used to test on zoom3? I would like to test this 
patch with lo master branch and zoom3.


Thanks,
Pramod

>
>  From d928bd31c9c4ad16a044b244ef3d2ad3ed648f6f Mon Sep 17 00:00:00 2001
> From: Paul Walmsley<paul@pwsan.com>
> Date: Tue, 5 Oct 2010 00:11:27 -0600
> Subject: [PATCH] RFC: omap serial: block console output while resetting earlyconsole UART
>
> Currently, no attempt is made to block console output while the
> earlyconsole UART is unavailable.  This can result in silent crashes
> that are very difficult to debug due to the lack of console output.
> This patch holds the console semaphore while resetting the active console
> UART, which causes all console output during that time to be buffered and
> then transmitted after the console semaphore is released.
>
> Not-yet-signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/serial.c |  100 ++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 100 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 338e46a..577f8f9 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -28,10 +28,13 @@
>   #include<linux/serial_8250.h>
>   #include<linux/pm_runtime.h>
>
> +#include<linux/console.h>
> +
>   #ifdef CONFIG_SERIAL_OMAP
>   #include<plat/omap-serial.h>
>   #endif
>
> +#include<plat/serial.h>
>   #include<plat/common.h>
>   #include<plat/board.h>
>   #include<plat/clock.h>
> @@ -39,6 +42,8 @@
>   #include<plat/omap_hwmod.h>
>   #include<plat/omap_device.h>
>
> +#include<asm/memory.h>
> +
>   #include "prm.h"
>   #include "pm.h"
>   #include "cm.h"
> @@ -51,6 +56,8 @@
>   #define UART_ERRATA_FIFO_FULL_ABORT	(0x1<<  0)
>   #define UART_ERRATA_i202_MDR1_ACCESS	(0x1<<  1)
>
> +#define uart_id_to_ttys_id(u)		(u - 1)
> +
>   /*
>    * NOTE: By default the serial timeout is disabled as it causes lost characters
>    * over the serial ports. This means that the UART clocks will stay on until
> @@ -106,6 +113,83 @@ static LIST_HEAD(uart_list);
>   static u8 num_uarts;
>
>   /*
> + * early_console_uart: if earlyconsole is enabled and active, the UART
> + * ID (e.g., 1, 2, 3, 4) will be stored here.  '0' means earlyconsole
> + * is disabled or some problem occurred during earlyconsole handling.
> + */
> +static int early_console_uart;
> +
> +#define for_each_console(con) \
> +	for (con = console_drivers; con != NULL; con = con->next)
> +
> +/* XXX belongs in kernel/printk.c or some earlyconsole file */
> +/* XXX The "earlycon" string is an ugly hack */
> +int _is_early_console_enabled(void)
> +{
> +	int ret = 0;
> +	struct console *c;
> +
> +	acquire_console_sem();
> +	for_each_console(c)
> +		if (!strcmp("earlycon", c->name))
> +			ret = 1;
> +	release_console_sem();
> +
> +	return ret;
> +}
> +
> +/* XXX document */
> +static int _get_early_console_uart(void)
> +{
> +	u32 v;
> +	int u = -EINVAL;
> +
> +	v = __raw_readl(phys_to_virt(OMAP_UART_INFO));
> +	/* XXX see the OMAP debug-macro.S for this table */
> +	switch (v) {
> +	case 0:
> +	case OMAP2UART1:
> +		u = 1;
> +		break;
> +	case OMAP2UART2:
> +		u = 2;
> +		break;
> +	case OMAP2UART3:
> +	case OMAP3UART3:
> +	case OMAP4UART3:
> +		u = 3;
> +		break;
> +	case OMAP3UART4:
> +	case OMAP4UART4:
> +		u = 4;
> +		break;
> +	case ZOOM_UART:
> +		WARN(1, "omap serial: ZOOM UART in use - does that go through "
> +		     "the OMAP serial code?\n");
> +		break;
> +	default:
> +		WARN(1, "omap serial: unknown serial port in use!\n");
> +	}
> +
> +	return u;
> +}
> +
> +/* XXX document */
> +static void _store_early_console_uart_id(void)
> +{
> +	int uart_id;
> +
> +	if (_is_early_console_enabled()) {
> +		uart_id = _get_early_console_uart();
> +		if (uart_id>  0) {
> +			early_console_uart = uart_id;
> +			pr_info("omap serial: early console active on UART%d (ttyS%d)\n",
> +				uart_id, uart_id_to_ttys_id(uart_id));
> +		}
> +	}
> +}
> +
> +/*
>    * Since these idle/enable hooks are used in the idle path itself
>    * which has interrupts disabled, use the non-locking versions of
>    * the hwmod enable/disable functions.
> @@ -801,6 +885,17 @@ void __init omap_serial_init_port(int port)
>   	oh->dev_attr = uart;
>
>   	/*
> +	 * XXX How do we know whether the console is on this UART or not?
> +	 * We should only call acquire_console_sem() if the console is on
> +	 * this UART.
> +	 *
> +	 * Of course, the console is not the only thing that could be using
> +	 * this UART.
> +	 */
> +	if (uart->num == uart_id_to_ttys_id(early_console_uart))
> +		acquire_console_sem();
> +
> +	/*
>   	 * Because of early UART probing, UART did not get idled
>   	 * on init.  Now that omap_device is ready, ensure full idle
>   	 * before doing omap_device_enable().
> @@ -824,6 +919,9 @@ void __init omap_serial_init_port(int port)
>   	omap_uart_block_sleep(uart);
>   	uart->timeout = DEFAULT_TIMEOUT;
>
> +	if (uart->num == uart_id_to_ttys_id(early_console_uart))
> +		release_console_sem();
> +
>   	if ((cpu_is_omap34xx()&&  uart->padconf) ||
>   	    (uart->wk_en&&  uart->wk_mask)) {
>   		device_init_wakeup(&od->pdev.dev, true);
> @@ -846,6 +944,8 @@ void __init omap_serial_init(void)
>   {
>   	struct omap_uart_state *uart;
>
> +	_store_early_console_uart_id();
> +
>   	list_for_each_entry(uart,&uart_list, node)
>   		omap_serial_init_port(uart->num);
>   }

