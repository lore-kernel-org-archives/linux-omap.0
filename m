From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Remove unnecessary #ifdef CONFIG_MENELAUS
Date: Thu, 21 Jun 2007 05:06:29 -0700
Message-ID: <20070621120628.GL20283@atomide.com>
References: <5d5443650706150453v45a18d3l20fe0a66355d75c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650706150453v45a18d3l20fe0a66355d75c7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070615 04:54]:
> -- 
> --Trilok Soni

> From e6b47c5334cda7485d4d0ec4907349ffdf7b9b86 Mon Sep 17 00:00:00 2001
> From: Trilok Soni <soni.trilok@gmail.com>
> Date: Sat, 26 May 2007 19:19:19 +0530
> Subject: [PATCH] ARM: OMAP: Remove unnecessary #ifdef CONFIG_MENELAUS
> 
> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
> ---
>  arch/arm/mach-omap2/board-n800.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index a050b47..e2447fc 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -527,13 +527,11 @@ static struct menelaus_platform_data n800_menelaus_platform_data = {
>  #endif
>  
>  static struct i2c_board_info __initdata n800_i2c_board_info[] = {
> -#ifdef CONFIG_MENELAUS
>  	{
>  		I2C_BOARD_INFO("menelaus", 0x72),
>  		.irq = INT_24XX_SYS_NIRQ,
>  		.platform_data = &n800_menelaus_platform_data,
>  	},
> -#endif
>  };
>  
>  static void __init nokia_n800_init(void)

Pushing.

Tony
