From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v8 11/20] OMAP2+: UART: Move errata handling from serial.c
 to omap-serial
Date: Mon, 14 Nov 2011 13:50:59 -0600
Message-ID: <4EC17123.2070505@ti.com>
References: <1321005551-21786-1-git-send-email-govindraj.raja@ti.com> <1321005551-21786-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321005551-21786-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

On 11/11/2011 3:59, Govindraj.R wrote:
> Move the errata handling mechanism from serial.c to omap-serial file
> and utilise the same func in driver file.
>
> Errata i202, i291 are moved to be handled with omap-serial
> Moving the errata macro from serial.c file to driver header file
> as from on errata will be handled in driver file itself.
> Corrected errata id from chapter reference 2.15 to errata id i291.
>
> Removed errata and dma_enabled fields from omap_uart_state struct
> as they are no more needed with errata handling done within omap-serial.
>
> Acked-by: Alan Cox<alan@linux.intel.com>
> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
> ---
>   arch/arm/mach-omap2/serial.c                  |   98 +++++++------------------
>   arch/arm/plat-omap/include/plat/omap-serial.h |    6 ++
>   drivers/tty/serial/omap-serial.c              |   66 ++++++++++++++++-
>   3 files changed, 96 insertions(+), 74 deletions(-)

[snip]

> +/*
> + * Errata i291: [UART]:Cannot Acknowledge Idle Requests
> + * in Smartidle Mode When Configured for DMA Operations.
> + * WA: configure uart in force idle mode.
> + */

Sorry, I should have checked this on the last version. However, this 
errata only appears to impact OMAP3 devices not OMAP1, OMAP2 or OMAP4. 
Can we add the devices impacted by this in the above comment? I believe 
it is just OMAP3430 and OMAP3630.

