From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 07/12] OMAP: Serial: Allow UART parameters to be configured from board file.
Date: Fri, 24 Jun 2011 17:12:57 -0700
Message-ID: <87vcvurcom.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-8-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1307532194-13039-8-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 8 Jun 2011 16:53:09 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Deepak K <deepak.k@ti.com>, Jon Hunter <jon-hunter@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> The following UART parameters are defined within the UART driver:
>
> 1). Whether the UART uses DMA (dma_enabled), by default set to 0
> 2). The size of dma buffer (set to 4096 bytes)
> 3). The time after which the dma should stop if no more data is received.
> 4). The auto suspend delay that will be passed for pm_runtime_autosuspend
>     where uart will be disabled after timeout
>
> Different UARTs may be used for different purpose such as the console,
> for interfacing bluetooth chip, for interfacing to a modem chip, etc.
> Therefore, it is necessary to be able to customize the above settings
> for a given board on a per UART basis.
>
> This change allows these parameters to be configured from the board file
> and allows the parameters to be configured for each UART independently.
>
> If a board does not define its own custom parameters for the UARTs, then
> use the default parameters in the structure "omap_serial_default_info".
> The default parameters are defined to be the same as the current settings
> in the UART driver to avoid breaking the UART for any board. By default,
> make all boards use the default UART parameters.
>
> Signed-off-by: Deepak K <deepak.k@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Nice.  some minor comments below.

[...]

> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index ac30de8..4e2dcdc 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -51,7 +51,12 @@
>  
>  #define OMAP_UART_DMA_CH_FREE	-1
>  
> -#define RX_TIMEOUT		(3 * HZ)
> +#define RX_TIMEOUT		(3 * HZ)	/* RX DMA timeout (jiffies) */
> +#define DEFAULT_RXDMA_TIMEOUT	1		/* RX DMA polling rate (us) */
> +#define DEFAULT_RXDMA_BUFSIZE	4096		/* RX DMA buffer size */
> +#define DEFAULT_AUTOSUSPEND_DELAY (30 * HZ) /* Runtime autosuspend (msecs) */

These don't need to be in omap-serial.h since neither the driver code or
the board file should be using them.  They can stay in mach-omap2/serial.c

> +
>  #define OMAP_MAX_HSUART_PORTS	4
>  
>  #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
> @@ -64,6 +69,9 @@ struct omap_uart_port_info {
>  	upf_t			flags;		/* UPF_* flags */
>  	unsigned int		errata;
>  	unsigned int		console_uart;
> +	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
> +	unsigned int		dma_rx_timeout;	/* DMA RX timeout */

Comments don't add value over variable name.

> +	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */

rename to autosuspend_timeout, drop comment.

Kevin
