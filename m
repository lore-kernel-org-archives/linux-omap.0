From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 06/16] OMAP2+: UART: Remove certain feilds from omap_uart_state struct
Date: Mon, 10 Oct 2011 16:31:25 -0700
Message-ID: <87d3e4ctki.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-6-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42080 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213Ab1JJXbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 19:31:31 -0400
In-Reply-To: <1317380495-584-6-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Removing some of the uart info that is maintained in omap_uart_state struct
> used for UART PM in serial.c.
>
> Remove omap_uart_state struct dependency from omap_serial_init,
> omap_serial_init_port, omap_serial_early_init and omap_uart_idle_init
> functions.  And populate the same info in omap_uart_port_info struct
> used as pdata struct.

IMO, this change doesn't belong in this patch and leads to clutter.  The
rest of the series slowly removes/replaces all the fields from this
struct, so the right place to remove it's usage all together is at the
end of the series when (if) all the fields are no longer needed (or have
been moved.)

Stated differently, IMO, this patch should leave the uart->num and
uart->oh and the list_head (uart->node) alone (probably uart->pdev too)
and just cleanup the fields that are no longer used.  Removing num, oh,
node here causes churn because you're force to change things here that
are then removed in later patches.

> Added omap_uart_hwmod_lookup function to look up oh by name used in
> serial_port_init and omap_serial_early_init functions.

Because of the above change, you now are doing a hwmod lookup 2 times
for every UART.  Leaving the uart_list and uart->num in place will avoid
the need for that change.

> A list of omap_uart_state was maintained one for each uart, the same
> is removed.  Number of uarts available is maintained in num_uarts
> field, re-use the same in omap_serial_init func to register each uart.
>
> Remove omap_info which used details from omap_uart_state and use a
> pdata pointer to pass platform specific info to driver.

There is no omap_info.  Did you mean omap_up_info?

> The mapbase (start_address), membase(io_remap cookie) maintained as
> part of uart_state struct and pdata struct are removed as this is
> handled within driver. 

This part makes sense.

> Errata field is also moved to pdata. 

Why in this patch instead of the subsequent "Move errata handling from
serial.c to omap-serial" patch?

> These changes are done to cleanup serial.c file and prepare for
> runtime changes.

There are a lot of changes in this patch with very little description as
to why, and many appear to be unrelated.  They should probably be
separate patches, or have a better description as to how all the changes
are related so they belong in the same patch.

> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c                  |  132 +++++++++---------------
>  arch/arm/plat-omap/include/plat/omap-serial.h |    4 +-
>  drivers/tty/serial/omap-serial.c              |   12 ++-
>  3 files changed, 61 insertions(+), 87 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index c98b9b4..8c43d1c 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -68,14 +68,6 @@ struct omap_uart_state {
>  	int clocked;
>  
>  	int regshift;
> -	void __iomem *membase;
> -	resource_size_t mapbase;
> -
> -	struct list_head node;
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -
> -	u32 errata;
>  #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>  	int context_valid;
>  
> @@ -90,7 +82,6 @@ struct omap_uart_state {
>  #endif
>  };
>  
> -static LIST_HEAD(uart_list);
>  static u8 num_uarts;
>  
>  static int uart_idle_hwmod(struct omap_device *od)
> @@ -143,7 +134,19 @@ static inline void serial_write_reg(struct omap_uart_state *uart, int offset,
>  	__raw_writeb(value, uart->membase + offset);
>  }
>  
> -#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
> +struct omap_hwmod *omap_uart_hwmod_lookup(int num)
> +{
> +	struct omap_hwmod *oh;
> +	char oh_name[MAX_UART_HWMOD_NAME_LEN];
> +
> +	snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN, "uart%d", num + 1);
> +	oh = omap_hwmod_lookup(oh_name);
> +	WARN(IS_ERR(oh), "Could not lookup hmwod info for %s\n",
> +			oh_name);
> +	return oh;
> +}
> +
> +#if defined(CONFIG_PM)

The CONFIG_ARCH_OMAP3 part of this #if was dropped with this change with
no mention as to why.  (I understand why it was done, but it's not
releveant to $SUBJECT patch so should be a separate patch.)

