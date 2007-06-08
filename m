From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix omap1510-generic board compilation.
Date: Fri, 8 Jun 2007 03:31:26 -0700
Message-ID: <20070608103126.GM28556@atomide.com>
References: <fb249edb0706061945n20d12010scf13154d981c0657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0706061945n20d12010scf13154d981c0657@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [070606 19:46]:
> Move an #endif so that it doesn't hide the mmc config declaration.
> Minor formatting change.
>
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

> From d0ec40c4888e8d0281ae38abd5de4caba5adfc3f Mon Sep 17 00:00:00 2001
> From: Andrzej Zaborowski <balrog@zabor.org>
> Date: Thu, 7 Jun 2007 05:26:43 +0200
> Subject: [PATCH] ARM: OMAP: Fix omap1510-generic building out of defconfig.
> 
> ---
>  arch/arm/mach-omap1/board-generic.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
> index 33d01ad..29fa364 100644
> --- a/arch/arm/mach-omap1/board-generic.c
> +++ b/arch/arm/mach-omap1/board-generic.c
> @@ -55,6 +55,7 @@ static struct omap_usb_config generic1610_usb_config __initdata = {
>  	.hmc_mode	= 16,
>  	.pins[0]	= 6,
>  };
> +#endif
>  
>  static struct omap_mmc_config generic_mmc_config __initdata = {
>  	.mmc [0] = {
> @@ -73,15 +74,13 @@ static struct omap_mmc_config generic_mmc_config __initdata = {
>  	},
>  };
>  
> -#endif
> -
>  static struct omap_uart_config generic_uart_config __initdata = {
>  	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
>  };
>  
>  static struct omap_board_config_kernel generic_config[] = {
> -	{ OMAP_TAG_USB,           NULL },
> -	{ OMAP_TAG_MMC,           &generic_mmc_config },
> +	{ OMAP_TAG_USB,		NULL },
> +	{ OMAP_TAG_MMC,		&generic_mmc_config },
>  	{ OMAP_TAG_UART,	&generic_uart_config },
>  };
>  

This one does not seem to apply, did you forget to send your patch
0006 that this depends on?

Tony