> +static void omap_uart_set_noidle(struct platform_device *pdev)
> +{
> +	struct omap_device *od = to_omap_device(pdev);
> +
> +	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
> +}
> +
> +static void omap_uart_set_forceidle(struct platform_device *pdev)
> +{
> +	struct omap_device *od = to_omap_device(pdev);
> +
> +	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_FORCE);
> +}
> +
>   #else
> +static void omap_uart_set_noidle(struct platform_device *pdev) {}
> +static void omap_uart_set_forceidle(struct platform_device *pdev) {}
>   static void omap_uart_block_sleep(struct omap_uart_state *uart)
>   {
>   	/* Needed to enable UART clocks when built without CONFIG_PM */
> @@ -473,13 +429,19 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>   			break;
>
>   	oh = uart->oh;
> -	uart->dma_enabled = 0;
>   	name = DRIVER_NAME;
>
>   	omap_up.dma_enabled = uart->dma_enabled;
>   	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
>   	omap_up.flags = UPF_BOOT_AUTOCONF;
>   	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
> +	omap_up.set_forceidle = omap_uart_set_forceidle;
> +	omap_up.set_noidle = omap_uart_set_noidle;
> +
> +	/* Enable the MDR1 errata for OMAP2/3/4 */
> +	if ((cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())&&
> +						!cpu_is_ti816x())
> +		omap_up.errata |= UART_ERRATA_i202_MDR1_ACCESS;

I am not sure that this will apply the errata for OMAP3630 devices. I 
think we need cpu_is_omap36xx() above too. Or you may wish to do 
!cpu_class_is_omap1 and !cpu_is_omap2420.

>   	pdata =&omap_up;
>   	pdata_size = sizeof(struct omap_uart_port_info);
> @@ -519,10 +481,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>   	if (((cpu_is_omap34xx() || cpu_is_omap44xx())&&  bdata->pads) ||
>   		(pdata->wk_en&&  pdata->wk_mask))
>   		device_init_wakeup(&pdev->dev, true);
> -
> -	/* Enable the MDR1 errata for OMAP3 */
> -	if (cpu_is_omap34xx()&&  !cpu_is_ti816x())
> -		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
>   }
>
>   /**
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 348c9ea..fd3d2f7 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -58,12 +58,17 @@
>
>   #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
>
> +#define UART_ERRATA_i202_MDR1_ACCESS	(0x1<<  1)
> +
>   struct omap_uart_port_info {
>   	bool			dma_enabled;	/* To specify DMA Mode */
>   	unsigned int		uartclk;	/* UART clock rate */
>   	upf_t			flags;		/* UPF_* flags */
> +	u32			errata;
>
>   	int (*get_context_loss_count)(struct device *);
> +	void (*set_forceidle)(struct platform_device *);
> +	void (*set_noidle)(struct platform_device *);
>   };
>
>   struct uart_omap_dma {
> @@ -117,6 +122,7 @@ struct uart_omap_port {
>   	char			name[20];
>   	unsigned long		port_activity;
>   	u32			context_loss_cnt;
> +	u32			errata;
>   };
>
>   #endif /* __OMAP_SERIAL_H__ */
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index ea4c24a..77f0829 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -51,6 +51,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>   static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
>   static void serial_omap_rx_timeout(unsigned long uart_no);
>   static int serial_omap_start_rxdma(struct uart_omap_port *up);
> +static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
>
>   static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
>   {
> @@ -808,7 +809,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>
>   	/* Protocol, Baud Rate, and Interrupt Settings */
>
> -	serial_out(up, UART_OMAP_MDR1, up->mdr1);
> +	if (up->errata&  UART_ERRATA_i202_MDR1_ACCESS)
> +		serial_omap_mdr1_errataset(up, up->mdr1);
> +	else
> +		serial_out(up, UART_OMAP_MDR1, up->mdr1);
> +
>   	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>
>   	up->efr = serial_in(up, UART_EFR);
> @@ -833,7 +838,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>   	else
>   		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
>
> -	serial_out(up, UART_OMAP_MDR1, up->mdr1);
> +	if (up->errata&  UART_ERRATA_i202_MDR1_ACCESS)
> +		serial_omap_mdr1_errataset(up, up->mdr1);
> +	else
> +		serial_out(up, UART_OMAP_MDR1, up->mdr1);
>
>   	/* Hardware Flow Control Configuration */
>
> @@ -1362,6 +1370,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>   	up->port.flags = omap_up_info->flags;
>   	up->port.uartclk = omap_up_info->uartclk;
>   	up->uart_dma.uart_base = mem->start;
> +	up->errata = omap_up_info->errata;
>
>   	if (omap_up_info->dma_enabled) {
>   		up->uart_dma.uart_dma_tx = dma_tx->start;
> @@ -1415,9 +1424,47 @@ static int serial_omap_remove(struct platform_device *dev)
>   	return 0;
>   }
>
> +/*
> + * Work Around for Errata i202 (2430, 3430, 3630, 4430 and 4460)
> + * The access to uart register after MDR1 Access
> + * causes UART to corrupt data.
> + *
> + * Need a delay =
> + * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
> + * give 10 times as much
> + */
> +static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1)
> +{
> +	u8 timeout = 255;
> +
> +	serial_out(up, UART_OMAP_MDR1, mdr1);
> +	udelay(2);
> +	serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
> +			UART_FCR_CLEAR_RCVR);
> +	/*
> +	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
> +	 * TX_FIFO_E bit is 1.
> +	 */
> +	while (UART_LSR_THRE != (serial_in(up, UART_LSR)&
> +				(UART_LSR_THRE | UART_LSR_DR))) {
> +		timeout--;
> +		if (!timeout) {
> +			/* Should *never* happen. we warn and carry on */
> +			dev_crit(&up->pdev->dev, "Errata i202: timedout %x\n",
> +						serial_in(up, UART_LSR));
> +			break;
> +		}
> +		udelay(1);
> +	}
> +}
> +
>   static void serial_omap_restore_context(struct uart_omap_port *up)
>   {
> -	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
> +	if (up->errata&  UART_ERRATA_i202_MDR1_ACCESS)
> +		serial_omap_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
> +	else
> +		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
> +
>   	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
>   	serial_out(up, UART_EFR, UART_EFR_ECB);
>   	serial_out(up, UART_LCR, 0x0); /* Operational mode */
> @@ -1434,7 +1481,10 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
>   	serial_out(up, UART_OMAP_SCR, up->scr);
>   	serial_out(up, UART_EFR, up->efr);
>   	serial_out(up, UART_LCR, up->lcr);
> -	serial_out(up, UART_OMAP_MDR1, up->mdr1);
> +	if (up->errata&  UART_ERRATA_i202_MDR1_ACCESS)
> +		serial_omap_mdr1_errataset(up, up->mdr1);
> +	else
> +		serial_out(up, UART_OMAP_MDR1, up->mdr1);
>   }
>
>   #ifdef CONFIG_PM_RUNTIME
> @@ -1449,6 +1499,10 @@ static int serial_omap_runtime_suspend(struct device *dev)
>   	if (pdata->get_context_loss_count)
>   		up->context_loss_cnt = pdata->get_context_loss_count(dev);
>
> +	/* Errata i291 */
> +	if (up->use_dma&&  pdata->set_forceidle)
> +		pdata->set_forceidle(up->pdev);
> +

So it does appear that you are applying this to all devices. I think 
that this should only impact omap3.

>   	return 0;
>   }
>
> @@ -1464,6 +1518,10 @@ static int serial_omap_runtime_resume(struct device *dev)
>   			if (up->context_loss_cnt != loss_cnt)
>   				serial_omap_restore_context(up);
>   		}
> +
> +		/* Errata i291 */
> +		if (up->use_dma&&  pdata->set_noidle)
> +			pdata->set_noidle(up->pdev);

Same as above.

Cheers
Jon
