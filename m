From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Update TSC2301 touchscreen config name
	in board-n800.c
Date: Fri, 30 Mar 2007 15:13:46 -0400
Message-ID: <20070330191344.GJ18375@atomide.com>
References: <20070322111502.8988f08a.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070322111502.8988f08a.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070322 05:17]:
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/mach-omap2/board-n800.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index 69e5d36..bb805cf 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -409,7 +409,7 @@ static struct platform_device n800_keypad_led_device = {
>  };
>  #endif
>  
> -#if defined(CONFIG_SPI_TSC2301_TOUCHSCREEN)
> +#if defined(CONFIG_TOUCHSCREEN_TSC2301)
>  static void __init n800_ts_set_config(void)
>  {
>  	const struct omap_lcd_config *conf;

This is already applied now too.

Tony
