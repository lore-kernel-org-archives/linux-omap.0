From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix section mismatch warning in board-osk.c
Date: Fri, 18 May 2007 08:47:30 -0700
Message-ID: <20070518154730.GE3369@atomide.com>
References: <464D5230.6020603@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <464D5230.6020603@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070518 00:17]:
>
> Fix section mismatch reference to .init.data: from .data in 'osk_config'
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

> Index: linux-osk/arch/arm/mach-omap1/board-osk.c
> ===================================================================
> --- linux-osk.orig/arch/arm/mach-omap1/board-osk.c
> +++ linux-osk/arch/arm/mach-omap1/board-osk.c
> @@ -237,7 +237,7 @@ static struct omap_lcd_config osk_lcd_co
>  };
>  #endif
>  
> -static struct omap_board_config_kernel osk_config[] = {
> +static struct omap_board_config_kernel osk_config[] __initdata = {
>  	{ OMAP_TAG_USB,           &osk_usb_config },
>  	{ OMAP_TAG_UART,		&osk_uart_config },
>  #ifdef	CONFIG_OMAP_OSK_MISTRAL
> 

Pushing today.

Tony