>  /*
>   * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
> @@ -357,22 +360,17 @@ int omap_uart_can_sleep(void)
>  	return can_sleep;
>  }
>  
> -static void omap_uart_idle_init(struct omap_uart_state *uart)
> +static void omap_uart_idle_init(struct omap_uart_port_info *uart,
> +				unsigned short num)
>  {
> -	int ret;
> -
> -	uart->can_sleep = 0;
> -	omap_uart_smart_idle_enable(uart, 0);
> -
>  	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
> -		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
> +		u32 mod = (num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
>  		u32 wk_mask = 0;
>  		u32 padconf = 0;
>  
> -		/* XXX These PRM accesses do not belong here */

why?

>  		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
>  		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
> -		switch (uart->num) {
> +		switch (num) {
>  		case 0:
>  			wk_mask = OMAP3430_ST_UART1_MASK;
>  			padconf = 0x182;
> @@ -391,12 +389,11 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  			break;
>  		}
>  		uart->wk_mask = wk_mask;
> -		uart->padconf = padconf;

The assignment is removed here, making all the rest of the padconf stuff
that remains useless.

However, a subsequent patch removes the mux stuff entirely, so I suggest
you just drop this change from here.

>  	} else if (cpu_is_omap24xx()) {
>  		u32 wk_mask = 0;
>  		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
>  
> -		switch (uart->num) {
> +		switch (num) {
>  		case 0:
>  			wk_mask = OMAP24XX_ST_UART1_MASK;
>  			break;
> @@ -421,7 +418,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  		uart->wk_en = NULL;
>  		uart->wk_st = NULL;
>  		uart->wk_mask = 0;
> -		uart->padconf = 0;
>  	}
>  }
>  
> @@ -436,26 +432,13 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
>  
>  static int __init omap_serial_early_init(void)
>  {
> -	int i = 0;
> -
>  	do {
> -		char oh_name[MAX_UART_HWMOD_NAME_LEN];
>  		struct omap_hwmod *oh;
> -		struct omap_uart_state *uart;
>  
> -		snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
> -			 "uart%d", i + 1);
> -		oh = omap_hwmod_lookup(oh_name);
> +		oh = omap_uart_hwmod_lookup(num_uarts);
>  		if (!oh)
>  			break;
>  
> -		uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> -		if (WARN_ON(!uart))
> -			return -ENODEV;
> -
> -		uart->oh = oh;
> -		uart->num = i++;
> -		list_add_tail(&uart->node, &uart_list);
>  		num_uarts++;
>  
>  		/*
> @@ -468,7 +451,7 @@ static int __init omap_serial_early_init(void)
>  		 * to determine SoC specific init before omap_device
>  		 * is ready.  Therefore, don't allow idle here
>  		 */
> -		uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
> +		oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>  	} while (1);
>  
>  	return 0;
> @@ -488,57 +471,47 @@ core_initcall(omap_serial_early_init);
>   */
>  void __init omap_serial_init_port(struct omap_board_data *bdata)
>  {
> -	struct omap_uart_state *uart;
>  	struct omap_hwmod *oh;
>  	struct platform_device *pdev;
> -	void *pdata = NULL;
> +	char *name = DRIVER_NAME;
> +	struct omap_uart_port_info *pdata;
>  	u32 pdata_size = 0;
> -	char *name;
> -	struct omap_uart_port_info omap_up;
>  
>  	if (WARN_ON(!bdata))
>  		return;
>  	if (WARN_ON(bdata->id < 0))
>  		return;
> -	if (WARN_ON(bdata->id >= num_uarts))
> +	if (WARN_ON(bdata->id >= OMAP_MAX_HSUART_PORTS))

why?  because of early_init, num_uarts is already the max number
of UARTs available (based on hwmod probe.)

>  		return;
>  
> -	list_for_each_entry(uart, &uart_list, node)
> -		if (bdata->id == uart->num)
> -			break;
> -
> -	oh = uart->oh;
> -	uart->dma_enabled = 0;
> -	name = DRIVER_NAME;
> +	oh = omap_uart_hwmod_lookup(bdata->id);
> +	if (!oh)
> +		return;
>  
> -	omap_up.dma_enabled = uart->dma_enabled;
> -	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
> -	omap_up.mapbase = oh->slaves[0]->addr->pa_start;
> -	omap_up.membase = omap_hwmod_get_mpu_rt_va(oh);
> -	omap_up.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		pr_err("Memory allocation for UART pdata failed\n");
> +		return;
> +	}
>  
> -	pdata = &omap_up;
>  	pdata_size = sizeof(struct omap_uart_port_info);
> +	omap_uart_idle_init(pdata, bdata->id);

Why was this moved here?  

ISTR that the order of this call relative to the hwmod/omap_device
enable/disable calls below was important, especially in the DEBUG_LL
case.

> -	if (WARN_ON(!oh))
> -		return;
> +	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
> +	pdata->flags = UPF_BOOT_AUTOCONF;
> +
> +	/* Enable the MDR1 errata for OMAP3 */
> +	if (cpu_is_omap34xx() && !cpu_is_ti816x())
> +		pdata->errata |= UART_ERRATA_i202_MDR1_ACCESS;
>  
> -	pdev = omap_device_build(name, uart->num, oh, pdata, pdata_size,
> -			       omap_uart_latency,
> -			       ARRAY_SIZE(omap_uart_latency), false);
> +	pdev = omap_device_build(name, bdata->id, oh, pdata,
> +				pdata_size, omap_uart_latency,
> +				ARRAY_SIZE(omap_uart_latency), false);

Note the unecesary whitespace changes in this change.

>  	WARN(IS_ERR(pdev), "Could not build omap_device for %s: %s.\n",
>  	     name, oh->name);
>  
> -	omap_device_disable_idle_on_suspend(pdev);

This should also be a separate patch at the end of the series, and is
not related to the changes described in the changelog.

>  	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
>  
> -	uart->regshift = 2;
> -	uart->mapbase = oh->slaves[0]->addr->pa_start;
> -	uart->membase = omap_hwmod_get_mpu_rt_va(oh);
> -	uart->pdev = pdev;
> -
> -	oh->dev_attr = uart;
> -
>  	console_lock(); /* in case the earlycon is on the UART */
>  
>  	/*
> @@ -546,23 +519,18 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>  	 * on init.  Now that omap_device is ready, ensure full idle
>  	 * before doing omap_device_enable().
>  	 */
> -	omap_hwmod_idle(uart->oh);
> +	omap_hwmod_idle(oh);
>  
> -	omap_device_enable(uart->pdev);
> -	omap_uart_idle_init(uart);
> -	omap_hwmod_enable_wakeup(uart->oh);
> -	omap_device_idle(uart->pdev);
> +	omap_device_enable(pdev);
> +	omap_hwmod_enable_wakeup(oh);
>  
> -	omap_uart_block_sleep(uart);
>  	console_unlock();
>  
> -	if ((cpu_is_omap34xx() && uart->padconf) ||
> -	    (uart->wk_en && uart->wk_mask))
> +	if ((cpu_is_omap34xx() && bdata->pads) ||
> +		(pdata->wk_en && pdata->wk_mask))

This change seems to belong as part of the mux patch.

>  		device_init_wakeup(&pdev->dev, true);
>  
> -	/* Enable the MDR1 errata for OMAP3 */
> -	if (cpu_is_omap34xx() && !cpu_is_ti816x())
> -		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
> +	kfree(pdata);
>  }
>  
>  /**
> @@ -574,11 +542,11 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>   */
>  void __init omap_serial_init(void)
>  {
> -	struct omap_uart_state *uart;
>  	struct omap_board_data bdata;
> +	u8 i;
>  
> -	list_for_each_entry(uart, &uart_list, node) {
> -		bdata.id = uart->num;
> +	for (i = 0; i < num_uarts; i++) {
> +		bdata.id = i;
>  		bdata.flags = 0;
>  		bdata.pads = NULL;
>  		bdata.pads_cnt = 0;
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 307cd6f..0f061b4 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -59,9 +59,9 @@
>  struct omap_uart_port_info {
>  	bool			dma_enabled;	/* To specify DMA Mode */
>  	unsigned int		uartclk;	/* UART clock rate */
> -	void __iomem		*membase;	/* ioremap cookie or NULL */
> -	resource_size_t		mapbase;	/* resource base */
>  	upf_t			flags;		/* UPF_* flags */
> +
> +	u32			errata;
>  };
>  
>  struct uart_omap_dma {
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 5e713d3..6c2ea54 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1275,10 +1275,16 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	up->port.ops = &serial_omap_pops;
>  	up->port.line = pdev->id;
>  
> -	up->port.membase = omap_up_info->membase;
> -	up->port.mapbase = omap_up_info->mapbase;
> +	up->port.mapbase = mem->start;
> +	up->port.membase = ioremap(mem->start, resource_size(mem));
> +
> +	if (!up->port.membase) {
> +		dev_err(&pdev->dev, "can't ioremap UART\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
>  	up->port.flags = omap_up_info->flags;
> -	up->port.irqflags = omap_up_info->irqflags;
>  	up->port.uartclk = omap_up_info->uartclk;
>  	up->uart_dma.uart_base = mem->start;

Kevin
