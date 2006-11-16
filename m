From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] board-nokia770: correct lcd name
Date: Thu, 16 Nov 2006 03:07:38 +0200
Message-ID: <20061116010738.GN21064@atomide.com>
References: <858xig3fel.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <858xig3fel.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [061112 16:57]:
> Hi, 
> 
> (Sorry, I forgot to send this patch while sending the others)
> 
> Some time ago, the 'lcd_lph8923' device was renamed to 'lcd_mipid' but
> the board-nokia770.c file was not updated accordingly, leading to not
> working lcd.
> This one-liner fixe the trouble.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
> 

> ---
>  arch/arm/mach-omap1/board-nokia770.c |    2 	1 +	1 -	0 !
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap1/board-nokia770.c	2006-11-12 15:15:27.000000000 +0100
> +++ linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c	2006-11-12 15:16:21.000000000 +0100
> @@ -146,7 +146,7 @@ static struct ads7846_platform_data noki
>  
>  static struct spi_board_info nokia770_spi_board_info[] __initdata = {
>  	[0] = {
> -		.modalias       = "lcd_lph8923",
> +		.modalias       = "lcd_mipid",
>  		.bus_num        = 2,
>  		.chip_select    = 3,
>  		.max_speed_hz   = 12000000,

Thanks, pushing today.

Tony
