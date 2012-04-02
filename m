From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2] OMAP2+: UART: Remove cpu checks for populating errata
 flags
Date: Mon, 2 Apr 2012 10:44:11 -0500
Message-ID: <4F79C94B.90801@ti.com>
References: <1332325501-10467-2-git-send-email-govindraj.raja@ti.com> <1333356489-5816-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42504 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288Ab2DBPoP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 11:44:15 -0400
In-Reply-To: <1333356489-5816-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>

Hi Govindraj,

Looks good, one minor comment ...

On 4/2/2012 3:48, Govindraj.R wrote:

> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> Currently the errata is populated based on cpu checks this can
> be removed and replaced with module version check of uart ip block.
> MVR reg is provided within the uart reg map use the same
> to populate the errata and thus now errata population and handling
> can be managed within the driver itself.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c                  |    8 ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |    1 -
>  drivers/tty/serial/omap-serial.c              |   75 ++++++++++++++++++++++++-
>  3 files changed, 74 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 0cdd359..6affdd4 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -355,14 +355,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>  	omap_up.dma_rx_poll_rate = info->dma_rx_poll_rate;
>  	omap_up.autosuspend_timeout = info->autosuspend_timeout;
>  
> -	/* Enable the MDR1 Errata i202 for OMAP2430/3xxx/44xx */
> -	if (!cpu_is_omap2420() && !cpu_is_ti816x())
> -		omap_up.errata |= UART_ERRATA_i202_MDR1_ACCESS;
> -
> -	/* Enable DMA Mode Force Idle Errata i291 for omap34xx/3630 */
> -	if (cpu_is_omap34xx() || cpu_is_omap3630())
> -		omap_up.errata |= UART_ERRATA_i291_DMA_FORCEIDLE;
> -
>  	pdata = &omap_up;
>  	pdata_size = sizeof(struct omap_uart_port_info);
>  
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 9ff4444..1a52725 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -65,7 +65,6 @@ struct omap_uart_port_info {
>  	bool			dma_enabled;	/* To specify DMA Mode */
>  	unsigned int		uartclk;	/* UART clock rate */
>  	upf_t			flags;		/* UPF_* flags */
> -	u32			errata;
>  	unsigned int		dma_rx_buf_size;
>  	unsigned int		dma_rx_timeout;
>  	unsigned int		autosuspend_timeout;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 0121486..7d218c6 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -44,6 +44,13 @@
>  #include <plat/dmtimer.h>
>  #include <plat/omap-serial.h>
>  
> +#define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
> +
> +#define OMAP_UART_REV_42 0x0402
> +#define OMAP_UART_REV_46 0x0406
> +#define OMAP_UART_REV_52 0x0502
> +#define OMAP_UART_REV_63 0x0603
> +
>  #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
>  
>  /* SCR register bitmasks */
> @@ -53,6 +60,18 @@
>  #define OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT		6
>  #define OMAP_UART_FCR_RX_FIFO_TRIG_MASK			(0x3 << 6)
>  
> +/* MVR register bitmasks */
> +#define OMAP_UART_MVR_SCHEME_SHIFT	30
> +
> +#define OMAP_UART_LEGACY_MVR_MAJ_MASK	0xf0
> +#define OMAP_UART_LEGACY_MVR_MAJ_SHIFT	4
> +#define OMAP_UART_LEGACY_MVR_MIN_MASK	0x0f
> +
> +#define OMAP_UART_MVR_MAJ_MASK		0x7


I think that you need to be consistent in how you define the mask and
shifts here. For Legacy major the mask is the actual bits in the
register representing the major number but for non-legacy the mask is
simply the bits minus the shift. So may be change the above define to ...

#define OMAP_UART_MVR_MAJ_MASK		0x700

> +#define OMAP_UART_MVR_MAJ_SHIFT		8
> +#define OMAP_UART_MVR_MIN_MASK		0x3f
> +
> +


I think you can remove one of the above lines of white space.

>  static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>  
>  /* Forward declaration of functions */
> @@ -1346,6 +1365,59 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
>  	return;
>  }
>  
> +static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
> +{
> +	u32 mvr, scheme;
> +	u16 revision, major, minor;
> +
> +	mvr = serial_in(up, UART_OMAP_MVER);
> +
> +	/* Check revision register scheme */
> +	scheme = mvr >> OMAP_UART_MVR_SCHEME_SHIFT;
> +
> +	switch (scheme) {
> +	case 0: /* Legacy Scheme: OMAP2/3 */
> +		/* MINOR_REV[0:4], MAJOR_REV[4:7] */
> +		major = (mvr & OMAP_UART_LEGACY_MVR_MAJ_MASK) >>
> +					OMAP_UART_LEGACY_MVR_MAJ_SHIFT;
> +		minor = (mvr & OMAP_UART_LEGACY_MVR_MIN_MASK);
> +		break;
> +	case 1:
> +		/* New Scheme: OMAP4+ */
> +		/* MINOR_REV[0:5], MAJOR_REV[8:10] */
> +		major = (mvr >> OMAP_UART_MVR_MAJ_SHIFT) &
> +					OMAP_UART_MVR_MAJ_MASK;


By changing the mask definition, you can then make the code for
extracting the major number consistent between legacy and non-legacy
devices too. Easier to read :-)

Cheers
Jon
