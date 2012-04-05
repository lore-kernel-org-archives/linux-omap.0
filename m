From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v3] OMAP2+: UART: Remove cpu checks for populating errata
 flags
Date: Thu, 05 Apr 2012 16:42:53 +0530
Message-ID: <4F7D7E35.9000303@ti.com>
References: <1333356489-5816-1-git-send-email-govindraj.raja@ti.com> <1333460554-7356-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42018 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962Ab2DELNC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 07:13:02 -0400
Received: by obbtb4 with SMTP id tb4so2425836obb.17
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 04:13:00 -0700 (PDT)
In-Reply-To: <1333460554-7356-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>

Hi Govind,

On Tuesday 03 April 2012 07:12 PM, Govindraj.R wrote:
> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> Currently the errata is populated based on cpu checks this can
> be removed and replaced with module version check of uart ip block.
> MVR reg is provided within the uart reg map use the same
> to populate the errata and thus now errata population and handling
> can be managed within the driver itself.
>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c                  |    8 ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |    1 -
>  drivers/tty/serial/omap-serial.c              |   74 ++++++++++++++++++++++++-
>  3 files changed, 73 insertions(+), 10 deletions(-)
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
34xx is true for 3630 also thanks for fixing the unneeded oring.
:-)

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
> index 0121486..0555c96 100644
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
Maybe a comment can be added or the #define changed to reflect
the processor also so that it is easy to map.


A dev_info print could be added so that the bootup logs(probe) could
tell what ip rev is booted is running.


Feel free to ignore such trivial comments.
> +
>  #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
>  
>  /* SCR register bitmasks */
> @@ -53,6 +60,17 @@
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
> +#define OMAP_UART_MVR_MAJ_MASK		0x700
> +#define OMAP_UART_MVR_MAJ_SHIFT		8
> +#define OMAP_UART_MVR_MIN_MASK		0x3f
> +
>  static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>  
>  /* Forward declaration of functions */
> @@ -1346,6 +1364,59 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
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
> +		major = (mvr & OMAP_UART_MVR_MAJ_MASK) >>
> +					OMAP_UART_MVR_MAJ_SHIFT;
> +		minor = (mvr & OMAP_UART_MVR_MIN_MASK);
> +		break;
> +	default:
> +		dev_warn(&up->pdev->dev,
> +			"Unknown %s revision, defaulting to highest\n",
> +			up->name);
> +		/* highest possible revision */
> +		major = 0xff;
> +		minor = 0xff;
> +	}
> +
> +	/* normalize revision for the driver */
> +	revision = UART_BUILD_REVISION(major, minor);
> +
> +	switch (revision) {
> +	case OMAP_UART_REV_46:
> +		up->errata |= (UART_ERRATA_i202_MDR1_ACCESS |
> +				UART_ERRATA_i291_DMA_FORCEIDLE);
> +		break;
> +	case OMAP_UART_REV_52:
> +		up->errata |= (UART_ERRATA_i202_MDR1_ACCESS |
> +				UART_ERRATA_i291_DMA_FORCEIDLE);
> +		break;
> +	case OMAP_UART_REV_63:
> +		up->errata |= UART_ERRATA_i202_MDR1_ACCESS;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
>  {
>  	struct omap_uart_port_info *omap_up_info;
> @@ -1443,7 +1514,6 @@ static int serial_omap_probe(struct platform_device *pdev)
>  						"%d\n", DEFAULT_CLK_SPEED);
>  	}
>  	up->uart_dma.uart_base = mem->start;
> -	up->errata = omap_up_info->errata;
>  
>  	if (omap_up_info->dma_enabled) {
>  		up->uart_dma.uart_dma_tx = dma_tx->start;
> @@ -1473,6 +1543,8 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_get_sync(&pdev->dev);
>  
> +	omap_serial_fill_features_erratas(up);
Nit : errata ( it is the prural of erratum)
> +
>  	ui[up->port.line] = up;
>  	serial_omap_add_console_port(up);
>  

