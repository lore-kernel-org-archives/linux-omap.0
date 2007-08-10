From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: 2430SDP: turn off secondary LCD backlight
	on boot
Date: Fri, 10 Aug 2007 02:33:09 -0700
Message-ID: <20070810093309.GN8658@atomide.com>
References: <20070730225528.778419364@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070730225528.778419364@mvista.com>
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

* Kevin Hilman <khilman@mvista.com> [070730 16:11]:
> There is not yet any driver for the secondary LCD, so turn off
> the backlight on boot.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6.21/arch/arm/mach-omap2/board-2430sdp.c
> ===================================================================
> --- linux-2.6.21.orig/arch/arm/mach-omap2/board-2430sdp.c
> +++ linux-2.6.21/arch/arm/mach-omap2/board-2430sdp.c
> @@ -55,6 +55,7 @@
>  #define TS_GPIO                 24
>  
>  #define TWL4030_MSECURE_GPIO	118
> +#define SECONDARY_LCD_GPIO	147
>  
>  static struct mtd_partition sdp2430_partitions[] = {
>  	/* bootloader (U-Boot, etc) in first sector */
> @@ -466,6 +467,10 @@ static void __init omap_2430sdp_init(voi
>  	spi_register_board_info(sdp2430_spi_board_info,
>  				ARRAY_SIZE(sdp2430_spi_board_info));
>  	ads7846_dev_init();
> +
> +	/* turn off secondary LCD backlight */
> +	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
> +	omap_set_gpio_dataout(SECONDARY_LCD_GPIO, 0);
>  }
>  
>  static void __init omap_2430sdp_map_io(void)

Pushing today.

Tony
