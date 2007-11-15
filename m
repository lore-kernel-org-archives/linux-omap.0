From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: 2430: add serial console ATAG
Date: Thu, 15 Nov 2007 12:49:03 -0800
Message-ID: <20071115204902.GG20686@atomide.com>
References: <20071101181134.117588023@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071101181134.117588023@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071101 11:12]:
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> Index: dev/arch/arm/mach-omap2/board-2430sdp.c
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/board-2430sdp.c
> +++ dev/arch/arm/mach-omap2/board-2430sdp.c
> @@ -349,9 +349,16 @@ static struct omap_uart_config sdp2430_u
>  	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
>  
> +static
> +struct omap_serial_console_config sdp2430_serial_console_config __initdata = {
> +	.console_uart = 1,
> +	.console_speed = 115200,
> +};
> +
>  static struct omap_board_config_kernel sdp2430_config[] __initdata = {
>  	{OMAP_TAG_UART, &sdp2430_uart_config},
>  	{OMAP_TAG_LCD, &sdp2430_lcd_config},
> +	{OMAP_TAG_SERIAL_CONSOLE, &sdp2430_serial_console_config},
>  };
>  
>  #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)

Pushing today.

Tony
